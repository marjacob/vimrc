@echo off

set self=%~nx0
set vimrc=%userprofile%\_vimrc
set vimfiles=%userprofile%\vimfiles
set viminfo=%userprofile%\_viminfo

where git >nul 2>&1

if not errorlevel 0 (
	set url=https://git-scm.com/download/win

	echo.
	echo   MISSING REQUIREMENT
	echo     Git is required by the plugin manager
	echo.
	echo   INSTALL
	echo     1. Install Git from %url%
	echo     2. Select "Use Git from the Windows Command Prompt"
	echo     3. Execute %self% in a new command prompt instance
	echo.

	exit /b 1
)

if not defined GIT_SSH (
	set url=https://www.chiark.greenend.org.uk/~sgtatham/putty/

	echo.
	echo   MISSING REQUIREMENT
	echo     PuTTY is required for passwordless Git
	echo.
	echo   INSTALL
	echo     1. Install PuTTY from %url%
	echo     2. Go to System Properties > Environment Variables
	echo     3. Add system variable GIT_SSH with the path to plink.exe
	echo     3. Execute %self% in a new command prompt instance
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

echo.
echo   INSTALL COMPLETED
echo     Run Vim and execute :PlugInstall to install plugins
echo.

exit /b 0

