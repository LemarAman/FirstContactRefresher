#NoEnv  
#SingleInstance, Force
#Persistent
SetTitleMatchMode, 2
#InstallMouseHook

Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "

Sleep, 3000
WinMove, 1st Contact, ,3529,1074,1026,379



loop 255
{
	
	BlockInput, On
	Sleep 50
	WinMove, 1st Contact, ,3529,1074,1026,379
	#IfWinExist, Google Chrome
	ControlFocus, , 1st Contact
	Sleep, 50
	ControlSend,,{F5}, 1st Contact
	Sleep, 50
	WinSet, Bottom, , 1st Contact
	Sleep, 150
	WinSet, Bottom, , 1st Contact
	Sleep 50
	BlockInput, Off
	
	sleep, 120000
	
}

^+p::Pause
return
