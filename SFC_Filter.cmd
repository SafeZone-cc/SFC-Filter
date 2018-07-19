@echo off
SetLocal EnableExtensions
cd /d "%~dp0"

echo.
echo                             ��ਯ� 䨫���樨 ���� SFC
echo                                       �� Alex Dragokas
echo.
echo.                                                v. 2.1
echo.
echo.

:: �������� ���� SFC
:: �ᯮ�짮����� - �������� ��� �� �ਯ�
:: ����� ��� ����� ���� ࠧ��饭 �冷� � ��⭨��� ��� ������ *sfcdoc*.log ��� *cbs*.log

:: ����� ��� ��㬥�� - ������ ���� ⥪�饩 ��⥬�


set curCBS=%SystemRoot%\Logs\CBS\CBS.log

  rem �᫨ ����饭 � ��㬥�⮬

if "%~1" neq "" (

  rem �᫨ �� �����:

  if exist "%~1\" (
    call :SeekOnFolder "%~1" true|| (
      echo � 㪠������ ����� ����� �� �������!
      echo.
      echo ����� �ਯ� �㤥� �����襭�.
      pause >NUL
      exit /B 1
    )

  rem �᫨ 䠩�:

  ) else (
    set "CBS=%~1"
    set "clearCBS=%~dpn1_Clear%~x1"
    set "clearCBS_Rights=%~dpn1_Permissions%~x1"
  )

rem �᫨ ����饭 ��� ��㬥��, �饬 ��� �冷� � ��⭨���

) else (

  call :SeekOnFolder .|| (

    rem �᫨ ��� �冷� �� ������, �����㥬 CBS.log �� ��⥬��� ����� � ����� �冷� � ��⭨���

    call :GetPrivileges || exit /B

    if not exist "%curCBS%" (
      echo ��� SFC �� ⥪�饩 ��⥬� �� ᮧ���.
      echo.
      echo ������ ENTER, �⮡� �믮����� �஢��� 楫��⭮�� ��⥬���� 䠩���.
      pause >NUL
      sfc /scannow
    )

    copy /y "%curCBS%" ".\_CBS_Dragokas.log" || (
      echo �� 㤠���� ᪮��஢��� ��� SFC � �����쭮� ��⥬�!
      echo.
      echo ����� �ਯ� �㤥� �����襭�.
      pause >NUL
      exit /B 1
    )

    set "CBS=%~dp0_CBS_Dragokas.log"
    set "clearCBS=%~dp0_CBS_Clear.log"
    set "clearCBS_Rights=%~dp0_CBS_Permissions.log"
  )
)

:: ��������
< "%CBS%" findstr /i /C:"[SR]" /C:"Hashes for file member" /C:"  Found:" | findstr /IV /C:"[SR] Verify complete" /C:"[SR] Verifying 100" /C:"[SR] Beginning Verify and Repair transaction" /C:"[SR] Verifying 1 components" > "%clearCBS%"
< "%CBS%" findstr /i /C:"[DIRSD OWNER WARNING]" /C:"ownership" > "%clearCBS_Rights%"

:: ����塞 �६���� 䠩�
if exist "%~dp0_CBS_Dragokas.log" del /f /a "%~dp0_CBS_Dragokas.log"

:: ������ "����" ���� �ணࠬ��� ��-㬮�砭��
rundll32 shell32.dll,ShellExec_RunDLL "%clearCBS%"

goto :eof


:GetPrivileges
  net session >NUL 2>NUL || (
    echo �㤥� ����祭 ��� ������� ��⥬�.
    echo.
    echo �ॡ����� �ਢ������ �����������.
    echo.
    echo ������ ENTER.
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
    echo �㤥� �஢���� ������ ���� [ "%CBS_name%" ]  - %CBS%
    echo.
    echo ������ ENTER.
    pause >NUL
  ) else (
    exit /B 1
  )
exit /B
