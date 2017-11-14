# MsTeams - Install TEAMS using GPO

This is a sample script to install Microsoft TEAMS using Group Policy Deployment.


## Create the Group Policy

#### Open the Group Policy Management tool:
![Gpo Management Tool](https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/GPOManagement.png)

####  Create a New Group Policy and assing it to the Users OU:
![New Group Policy](https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/CreateNewPolicy.png)

#### Add a NEW User Configuration -> Policies -> Windows Settings - Scripts - Logon script:
![New User logon script](https://github.com/francescopoli/raw/MsTeams/master/GPO_InstallPshell/Images/ScriptLogonPolicy.PNG)

#### Create the New PowerShell Script
... Click Add and then Browse in the Edit script window.
... Copy the InstallTeams.ps1 script in the proposed folder
... Add the -SourcePath parameter if you haven`t alread changed it in the script:
![Powershell logon script](https://github.com/francescopoli/raw/MsTeams/master/GPO_InstallPshell/Images/AddNewPowershellScript.PNG)