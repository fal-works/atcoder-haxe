@echo off
setlocal

:: Pass the directory path that contains the test data.
set DIRECTORY_PATH=%1

echo.
echo.

for %%F in (%DIRECTORY_PATH%\*.txt) do (
  echo ---- %%~nF.txt ----
  REM echo.
  REM echo input:
  REM type %%F
  REM echo.
  REM echo.
  REM echo output:
  type %%F | node %~dp0bin\js\main.js
  echo.
)

endlocal
