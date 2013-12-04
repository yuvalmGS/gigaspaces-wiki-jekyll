@echo off
cd /d %~dp0

FOR %%a IN (sbp xap97 xap97net) DO (
	IF EXIST _includes\%%a rmdir _includes\%%a
	IF EXIST _includes\%%a del _includes\%%a
	IF EXIST _includes\%%a GOTO error
	mklink /D %~dp0_includes\%%a ..\%%a
	if ERRORLEVEL 1 GOTO error
	git update-index --assume-unchanged _includes\%%a
	if ERRORLEVEL 1 GOTO error
)

goto end

:error
echo Script failed - make sure you're running with administrative permissions.
pause

:end
pause
