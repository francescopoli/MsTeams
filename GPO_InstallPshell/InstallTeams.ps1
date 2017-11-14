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


[CmdletBinding(SupportsShouldProcess=$True)]
Param(
    # best option will be to install from a sysvol share, so it will use an in-site dc
    [Parameter(Mandatory=$False)]
    [String]$SourcePath = "\\comFpoliSADDCaaaaaa\swdist$\MsTeams\",

    # if no /silent is passed, teams will open at fullscreen at completion, 
    # along with its install banner and loging prompt
    [Parameter(Mandatory = $False)]
    [String]$options = "/silent"
)

#Teams download page
#https://teams.microsoft.com/downloads

#if Teams not installed, just do it
if ( !(Test-Path "$env:APPDATA\Roaming\Microsoft\Teams\installTime.txt") ) { 
   
    write-eventlog -Logname Application -Source MsiInstaller -Eventid 1035 -Message "Installing Teams for $($env:USERDOMAIN)\$($env:USERNAME)"
   
    #installing based on the architecture (x64 or 32 bits)
    if ( $ENV:PROCESSOR_ARCHITECTURE -eq "AMD64" ){ 
        $package = "Teams_windows_x64.exe"
    } 
    else{
        $package = "Teams_windows.exe"
    }
   
   <# uncomment following part to copy binaries to client#> 
   #<# 
    if ( !(Test-Path "c:\MsTeams\$package" ) ){
        if ( !(Test-Path "c:\MsTeams" ) ){ 
            $dir = mkdir "c:\MsTeams"; 
            $dir.Attributes='hidden'; 
            Get-Item $dir
        }
        Copy-Item -Path "$($SourcePath)$($package)" -Destination "c:\MsTeams"
        if (Test-Path "c:\MsTeams\$package"){ $SourcePath="c:\MsTeams\" }
    }
    #>

    write-eventlog -Logname Application -Source MsiInstaller -Eventid 1035 -Message "Installing Teams package: $($package) from $($SourcePath)"
    
    set-location $SourcePath
    &.\$package $options

    Write-EventLog -Logname Application -Source MsiInstaller -Eventid 1035 -Message "Teams Installation triggered, it shall proceed in background"       
}