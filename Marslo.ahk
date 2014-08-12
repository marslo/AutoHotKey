; =============================================================================
;       FileName: Marslo.ahk
;           Desc:
;                 How to get class of windows:
;                       WinGetClass, sClass, A
;                       MsgBox $%sClass%$
;                       if ("TTOTAL_CMD" == sClass)
;                       {
;                         Send xxxx
;                       }
;         Author: Marslo
;          Email: marslo.vida@gmail.com
;        Version: 0.0.6
;     LastChange: 2013-11-27 16:00:00
;        History:
;               0.0.2: Add the shortcut key make command line looks like shell
;               0.0.3: Add the shortcut key for Python interative shell
;               0.0.4: Add ESC to close communicator main window, Total command and onenote
;               0.0.5: Add ESC to Minimize Outlook Main window
;               0.0.6: Add Operations into Console2
; =============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

^+r::
    reload
Return

; Move the windows by Shift+Win+h/l/j/k
+#h::
  WinGetTitle, mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos-10, ypos
Return
+#l::
  WinGetTitle, mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos+10, ypos
Return
+#k::
  WinGetTitle mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos, ypos-10
Return
+#j::
  WinGetTitle mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos, ypos+10
Return

; Make quick scroll to the putty window
#IfWinActive, ahk_class PuTTY
; ControlGetFocus, control, A

F10::
    WinGetTitle pTitle
    MsgBox %pTitle%
Return
; Ctrl+k to scroll up by one line
!k::
  WinGetTitle pTitle
  SendMessage, 0x115, 0, 0, , %pTitle%
  ; SendMessage, 0x115, 0, 0, , A
Return

; Ctrl+j to scroll down by one line
!j::
  WinGetTitle pTitle
  SendMessage, 0x115, 1, 0, , %pTitle%
  ; SendMessage, 0x115, 1, 0, , A
Return
#IfWinActive

; Make quick delete to begin in Python interactive shell
#IfWinActive ahk_class TkTopLevel
^u::
  Send +{Home}{Del}
Return
^a::
  Send {Home}
Return
!b::
  Send ^{Left}
Return
!f::
  Send ^{Right}
Return
!k::
  Send {Up}
Return
!j::
  Send {Down}
Return
!h::
  Send {Left}
Return
!l::
  Send {Right}
Return
#IfWinActive

; Using VIM-KEY against Foxit Reader
#IfWinActive, ahk_class classFoxitReader
^j::Down
^k::Up
#IfWinActive

; Using VIM-LIKE key against chm reader (c:\Windws\hh.exe)
#IfWinActive, ahk_class HH Parent
+j::Down
+k::Up
/::
  Send ^f
Return
#IfWinActive


; Using VIM-LIKE key against GoldenDict
#IfWinActive, ahk_class QWidget
+j::Down
+k::Up
+/::
  Send ^f
Return
#IfWinActive

; Using VIM-LIKE key against Explorer.exe
#IfWinActive, ahk_class IEFrame
!j::Down
!k::Up
!l::
  Send {Right}
Return
!h::
  Send {Left}
Return
+/::
  Send ^f
Return
#IfWinActive

; Redefine only when the active window is a cmd
#IfWinActive ahk_class ConsoleWindowClass
^a::
  Send {Home}
Return
^e::
  Send {End}
Return
^f::
  Send {Right}
Return
^b::
  Send {Left}
Return
!b::
  Send ^{Left}
Return
!f::
  Send ^{Right}
Return

^d::
  Send {Del}
Return
^k::
  Send ^{End}
Return
^u::
  Send ^{Home}
Return
^w::
  Send ^+{Left}
  Loop, 50 {
    Send {Del}
  }
Return
!d::
  Send ^+{Right}
  Loop, 50 {
    Send {Backspace}
  }
Return

!k::
  WinGetTitle sTitle
  SendMessage, 0x115, 0, 0, , %sTitle%
Return
!j::
  WinGetTitle sTitle
  SendMessage, 0x115, 1, 0, , %sTitle%
