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
;        Version: 0.0.4
;     LastChange: 2013-10-31 18:24:06
;        History:
;               0.0.2: Add the shortcut key make command line looks like shell
;               0.0.3: Add the shortcut key for Python interative shell
;               0.0.4: Add ESC to close communicator main window, totle command and onenote
; =============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^+r::
    reload
Return



; Make quick scroll to the putty window
#IfWinActive, ahk_class PuTTY
; ControlGetFocus, control, A

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
    ; Send ^{a}+{End}{Del}
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
; ^j::
    ; Send ^{End}{Enter}{Enter}
; Return
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
; j::Down
; k::Up
; f::PgDn
; b::PgUp
; G::End
; g::Home
; h::
    ; Send ^+{Tab}
; Return
; l::
    ; Send ^{Tab}
; Return
; /::
    ; Send ^f
; Return
; o::
    ; Send ^o
; Return
; d::
    ; Send ^w q::Send !{F4}
; Return
#IfWinActive

; Using VIM-LIKE key against chm reader (c:\Windws\hh.exe)
#IfWinActive, ahk_class HH Parent
+j::Down
+k::Up
/::
    Send ^f
Return
; ^w::
    ; Send !{F4}
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
+j::Down
+k::Up
; +g::Home
; +e::End
+l::
    Send {Right}
Return
+h::
    Send {Left}
Return
+/::
    Send ^f
Return
; ^w::
    ; Send !{F4}
Return
#IfWinActive


; Redefine only when the active window is a console window
#IfWinActive ahk_class ConsoleWindowClass
; Line move
^a:: ;; Move to beginning of line
    Send {Home}
Return
^e:: ;; Move to End of line
    Send {End}
Return

; Character move
^f:: ;; Move a character forward
    Send {Right}
Return
^b:: ;; Move a character backward
    Send {Left}
Return

; Word Move
!b:: ;; Move a word backward
    Send ^{Left}
Return
!f:: ;; Move a word forward
    Send ^{Right}
Return

; Delete
^d:: ;; Delete a char backward
    Send {Del}
Return
^k:: ;; Delete the line from cursor to end
    Send ^{End}
Return
^u:: ;; Delete the line from cursor to beginning
    Send ^{Home}
Return
^w:: ;; Delete previous word
    Send ^+{Left}
    Loop, 50 {
        Send {Del}
    }
Return
!d:: ;; Delete backward word
    Send ^+{Right}
    Loop, 50 {
         Send {Backspace}
    }
Return

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

; Ctrl+p/n to switch the command history
^p::
    Send {Up}
Return
^n::
    Send {Down}
Return

; Paste in command window
^v::
    ; Spanish menu (Editar->Pegar, I suppose English version is the same, Edit->Paste)
    ; MouseClick, right
    ; Send !{Space}ep
    StringReplace clipboard2, clipboard, \r\n, \n, All
    SendInput {Raw}%clipboard2%
Return

; Close Command Window with Ctrl+w
; $^w::
; WinGetTitle sTitle
; If (InStr(sTitle, "-")=0)
; {
    ; Send EXIT{Enter}
; }
; else
; {
    ; Send ^w
; }
; Return

#IfWinActive


; Redefine only when the active window is Console2
#IfWinActive, ahk_class Console_2_Main
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

; Ctrl+p/n to switch the command history
^p::
    Send {Up}
Return
^n::
    Send {Down}
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
    Send, !{F4}
    Return
Return
#IfWinActive

; Make <ESC> to close Totle command
#IfWinActive, ahk_class TTOTAL_CMD
Esc::
    Send, !{F4}
    Return
Return
#IfWinActive

; Make <ESC> to close OneNote
#IfWinActive, ahk_class Framework::CFrame
ESC::
    Send, !{F4}
    Return
Return
#IfWinActive

; Open files
!+f::
    ; run "%A_ProgramFiles%\Foxit Software\Foxit Reader\Foxit Reader.exe"
    run "C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe"
Return
; !+l::
    ; Run "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE" /recycle
    ; Run C:\Marslo\Tools\Software\WorkSW\ExtraOutlook.exe "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE" /profile "TEdefault"
; Return
; !+k::
    ; Run C:\Marslo\Tools\Software\WorkSW\ExtraOutlook.exe "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE" /profile "li.jiao@tieto.com - Google Apps"
; Return
!+m::
    Run %A_WinDir%\hh.exe c:\Marslo\Study\Scritps\MySql\MySQL.Cookbook.2nd.ed.chm
Return
!+r::
    ; Run %A_WinDir%\hh.exe "%A_ProgramFiles%\Ruby187\doc\ruby18.chm"
    Run %A_WinDir%\hh.exe "C:\MyProgrames\Ruby193\doc\ruby19-core.chm"
Return
!+p::
    Run %A_WinDir%\hh.exe "C:\MyProgrames\Python27\Doc\python275.chm"
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

F9::
    Send source ~/lijiao/.lijiaorc{Enter}
    Send clear{Enter}
Return
F6::
    ; clipboardSaved := clipboard
    ; MsgBox clipboardSaved

    MouseClick, Right
    Send, e
    Send, {Down 2}{Enter}

    ; Clipboard=%1%
    ; MsgBox Clipboard
    ; Run,% "Explorer.exe /select, " Clipboard
Return


; F1::MsgBox, % ComObjActive("Word.Application").ActiveDocument.FullName
; F1::MsgBox, ActiveDocument.Path
; "\" & ActiveDocument.Name

; F7::
    ; Send, ^c
    ; MsgBox, %clipboard%
    ; Run, vim.exe %clipboard%
; return
