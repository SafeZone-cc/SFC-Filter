@echo off
SetLocal EnableExtensions
cd /d "%~dp0"

:: �������� ���� SFC
:: �ᯮ�짮����� - �������� ��� �� �ਯ�

:: ����� ��� ��㬥�� - ������ ���� ⥪�饩 ��⥬�

set curCBS=%SystemRoot%\Logs\CBS\CBS.log

:: �᫨ ����饭 ��� ��㬥��, �����㥬 CBS.log �� ��⥬��� ����� � ����� �冷� � ��⭨���
if "%~1"=="" (copy "%curCBS%" ".\_CBS_.log"& set "CBS=%~dp0_CBS_.log") else (set "CBS=%~1")
if "%~1"=="" (set "clearCBS=%~dp0_CBS_Clear.log") else (set "clearCBS=%~dpn1_Clear%~x1")

:: ��������
< "%CBS%" find /i "[SR]" | find /v /i "[SR] Verify complete" | find /v /i "[SR] Verifying 100" | find /v /i "[SR] Beginning Verify and Repair transaction" > "%clearCBS%"

:: ������� �६���� 䠩�
if "%~1"=="" del /F /A "%CBS%"

:: ������ "����" ���� �ணࠬ��� ��-㬮�砭��
rundll32 shell32.dll,ShellExec_RunDLL "%clearCBS%"
