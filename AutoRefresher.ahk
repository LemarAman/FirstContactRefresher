#NoEnv  
#SingleInstance, Force
#Persistent
SetTitleMatchMode, 2
#InstallMouseHook
SendMode, Input
Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "

Sleep, 3000
WinMove, 1st Contact, ,0,0,1026,379
Winset, AlwaysOnTop, Off, 1st Contact

;WinMove, 1st Contact, ,0,0,1026,964 ;top left screen

noFca = 0 record
oneRecord = 1 record
twoRecords = 2 records
threeRecords = 3 records
fourRecords = 4 records

openFcaPage(){
	Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "
	Sleep 5000
	WinMove, 1st Contact, ,1497,0,2073,1370
	Sleep, 120000
}

firstContactAlert(){
	Sleep 10
	SoundGet, normalVolume
	Sleep 10
	SoundSet, 45
	Sleep 10
	SoundBeep, 750, 500
	Sleep, 100
	SoundBeep, 750, 500
	Sleep 10
	Soundset, normalVolume
	Sleep 10
	MsgBox, 4, You have a first contact!, Would you like to go to your FCA page? (press Yes or No), 20
	IfMsgBox Yes
		openFcaPage()
	else IfMsgBox No
		Sleep 50
	
}

loop 540
	
{
	
	BlockInput,On
	Sleep 50
	WinMove, 1st Contact, ,0,0,1354,892
	Sleep 50
	ControlSend, , {CtrlDown}a{CtrlUp}, 1st Contact 
	Sleep 100
	ControlSend, , {CtrlDown}c{CtrlUp}, 1st Contact 
	Sleep 100
	WinMove, 1st Contact, ,0,0,1026,379
	Sleep, 50
	WinSet, Bottom, , 1st Contact
	Sleep 50
	ControlFocus, , 1st Contact
	Sleep, 50
	ControlSend,,{F5}, 1st Contact 
	Sleep 50
	BlockInput,Off
	Sleep 10
	
	if Clipboard contains %oneRecord%,%twoRecords%,%threeRecords%,%fourRecords%, ;%noFca%
		firstContactAlert()
	
	
	Sleep 50
	
	clipboard = "" ; clears the clipbard
	Sleep 50
	clipboard := ""
	
	sleep, 60000
	
	
}


Esc::ExitApp
return
