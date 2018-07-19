' Установщик скрипта "AVZ DeQuarantine" в контекстное меню "Отправить".

Option Explicit
Dim oShell, oFSO, curPath, AppData, SendTo, InstFolder, AppLink, AppName, AppPath

Set oShell     = CreateObject("WScript.Shell")
Set oFSO       = CreateObject("Scripting.FileSystemObject")

AppName = "SFC Filter by Dragokas"
SendTo = oShell.SpecialFolders("SendTo")
AppData = oShell.SpecialFolders("AppData")
AppLink = SendTo & "\" & "SFC - фильтрация лога.lnk"

'Папка установки
InstFolder = AppData & "\SFC_Filter"
AppPath = InstFolder & "\" & "SFC_Filter.cmd"

curPath = oFSO.GetParentFolderName(WScript.ScriptFullname)

' UnInstaller
if oFSO.FileExists(AppPath) then
	if msgbox("SFC Filter уже установлен. Хотите удалить его?", vbYesNo, AppName) = vbYes then
		on error resume next
		if oFSO.FolderExists(InstFolder) then oFSO.DeleteFolder InstFolder, true
		if err.Number <> 0 then
			msgbox "Удалите самостоятельно папку: " & InstFolder
			oShell.Run "explorer.exe " & """" & InstFolder & """"
		end if
		oFSO.DeleteFile AppLink, true
	end if
	WScript.Quit
end if

'Проверка, что запущен не из архива
if not oFSO.FileExists(curPath & "\SFC_Filter.cmd") then
	WScript.Echo "Сначала нужно распаковать все файлы из архива."
	WScript.Quit
end if

'Создаю папку для установки приложения
if not oFSO.FolderExists(InstFolder) then oFSO.CreateFolder InstFolder

'Копирую файлы скрипта
oFSO.CopyFile curPath & "\SFC_Filter.cmd", InstFolder & "\", true
oFSO.CopyFile curPath & "\Icon.ico", InstFolder & "\", true

'Создание ярлыка в папке SendTo (контекстное меню)
with oShell.CreateShortcut(AppLink)
	.Description        = AppName
	.IconLocation       = InstFolder & "\" & "Icon.ico"
	.TargetPath         = AppPath
	.WorkingDirectory   = InstFolder
	.Save
end with

Msgbox "Скрипт установлен в контекстное меню Отправить (SendTo)." & vbCrLf & _
	   "Файлы приложения находятся в папке:" & vbCrLf & InstFolder,, AppName

Set oShell = Nothing: Set oFSO = Nothing
