#!/bin/bash

# A script to backup my optiflex My Documents folder to the drive attached to this pi

# The source files are mounted in this location - it depends on Optiflex computer to be running and correctly mounted
# I have not yet tested any errors if this is not the case
THESOURCE="/home/pi/optiflexDocs/"

# The destination is the Toshiba 2 TB Drive USB Drive automounted by linux with this crazy number
THEDESTINATION="/media/pi/5E4A83B74A838A8B/OptiflexBackup"

TIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`   #current date and time
LOGFILE='/home/pi/Scripts/backuplog'    #backuplog contains list of each backup including timestamp and whether the backup was successful or not  
ERRORLOG='/home/pi/Scripts/backuperror.log'   #if the backup has an error - the error output will go to this log file
OUTPUTLOG='/home/pi/Scripts/backupout.log'      #if the backup is successful - the list of backed up files will go to this log file
msgSuccess="$TIMESTAMP: Successful Optiflex MyDocuments backup."     
msgError="$TIMESTAMP: There was an error in the backup process! Read the error log - backuperror.log"

# This is the main rsync command of this script, options are - a for archive - v for vebose and r for recursive
rsync -avr $THESOURCE $THEDESTINATION 2>$ERRORLOG 1>$OUTPUTLOG && echo $msgSuccess >> $LOGFILE || echo $msgError >> $LOGFILE
