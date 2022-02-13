cd %~dp0\..\Hawkeye\src

for %%f in ( ^
custom\hotstrings.ahk ^
custom\keymap.ahk ^
custom\my_udf.ahk ^
gui\GUI.ahk ^
gui\UserCommands.ahk ^
miscellaneous\miscellaneous.ahk ^
hawkeye.ahk ) ^
do xcopy %%f ..\released\%%f /Y
