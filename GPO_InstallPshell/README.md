# MsTeams - Install TEAMS using GPO

This is a sample script to install Microsoft TEAMS using Group Policy Deployment.


### Create the Group Policy

Open the Group Policy Management tool:
    ![alt text][GPOManagement]
    [GPOManagementogo]:<https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/GPOManagement.png> "GPO Management"

Create a New Group Policy and assing it to the Users OU:
    ![alt text][NewGPO]
    [NewGPO]:https://github.com/francescopoli/MsTeams/raw/master/GPO_InstallPshell/Images/CreateNewPolicy.png "New Group Policy

Add a NEW User Configuration -> Policies -> Windows Settings - Scripts - Logon script:
    ![alt text][NewLogonScript]
    [NewLogonScript]:https://github.com/francescopoli/raw/MsTeams/master/GPO_InstallPshell/Images/ScriptLoginPolicy.PNG "New User logong script"

Create the New PowerShell Script
Click Add, and then Browse in the Edit script window
Copy the InstallTeams.ps1 script in the proposed folder
Add the -SourcePath parameter if you haven`t alread changed it in the script:
    ![alt text][NewScript]
    [NewScript]:https://github.com/francescopoli/raw/MsTeams/master/GPO_InstallPshell/Images/AddNewPowershellScript.PNG "Powershell logon script"

