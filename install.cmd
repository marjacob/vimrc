@ECHO OFF

SET vimrc=%USERPROFILE%\_vimrc
SET vimfiles=%USERPROFILE%\vimfiles
SET viminfo=%USERPROFILE%\_viminfo

:: Move to script directory.
PUSHD "%~dp0"

:: Install configuration file.
COPY /V /Y "vimrc" "%vimrc%"

:: Install configuration directory.
XCOPY "vim" "%vimfiles%" /E /I /H /Y

:: Install empty history file.
IF NOT EXIST "%viminfo%" (
	COPY /Y NUL "%viminfo%" >NUL
)

:: Hide installed files.
ATTRIB +H "%vimfiles%"
ATTRIB +H "%viminfo%"
ATTRIB +H "%vimrc%"

:: Move to initial working directory.
POPD

