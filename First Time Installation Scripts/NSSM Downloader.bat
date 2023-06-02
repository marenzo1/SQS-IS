@echo off
color A

@echo This script will download NSSM (Non-Sucking Service Manager) from https://nssm.cc/ automatically.
@echo If you do not want NSSM to be installed automatically then please close this command prompt. NSSM has not yet been downloaded.
@echo NSSM is a great tool that is essential to the configuration of the SquadServerScripts's Server Updater and is used to stop and start and the squad server after a restart.
@echo NSSM also has the benefit of allowing the server to auto-restart when it crashes. I greatly recommend using NSSM if you do not plan on using any other restarter.
@echo Should this script install NSSM for you? You can install NSSM manually if you prefer by visiting https://nssm.cc/ through your browser!
@echo Press any button on your keyboard to automatically download NSSM.
Pause

cd ..\
@echo downloading NSSM from https://nssm.cc/release/nssm-2.24.zip
powershell -command "Invoke-WebRequest https://nssm.cc/release/nssm-2.24.zip -OutFile nssm.zip"
TIMEOUT 10
@echo Extracting the ZIP Archive. 
powershell -command "Expand-Archive -Force 'nssm.zip'"
TIMEOUT 5

@echo Cleaning up the installation files.
del /q nssm.zip

@echo NSSM has been downloaded and extracted! You can now close this script.
Pause  