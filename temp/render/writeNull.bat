setlocal enabledelayedexpansion
set /a mapLoaderx=0
set /a mapLoadery=0
for /l %%i in (1,1,14) do (
set /a mapLoadery+=30
	for /l %%j in (1,1,30) do (
		set /a mapLoaderx+=30
		echo ./blocks/null.bmp !mapLoaderx! !mapLoadery!>> null.bwdata
		if !mapLoaderx! == 900 set /a mapLoaderx=0
	)
)