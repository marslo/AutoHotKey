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
;     LastChange: 2020-02-14 17:59:38
;        History:
;               0.0.2: Add the shortcut key make command line looks like shell
;               0.0.3: Add the shortcut key for Python interative shell
;               0.0.4: Add ESC to close communicator main window, Total command and onenote
;               0.0.5: Add ESC to Minimize Outlook Main window
;               0.0.6: Add Operations into Console2
;               0.0.7: Add operations for lunchy
;               0.0.8: Make format simple
; =============================================================================

; ^: ctrl
; !: Alt
; +: Shift
; #: Win

#NoEnv                        ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn                         ; Recommended for catching common errors.
SendMode, Input               ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%   ; Ensures a consistent starting directory.
SetTitleMatchMode 2
#Include C:\marslo\tools\software\scripts\ahk\TrayIcon.ahk

; ^i:: Send, {Insert}
; For qwerkywrite keyboard
; End::Del
; Del::End

; ^End::End
; ^Del::Del

; LAlt::LWin
; LWin::LAlt

RAlt::Ins
^RAlt::RAlt

^!r::
    reload
Return

; win + m for mini windows
#m::
  Send  !{Space}n
Return

; alt + w for close the window
!w::
  Send !{F4}
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

+!WheelUp::
  scroll(0)
return

+!WheelDown::
  scroll(1)
return

scroll(direction)
{
  SetTitleMatchMode, 2
  ControlGetFocus, fcontrol, A
  Loop 5
  SendMessage, 0x114, %direction%, 0, %fcontrol%, A
}
:c*:dpw::P@ssw0rd

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
^u:: Send +{Home}{Del}
^a:: Send {Home}
!b:: Send ^{Left}
!f:: Send ^{Right}
!k:: Send {Up}
!j:: Send {Down}
!h:: Send {Left}
!l:: Send {Right}
#IfWinActive

; Using VIM-KEY against Foxit Reader
#IfWinActive, ahk_class classFoxitReader
^j:: Send {Down}
^k:: Send {Up}
#IfWinActive

; Using VIM-LIKE key against chm reader (c:\Windws\hh.exe)
#IfWinActive, ahk_class HH Parent
+j:: Send {Down}
+k:: Send {Up}
/:: Send ^f
#IfWinActive

; Using VIM-LIKE key against GoldenDict
#IfWinActive, ahk_class QWidget
+j:: Send {Down}
+k:: Send {Up}
+/:: Send ^f
esc:: Send !{F4}
#IfWinActive

; Using VIM-LIKE key against GoldenDict
#IfWinActive, ahk_class ApplicationFrameWindow
esc:: Send !{F4}
#IfWinActive


; win+w minimize MS Team
#IfWinActive, ahk_exe Teams.exe
#w:: Send !{F4}
#IfWinActive

; win+w to minimize for VNC Viewer
#IfWinActive, ahk_class ui::Window::Dialog
#w:: Send  !{Space}n
#IfWinActive

; Using VIM-LIKE key against Explorer.exe
#IfWinActive, ahk_class IEFrame
!j:: Send {Down}
!k:: Send {Up}
!l:: Send {Right}
!h:: Send {Left}
+/:: Send ^f
#IfWinActive

; Redefine only when the active window is a cmd
; #IfWinActive, ahk_class ConsoleWindowClass
#IfWinActive, ahk_exe cmd.exe
^a:: Send {Home}
^e:: Send {End}
^f:: Send {Right}
^b:: Send {Left}
!b:: Send ^{Left}
!f:: Send ^{Right}

^d:: Send {Del}
^k:: Send ^{End}
^u:: Send ^{Home}
^w:: Send {Backspace}^{Backspace}
!d::
  Send ^{Right}
  Send {Backspace}
  Send ^{Backspace}
Return

!k::
  WinGetTitle sTitle
  SendMessage, 0x115, 0, 0, , %sTitle%
Return
!j::
  WinGetTitle sTitle
  SendMessage, 0x115, 1, 0, , %sTitle%
Return

^p:: Send {Up}
^n:: Send {Down}

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

^v:: Send +{Ins}

^p:: Send {Up}
^n:: Send {Down}

^a:: send {home}
^e:: send {end}

^f:: send {right}
^b:: send {left}

!b:: send ^{left}
!f:: send ^{right}

^d:: send {del}
^k:: send ^{end}
^u:: send ^{home}
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

#IfWinActive, ahk_class VMPlayerFrame
!j:: send +{PgDn}
!k:: send +{PgUp}
#IfWinActive

