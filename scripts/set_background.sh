#!/bin/bash

# Setting the enviromental variables requeried by gsettings
# https://askubuntu.com/questions/140305/cron-not-able-to-succesfully-change-background
user=$(whoami)
fl=$(find /proc -maxdepth 2 -user $user -name environ -print -quit)
while [ -z $(grep -z DBUS_SESSION_BUS_ADDRESS "$fl" | cut -d= -f2- | tr -d '\000' ) ]
do
  fl=$(find /proc -maxdepth 2 -user $user -name environ -newer "$fl" -print -quit)
done
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS "$fl" | cut -d= -f2-)

# Getting from the configuration file the right source for the images
SCRIPT_DIR="/home/${user}/.earth-wallpaper/"

URI="file://${SCRIPT_DIR}/wallpaper_goes.jpg"

view_setting="$(head -1 ${SCRIPT_DIR}/earth-wallpaper.config)"

if [ "$view_setting" = "CONUS" ]; then
    URL="https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/latest.jpg"

elif [ "$view_setting" = "PACIFIC" ]; then
    URL="https://cdn.star.nesdis.noaa.gov/GOES17/ABI/SECTOR/tpw/GEOCOLOR/latest.jpg"

elif [ "$view_setting" = "DISK" ]; then
    URL="https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/5424x5424.jpg"
fi

# Download the image
/usr/bin/python3 ${SCRIPT_DIR}/download_script.py $URL

# Workaround to a bug that prevents updating the background with an image with the same name.
# https://askubuntu.com/questions/418493/setting-wallpaper-in-gnome-with-command-line-only-works-once
/usr/bin/gsettings set org.gnome.desktop.background draw-background false

# For a better appeareance with Disk view.
# More options: https://askubuntu.com/questions/914714/set-fill-settings-for-desktop-background-image-ubuntu-budgie-17-04
if [ "$view_setting" = "DISK" ]; then
    /usr/bin/gsettings set org.gnome.desktop.background picture-options 'centered'
else
    /usr/bin/gsettings set org.gnome.desktop.background picture-options 'stretched'
fi

/usr/bin/gsettings set org.gnome.desktop.background picture-uri "${URI}"
