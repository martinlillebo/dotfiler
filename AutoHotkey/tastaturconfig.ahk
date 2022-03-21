SetCapsLockState, alwaysoff
SetNumLockState, alwayson


;~~~~~~~~~~~~~~~~~~~~Tips~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Finne ut hva et program heter: Høyreklikk AHK i taskbar og velg Windows Spy
; Bruk ahk_class XXXX som programnavn

;~~~~~~~~~~~~~~~~~~~Åpne programmer~~~~~~~~~~~~~~~~~~~
; Utforsker [^1] 
NumpadEnter::
{
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
return
}



; QModMaster
Numpad3::
{
IfWinNotExist, ahk_exe qModMaster.exe
	Run, C:\Program Files (x86)\qModMaster-0.5.3-beta\qModMaster.exe
return
}

;~~~~~~~~~~~~~~~~~~~Autoskrive ting~~~~~~~~~~~~~~~~~~~
CapsLock::Send,% "- [ ] "

;~~~~~~~~~~~~~~~~~~~Autoskrive ting(numpad)~~~~~~~~~~~
Numpad1::Send, % "`"
NumpadSub::Send, % "lillebomartin@gmail.com"

; Tidsstempel
NumLock::
{
	FormatTime, tid,, yyyy-MM-dd
	Send %tid%
return
}

; ddd
NumpadDiv::
{
	FormatTime, tid,, yyyy-MM-dd HH:mm:ss
	Send %tid%
return
}

;~~~~~~~~~~~~~~~~~~~Emojis~~~~~~~~~~~~~~~~~~~
Numpad5::Send 🌞
Numpad6::Send 👍
Numpad8::Send ☕
Numpad9::Send 🍺  
Numpad7::Send 🎉
NumpadMult::Send ×

;~~~~~~~~~~~~~~~~~~Excel-greier~~~~~~~~~~~~~~
#IfWinActive ahk_class XLMAIN
^r::Send {Click Right}i{Enter}r{Enter} ; "CTRL+R" setter inn ny rad over musepekeren 
^k::Send {Click Right}i{Enter}c{Enter} ; "CTRL+K" setter inn ny kolonne til venstre for musepekeren 
^d::Send {Click Right}dr{Enter} ; "CTRL+D" sletter alle markerte rader 



;~~~~~~~~~~~~~~~~~~~Ref~~~~~~~~~~~~~~~~~~~
;[^1]: Stjælt herfra: https://github.com/TaranVH/2nd-keyboard/blob/9ee39aaccf9c58df9c4a7c19eb7d12ab5223872c/Almost_All_Windows_Functions.ahk#L570