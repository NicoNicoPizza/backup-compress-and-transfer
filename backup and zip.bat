@echo off

::File locations
NET USE Z: \\10.10.100.10\logs_backup /PERSISTENT:YES /user:EXAMPLEDOMAIN\exampleuser examplepassword
set backup_destination=\\10.10.100.27\logs_backup\App Config
set dateNtime="%date:~0,2%-%date:~3,2%-%date:~6,6%_%time:~0,2%-%time:~3,2%"
set hostname="%computername%"
set backup_source=C:\Users\exampleuser\Downloads\App Config\*

::Copy file
set backuptask=XCOPY /C /D /E /I /Y

::Backup file with the established parameters
echo Backing up file
%backuptask% %backup_source% %backup_destination%\%hostname%_%dateNtime%_logs

::Compress file
"C:\Program Files\7-zip\7z" A -R "%backup_destination%\%hostname%_%dateNtime%_logs" "%backup_destination%\%hostname%_%dateNtime%_logs"

::Delete original uncompressed file
rmdir /S /Q "%backup_destination%\%hostname%_%dateNtime%_logs"

echo Backup done
echo PAUSE>NULL
