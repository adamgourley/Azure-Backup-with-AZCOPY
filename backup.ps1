# Script to run backups daily for 1 year since script start.

# Set working directory
Set-Location "C:\BackupToAzure"

# Everyday at 3pm, run this script until it has been run 365 times.
while($val -ne 365)
{
    # Counter
    $val++

    # Get variables
    $dayinmonth = get-date -format "dd";
    $yearandmonth = get-date -format "yyyy-MM";
    $dayofweek = (get-date).DayOfWeek

    # Create log file
    New-Item -Type File -Path "C:\BackupToAzure\log" -Name "azcopy-$yearandmonth-$dayinmonth.log"

    # Copy the backup to Azure's bsdbackupalpharetta container 'vmbackup'
    C:\BackupToAzure\azcopy.exe copy "<redacted backup file location>\$dayofweek\*" "<redacted base Azure storage url>/$yearandmonth/$dayinmonth/<redacted credentials>" | Out-File "C:\BackupToAzure\logs\azcopy-$yearandmonth-$dayinmonth.log";

    # Sleep for 24 hours
    Start-Sleep -Seconds 86400
}