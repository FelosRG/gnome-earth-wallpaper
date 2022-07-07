#!/bin/bash

user=$(whoami)
DIR="/home/${user}/.earth-wallpaper/"

echo "Stoping the cronos task"
earth-wallpaper stop

echo "Deleting the directory of the program at ${DIR}"
rm -rf ${DIR}

echo "Deleting symbolic link"
sudo rm /usr/local/bin/earth-wallpaper

echo "The program has been complety unistalled!"
