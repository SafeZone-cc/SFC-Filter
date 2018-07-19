@echo off
SetLocal EnableExtensions
cd /d "%~dp0"

echo.
echo                             Скрипт фильтрации лога SFC
echo                                       от Alex Dragokas
echo.
echo.                                                v. 2.3
echo.
echo.

:: Фильтрация лога SFC
:: Использование - перетянуть лог на скрипт
:: Также лог может быть размещен рядом с батником под именем *sfcdoc*.log или *cbs*.log

:: Запуск без аргумента - анализ лога текущей системы


set curCBS=%SystemRoot%\Logs\CBS\CBS.log

  rem если запущен с аргументом

if "%~1" neq "" (

  rem Если это папка:

  if exist "%~1\" (
    call :SeekOnFolder "%~1" true|| (
      echo В указанной папке логов не найдено!
      echo.
      echo Работа скрипта будет завершена.
      pause >NUL
      exit /B 1
    )

  rem Если файл:

  ) else (
    set "CBS=%~1"
    set "clearCBS=%~dpn1_Clear%~x1"
    set "clearCBS_Rights=%~dpn1_Permissions%~x1"
  )

rem если запущен без аргумента, ищем лог рядом с батником

) else (

  call :SeekOnFolder .|| (

    rem Если лог рядом не найден, копируем CBS.log из системной папки в папку рядом с батником

    call :GetPrivileges || exit /B

    if not exist "%curCBS%" (
      echo Лог SFC на текущей системе не создан.
      echo.
      echo Нажмите ENTER, чтобы выполнить проверку целостности системнных файлов.
      pause >NUL
      sfc /scannow
    )

    copy /y "%curCBS%" ".\_CBS_Dragokas.log" || (
      echo Не удается скопировать лог SFC с локальной системы!
      echo.
      echo Работа скрипта будет завершена.
      pause >NUL
      exit /B 1
    )

    set "CBS=%~dp0_CBS_Dragokas.log"
    set "clearCBS=%~dp0_CBS_Clear.log"
    set "clearCBS_Rights=%~dp0_CBS_Permissions.log"
  )
)

:: Фильтрация
< "%CBS%" findstr /i /C:"[SR]" /C:"Hashes for file member" /C:"  Found:" | findstr /IV /C:"[SR] Verify complete" /C:"[SR] Verifying 100" /C:"[SR] Beginning Verify and Repair transaction" /C:"[SR] Verifying 1 components" > "%clearCBS%"
< "%CBS%" findstr /i /C:"[DIRSD OWNER WARNING]" /C:"ownership" | findstr /IV /C:"Ignoring duplicate ownership" > "%clearCBS_Rights%"

:: Удаляем временный файл
if exist "%~dp0_CBS_Dragokas.log" del /f /a "%~dp0_CBS_Dragokas.log"

:: Открыть "чистый" отчет программой по-умолчанию
rundll32 shell32.dll,ShellExec_RunDLL "%clearCBS%"

goto :eof


:GetPrivileges
  net session >NUL 2>NUL || (
    echo Будет получен лог ТЕКУЩЕЙ системы.
    echo.
    echo Требуются привилегии Администратора.
    echo.
    echo Нажмите ENTER.
    pause >NUL
    mshta "vbscript:CreateObject("Shell.Application").ShellExecute("%~fs0", "", "", "runas", 1) & Close()"
    exit /B 1
  )
exit /B

:SeekOnFolder [FolderPath] [UseRecursivity]
  if /i "%~2"=="true" (
    for /f "delims=" %%a in ('2^>NUL dir /b /a-d /s "%~1\*sfcdoc*.log" "%~1\*cbs*.log"^|findstr /ivrc:".*_Clear.log$"') do set "CBS=%%a"& set "clearCBS=%%~dpna_Clear%%~xa"& set "CBS_name=%%~nxa"
  ) else (
    for /f "delims=" %%a in ('2^>NUL dir /b /a-d "%~1\*sfcdoc*.log" "%~1\*cbs*.log"^|findstr /ivrc:".*_Clear.log$"') do set "CBS=%~dp0%%a"& set "clearCBS=%~dp0%%~na_Clear%%~xa"& set "CBS_name=%%a"
  )
  if defined CBS (
    echo Будет проведен анализ лога [ "%CBS_name%" ]  - %CBS%
    echo.
    echo Нажмите ENTER.
    pause >NUL
  ) else (
    exit /B 1
  )
exit /B