Return

^p::
  Send {Up}
Return
^n::
  Send {Down}
Return

^v::
  StringReplace clipboard2, clipboard, \r\n, \n, All
  SendInput {Raw}%clipboard2%
Return
#IfWinActive

; Redefine only when the active window is Console2
#IfWinActive, ahk_class Console_2_Main
!k::
  ControlGetFocus, control, A
  SendMessage, 0x115, 0, 0, %control%, A
Return
!j::
  ControlGetFocus, control, A
  SendMessage, 0x115, 1, 0, %control%, A
Return

^v::
  Send +{Ins}
Return

^p::
  Send {Up}
Return
^n::
  Send {Down}
Return

^a::
  send {home}
Return
^e::
  send {end}
Return

^f::
  send {right}
return
^b::
  send {left}
Return

!b::
  send ^{left}
Return
!f::
  send ^{right}
Return

^d::
  send {del}
Return
^k::
  send ^{end}
Return
^u::
  send ^{home}
Return
^w::
  send ^+{left}
  loop, 50 {
    send {del}
  }
Return
!d::
  send ^+{right}
  loop, 50 {
    send {backspace}
  }
Return
#IfWinActive

; Redefine only when the active window is Cygwin
#IfWinActive, ahk_class mintty
; Ctrl+up / Down to scroll command window back and forward
!k::
  WinGetTitle sTitle
  SendMessage, 0x115, 0, 0, , %sTitle%
  ; Send {WheelUp}
Return
!j::
  WinGetTitle sTitle
  SendMessage, 0x115, 1, 0, , %sTitle%
  ; Send {WheelDown}
Return
#IfWinActive

; Make <ESC> to close office communicator
#IfWinActive, ahk_class CommunicatorMainWindowClass
Esc::
  Send !{F4}
  Return
Return
#IfWinActive

; Make <ESC> to close Total command
#IfWinActive, ahk_class TTOTAL_CMD
#e::
    Send !{F4}
    Return
Return
#IfWinActive

; Make <ESC> to close OneNote
#IfWinActive, ahk_class Framework::CFrame
ESC::
  Send !{F4}
  Return
Return
#IfWinActive

; Close Explorer.exe (My computer) by <ESC>
#IfWinActive, ahk_class CabinetWClass
ESC::
  Send !{F4}
  Return
Return
#IfWinActive

; Close Tencent Main window by <ESC>
#IfWinActive, ahk_class TXGuiFoundation
ESC::
  Send !{F4}
  Return
Return
#IfWinActive

; Close Skype Windows by <ESC>
#IfWinActive, Skype
ESC::
  Send !{F4}
  Return
Return
#IfWinActive

; VIM-Like and Emacs-Like shortcuts in Outlook
#IfWinActive, ahk_class rctrl_renwnd32
^w::
  Send  ^{Backspace}
Return
!d::
  Send  ^{Del}
Return
^a::
  Send  {Home}
Return
^e::
  Send  {End}
Return
!j::
  Send  {Down}
Return
!k::
  Send  {Up}
Return
#IfWinActive

; Minimize the Outlook Main Window by <ESC>
#IfWinActive, Microsoft Outlook
ESC::
  Send  !{Space}n
  Return
Return
#IfWinActive

; Open files
!+f::
  run "C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe"
Return
!+l::
  Run "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE" /recycle
Return
^!u::
  run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Cygwin\Cygwin64 Terminal.lnk"
Return
; !+p::
  ; Run %A_WinDir%\hh.exe "C:\MyProgrames\Python27\Doc\python275.chm"
; Return
; !+m::
  ; Run %A_WinDir%\hh.exe c:\Marslo\Study\Scritps\MySql\MySQL.Cookbook.2nd.ed.chm
; Return
; !+r::
  ; Run %A_WinDir%\hh.exe "C:\MyProgrames\Ruby193\doc\ruby19-core.chm"
; Return

F9::
  Send source ~/lijiao/.lijiaorc{Enter}
  Send clear{Enter}
Return
