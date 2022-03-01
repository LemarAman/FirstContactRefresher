#NoEnv  
#SingleInstance, Force
;#Persistent
SetTitleMatchMode, 2


loop 190
	{
	#IfWinExist, Google Chrome
	ControlFocus, , 1st Contact
	ControlSend,,{F5}, Google Chrome
	sleep, 180000
	
	}
