<#
	The sample scripts are not supported under any Microsoft standard support 
	program or service. The sample scripts are provided AS IS without warranty  
	of any kind. Microsoft further disclaims all implied warranties including,  
	without limitation, any implied warranties of merchantability or of fitness for 
	a particular purpose. The entire risk arising out of the use or performance of  
	the sample scripts and documentation remains with you. In no event shall 
	Microsoft, its authors, or anyone else involved in the creation, production, or 
	delivery of the scripts be liable for any damages whatsoever (including, 
	without limitation, damages for loss of business profits, business interruption, 
	loss of business information, or other pecuniary loss) arising out of the use 
	of or inability to use the sample scripts or documentation, even if Microsoft 
	has been advised of the possibility of such damages.
#>

<#       
    .DESCRIPTION
        Group Policy script to deploy TEAMS with a User Logon Script Gropu Policy.
        Create User Logon Policy, the script will install TEAMS from a net share, or
        cache the binaries locally before installation. 
        With /silent option installation will happen in background, with an icon ending 
        on user desktop

        Download binaries from here and drop them on the network share.
        Teams download page
        https://teams.microsoft.com/downloads
        
        Author: Francesco Poli fpoli@microsoft.com
			
    .PARAMETER $SourcePath
        Specifies the location where install binaries are located, any valid path allowed
        please consider that if the parameter is passed as the login script in the group policy
        it shall be passed like -SourcePath \\server\path
	
    .PARAMETER $options 
        Not so many options for TEAMS when installing, adding /silent by default will let it intall
        in background, the drawback is that it will not start when user log on in Windows, unless
        he started and authenticate in the application once.
#>

[CmdletBinding(SupportsShouldProcess=$True)]
Param(
    # best option will be to install from a sysvol share, so it will use an in-site dc
    [Parameter(Mandatory=$False)]
    [String]$SourcePath = "\\SERVERNAME\swdist$\MsTeams\",

    # if no /silent is passed, teams will open at fullscreen at completion, 
    # along with its install banner and loging prompt
    [Parameter(Mandatory = $False)]
    [String]$options = "/silent"
)

# Checking folder path existence and format
if ( !(Test-Path $SourcePath) ) { 
    Write-EventLog -Logname Application -Source MsiInstaller -Eventid 11728 `
                   -Message "Teams Installation failed: Incorrect source binaries folder" `
                   -EntryType error -Category
    exit 
}
else{
    if ($SourcePath -ne '\') {$SourcePath+='\'}
}
#if Teams not installed, just do it
if ( !(Test-Path "$env:APPDATA\Roaming\Microsoft\Teams\installTime.txt") ) { 
    
    $installMessage = "Installing Teams for $($env:USERDOMAIN)\$($env:USERNAME)"
    #write-eventlog -Logname Application -Source MsiInstaller -Eventid 1040 -Message 
   
    #installing based on the architecture (x64 or 32 bits)
    if ( $ENV:PROCESSOR_ARCHITECTURE -eq "AMD64" ){ 
        $package = "Teams_windows_x64.exe"
    } 
    else{
        $package = "Teams_windows.exe"
    }
 
#region Cache it locally
    <# 
        uncomment following part to copy binaries to client
        files will be cached in c:\MsTeams, folder will be made hidden
    #>
<# Remove this WHOLE line to uncomment ------------
    if ( !(Test-Path "c:\MsTeams\$package" ) ){
        if ( !(Test-Path "c:\MsTeams" ) ){ 
            $dir = mkdir "c:\MsTeams"; 
            $dir.Attributes='hidden'; 
            Get-Item $dir
        }
        Copy-Item -Path "$($SourcePath)$($package)" -Destination "c:\MsTeams"
        if (Test-Path "c:\MsTeams\$package"){ $SourcePath="c:\MsTeams\" }
    }
#> #remove this WHOLE line to uncomment ----------
#endregion
    $installMessage = " --- package: $($package) from $($SourcePath)"
    Write-EventLog  -Logname Application -Source MsiInstaller -Eventid 11728 -Message " $($installMessage)"
       
    set-location $SourcePath
    &.\$package $options

    Write-EventLog  -Logname Application -Source MsiInstaller -Eventid 1040 -Message "Teams Installation triggered, it will continue in background"
    
}