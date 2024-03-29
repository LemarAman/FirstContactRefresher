#NoEnv  
#SingleInstance, Force
#Persistent
SetTitleMatchMode, 2
#InstallMouseHook

SetKeyDelay, 50
Run, chrome.exe "https://us-west-2.actionstep.com/mym/asfw/workflow/actions/user-list/user_list_id/627"" " --new-window "
Sleep, 6000
Winget,FCAID,ID, 1st Contact
Sleep 10
Winset, Transparent, 0, ahk_id %FCAID%



Sleep 10
Winset, AlwaysOnTop, Off, ahk_id %FCAID%
Sleep 10
WinMove, ahk_id %FCAID%, ,-11,0,1740,1370


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
	Sleep 6000
	Winget,NewFCAWindow,ID, 1st Contact
	Sleep 10
	WinMove, ahk_id %NewFCAWindow%, ,1497,0,2073,1370
	Sleep, 60000
}

; Function to alert the user there is a first contact available. Displays a message box with option to go to FCA page, and a auditory cue.
firstContactAlert(){
	SoundGet, NormalVolume
	Sleep 50
	SoundSet, 30
	Sleep, 10
	SoundBeep, 750, 500
	Sleep, 100
	SoundBeep, 750, 500
	Sleep 10
	SoundSet, NormalVolume
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
	SetKeyDelay, 50
	IfWinNotExist, ahk_id %FCAID%
		Reload
	BlockInput,On
	Sleep 50
	ControlClick,X35 Y565, ahk_id %FCAID%
	Sleep 100
	ControlSend,,{Ctrl Down}a{Ctrl Up}, ahk_id %FCAID%
	Sleep 50
	ControlSend,,{Ctrl Down}c{Ctrl Up}, ahk_id %FCAID%
	Sleep 50
	ControlSend,,{Ctrl Down}r{Ctrl Up}, ahk_id %FCAID%
	Sleep 50
	WinSet, Bottom, , ahk_id %FCAID%
	Sleep 50
	
	BlockInput,Off
	Sleep 10
	
	
	for key, value in agent_Array {
		if(!InStr(clipboard, value))
			Continue
		
		firstContactAlert()
		break
	}
	Sleep 10
	;clipboard := "" ; clears the clipboard
	sleep, 60000
	BlockInput,On
	Sleep 50
	ControlClick,X35 Y565, ahk_id %FCAID%
	Sleep 50
	ControlSend,,{Ctrl Down}r{Ctrl Up}, ahk_id %FCAID%
	Sleep 50
	WinSet, Bottom, , ahk_id %FCAID%
	Sleep 50
	
	BlockInput,Off
	Sleep 10
	sleep 60000
	
	
	
}

; User can hit escape to turn off the script
Esc::ExitApp

return

