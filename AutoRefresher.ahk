#NoEnv  
#SingleInstance, Force
#Persistent
SetTitleMatchMode, 2
#InstallMouseHook
SendMode, Input

; Opens FCA Page, sets it to always be on bottom so it's out of the way.

Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "

Sleep, 6000
WinMaximize, 1st Contact
Sleep 10
Winset, AlwaysOnTop, Off, 1st Contact

; Prompts user to enter the agents he wants to track for FCAs.

InputBox, nameOfAgents, Agent Names, Please enter the names of the agents FCAs. Example: Joe, John, Bob

;Creates an array of agent names and appends a return carat to each element so as to recognize how FCAs are formatted on the webpage, particularly the agent's name.
agent_Array := StrSplit(nameOfAgents, ",")
for i in agent_Array {
    agent_Array[i] .= "`r"
}

; Function to open the FCA page and move it to the main screen.

openFcaPage(){
	Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "
	Sleep 10000
	WinMaximize, 1st Contact
	Sleep, 60000
}

; Function to alert the user there is a first contact available. Displays a message box with option to go to FCA page, and a auditory cue.
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

; Loops 540 times (540 minutes, duration of a shift). 
; Each Loop first highlights the entire page and copies it to the clipboard.
; It then checks to see if there is a FCA on the FCA page specified by the user during program onset.
; Inner loop, If the FCA exists, firstContactAlert() is used, if not,exits out of inner loop
; Clipboard is then cleared and FCA page is refreshed for next iteration.
loop 540
	
{
	BlockInput,On
	Sleep 50
	WinMove, 1st Contact, ,0,0,1354,892
	sleep 50
	ControlClick,X229 Y572, 1st Contact
	Sleep 100
	ControlSend,,{Ctrl Down}ac{Ctrl Up}, 1st Contact
	Sleep 100
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

; User can hit escape on their keyboard to turn off the script.
Esc::ExitApp

return
