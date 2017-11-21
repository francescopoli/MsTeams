# MsTeams - Install TEAMS using GPO

This is a sample script to install Microsoft TEAMS using Group Policy Deployment.
<br>
<br>
## Create the Group Policy

#### Open the Group Policy Management tool:
![Gpo Management Tool](https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/GPOManagement.png)

####  Create a New Group Policy and assing it to the Users OU:
![New Group Policy](https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/CreateNewPolicy.png)

#### Add a NEW User Configuration -> Policies -> Windows Settings - Scripts - Logon script:
![New User logon script](https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/ScriptLogonPolicy.PNG)

#### Create the New PowerShell Script
Click Add and then Browse in the Edit script window.<br>
Copy the InstallTeams.ps1 script in the proposed folder<br>
Add the -SourcePath parameter if you haven`t alread changed it in the script:
![Powershell logon script](https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/AddNewPowershellScript.PNG)

<br>
<br>

## InstallTeams script

InstallTeams.ps1 -> check local file system for Teams deployment (if already installed)
InstallTeamsRegTest.ps1 -> check registry key for Teams deployment (if already installed)

Is all in the script comments:

.DESCRIPTION

        Group Policy script to deploy TEAMS with a User Logon Script Gropu Policy.
        Create User Logon Policy, the script will install TEAMS from a net share, or
        cache the binaries locally before installation. 
        With /silent option installation will happen in background, with an icon ending 
        on user desktop.
        Note: install events created in the Windows Event log, under the MSIInstaller source,
        altough the package does not use the MSI technology.

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