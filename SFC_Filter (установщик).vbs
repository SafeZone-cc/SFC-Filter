' ���������� ������� "AVZ DeQuarantine" � ����������� ���� "���������".

Option Explicit
Dim oShell, oFSO, curPath, AppData, SendTo, InstFolder, AppLink, AppName, AppPath

Set oShell     = CreateObject("WScript.Shell")
Set oFSO       = CreateObject("Scripting.FileSystemObject")

AppName = "SFC Filter by Dragokas"
SendTo = oShell.SpecialFolders("SendTo")
AppData = oShell.SpecialFolders("AppData")
AppLink = SendTo & "\" & "SFC - ���������� ����.lnk"

'����� ���������
InstFolder = AppData & "\SFC_Filter"
AppPath = InstFolder & "\" & "SFC_Filter.cmd"

curPath = oFSO.GetParentFolderName(WScript.ScriptFullname)

' UnInstaller
if oFSO.FileExists(AppPath) then
	if msgbox("SFC Filter ��� ����������. ������ ������� ���?", vbYesNo, AppName) = vbYes then
		on error resume next
		if oFSO.FolderExists(InstFolder) then oFSO.DeleteFolder InstFolder, true
		if err.Number <> 0 then
			msgbox "������� �������������� �����: " & InstFolder
			oShell.Run "explorer.exe " & """" & InstFolder & """"
		end if
		oFSO.DeleteFile AppLink, true
	end if
	WScript.Quit
end if

'��������, ��� ������� �� �� ������
if not oFSO.FileExists(curPath & "\SFC_Filter.cmd") then
	WScript.Echo "������� ����� ����������� ��� ����� �� ������."
	WScript.Quit
end if

'������ ����� ��� ��������� ����������
if not oFSO.FolderExists(InstFolder) then oFSO.CreateFolder InstFolder

'������� ����� �������
oFSO.CopyFile curPath & "\SFC_Filter.cmd", InstFolder & "\", true
oFSO.CopyFile curPath & "\Icon.ico", InstFolder & "\", true

'�������� ������ � ����� SendTo (����������� ����)
with oShell.CreateShortcut(AppLink)
	.Description        = AppName
	.IconLocation       = InstFolder & "\" & "Icon.ico"
	.TargetPath         = AppPath
	.WorkingDirectory   = InstFolder
	.Save
end with

Msgbox "������ ���������� � ����������� ���� ��������� (SendTo)." & vbCrLf & _
	   "����� ���������� ��������� � �����:" & vbCrLf & InstFolder,, AppName

Set oShell = Nothing: Set oFSO = Nothing
