@echo off
color A

@echo This script will download SteamCMD from https://developer.valvesoftware.com/ automatically.
@echo If you do not want SteamCMD to be installed automatically then please close this command prompt. SteamCMD has not yet been downloaded.
@echo SteamCMD is essential for the SquadServerScripts's Server Updater and is used to download and update the squad servers.
@echo Should this script install SteamCMD for you? You can install SteamCMD manually if you prefer by visiting https://developer.valvesoftware.com/wiki/SteamCMD through your browser!
@echo Press any button on your keyboard to automatically download SteamCMD.
Pause

cd ..\
@echo downloading SteamCMD from https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip
powershell -command "Invoke-WebRequest https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip -OutFile SteamCMD.zip"
TIMEOUT 10
@echo Extracting the ZIP Archive. 
powershell -command "Expand-Archive -Force 'SteamCMD.zip'"
TIMEOUT 5

@echo Cleaning up the installation files.
del /q SteamCMD.zip

@echo SteamCMD has been downloaded and extracted! SteamCMD will now run for the first time to  update.
TIMEOUT 3

Start SteamCMD\steamcmd.exe
@echo SteamCMD is now updating! This installation is now complete.
Pause