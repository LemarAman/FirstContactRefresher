#NoEnv  
#SingleInstance, Force
;#Persistent
SetTitleMatchMode, 2


loop 270 ; 270 iterations, with two minutes between iterations, = 9 hours  
	{
	#IfWinExist, Google Chrome
	ControlFocus, , 1st Contact
	ControlSend,,{F5}, Google Chrome
	sleep, 120000
	
	}
