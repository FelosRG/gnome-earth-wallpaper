#!/bin/bash

user=$(whoami)
SCRIPT_DIR="/home/${user}/.earth-wallpaper/"

crontab -l | tail -n +2 &> ${SCRIPT_DIR}/.earth-wallpaper.temp
crontab_job="*/15 * * * * /usr/bin/bash ${SCRIPT_DIR}/set_background.sh"

# Show running status
if grep -Fxq "${crontab_job}" "${SCRIPT_DIR}/.earth-wallpaper.temp" ; then
    echo "Status: earth-wallpaper script is running :)"
else
    echo "Status: earth-wallpaper script is stop"
fi

# Show current options
echo "Current view setting: $(head -1 ${SCRIPT_DIR}/earth-wallpaper.config)"

# Other info
echo "Frequency updates: Every 15 minutes"

