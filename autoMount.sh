#!/bin/bash
# This is used by Crontab to auto mount my windows optiflex share after a reboot.
# It doesn't automatically mount the share, so I send this command which mounts the share 3 seconds after reboot.
# Crontab command is: @reboot sleep 3 && /home/pi/Scripts/autoMount.sh

sudo mount -a
