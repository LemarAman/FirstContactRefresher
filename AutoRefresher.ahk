#NoEnv  
#SingleInstance, Force
#Persistent
SetTitleMatchMode, 2
#InstallMouseHook
SendMode, Input
Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "

Sleep, 6000
WinMove, 1st Contact, ,0,0,1026,379
Sleep 10
Winset, AlwaysOnTop, Off, 1st Contact

InputBox, nameOfAgents, Agent Names, Please enter the names of the agents FCAs you'd like to be notified for. `rExample: Daisy`,Adam`,John

agent_Array := StrSplit(nameOfAgents, ",")
for i in agent_Array {
    agent_Array[i] .= "`r"
}


openFcaPage(){
	Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "
	Sleep 10000
	WinMove, 1st Contact, ,1497,0,2073,1370
	Sleep, 60000
}


firstContactAlert(){
	SoundBeep, 750, 500
	Sleep, 100
	SoundBeep, 750, 500
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
	sleep 50
	ControlClick,X229 Y572, 1st Contact
	Sleep 50
	WinMove, 1st Contact, ,0,0,1354,892
	sleep 50
	ControlClick,X229 Y572, 1st Contact
	Sleep 50
	ControlSend,,{Ctrl Down}ac{Ctrl Up}, 1st Contact
	Sleep 50
	WinSet, Bottom, , 1st Contact
	Sleep 50
	WinMove, 1st Contact, ,0,0,1026,379
	Sleep 10
	BlockInput,Off
	Sleep 10
	
	
	for key, value in agent_Array {
		if(!InStr(clipboard, value))
			Continue
		
		firstContactAlert()
		break
	}
	
	
	Sleep 50
	
	
	
	clipboard := "" ; clears the clipboard
	
	
	sleep, 50000
	ControlFocus, , 1st Contact
	Sleep, 50
	ControlSend,,{F5}, 1st Contact
	Sleep 50
	Sleep 10000
	
	
}


Esc::ExitApp

return
