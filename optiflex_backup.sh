#!/bin/bash

# A script to backup my optiflex My Documents folder to the drive attached to this pi

# variables for file locations and messages
TIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`   #current date and time
LOGFILE='/home/pi/backupLogs/backuplog'    #backuplog contains list of each backup including timestamp and whether the backup was successful or not  
ERRORLOG='/home/pi/backupLogs/backuperror.log'   #if the backup has an error - the error output will go to this log file
OUTPUTLOG='/home/pi/backupLogs/backupout.log'      #if the backup is successful - the list of backed up files will go to this log file
msgSuccess="$TIMESTAMP: Successful Optiflex MyDocuments backup."     
msgError="$TIMESTAMP: There was an error in the backup process! Read the error log - /home/pi/backupLogs/backuperror.log"
NOSOURCEERROR="$TIMESTAMP: The Optiflex source cannot be located"  

# The source files are mounted in this location - it depends on Optiflex computer to be running and correctly mounted
THESOURCE="/home/pi/optiflexDocs/"

# The destination is the Toshiba 2 TB Drive USB Drive automounted by linux with this crazy number
THEDESTINATION="/media/pi/5E4A83B74A838A8B/OptiflexBackup"

# Files deleted from the source will be backed up here, stored in daily directories - being replaced every year in a cycle
THEBACKUP="/media/pi/5E4A83B74A838A8B/deletedOptiflexFiles/"$(date +"%Y")
THESUFFIX="."$(date +"%d%m%Y.%H%M%S")


# This is the main rsync command of this script
rsync -avbh --delete --backup-dir=$THEBACKUP --suffix=$THESUFFIX $THESOURCE $THEDESTINATION 2>$ERRORLOG 1>$OUTPUTLOG && echo $msgSuccess >> $LOGFILE || echo $msgError >> $LOGFILE
