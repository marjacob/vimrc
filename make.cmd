@echo off
pushd "%~dp0"

set bundle=bundle.tgz
set packer=bin\win32\7za.exe

if [%1] == [] (
	call :create_archive
)

if /i "%1" == "bundle" (
	call :create_archive
)

if /i "%1" == "clean" (
	call :delete_archive
)

if /i "%1" == "init" (
	git submodule update --init --recursive
)

if /i "%1" == "update" (
	git submodule foreach git pull origin master
)

popd
exit /b 0

:create_archive
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
call :delete_archive

"%packer%" a -ttar -so -an^
	Makefile^
	README.md^
	make.cmd^
	vimrc^
	.gitignore^
	.gitmodules^
	autoload^
	bin^
	ftdetect^
	pack | "%packer%" a -si "%bundle%"
exit /b 0

:delete_archive
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist "%bundle%" (
	del "%bundle%"
)

exit /b 0

