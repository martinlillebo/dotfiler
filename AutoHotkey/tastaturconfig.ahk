SetCapsLockState, alwaysoff
SetNumLockState, alwayson



; Åpner Utforsker og blar gjennom åpne vinduer
; Stjælt herfra: https://github.com/TaranVH/2nd-keyboard/blob/9ee39aaccf9c58df9c4a7c19eb7d12ab5223872c/Almost_All_Windows_Functions.ahk#L570
NumpadEnter::
{
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}



; qmodmaster-knapp
Numpad3::
{
IfWinNotExist, ahk_exe qModMaster.exe
	Run, C:\Program Files (x86)\qModMaster-0.5.3-beta\qModMaster.exe
}

; Autoskrive ting
Numpad5::Send 🌞


; Tidsstempel
Numpad9::
FormatTime, tid,, yyyy-MM-dd
Send %tid%