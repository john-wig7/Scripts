#!/bin/bash

# Script by John Wigglesworth 15/2/22
# Designed for a Raspberry SBC.

# A script to sync and backup my MyDocuments folder on my Windows 10 PC, copied to a usb drive mounted on this Raspberry Pi 4 (Raspberry Pi OS).
# It uses an rsync function to sync the destination directory with the source directory.

# The rsync function copies in another directory any files that have been changed or deleted at the source since the last backup,
# a date stamp is appended to the filename, and 
# the now 'out-of-sync' file in the destination folder is finally deleted.

# Ouputs from the rsync function are copied to logs.
# The script can be run from the terminal or scheduled to run automatically on crontab.

# variables for files and locations of output logs, and messages
TIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`   #current date and time
LOGFILE='/home/pi/backupLogs/backuplog'    #backuplog contains list of each backup including timestamp and whether the backup was successful or not  
ERRORLOG='/home/pi/backupLogs/backuperror.log'   #if the backup has an error - the error output will go to this log file
OUTPUTLOG='/home/pi/backupLogs/backupout.log'      #if the backup is successful - the list of backed up files will go to this log file
msgSuccess="$TIMESTAMP: Successful Optiflex MyDocuments backup."     
msgError="$TIMESTAMP: There was an error in the backup process! Read the error log - /home/pi/backupLogs/backuperror.log"
NOSOURCEERROR="$TIMESTAMP: The Optiflex source cannot be located"  

# The source files on the optiflex PC are mounted via fstab in the source location
THESOURCE="/home/pi/optiflexDocs/"

# Check that the source is mounted and only run rsync if it is
if [[ $(findmnt -M "$THESOURCE") ]]
then
    echo "$TIMESTAMP: $THESOURCE is correctly mounted."
    echo "running rsync backup..."

    # The destination is a directory on a Toshiba 2 TB USB Drive
    THEDESTINATION="/media/pi/5E4A83B74A838A8B/OptiflexBackup"

    # Files deleted at the source will be deleted from the sync folder and copied to an annual directory 
    THEBACKUP="/media/pi/5E4A83B74A838A8B/deletedOptiflexFiles/"$(date +"%Y")"-backups"
    # A .date suffix will be added to the filename of the copied file
    THESUFFIX="."$(date +"%d-%m-%Y_%H-%M-%S")

    # This is the main rsync command, archival for recursive directories and preserve attributes, verbose for the output, b for backup and h for more readable output
    rsync -avbh --delete --backup-dir=$THEBACKUP --suffix=$THESUFFIX $THESOURCE $THEDESTINATION 2>$ERRORLOG 1>$OUTPUTLOG && echo $msgSuccess >> $LOGFILE || echo $msgError >> $LOGFILE

else
    echo "$TIMESTAMP: $THESOURCE is not mounted on your filesystem!" >> $LOGFILE
fi

ENDTIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`   #current date and time
echo "$ENDTIMESTAMP: Rsync backup finished."
