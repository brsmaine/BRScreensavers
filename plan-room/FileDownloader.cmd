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

rem set remoteUri = "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/5424x5424.jpg"
rem set filename = "Z:\LeightonProjects\TEST\%HR%.jpg"

CD C:\Users\Plan_Room\Screensaver\
echo %time% > lastRun.txt
REM if not exist .\%HR% mkdir %HR%

REM /*** USE HOUR FOR FILENAME ***/
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/5424x5424.jpg','C:\Users\Plan_Room\Screensaver\%HR%.jpg')"
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://sdo.gsfc.nasa.gov/assets/img/latest/latest_1024_211193171.jpg','C:\Users\Plan_Room\Screensaver\SUN_%HR%.jpg')"
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://svs.gsfc.nasa.gov/vis/a000000/a005100/a005187/frames/730x730_1x1_30p/moon.7603.jpg','C:\Users\Plan_Room\Screensaver\MOON_%HR%.jpg')"
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.swpc.noaa.gov/sites/default/files/styles/medium/public/Total Electron Content.png','C:\Users\Plan_Room\Screensaver\ELECTRONS_%HR%.jpg')"
Powershell.exe -Command "(New-Object System.Net.WebClient).DownloadFile('https://wave.marineweather.net/itide/tides/png/me_boothbay_harbor.png?x=1731435698','C:\Users\Plan_Room\Screensaver\TIDES_%HR%.png')"

magick SUN_%HR%.jpg -resize 1792x1792 SUN_%HR%b.JPG
magick SUN_%HR%b.jpg blackspace.jpg -gravity center -background "black" -append STEP1.JPG
magick ELECTRONS_%HR%.jpg -resize 1953x2399 ELECTRONS_%HR%b.jpg
magick STEP1.jpg ELECTRONS_%HR%b.jpg -gravity center -background "black" -append STEP2.JPG
magick STEP2.jpg blackspace.jpg -gravity center -background "black" -append STEP3.JPG
magick STEP3.jpg MOON_%HR%.jpg -gravity center -background "black" -append STEP4.JPG
magick STEP4.jpg blackspace.jpg -gravity center -background "black" -append STEP5.JPG
magick TIDES_%HR%.png -resize 2118x915 TIDES_%HR%b.png
magick STEP5.jpg TIDES_%HR%b.png -gravity center -background "black" -append STEP6.JPG
magick %HR%.jpg STEP6.jpg -background "black" +append %HR%_FINAL.JPG
del STEP*.*
move /y %HR%_FINAL.jpg .\LIVE

REM /*** USE MINUTE FOR FILENAME ***/
REM bitsadmin /TRANSFER globejob /download /priority normal https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/5424x5424.jpg C:\Users\Plan_Room\Screensaver\%HR%\%MIN%.jpg

REM /*** USE SECOND FOR FILENAME ***/
REM bitsadmin /TRANSFER globejob /download /priority normal https://cdn.star.nesdis.noaa.gov/GOES16/ABI/FD/GEOCOLOR/5424x5424.jpg C:\Users\Plan_Room\Screensaver\%SEC%.jpg

