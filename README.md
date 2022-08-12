# Setup AZCOPY Service on Windows Server

#### Prerequisites
1) [NSSM](https://nssm.cc/download) I used version 2.24, but you can adjust accordingly for another version.
2) [AZCOPY](https://aka.ms/downloadazcopy-v10-windows) I am using version 10, but any newer version should work.
3) Setup a directory with the following structure...

```
nssm-2.24/    - Will be used for installing the service
logs/         - Empty directory to be used to store logs for the service
azcopy.exe    - Dependancy for the script
backup.ps1    - Primary script
README.md     - Instructions/overview
```

#### Instructions
1) Copy the contents of this directory to  `C:\BackupToAzure`
2) Edit line 21 in `backup.ps1` to reflect the Azure location/credentials of your backup file location and the storage destination. You will see several `redacted` sections where you need to add your information.
3) Install the service with the following commands (in an elevated PowerShell prompt)

```Powershell
$powershell = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

$arguments = '-ExecutionPolicy Bypass -NoProfile -File "C:\BackupToAzure\backup.ps1"'

Set-Location "C:\BackupToAzure\nssm-2.24\win64"

.\nssm.exe install "Azure Backup Service" $powershell $arguments
```

4) Start your service with the following command.
```powershell
Start-Service "Azure Backup Service"
```

5) Any logs from the backup will be outputted to `C:\BackupToAzure\logs\azcopy-xxxx-xx-xx.log`
