#!/bin/bash

#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
user=$(whoami)
SCRIPT_DIR="/home/${user}/.earth-wallpaper"

crontab -l | tail -n +2 &> ${SCRIPT_DIR}/.earth-wallpaper.temp
crontab_job="*/15 * * * * /usr/bin/bash ${SCRIPT_DIR}/set_background.sh"
crontab_job_reboot="@reboot /usr/bin/bash ${SCRIPT_DIR}/set_background.sh"

# Stopping task in Cronos
# https://askubuntu.com/questions/408611/how-to-remove-or-delete-single-cron-job-using-linux-command
if grep -Fxq "${crontab_job}" "${SCRIPT_DIR}/.earth-wallpaper.temp"
then
    crontab -l | grep -Fvx "${crontab_job}"  | crontab -
    crontab -l | grep -Fvx "${crontab_job_reboot}"  | crontab -
else 
    echo "Cronjob it's already stop"
fi

echo "Background will not longer change."

