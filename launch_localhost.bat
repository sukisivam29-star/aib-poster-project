@echo off
title AlphaQuant AI - Indian Stock Market Terminal
color 0b

echo ======================================================================
echo          AlphaQuant AI - Terminal v3.2 (NSE & BSE India)
echo ======================================================================
echo.
echo  Starting local web server and launching your browser...
echo.

cd /d "%~dp0"

:: Execute native PowerShell TCP server (zero external dependencies, auto-opens browser)
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1" -Port 8080

echo.
echo Server has been stopped.
pause
