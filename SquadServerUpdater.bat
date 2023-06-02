:: This .bat is a rather straightforward file to update SquadGame Servers. Allowing for an automated and easy way for server hosters to update their servers automatticaly or with ease.
:: This script works as follows: It sets the Paths to the SteamCMD, ServerTemplate and Server Paths. Then runs through the commands and prompts the user with confirmations.
:: By design, this Bat is designed assuming you have set up your Squad Server using NSSM (Non-Sucking Service Manager) and that you already have SteamCMD Installed.

:: This script will download a "ServerTemplate" to download and check for any new Squad Server updates and download that first. SteamCMD verifies the installation before shutting down.
:: Once the Squad Server has been downloaded and updated, it'll prompt you when ready to shut down your server down. Your server has to be shut down to Copy (and verify) the ServerTemplate to your Squad Server installation.
:: The "ServerTemplate" is used to speed up the update progress and prevent downtime by only taking your server down to copy and verify the server files and bringing it back up.

:: In order to properly use this script, you'll need to follow these steps:
:: Start by ensuring the correct paths are set below. "SteamCMD=" "ServerTemplate=" and "Server1=" followed by their correct paths. 

:: This script with detailed instructions and explanations can be found on the github page. Transparancy and clarity is a project focus point.
:: Development version 0.0.1 by Marenzo1 - Github: - Issues? Create an issue on Github or Contact me directly! https://catry.pm/contact

@ECHO off
color A
:: Setting the paths for the update proccess.
SET STEAMCMD=C:\SquadServerScripts\SteamCMD\steamcmd.exe
SET UPDATESCRIPT=C:\SquadServerScripts\squadserverscript.txt

SET SQUADSERVERTEMPLATE=C:\SquadServers\SquadServerTemplate
SET SQUADSERVER=C:\SquadServers\SquadServer

SET NSSM=C:\SquadServerScripts\nssm\nssm-2.24\win32\nssm.exe
SET NSSMServiceName=SquadServer

:: Updating the Squad Template Server.
@echo Starting to update the Squad Template Server.
start %STEAMCMD% +runscript %UPDATESCRIPT%
@echo Wait for the Update to complete. After the update is complete, press any button to continue the update.
Pause

:: Killing and updating the Squad Server
@echo Can the SquadServer be shutdown and updated? If YES, press any button to continue the update. This will take your server offline to update!
Pause
:: Server kill nssm / services
%nssm% stop %NSSMServiceName%
TIMEOUT /t 10 /nobreak

:: Copy files: Backing up the ServerConfig and transfering files from SquadServerTemplate to the Squad Server.
xcopy /s /v /i /y %SQUADSERVER%\SquadGame\ServerConfig %SQUADSERVER%\SquadGame\ServerConfig_backup
TIMEOUT /T 5 /nobreak
xcopy /s /v /i /y %SQUADSERVERTEMPLATE% %SQUADSERVER%
TIMEOUT /T 5 /nobreak

:: restore config folder
xcopy /v /y %SQUADSERVER%\SquadGame\ServerConfig_backup %SQUADSERVER%\SquadGame\ServerConfig
TIMEOUT /T 5 /nobreak

echo Logged time = %time% %date%>> Server_Updated_Log.txt

:: Boot service up again
%nssm% start %NSSMServiceName%
TIMEOUT /t 10 /nobreak

@echo The server has been updated and has been brought back online!

Pause