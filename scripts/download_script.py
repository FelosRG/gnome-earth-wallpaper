import os
import sys
import requests

SCRIPT_PATH = "/".join(os.path.realpath(__file__).split("/")[:-1])

url = sys.argv[1]

try:
    response = requests.get(url)
    file = open(f"{SCRIPT_PATH}/wallpaper_goes.jpg", "wb")
    file.write(response.content)
    file.close()
except Exception as err:
    print("Something failed while downloading the image.")
    print(err)