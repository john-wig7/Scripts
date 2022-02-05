#!/bin/bash

# A script to backup my optiflex My Documents folder to the drive attached to this pi

TIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`
LOGFILE='/home/pi/Scripts/backuplog'
msgSuccess="$TIMESTAMP: Successful Optiflex MyDocuments Backup."

rsync -avr  /home/pi/optiflexDocs/ /media/pi/5E4A83B74A838A8B/OptiflexBackup && echo $msgSuccess >> $LOGFILE 
