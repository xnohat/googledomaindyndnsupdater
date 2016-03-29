#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=application.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Google Domain DynDNS Updater Setup
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright (c) 2016 by xnohat
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "CustomMsgBox.au3"

;----Setup Hardcode Setting----
$InstallDialogTitle = 'Google Domain DynDNS Updater';
$DestDir = @AppDataDir & '\GoogleDomainDynDNSUpdater\';

;----Uninstall Files if Exist----

;Just Example
;$ButtPressed = xMsgBox(16+0x200,"Title","Text","Butt 1","The 2nd","The3rd",Default,34,"C:\vista.ico")
;MsgBox(0, 'ReturnValue:', $ButtPressed); DEBUG

If FileExists($DestDir & 'GoogleDomainDynDNSUpdater.exe') Then

	$ButtPressed = xMsgBox(16+0x200,$InstallDialogTitle, "You want to Install or Uninstall","Install","Uninstall","Re-Config",Default,34)

	If $ButtPressed = 7 Then ; Uninstall
		ProcessClose('GoogleDomainDynDNSUpdater.exe')
		Sleep(3000)
		FileDelete($DestDir & 'GoogleDomainDynDNSUpdater.exe')
		FileDelete($DestDir & 'GoogleDomainDynDNSUpdater.ini')
		RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "GooogleDomainDynDNSUpdater")
		DirRemove($DestDir)
		MsgBox(0,$InstallDialogTitle,"Uninstalled ! Bye")
	ElseIf $ButtPressed = 2 Then ; Re-Config
		$dyndomain = InputBox($InstallDialogTitle &" Setting", "Google Domain DynDNS Domain:", "");
		IniWrite($DestDir & 'GoogleDomainDynDNSUpdater.ini','setting','dyndomain',$dyndomain);
		$username = InputBox($InstallDialogTitle &" Setting", "Google Domain DynDNS Username:", "");
		IniWrite($DestDir & 'GoogleDomainDynDNSUpdater.ini','setting','username',$username);
		$password = InputBox($InstallDialogTitle &" Setting", "Google Domain DynDNS Password:", "");
		IniWrite($DestDir & 'GoogleDomainDynDNSUpdater.ini','setting','password',$password);
		MsgBox(0,$InstallDialogTitle,"Updated Config! if you need Re-Configure please Re-Run setup.exe again")
	EndIf

Exit; Remember exit script after Uninstall

EndIf

;----Install Files----

DirCreate($DestDir);
FileInstall('GoogleDomainDynDNSUpdater.exe',$DestDir & 'GoogleDomainDynDNSUpdater.exe');
FileInstall('GoogleDomainDynDNSUpdater.ini',$DestDir & 'GoogleDomainDynDNSUpdater.ini');

;----Post Install----
$dyndomain = InputBox($InstallDialogTitle &" Setting", "Google Domain DynDNS Domain:", "");
IniWrite($DestDir & 'GoogleDomainDynDNSUpdater.ini','setting','dyndomain',$dyndomain);
$username = InputBox($InstallDialogTitle &" Setting", "Google Domain DynDNS Username:", "");
IniWrite($DestDir & 'GoogleDomainDynDNSUpdater.ini','setting','username',$username);
$password = InputBox($InstallDialogTitle &" Setting", "Google Domain DynDNS Password:", "");
IniWrite($DestDir & 'GoogleDomainDynDNSUpdater.ini','setting','password',$password);

MsgBox(0,$InstallDialogTitle,"Updated Config! if you need Re-Configure please Re-Run setup.exe again")

;----Post Install - Auto Run----
$answer = MsgBox (4, $InstallDialogTitle ,"Do you want to allow this program auto start with Windows. Recommend choice YES !")
If $answer = 6 Then
	;Auto start at system boot
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "GooogleDomainDynDNSUpdater", "REG_SZ", $DestDir & 'GoogleDomainDynDNSUpdater.exe')
	MsgBox(0,$InstallDialogTitle, "you have pressed Yes and I will auto start with Windows")
ElseIf $answer = 7 Then
	;Auto start at system boot
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "GooogleDomainDynDNSUpdater", "REG_SZ", $DestDir & 'GoogleDomainDynDNSUpdater.exe')
    MsgBox(0,$InstallDialogTitle, "you have pressed No but I still auto start I dont care your choice")
EndIf

;----Finish Install and Run programm----
MsgBox(0, $InstallDialogTitle, "Installed Done")
Run($DestDir & 'GoogleDomainDynDNSUpdater.exe')