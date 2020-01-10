@echo off
setlocal enabledelayedexpansion
set handblock=blocks/stone.bmp
set Version=Alpha Build89158
set Copyright=WinslowSorenEricMent
set /a time=0
set Command_dir=command/
set bar=GUI/bar.bmp
set chobar=choice1
set choice1=blocks/stone.bmp
set choice2=blocks/brick.bmp
set choice3=blocks/cobblestone.bmp
set choice4=blocks/dirt.bmp
set choice5=blocks/obsidian.bmp
set choice6=blocks/grass_block.bmp

title Build World %Version%
mode con cols=150 lines=35
rem wget http://file.blankwings.cn/files/updataTF.txt
rem set /p TF=<updataTF.txt
rem if %TF% == True goto T
rem if %TF% == False goto main
rem :T
rem wget http://file.blankwings.cn/files/updata.bat
goto main
:main
mode con cols=120 lines=35
title Build World %Version%
del updataTF.txt
del updata.bat

image gui/start.bmp 0 0
powershell sleep 1
goto GUI_l
:GUI_l
for /l %%i in (0,30,540) do (
	for /l %%j in (0,30,930) do (
	set /a rand=!random!%%11
	if !rand! == 0 set GUIblocknow=blocks/air.bmp
	if !rand! == 1 set GUIblocknow=blocks/brick.bmp
	if !rand! == 2 set GUIblocknow=blocks/coal_block.bmp
	if !rand! == 3 set GUIblocknow=blocks/coal_ore.bmp
	if !rand! == 4 set GUIblocknow=blocks/cobblestone.bmp
	if !rand! == 5 set GUIblocknow=blocks/stone.bmp
	if !rand! == 6 set GUIblocknow=blocks/rose_pyroxene.bmp
	if !rand! == 7 set GUIblocknow=blocks/grass_block.bmp	
	if !rand! == 8 set GUIblocknow=blocks/dirt.bmp	
	if !rand! == 9 set GUIblocknow=blocks/code_block.bmp
	if !rand! == 10 set GUIblocknow=blocks/obsidian.bmp	
	if !rand! == 11 set GUIblocknow=blocks/NULL.bmp
	if !rand! == 12 set GUIblocknow=blocks/clode_block.bmp
	echo ./!GUIblocknow! %%j %%i>>temp/render/render.bwdata
	)
)
image /l temp/render/render.bwdata
imageplus GUI/gray.png 0 0
imageplus GUI/buildworld.png 150 40
imageplus GUI/button1.png 180 220
imageplus GUI/button2.png 180 265
goto GUI_c
:GUI_c
cmos 0 -1 -1
pmosx
set x=%errorlevel%
pmosy
set y=%errorlevel%
if %x% GEQ 180 if %x% LEQ 780 if %y% GEQ 220 if %y% LEQ 240 goto game
if %x% GEQ 180 if %x% LEQ 780 if %y% GEQ 265 if %y% LEQ 285 goto settings
goto GUI_c
:game
image gui/game.bmp 0 0
image gui/void.bmp 30 30
rem Loadingvarmap
for /l %%i in (1,1,14) do (
	for /l %%j in (1,1,30) do (
		set /p arr%%i_%%j=<saves/map/chunks/%%i/x%%j.txt
	)
)
set /a mapLoaderx=0
set /a mapLoadery=0
for /l %%i in (1,1,14) do (
set /a mapLoadery+=30
	for /l %%j in (1,1,30) do (
		set /a mapLoaderx+=30
		echo !arr%%i_%%j! !mapLoaderx! !mapLoadery!>> temp/render/map.bwdata
		if !mapLoaderx! == 900 set /a mapLoaderx=0
	)
)
for /l %%i in (390,30,540) do (
	imageplus !bar! %%i 450 30 30
)
imageplus GUI/chobar.bmp 390 450 30 30
set /a barer1=395
for /l %%i in (1,1,6) do (
imageplus !choice%%i! !barer1! 455 20 20
set /a barer1+=30
)
goto RenderingMap

:RenderingMap 
image /l  temp/render/null.bwdata
image /l  temp/render/map.bwdata

image blocks/code_block.bmp 0 0
imageplus GUI/breaker.png 115 460 60 60
goto SelectBox
:SelectBox
goto SetBlockCheck
:SetBlockCheck
cmos 0 -1 -1
pmosx
set x=%errorlevel%
pmosy
set y=%errorlevel%
set /a setblockerx1=0
set /a setblockerx2=30
set /a setblockery1=0
set /a setblockery2=30
rem if %x% == -1 if %y% == -1 mshta vbscript:msgbox("pause",1,"pause") && goto SetBlockCheck
rem for /l %%i in (1,1,14) do (
rem	for /l %%j in (1,1,30) do (
rem	)
rem )
for /l %%i in (30,30,420) do (
	set /a setblockery1+=30
	set /a setblockery2+=30
	for /l %%j in (30,30,900) do (
		set /a setblockerx1+=30
		set /a setblockerx2+=30
		if !x! GEQ !setblockerx1! if !x! LEQ !setblockerx2! if !y! GEQ !setblockery1! if !y! LEQ !setblockery2! imageplus !handblock! %%j %%i 30 30
		if !setblockerx1! == 900 set /a setblockerx1=0
		if !setblockerx2! == 930 set /a setblockerx2=30
	)
if !setblockery1! == 420 set /a setblockery1=0
if !setblockery2! == 450 set /a setblockery2=30
)
set /a barer2=390
set /a barer3=420
for /l %%i in (1,1,6) do (
if !x! GEQ !barer2! if !x! LEQ !barer3! if !y! GEQ 450 if !y! LEQ 480 set handblock=!choice%%i! && set chobar=choice%%i
set /a barer2+=30
set /a barer3+=30
)
if !x! GEQ 115 if !x! LEQ 175 if !y! GEQ 460 if !y! LEQ 520 set handblock=blocks/air.bmp
goto SetBlockCheck
pause>nul
:EndPoem
:CommandSystem
Echo Build World Version:[shapshot:0w3a]-Test
Echo Copyright (c) 2017 ZYEHSOFT Corporation
set /p Command="%Command_dir%>_"
if %Command% == exitc goto SetBlockCheck
if %Command% == reloadall goto main
call %Command_dir%%Command%.exe

:settings
image /l temp/render/render.bwdata
imageplus GUI/gray.png 0 0
pause>nul
