@echo off
REM /*** GRAB CURRENT DATE/TIME INFO ***/
set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%

set HR=%time:~0,2%
set MIN=%time:~3,2%
set SEC=%time:~6,2%
REM /*** REPLACE SPACE WITH ZERO ***/
set HR=%Hr: =0%
set MIN=%min: =0%
set SEC=%sec: =0%

CD C:\Users\Office-2\Screensaver
echo %time% > lastRun.txt
REM if not exist .\%HR% mkdir %HR%

REM /*** USE HOUR FOR FILENAME ***/
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://services.swpc.noaa.gov/images/animations/ovation/north/latest.jpg','C:\Users\Office-2\Screensaver\a1.jpg')"
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://services.swpc.noaa.gov/experimental/images/aurora_dashboard/tonights_static_viewline_forecast.png','C:\Users\Office-2\Screensaver\a2.png')"

magick a2.png space.jpg -background "black" +append a3.png
magick a3.png a1.jpg -gravity center -background "black" +append AURORAs.JPG
move /y AURORAs.JPG ./LIVE