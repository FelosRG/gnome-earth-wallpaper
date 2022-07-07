#!/bin/bash
user=$(whoami)
SCRIPT_DIR="/home/${user}/.earth-wallpaper"

# Run set_background script
/usr/bin/bash ${SCRIPT_DIR}/set_background.sh

# Putting crontab jobs into a file
# Note: Grep only works here when omiting  the first line 
# which is a empty one do not know why ??
crontab -l | tail -n +2 &> ${SCRIPT_DIR}/.earth-wallpaper.temp
crontab_job="*/15 * * * * /usr/bin/bash ${SCRIPT_DIR}/set_background.sh"
crontab_job_reboot="@reboot /usr/bin/bash ${SCRIPT_DIR}/set_background.sh"

# Check if crontab job its lready running
# https://stackoverflow.com/questions/4749330/how-to-test-if-string-exists-in-file-with-bash

if grep -Fxq "${crontab_job}" "${SCRIPT_DIR}/.earth-wallpaper.temp" ; then
    echo "Crontab job it's already running"
else 
    crontab -l | { cat; echo "$crontab_job"; } | crontab -
    crontab -l | { cat; echo "$crontab_job_reboot"; } | crontab -
    echo "Cronjob has been set succesfully!"
fi