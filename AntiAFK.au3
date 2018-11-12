#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=league-of-legends.ico
#AutoIt3Wrapper_Compile_Both=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <WinAPISys.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

FileInstall("logo.bmp", "logo.bmp")
OnAutoItExitRegister("AutoItExit")
Func AutoItExit()
	;If @Compiled Then FileDelete("logo.bmp")
EndFunc

#Region Global const variable
Global Const $VK_F12 = 0x7B
Global Const $VK_LCONTROL = 0xA2
Global Const $VK_RCONTROL = 0xA3

Global Const $iTimeRepeat = 7000

Global Const $iBitMask = 0x8000
Global Const $iScreenWidth = @DesktopWidth
Global Const $iScreenHeight = @DesktopHeight
Global Const $iXCenter = $iScreenWidth/2
Global Const $iYCenter = $iScreenHeight/2

;	C
;A     B
;   D
;

Global Const $Ax = $iXCenter - 50
Global Const $Ay = $iYCenter

Global Const $Bx = $iXCenter + 50
Global Const $By = $iYCenter

Global Const $Cx = $iXCenter
Global Const $Cy = $iYCenter - 50

Global Const $Dx = $iXCenter
Global Const $Dy = $iYCenter + 50

Global Const $LMHT_GUI_EXE = "LeagueClientUxRender.exe"

#EndRegion


#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("LOL: AntiAFK", 508, 480, 468, 160)
GUISetFont(12, 400, 0, "SegoeUI")
GUISetBkColor(0xFFFFFF)
GUICtrlCreatePic("logo.bmp", 40, 8, 400, 208)
$Edit1 = GUICtrlCreateEdit("", 34, 224, 440, 161)
GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 12, 400, 0, "Consolas")
GUICtrlSetColor(-1, 0xEB7B2D)
$Button1 = GUICtrlCreateButton("Start", 106, 423, 89, 41)
$Button2 = GUICtrlCreateButton("Close", 208, 424, 89, 41)
$Button3 = GUICtrlCreateButton("About", 312, 424, 89, 41)
GUICtrlCreateLabel("Notes: Press Ctrl+F12 to start or stop mouse click program.", 46, 395, 450, 25)
GUICtrlSetColor(-1, 0xA637EA)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

export('Waitting LOL game to start...')

#Region Global variable

Global $IsLMHTStarted = False

Global $IsCanPlayMouse = False
Global $hTime = TimerInit()

#EndRegion

While 1
	If ProcessExists($LMHT_GUI_EXE) Then
		If $IsLMHTStarted == False Then
			export("=> OK ! Let's begin antiAFK.")
			$IsLMHTStarted = True
		EndIf
	Else
		If $IsLMHTStarted == True Then
			export("You has exited game.")
			$IsLMHTStarted = False

			; Some action when game is end
			GUICtrlSetData($Button1, "Start")
			$IsCanPlayMouse = False ; Not continue playing mouse
		EndIf
	EndIf

	Sleep(10)

	; Playing mouse proccess
	If TimerDiff($hTime) >= $iTimeRepeat Then
		If $IsCanPlayMouse Then
			PlayMouse()
		EndIf
		$hTime = TimerInit()
	EndIf

	Sleep(10)


	; Event from GUI
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			GUISetState(@SW_MINIMIZE)
		Case $Button1
			BtnStartStop_MouseClick()
		Case $Button2
			Exit
		Case $Button3
			MsgBox(64, "About", "Author: V2D27 (programmer), DoubleA (designer)" & @CRLF & _
								"Language: AutoItScript v3.3.14.5" & @CRLF & _
								"Contact me: ducduc08@gmail.com" )
	EndSwitch

	Sleep(20)

	; Event from hot Key Ctrl + F12
	If BitAND(_WinAPI_GetAsyncKeyState($VK_F12), $iBitMask) Then
		If BitAND(_WinAPI_GetAsyncKeyState($VK_RCONTROL), $iBitMask) Or BitAND(_WinAPI_GetAsyncKeyState($VK_LCONTROL), $iBitMask) Then
			BtnStartStop_MouseClick()
			; Delay for press key
			Sleep(500)
		EndIf
	EndIf

WEnd


Func PlayMouse()
	MouseClick("right", $Ax, $Ay, 1, 200)
	MouseClick("right", $Cx, $Cy, 1, 200)
	MouseClick("right", $Bx, $By, 1, 200)
	MouseClick("right", $Dx, $Dy, 1, 200)

EndFunc

Func BtnStartStop_MouseClick()
	If $IsLMHTStarted == True Then
		If $IsCanPlayMouse == True Then
			$IsCanPlayMouse = False
			GUICtrlSetData($Button1, "Start")
			export("You stop playing mouse.")
			ToolTip("")
		Else
			$IsCanPlayMouse = True
			GUICtrlSetData($Button1, "Stop")
			export("Automate playing mouse...")
			ToolTip("Mouse right-lick is pressed every " & $iTimeRepeat & " milliseconds. Press Ctrl + F12 to stop.", $iXCenter - 200, 10)

			WinActivate("League of Legends")
		EndIf
	Else
		MsgBox(64, "Notification", "Are you sure to open your League of Legends game?")
	EndIf
EndFunc



Func export($sString)
	Local Static $sdata = ""
	Local $time = @HOUR & ":" & @MIN & ":" & @SEC & ":" & @MSEC
	If $sdata == "" Then
		$sdata = $time & " " & $sString
	Else
		$sdata = $sdata & @CRLF & $time & " " & $sString
	EndIf
	GUICtrlSetData($Edit1, $sdata)
EndFunc


#cs
Local Const $iBitMask = 0x8000
While GUIGetMsg() <> $GUI_EVENT_CLOSE
	If BitAND(_WinAPI_GetAsyncKeyState($VK_1), $iBitMask) <> 0 Or BitAND(_WinAPI_GetAsyncKeyState($VK_NUMPAD1), $iBitMask) <> 0 Then
		MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "Task 1")
	ElseIf BitAND(_WinAPI_GetAsyncKeyState($VK_2), $iBitMask) <> 0 Or BitAND(_WinAPI_GetAsyncKeyState($VK_NUMPAD2), $iBitMask) <> 0 Then
		MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "Task 2")
	ElseIf BitAND(_WinAPI_GetAsyncKeyState($VK_3), $iBitMask) <> 0 Or BitAND(_WinAPI_GetAsyncKeyState($VK_NUMPAD3), $iBitMask) <> 0 Then
		MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "Task 3")
	ElseIf BitAND(_WinAPI_GetAsyncKeyState($VK_ESCAPE), $iBitMask) <> 0 Then
		MsgBox($MB_SYSTEMMODAL, "_WinAPI_GetAsyncKeyState", "The Esc Key was pressed, exiting.")
		ExitLoop
	EndIf
WEnd

#ce