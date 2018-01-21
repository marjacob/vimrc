@echo off

set self=%~nx0
set vimrc=%userprofile%\_vimrc
set vimfiles=%userprofile%\vimfiles
set viminfo=%userprofile%\_viminfo

where git >nul 2>&1

if not errorlevel 0 (
	echo.
	echo   MISSING REQUIREMENT
	echo     Git is required by the plugin manager
	echo.
	echo   INSTALL
	echo     1. Install Git from https://git-scm.com/download/win
	echo     2. Select "Use Git from the Windows Command Prompt"
	echo     3. Execute "%self%" in a new command prompt instance
	echo     4. Execute :PlugInstall in Vim
	echo.

	exit /b 1
)

:: Move to script directory.
pushd "%~dp0"

:: Install configuration file.
copy /v /y "vimrc" "%vimrc%"

:: Install configuration directory.
xcopy "vim" "%vimfiles%" /e /i /h /y

:: Install empty history file.
if not exist "%viminfo%" (
	copy /y nul "%viminfo%" >nul
)

:: Hide installed files.
attrib +h "%vimfiles%"
attrib +h "%viminfo%"
attrib +h "%vimrc%"

:: Move to initial working directory.
popd

