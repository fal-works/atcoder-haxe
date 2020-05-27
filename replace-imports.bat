@echo off
setlocal

:: Pass the hx file path.
set FILE_PATH=%1

echo replace-imports (%FILE_PATH%, java)
haxelib run wronganswer replace-imports %FILE_PATH% java

clip < %FILE_PATH%.replaced
echo.
echo Copied to clipboard!

endlocal
