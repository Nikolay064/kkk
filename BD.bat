@echo off
SetLocal EnableDelayedExpansion

rem =============================
rem ====== admin variables ======
rem =============================

set DirName=2016
set SourceDir=G:\Cherteji_pasporta\Pasporta\Lebedki\%DirName%
set BackupDir=Y:\Backups\Nikolay\%DirName%\daily\
set NumFolders=2

rem =============================
rem ======== 7-Zip path =========
rem =============================

set a7z=%ProgramFiles%\7-Zip\7z.exe

rem =============================
rem == create backup directory == 
rem ==== DD.MM.YYYY_hhmmmss =====
rem =============================

set h=%time:~0,2%
set h=%h: =0%
set FullBackupDir=%BackupDir%%date%_%h%%time:~3,2%%time:~6,2%\
md %FullBackupDir%

rem =============================
rem ====== copy directory =======
rem =============================

xcopy %SourceDir% %FullBackupDir%%DirName%\ /E /F /H /R /K /Y /D 2>nul >nul

rem =============================
rem ====== zip directory ========
rem =============================

"%a7z%" a -tzip -bb0 -bd -sdel "%FullBackupDir%%DirName%.zip" "%FullBackupDir%" 2>nul >nul

rem =============================
rem ==== remove old folders =====
rem =============================

for /f "tokens=* delims=" %%D in ('dir %BackupDir% /ad /b /o-d') do (
	if not %%D=="" (
		if not !NumFolders!==0 (
			set /a NumFolders-=1
		) else (
			rd /s /q %BackupDir%%%D 2>nul >nul
		)
	)
)