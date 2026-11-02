@echo off
title AlphaQuant AI - GitHub Upload Assistant
color 0b

echo ======================================================================
echo          AlphaQuant AI - GitHub Upload Assistant
echo ======================================================================
echo.
echo  This tool will prepare and upload your project to GitHub.
echo.

cd /d "%~dp0"

:: 1. Check if Git is installed
where git >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [1/4] Git is not detected on your system.
    echo       Attempting automatic installation via Windows Package Manager (winget)...
    echo.
    winget install --id Git.Git -e --source winget
    if %ERRORLEVEL% neq 0 (
        echo.
        echo [NOTICE] If winget is unavailable, please install Git from:
        echo          https://git-scm.com/download/win
        echo.
        echo After installing Git, restart this script.
        pause
        exit /b 1
    )
    echo.
    echo [OK] Git installed successfully! Refreshing environment...
    call refreshenv >nul 2>nul
)

:: 2. Initialize Git Repository
echo [2/4] Initializing local Git repository...
if not exist ".git" (
    git init -b main
)

:: 3. Stage and commit files
echo [3/4] Staging and committing files...
git config user.name >nul 2>nul
if %ERRORLEVEL% neq 0 (
    set /p GIT_NAME="Enter your name for Git commits: "
    set /p GIT_EMAIL="Enter your Google/GitHub email address: "
    git config user.name "%GIT_NAME%"
    git config user.email "%GIT_EMAIL%"
)

git add .
git commit -m "Initial release: AlphaQuant AI Indian Stock Market Terminal v3.2" >nul 2>nul

echo.
echo ======================================================================
echo  GitHub Repository Setup
echo ======================================================================
echo  1. Open your browser and go to: https://github.com/new
echo  2. Sign in with your Google account / GitHub credentials.
echo  3. Name the repository: stock-ai-platform
echo  4. Choose "Public" (or "Private") and leave "Initialize with README" UNCHECKED.
echo  5. Click "Create repository".
echo.
echo  Copy the HTTPS repository URL (e.g. https://github.com/your-username/stock-ai-platform.git)
echo ======================================================================
echo.

set /p REPO_URL="Paste your GitHub repository URL here: "

if "%REPO_URL%"=="" (
    echo [ERROR] No URL provided. Aborting.
    pause
    exit /b 1
)

echo.
echo [4/4] Pushing to GitHub...
git remote remove origin >nul 2>nul
git remote add origin %REPO_URL%
git branch -M main
git push -u origin main

echo.
if %ERRORLEVEL% equ 0 (
    echo ======================================================================
    echo  [SUCCESS] Project successfully uploaded to GitHub!
    echo ======================================================================
) else (
    echo ======================================================================
    echo  [NOTE] If GitHub asked for a password, use a GitHub Personal Access
    echo  Token (PAT) instead of your password.
    echo  Generate one at: https://github.com/settings/tokens
    echo ======================================================================
)

pause

