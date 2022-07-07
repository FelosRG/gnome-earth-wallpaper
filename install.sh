#!/bin/bash

USER=$(whoami)
DIR="/home/${USER}/.earth-wallpaper"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "The directory of the program will be set to ${DIR}"

if [ -d "$DIR" ]; then
    echo "The installation script detected that there is already a folder named ${DIR}"
    echo "If you want to reinstall please run the unistall.sh script first."
else
    mkdir $DIR
    echo "Copying files to ${DIR}..."
    cp -R ${SCRIPT_DIR}/scripts/. ${DIR}/

    echo "Making main scripts executable..."
    chmod +x "${DIR}/set_background.sh"
    chmod +x "${DIR}/main.sh"

    echo "Creating symbolic the link /usr/local/bin/earth-wallpaper"
    sudo ln -s "${DIR}/main.sh" "/usr/local/bin/earth-wallpaper"
fi

echo "The instalation has been complete!"