; Alt + j/k for scroll up/down in Adobe Reader
#IfWinActive ahk_class AcrobatSDIWindow
!j::
  loop, 2 {
    send {Down}
  }
Return
!K::
  loop, 2{
    send {Up}
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

; Make Office Communicator using vim-like shortcut keys
#IfWinActive, ahk_class IMWindowClass
^+e:: Send {End}
^+a:: Send {Home}
^u:: Send +{Home}{Del}
^k:: Send +{End}{Del}
#IfWinActive

; Make <ESC> to close office communicator
#IfWinActive, ahk_class CommunicatorMainWindowClass
Esc:: Send !{F4}
#IfWinActive

; Make <ESC> to close Total command
#IfWinActive, ahk_class TTOTAL_CMD
#w:: Send !{F4}
#IfWinActive

; Make <ESC> to close OneNote
#IfWinActive, ahk_class Framework::CFrame
^w:: Send  ^{Backspace}
!d:: Send  ^{Del}
^+e:: Send {End}
^a:: Send {Home}
^u:: Send +{Home}{Del}
^k:: Send +{End}{Del}
^+a:: Send ^{Home}+^{End}
^Down::Send !+{+}
^Up::Send !+-
ESC:: WinClose
#IfWinActive

; Close Explorer.exe (My computer) by <ESC>
#IfWinActive, ahk_class CabinetWClass
ESC:: Send !{F4}
^l:: Send !d
#IfWinActive

; Close Tencent Main window by <ESC>
#IfWinActive, ahk_class TXGuiFoundation
ESC:: Send !{F4}
#IfWinActive

; Close Skype Windows by <ESC>
#IfWinActive, Skype
ESC:: Send !{F4}
#IfWinActive

; VIM-Like and Emacs-Like shortcuts in Outlook
#IfWinActive, ahk_class rctrl_renwnd32
^w:: Send  ^{Backspace}
!d:: Send  ^{Del}
^a:: Send  {Home}
^e:: Send  {End}
!j:: Send  {Down}
!k:: Send  {Up}
#IfWinActive

; Minimize the Outlook Main Window by <ESC>
; #IfWinActive, marslo.jiao@<mycompany>.com - Outlook
#IfWinActive, - Outlook
ESC:: Send  !{Space}n
#IfWinActive

; For 163 music
#IfWinActive, ahk_class OrpheusBrowserHost
ESC:: Send  !{F4}
#IfWinActive

; For launchy
#IfWinActive, ahk_class QTool
^u:: Send +{HOME}{Del}
^k:: Send +{End}{Del}
^a:: Send {Home}
^e:: Send {End}
^w:: Send ^{Backspace}
^p:: Send {Up}
^n:: Send {Down}
#IfWinActive

; For everything
#IfWinActive, ahk_class EVERYTHING
^u:: Send +{HOME}{Del}
^k:: Send +{End}{Del}
^a:: Send {Home}
^e:: Send {End}
^w:: Send ^{Backspace}
#IfWinActive

; For PuTTyTray
#IfWinActive, ahk_class PuTTYConfigBox
^u:: Send +{HOME}{Del}
^k:: Send +{End}{Del}
^a:: Send {Home}
^e:: Send {End}
#IfWinActive


; zoom chart
#IfWinActive, ahk_class ZPPTMainFrmWndClass
ESC::
{
  IfWinActive, Zoom - Pro Account
  {
    Send !{F4}
    ; WinMinimize
  } else {
    WinClose
  }
  Return
}
#IfWinActive

#IfWinActive, ahk_class ZPOWChatWndClass
ESC:: Send  !{F4}
#IfWinActive

; Close Jabber
#IfWinActive, ahk_class wcl_manager1
ESC::
{
  IfWinActive, Cisco Jabber
  {
    Send !{F4}
    ; WinMinimize
  } else {
    WinClose
  }
  Return
}
#IfWinActive

; Open Skype of Business (lync)
#f::
{
  IfWinExist, Skype for Business
  {
    WinActivate
    Return
  } else {
    Run "c:\Program Files (x86)\Microsoft Office\Office16\lync.exe"
  }
  Return
}

; Open Microsoft Teams
#g::
{
  IfWinExist,  | Microsoft Teams
  {
    WinActivate
    Return
  } else {
    Run "c:\Users\<myid>\AppData\Local\Microsoft\Teams\current\Teams.exe"
  }
  Return
}


; Youdao Dictionary
#IfWinActive, ahk_class YodaoMainWndClass
ESC:: Send !{Space}x
^u:: Send +{HOME}{Del}
^k:: Send +{End}{Del}
^a:: Send {Home}
^e:: Send {End}
^w:: Send ^{Backspace}
#IfWinActive

; For Foobar2000
#IfWinActive, ahk_exe foobar2000.exe
ESC::
  Send !{Space}n
#IfWinActive

; For Wechat app in Chrome
; #IfWinActive, Wechat
; ESC::
  ; Send #{Down}
; #IfWinActive

; win+m to minimize chrome
#IfWinActive, ahk_exe chrome.exe
  #m:: Send !{Space}n
#IfWinActive

; For Autohotkey Active Windows Spy
#IfWinActive, ahk_exe AU3_Spy.exe
ESC::
  Send !{F4}
#IfWinActive

; Show Calendar
F9:: Send #b{Up}{Enter}

; Open files
!+f:: run "C:\Marslo\MarsloVeritas\Box Sync\Study\Books\Script\Python\Dive into Python\diveintopythonzh-cn.chm"
!+l:: Run "C\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE" /recycle
^!u:: run "c:\ProgramData\Microsoft\Windows\Start Menu\Programs\Cygwin\Cygwin64 Terminal.lnk"
^!p:: Run "C:\Marslo\Study\Books\CI\VCS\Perforce\P4 Command Reference - 2014.02.Dec.pdf"
; !+m:: ; Run %A_WinDir%\hh.exe c:\Marslo\Study\Scritps\MySql\MySQL.Cookbook.2nd.ed.chm
; !+r:: ; Run %A_WinDir%\hh.exe "C:\MarsloProgramFiles\Ruby193\doc\ruby19-core.chm"

; Open Vim by using Alt+q
!q::
  MaxTimeWait = 1000
  ClipSaved := ClipboardAll
  Clipboard =
  Sendinput ^c
  While(!Clipboard)
  {
    ClipWait,0.1,1
    If A_Index > %MaxTimeWait%
      Break
  }
  Select = %Clipboard%                                        ; 强制转换为纯文本
  IsFile := DllCall("IsClipboardFormatAvailable","int",15)
  Clipboard := ClipSaved
  ClipSaved =
  If IsFile
  {
    Run, "C:\Marslo\MyProgramFiles\Vim\vim80\gvim.exe" "%Select%"
  }
Return

:://cmd:: Run cmd
; Open Windows Task Manager
:://t:: Run taskmgr.exe
:://cc:: Run calc.exe
:://vsc::
  Run "C:\Program Files (x86)\VMware\Infrastructure\Virtual Infrastructure Client\Launcher\VpxClient.exe"
  Sleep 2000
  Send Administrator{Tab}ASP@ssw0rd{Enter}
Return

:://jp4::
  Send ssl:perforce.community.<myvtas>.com:9666{Tab}svc.appbld{Tab}SPW{Tab}{Tab}
  Send jenkins-${{}JOB_NAME{}}
Return

:c*:mlg::
  Send marslo.jiao{TAB}MPW{!}
Return
:c*:sysadmin::
  Send sysadmin{TAB}DPW{Enter}
Return

:c*:winadmin::
  Send Administrator{TAB}ASPW{Enter}
Return

:c*:MJ::marslo.jiao
:c*:Arti::Artifactory
:c*:artt::artifactory
:c*:@mj::marslo.jiao@gmail.com
:c*:mjhot::marslo.jiao@hotmail.com
:c*:mbu::appbuilder.engba.symantec.com{Left 19}
:c*:cbu::appbuilder.engma.symantec.com{Left 19}
:c*:exportnone::export http_proxy=""`; export https_proxy=$http_proxy`; export ftp_proxy=$http_proxy`;{Left 64}
:c*:gitvvt::GIT_SSH_COMMAND="ssh -vvvT"

; prevent the screensave
; credit belongs to https://gist.github.com/Otiel/8d15d21593b481c1e525500762db52ba
; CoordMode, Mouse, Screen
; Loop
; {
;     ; Move mouse
;     MouseMove, 1, 1, 0, R
;     ; Replace mouse to its original location
;     MouseMove, -1, -1, 0, R
;     ; Wait before moving the mouse again
;     Sleep, 600000
; }
; return

; Show/hide Slack by win+s. credit belongs to https://gist.github.com/Otiel/24248595ac4b30366a2228a7ac5ec964
#s::
DetectHiddenWindows, Off
Process, Exist, slack.exe
slackPid = %ErrorLevel%
IfWinNotExist, ahk_pid %slackPid%
{
  TrayIcon_Button("slack.exe")
}
Else
{
  IfWinActive, ahk_pid %slackPid%
  {
    WinClose, ahk_pid %slackPid%
  }
  Else
  {
    WinActivate, ahk_pid %slackPid%
  }
}
return
