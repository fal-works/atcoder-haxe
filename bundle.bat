@echo off
setlocal

:: Pass the hx file path and the target.
set FILE_PATH=%1
set TARGET=%2

echo bundle (%FILE_PATH%, %TARGET%)
haxelib run wronganswer bundle %FILE_PATH% %TARGET%

set NEW_FILE_PATH=%~dpn1.bundle.hx

echo.
if exist %NEW_FILE_PATH% clip < %NEW_FILE_PATH%
if exist %NEW_FILE_PATH% (echo Copied to clipboard!) else (echo File not found: %NEW_FILE_PATH%)

endlocal
