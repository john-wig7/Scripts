#!/bin/bash

# A script to backup my optiflex My Documents folder to the drive attached to this pi

# The source files are mounted in this location - it depends on Optiflex computer to be running and correctly mounted
# I have not yet tested any errors if this is not the case
THESOURCE="/home/pi/optiflexDocs/"

# The destination is the Toshiba 2 TB Drive USB Drive automounted by linux with this crazy number
THEDESTINATION="/media/pi/5E4A83B74A838A8B/OptiflexBackup"

TIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`
LOGFILE='/home/pi/Scripts/backuplog'
ERRORLOG='/home/pi/Scripts/backuperror.log'
OUTPUTLOG='/home/pi/Scripts/backupout.log'
msgSuccess="$TIMESTAMP: Successful Optiflex MyDocuments Backup."
msgError="$TIMESTAMP: There was an error in the backup process!"


rsync -avr  $THESOURCE $THEDESTINATION 2>$ERRORLOG 1>$OUTPUTLOG && echo $msgSuccess >> $LOGFILE || echo $msgError >> $LOGFILE
