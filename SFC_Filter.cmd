@echo off
SetLocal EnableExtensions
cd /d "%~dp0"

:: Фильтрация лога SFC
:: Использование - перетянуть лог на скрипт

:: Запуск без аргумента - анализ лога текущей системы

set curCBS=%SystemRoot%\Logs\CBS\CBS.log

:: если запущен без аргумента, копируем CBS.log из системной папки в папку рядом с батником
if "%~1"=="" (copy "%curCBS%" ".\_CBS_.log"& set "CBS=%~dp0_CBS_.log") else (set "CBS=%~1")
if "%~1"=="" (set "clearCBS=%~dp0_CBS_Clear.log") else (set "clearCBS=%~dpn1_Clear%~x1")

:: Фильтрация
< "%CBS%" find /i "[SR]" | find /v /i "[SR] Verify complete" | find /v /i "[SR] Verifying 100" | find /v /i "[SR] Beginning Verify and Repair transaction" > "%clearCBS%"

:: Удалить временный файл
if "%~1"=="" del /F /A "%CBS%"

:: Открыть "чистый" отчет программой по-умолчанию
rundll32 shell32.dll,ShellExec_RunDLL "%clearCBS%"
