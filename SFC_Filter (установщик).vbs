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

'' SIG '' Begin signature block
'' SIG '' MIIQIgYJKoZIhvcNAQcCoIIQEzCCEA8CAQExCzAJBgUr
'' SIG '' DgMCGgUAMGcGCisGAQQBgjcCAQSgWTBXMDIGCisGAQQB
'' SIG '' gjcCAR4wJAIBAQQQTvApFpkntU2P5azhDxfrqwIBAAIB
'' SIG '' AAIBAAIBAAIBADAhMAkGBSsOAwIaBQAEFDmU4D/3e0pl
'' SIG '' cY1+FZXwii1RLqHyoIICDDCCAggwggF1oAMCAQICEPTb
'' SIG '' 3W6cNZGsSlw56VqCU28wCQYFKw4DAh0FADAYMRYwFAYD
'' SIG '' VQQDEw1BbGV4IERyYWdva2FzMB4XDTE0MDYzMDIwNTk0
'' SIG '' MloXDTM5MTIzMTIzNTk1OVowGDEWMBQGA1UEAxMNQWxl
'' SIG '' eCBEcmFnb2thczCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
'' SIG '' gYkCgYEA0ZF2vv2gn+17UGx/QNKdOdEKeCjk/cz0zjFv
'' SIG '' qb59WEg9CP975lku7nklgPOKw3w/O4vfSjurwYW9Yh9c
'' SIG '' Ldef6UVN0NBooVRtZ3H8LAk5s/6h3/bOGhbHQxV4EakA
'' SIG '' h84zkK4eBr3wR1lOT9RC2+zruwGlG1KJPHkZE5ex+yyU
'' SIG '' KAcCAwEAAaNbMFkwDAYDVR0TAQH/BAIwADBJBgNVHQEE
'' SIG '' QjBAgBAg3Mm7xHMuIoLCqkkoBotCoRowGDEWMBQGA1UE
'' SIG '' AxMNQWxleCBEcmFnb2thc4IQ9Nvdbpw1kaxKXDnpWoJT
'' SIG '' bzAJBgUrDgMCHQUAA4GBAF7S7++1pq0cQKeHkD2wCbbR
'' SIG '' nfrOA6F26AT6Ol0UHXbvHl92M+UzuNrkT+57LH0kG9eu
'' SIG '' UlDbrP4kytNQ7FtL8o/IS5tvORwuTsrs4AGrzfpKm2KH
'' SIG '' y0EIMGJbIW3OoHHpiVqZK2eEW5HuSqaE+xTs05vfgBho
'' SIG '' TugVef8DA2tnrOgpMYINgjCCDX4CAQEwLDAYMRYwFAYD
'' SIG '' VQQDEw1BbGV4IERyYWdva2FzAhD0291unDWRrEpcOela
'' SIG '' glNvMAkGBSsOAwIaBQCgUjAQBgorBgEEAYI3AgEMMQIw
'' SIG '' ADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAjBgkq
'' SIG '' hkiG9w0BCQQxFgQUqJorJr1JNIvK47YgCygoskEdNbcw
'' SIG '' DQYJKoZIhvcNAQEBBQAEgYACDKk6cUysTsBRorha+DiK
'' SIG '' 5wS2UMvf0mBkWkPvwVvrrKqGWgfptfGZXdPE0b7sYCoV
'' SIG '' EQYFxtRWu9K/x5xSH8rlqYq3P+TSDG7Jl2WulqRFCKvy
'' SIG '' RVFmMPE7XZ6yahz9ZIkTFfnYfDQGU3lfhjh2YurWmNJK
'' SIG '' ugshRp3DwcdEJARORKGCDFgwggxUBgorBgEEAYI3AwMB
'' SIG '' MYIMRDCCDEAGCSqGSIb3DQEHAqCCDDEwggwtAgEDMQsw
'' SIG '' CQYFKw4DAhoFADCBzQYLKoZIhvcNAQkQAQSggb0Egbow
'' SIG '' gbcCAQEGCSsGAQQBoDICAjAhMAkGBSsOAwIaBQAEFEyF
'' SIG '' RrR6+2yB77wqRsvrYHClZsUIAhR58V85+hb0tbKQpuLa
'' SIG '' ObtwS98x1xgPMjAxNTA5MTkxNDUyMTBaoF2kWzBZMQsw
'' SIG '' CQYDVQQGEwJTRzEfMB0GA1UEChMWR01PIEdsb2JhbFNp
'' SIG '' Z24gUHRlIEx0ZDEpMCcGA1UEAxMgR2xvYmFsU2lnbiBU
'' SIG '' U0EgZm9yIFN0YW5kYXJkIC0gRzKgggi0MIIEmDCCA4Cg
'' SIG '' AwIBAgISESFFAutjFQylsZUj8VNWkS/lMA0GCSqGSIb3
'' SIG '' DQEBBQUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
'' SIG '' bG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxT
'' SIG '' aWduIFRpbWVzdGFtcGluZyBDQSAtIEcyMB4XDTE1MDIw
'' SIG '' MzAwMDAwMFoXDTI2MDMwMzAwMDAwMFowWTELMAkGA1UE
'' SIG '' BhMCU0cxHzAdBgNVBAoTFkdNTyBHbG9iYWxTaWduIFB0
'' SIG '' ZSBMdGQxKTAnBgNVBAMTIEdsb2JhbFNpZ24gVFNBIGZv
'' SIG '' ciBTdGFuZGFyZCAtIEcyMIIBIjANBgkqhkiG9w0BAQEF
'' SIG '' AAOCAQ8AMIIBCgKCAQEApLbCTEUO4rBsJZ6Cd3QPTcR5
'' SIG '' oedNN1N4NG+GyrukMrQtwSqqY/v1a/+4KVmJET/bejo4
'' SIG '' wo4pgSPUMw0gpeQUMWSM/qhs5RI/2JyYlp6Fvd7vhsAa
'' SIG '' vsvTjbVS5yXaLQJxciT3rN5jxGs55jT0Qske6yz1FEyZ
'' SIG '' eH3bz/SKo4haoeQ4ebo/iT4R2Y5S7s4nmeDsWKgeshT4
'' SIG '' aLpvLQDUkglAGtkC5pwlWtC403LfDmyp/fWd3aCDG3qB
'' SIG '' mEBQ8WC2MGslldu63IHe+o+Mw1iyDy71sJg3Ac4KHffx
'' SIG '' vKubQK10j3CUJZ8LyrT/zjWXAHvZWoFpwtrJoXW6Hs7E
'' SIG '' FzUbscvLTQIDAQABo4IBXzCCAVswDgYDVR0PAQH/BAQD
'' SIG '' AgeAMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEeMDQwMgYI
'' SIG '' KwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24u
'' SIG '' Y29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwFgYDVR0l
'' SIG '' AQH/BAwwCgYIKwYBBQUHAwgwQgYDVR0fBDswOTA3oDWg
'' SIG '' M4YxaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
'' SIG '' c3RpbWVzdGFtcGluZ2cyLmNybDBUBggrBgEFBQcBAQRI
'' SIG '' MEYwRAYIKwYBBQUHMAKGOGh0dHA6Ly9zZWN1cmUuZ2xv
'' SIG '' YmFsc2lnbi5jb20vY2FjZXJ0L2dzdGltZXN0YW1waW5n
'' SIG '' ZzIuY3J0MB0GA1UdDgQWBBRPNUG1+UqSzkgpUEsDLLN3
'' SIG '' +ipAtDAfBgNVHSMEGDAWgBRG2D7/3OO+/4Pm9IWbsN1q
'' SIG '' 1hSpwTANBgkqhkiG9w0BAQUFAAOCAQEAg6MHSDloH9JT
'' SIG '' v7P4gxNxle6XLVh9rT6cx4UBSM0JNgIhPtsImZ6GezVw
'' SIG '' akoQr6wDc2LukuW7wffH6sjtbGwa/C/QFzfjjuyzd+T7
'' SIG '' WgfLjEzVl9WX1M9xa4L5UHcsA770lxx+aQ5d3US7Zl/R
'' SIG '' 5ENMWkUxDCMQaTjckXMuX5DG30+n8xhrwXXmjSPqRn7R
'' SIG '' XQLeGcwgshyj5b5aDWp677SEu0ip4tPnq21PhXraNLmb
'' SIG '' Y+Ln5fmvQ9WzL+ReeCO1z3WoVFZoGOg7UYKopk6I2viq
'' SIG '' QHlJXZhFZ3AJqXufQX5glP/TOjpPBor39rW+1RcJFH38
'' SIG '' t/3Lqt0Kb1kySSUZ8VgygDCCBBQwggL8oAMCAQICCwQA
'' SIG '' AAAAAS9O4VLXMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNV
'' SIG '' BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
'' SIG '' MRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9i
'' SIG '' YWxTaWduIFJvb3QgQ0EwHhcNMTEwNDEzMTAwMDAwWhcN
'' SIG '' MjgwMTI4MTIwMDAwWjBSMQswCQYDVQQGEwJCRTEZMBcG
'' SIG '' A1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
'' SIG '' R2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBHMjCC
'' SIG '' ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJTv
'' SIG '' Zfi1V5+gUw00BusJH7dHGGrL8Fvk/yelNNH3iRq/nrHN
'' SIG '' EkFuZtSBoIWLZFpGL5mgjXex4rxc3SLXamfQu+jKdN6L
'' SIG '' Tw2wUuWQW+tHDvHnn5wLkGU+F5YwRXJtOaEXNsq5oIwb
'' SIG '' TwgZ9oExrWEWpGLmtECew/z7lfb7tS6VgZjg78Xr2AJZ
'' SIG '' eHf3quNSa1CRKcX8982TZdJgYSLyBvsy3RZR+g79ijDw
'' SIG '' Fwmnu/MErquQ52zfeqn078RiJ19vmW04dKoRi9rfxxRM
'' SIG '' 6YWy7MJ9SiaP51a6puDPklOAdPQD7GiyYLyEIACDG6Hu
'' SIG '' tHQFwSmOYtBHsfrwU8wY+S47+XB+tCUCAwEAAaOB5TCB
'' SIG '' 4jAOBgNVHQ8BAf8EBAMCAQYwEgYDVR0TAQH/BAgwBgEB
'' SIG '' /wIBADAdBgNVHQ4EFgQURtg+/9zjvv+D5vSFm7DdatYU
'' SIG '' qcEwRwYDVR0gBEAwPjA8BgRVHSAAMDQwMgYIKwYBBQUH
'' SIG '' AgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3Jl
'' SIG '' cG9zaXRvcnkvMDMGA1UdHwQsMCowKKAmoCSGImh0dHA6
'' SIG '' Ly9jcmwuZ2xvYmFsc2lnbi5uZXQvcm9vdC5jcmwwHwYD
'' SIG '' VR0jBBgwFoAUYHtmGkUNl8qJUC99BM00qP/8/UswDQYJ
'' SIG '' KoZIhvcNAQEFBQADggEBAE5eVpAeRrTZSTHzuxc5KBvC
'' SIG '' Ft39QdwJBQSbb7KimtaZLkCZAFW16j+lIHbThjTUF8xV
'' SIG '' OseC7u+ourzYBp8VUN/NFntSOgLXGRr9r/B4XOBLxRjf
'' SIG '' OiQe2qy4qVgEAgcw27ASXv4xvvAESPTwcPg6XlaDzz37
'' SIG '' Dbz0xe2XnbnU26UnhOM4m4unNYZEIKQ7baRqC6GD/Sjr
'' SIG '' 2u8o9syIXfsKOwCr4CHr4i81bA+ONEWX66L3mTM1fsua
'' SIG '' irtFTec/n8LZivplsm7HfmX/6JLhLDGi97AnNkiPJm87
'' SIG '' 7k12H3nD5X+WNbwtDswBsI5//1GAgKeS1LNERmSMh08W
'' SIG '' YwcxS2Ow3/MxggKRMIICjQIBATBoMFIxCzAJBgNVBAYT
'' SIG '' AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgw
'' SIG '' JgYDVQQDEx9HbG9iYWxTaWduIFRpbWVzdGFtcGluZyBD
'' SIG '' QSAtIEcyAhIRIUUC62MVDKWxlSPxU1aRL+UwCQYFKw4D
'' SIG '' AhoFAKCB/zAaBgkqhkiG9w0BCQMxDQYLKoZIhvcNAQkQ
'' SIG '' AQQwHAYJKoZIhvcNAQkFMQ8XDTE1MDkxOTE0NTIxMFow
'' SIG '' IwYJKoZIhvcNAQkEMRYEFLQFLrb5IlpihkiH0DJbpiG7
'' SIG '' 4PIeMIGdBgsqhkiG9w0BCRACDDGBjTCBijCBhzCBhAQU
'' SIG '' GeGaY9X5bNLJB4dEnxcq05WxZbYwbDBWpFQwUjELMAkG
'' SIG '' A1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
'' SIG '' c2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gVGltZXN0YW1w
'' SIG '' aW5nIENBIC0gRzICEhEhRQLrYxUMpbGVI/FTVpEv5TAN
'' SIG '' BgkqhkiG9w0BAQEFAASCAQAlXz5SxJT7Lgp56XMTHt+d
'' SIG '' 0QFbK3CgggOHE7Tb1wFcJk1mTIGP9gn17SMVXrQmXrFp
'' SIG '' e5mMTDe8K37As/ZRHgAfp38r94QMSYb0gc2MLVf/h5de
'' SIG '' ZEfCmXkA4Bg/RxoELCK4CNmNLmtdcTX/R9OZ7V/BXSNO
'' SIG '' BzHIi6ZPvXIVLiihHwF5oKOxCbM01M7C8Rztj8H+R45l
'' SIG '' QRUnzsqQ2t01gFusJnk9PsrKD9dJhX9r2Keu1kEqJfsJ
'' SIG '' sfmxKNouK+4IOyjaN8YrsjsdLOHaG/hNFMnpehZLVOWx
'' SIG '' QWN+6a0R8OFbFX40vjTXrPa+WHatZpsi8tl+dFXTtZEY
'' SIG '' uG2Dle+45tdU
'' SIG '' End signature block
