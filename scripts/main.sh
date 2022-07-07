#!/bin/bash

user=$(whoami)
SCRIPT_DIR="/home/${user}/.earth-wallpaper/"

ARG=( "${@}" )

if [ "${ARG[0]}" = "start" ]; then
    /usr/bin/bash ${SCRIPT_DIR}/start.sh

elif [ "${ARG[0]}" = "stop" ]; then
    /usr/bin/bash ${SCRIPT_DIR}/stop.sh

elif [ "${ARG[0]}" = "status" ]; then
    /usr/bin/bash ${SCRIPT_DIR}/status.sh

elif [ "${ARG[0]}" = "set" ]; then

    if [ "${ARG[1]}" = "CONUS" ]; then
        sed -i "1s/.*/CONUS/" ${SCRIPT_DIR}/earth-wallpaper.config # https://stackoverflow.com/questions/13438095/replace-the-first-line-in-a-text-file-by-a-string
        /usr/bin/bash ${SCRIPT_DIR}/set_background.sh
        echo "The wallpaper view has been change to CONUS"

    elif [ "${ARG[1]}" = "PACIFIC" ]; then
        sed -i "1s/.*/PACIFIC/" ${SCRIPT_DIR}/earth-wallpaper.config # https://stackoverflow.com/questions/13438095/replace-the-first-line-in-a-text-file-by-a-string
        /usr/bin/bash ${SCRIPT_DIR}/set_background.sh
        echo "The wallpaper view has been change to CONUS"

    elif [ "${ARG[1]}" = "DISK" ]; then
        sed -i "1s/.*/DISK/" ${SCRIPT_DIR}/earth-wallpaper.config
        /usr/bin/bash ${SCRIPT_DIR}/set_background.sh
        echo "The wallpaper view has been change to DISK"

    else
        echo "Not a valid or missing option"
    fi

else
    echo "Not a valid or missing command."

fi