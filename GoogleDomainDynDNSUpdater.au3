#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=application.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Google Domain DynDNS Updater
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright (C) 2016 by xnohat
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Inet.au3>
#include "IniString.au3"

TraySetToolTip('Gooogle Domain DynDNS Updater');

; Document
; https://support.google.com/domains/answer/6147083

$externalIP = ReadURL('https://domains.google.com/checkip');
$dyndomain = IniRead(@ScriptDir & '\GoogleDomainDynDNSUpdater.ini','setting','dyndomain','novalue');
$username = IniRead(@ScriptDir & '\GoogleDomainDynDNSUpdater.ini','setting','username','novalue');
$password = IniRead(@ScriptDir & '\GoogleDomainDynDNSUpdater.ini','setting','password','novalue');
;MsgBox(0,0,$username)

While 1
$Response = ReadURL("https://"&$username&":"&$password&"@domains.google.com/nic/update?hostname="&$dyndomain&"&myip="&$externalIP)
;MsgBox(0,0,"DEBUG: Response from Google: " & $Response & @CRLF)
ConsoleWrite("DEBUG: Response from Google: " & $Response & @CRLF)
Sleep(300000);
WEnd

Func ReadURL($sURL)
	HttpSetUserAgent('Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36')

	; Read the file without downloading to a folder. The option of 'get the file from the local cache' has been selected.
	Local $dData = InetRead($sURL)

    ; The number of bytes read is returned using the @extended macro.
    Local $iBytesRead = @extended

    ; Convert the ANSI compatible binary string back into a string.
    Local $sData = BinaryToString($dData)

    ; Display the results.
    Return $sData
EndFunc