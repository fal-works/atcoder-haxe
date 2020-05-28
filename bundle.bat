@echo off
setlocal

:: Pass the hx file path.
set FILE_PATH=%1

echo bundle (%FILE_PATH%, java)
haxelib run wronganswer bundle %FILE_PATH% java

set NEW_FILE_PATH=%~dpn1.bundle.hx

echo.
if exist %NEW_FILE_PATH% clip < %NEW_FILE_PATH%
if exist %NEW_FILE_PATH% (echo Copied to clipboard!) else (echo File not found: %NEW_FILE_PATH%)

endlocal
