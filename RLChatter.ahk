
; Options

  #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
  ; #Warn  ; Enable warnings to assist with detecting common errors.
  SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
  SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
  #InstallKeybdHook

  ; Needs moving to external lib folder
  ; ToolTipOpt v1.004
    ; Changes:
    ; v1.001 - Pass "Default" to restore a setting to default
    ; v1.002 - ANSI compatibility
    ; v1.003 - Added workarounds for ToolTip's parameter being overwritten
    ; by code within the message hook.
    ; v1.004 - Fixed text colour.
    ToolTipFont(Options := "", Name := "", hwnd := "") {
    static hfont := 0
    if (hwnd = "")
    hfont := Options="Default" ? 0 : _TTG("Font", Options, Name), _TTHook()
    else
    DllCall("SendMessage", "ptr", hwnd, "uint", 0x30, "ptr", hfont, "ptr", 0)
    }
    ToolTipColor(Background := "", Text := "", hwnd := "") {
    static bc := "", tc := ""
    if (hwnd = "") {
    if (Background != "")
    bc := Background="Default" ? "" : _TTG("Color", Background)
    if (Text != "")
    tc := Text="Default" ? "" : _TTG("Color", Text)
    _TTHook()
    }
    else {
    VarSetCapacity(empty, 2, 0)
    DllCall("UxTheme.dll\SetWindowTheme", "ptr", hwnd, "ptr", 0
    , "ptr", (bc != "" && tc != "") ? &empty : 0)
    if (bc != "")
    DllCall("SendMessage", "ptr", hwnd, "uint", 1043, "ptr", bc, "ptr", 0)
    if (tc != "")
    DllCall("SendMessage", "ptr", hwnd, "uint", 1044, "ptr", tc, "ptr", 0)
    }
    }
    _TTHook() {
    static hook := 0
    if !hook
    hook := DllCall("SetWindowsHookExW", "int", 4
    , "ptr", RegisterCallback("_TTWndProc"), "ptr", 0
    , "uint", DllCall("GetCurrentThreadId"), "ptr")
    }
    _TTWndProc(nCode, _wp, _lp) {
    Critical 999
    ;lParam := NumGet(_lp+0*A_PtrSize)
    ;wParam := NumGet(_lp+1*A_PtrSize)
    uMsg := NumGet(_lp+2*A_PtrSize, "uint")
    hwnd := NumGet(_lp+3*A_PtrSize)
    if (nCode >= 0 && (uMsg = 1081 || uMsg = 1036)) {
    _hack_ = ahk_id %hwnd%
    WinGetClass wclass, %_hack_%
    if (wclass = "tooltips_class32") {
    ToolTipColor(,, hwnd)
    ToolTipFont(,, hwnd)
    }
    }
    return DllCall("CallNextHookEx", "ptr", 0, "int", nCode, "ptr", _wp, "ptr", _lp, "ptr")
    }
    _TTG(Cmd, Arg1, Arg2 := "") {
    static htext := 0, hgui := 0
    if !htext {
    Gui _TTG: Add, Text, +hwndhtext
    Gui _TTG: +hwndhgui +0x40000000
    }
    Gui _TTG: %Cmd%, %Arg1%, %Arg2%
    if (Cmd = "Font") {
    GuiControl _TTG: Font, %htext%
    SendMessage 0x31, 0, 0,, ahk_id %htext%
    return ErrorLevel
    }
    if (Cmd = "Color") {
    hdc := DllCall("GetDC", "ptr", htext, "ptr")
    SendMessage 0x138, hdc, htext,, ahk_id %hgui%
    clr := DllCall("GetBkColor", "ptr", hdc, "uint")
    DllCall("ReleaseDC", "ptr", htext, "ptr", hdc)
    return clr
    }
    }
  ; --|

  ToolTipFont("s16", "Calibri Light")
  ToolTipColor("Black", "White")

  globalSettings=settings.ini

  ; init

  ; IniWrite, 0, settings.ini, global_mode, current

; --|

; Hotkeys

  if WinActive("ahk_exe RocketLeague.exe") {
    ; Launch Menu sets
    1::Menu(1)

    2::Menu(2)

    3::Menu(3)

    4::Menu(4)


    ; Toggle sets
    5::
      IniRead, Set, settings.ini, set, current

      if (Set = 0) {
        ToolTip
        ToolTipColor("White", "Black")

        IniWrite, 1, settings.ini, set, current
        MouseMove, 20, 200
        ToolTip, Set swaitched to Custom
        sleep 2000
        ToolTip
      } else {
        ToolTip
        ToolTipColor("Black", "White")

        IniWrite, 0, settings.ini, set, current
        MouseMove, 20, 200
        ToolTip, Set swaitched to Normal
        sleep 1500
        ToolTip
      }

    return

    ; show pre/post game Menu
    6::
      IniWrite, 2, settings.ini, set, current
      Menu(0)
      IniWrite, 0, settings.ini, set, current
    return

    ; show macro menu
    7::
      IniWrite, 3, settings.ini, set, current
      IniWrite, 1, settings.ini, global_mode, current
      Menu(5)
      IniWrite, 0, settings.ini, set, current
      IniWrite, 0, settings.ini, global_mode, current
    return

    ; Address team
    8::IniWrite, 1, settings.ini, team, current
  }
; --|

; Functions

  Menu(bank) {

    ; read in settings
      ; IniWrite, %set%, settings.ini, set, current
      IniRead, Set, settings.ini, set, current
      ; Msgbox, %Set%

      if (Set = 0) {

        if (bank = 1) {
          IniRead, DirUp, settings.ini, message, oa1
          IniRead, DirRt, settings.ini, message, oa2
          IniRead, DirDn, settings.ini, message, oa3
          IniRead, DirLt, settings.ini, message, oa4
        } else if (bank = 2) {
          IniRead, DirUp, settings.ini, message, ob1
          IniRead, DirRt, settings.ini, message, ob2
          IniRead, DirDn, settings.ini, message, ob3
          IniRead, DirLt, settings.ini, message, ob4
        } else if (bank = 3) {
          IniRead, DirUp, settings.ini, message, oc1
          IniRead, DirRt, settings.ini, message, oc2
          IniRead, DirDn, settings.ini, message, oc3
          IniRead, DirLt, settings.ini, message, oc4
        } else if (bank = 4) {
          IniRead, DirUp, settings.ini, message, od1
          IniRead, DirRt, settings.ini, message, od2
          IniRead, DirDn, settings.ini, message, od3
          IniRead, DirLt, settings.ini, message, od4
        }

      } else if (set = 1) {

        if (bank = 1) {
          IniRead, DirUp, settings.ini, message, a1
          IniRead, DirRt, settings.ini, message, a2
          IniRead, DirDn, settings.ini, message, a3
          IniRead, DirLt, settings.ini, message, a4
        } else if (bank = 2) {
          IniRead, DirUp, settings.ini, message, b1
          IniRead, DirRt, settings.ini, message, b2
          IniRead, DirDn, settings.ini, message, b3
          IniRead, DirLt, settings.ini, message, b4
        } else if (bank = 3) {
          IniRead, DirUp, settings.ini, message, c1
          IniRead, DirRt, settings.ini, message, c2
          IniRead, DirDn, settings.ini, message, c3
          IniRead, DirLt, settings.ini, message, c4
        } else if (bank = 4) {
          IniRead, DirUp, settings.ini, message, d1
          IniRead, DirRt, settings.ini, message, d2
          IniRead, DirDn, settings.ini, message, d3
          IniRead, DirLt, settings.ini, message, d4
        }

      } else if (set = 2) {

        if (bank = 0) {
          IniRead, DirUp, settings.ini, message, pp1
          IniRead, DirRt, settings.ini, message, pp2
          IniRead, DirDn, settings.ini, message, pp3
          IniRead, DirLt, settings.ini, message, pp4
        }
      } else if (set = 3) {

        if (bank = 5) {
          IniRead, DirUp, settings.ini, message, mc1
          IniRead, DirRt, settings.ini, message, mc2
          IniRead, DirDn, settings.ini, message, mc3
          IniRead, DirLt, settings.ini, message, mc4
        }
      }

    ; Get current team
      IniRead, Team, settings.ini, team, current

      if (bank = 1) {
        team = 1
      }

    ; --|

    ; set set color
      if (Team = 0) {
        ToolTipColor("Black", "White")
      } else if (Team = 1) {
        ToolTipColor("White", "Black")
      }

    ; --|

    ; Map bank names

      if (bank =  0) {
        bankName = Pre/Post Game
      }

      if (bank =  1) {
        bankName = Info
      }

      if (bank =  2) {
        bankName = Reactions
      }

      if (bank =  3) {
        bankName = Apologies
      }

      if (bank =  4) {
        bankName = Compliments
      }

      if (bank =  5) {
        bankName = MacroMenu
      }

    ; --|

    ; Show messages and get choice

      ; build menu

        hr = ----------------------------------
        title = ----|%Set%|-|%bankName%|
        up = |⮙| %DirUp%
        right = |⮚| %DirRt%
        down = |⮛| %DirDn%
        left = |⮘| %DirLt%

      ; --|

      Menu = %title%`n%hr%`n%up%`n%right%`n%left%`n%down%`n%hr%
      ; Menu = ----|%Set%|-|%bankName%|`n%hr%`nup = |⮙|`nright = |⮚| %DirRt%`n|⮘| %DirLt%`n|⮛| %DirDn%`n%hr%

      MouseMove, 20, 200

      ToolTip % Menu

      Input, messageChoice, L1 M

      ToolTip

    ; --|

    ; Check global mode and trigger message or macro
      ; IniRead, GLOBAL_MODE, settings.ini, global_mode, current

      ; ; determines the mode (Insert message|macro)
      ; if (GLOBAL_MODE = 0) {

        ; determine chioce and trigger insert
        if (messageChoice = 1) {
          insertMessage(DirUp, Team)
        } else if (messageChoice = 2) {
          insertMessage(DirRt, Team)
        } else if (messageChoice = 3) {
          insertMessage(DirDn, Team)
        } else if (messageChoice = 4) {
          insertMessage(DirLt, Team)
        } else {
          ToolTip
        }

      ; } else if (GLOBAL_MODE = 1) {

      ;   ; determine chioce and trigger insert
      ;   if (messageChoice = 1) {
      ;     changeVideoMode("fs")
      ;   } else if (messageChoice = 2) {
      ;     changeVideoMode("bd")
      ;   } else if (messageChoice = 3) {
      ;     ; CUSTOM MACRO GOES HERE
      ;     ; NAME IT IN THE SETTINGS.INI
      ;     ToolTip
      ;   } else if (messageChoice = 4) {
      ;     ; CUSTOM MACRO GOES HERE
      ;     ; NAME IT IN THE SETTINGS.INI
      ;     ToolTip
      ;   } else {
      ;     ToolTip
      ;   }

      ; } else {
      ;   ToolTip
      ; }

    ; --|

    ; change team back to everyone
      IniWrite, 0, settings.ini, team, current
    ; --|
  }

  insertMessage(message, team) {

    ; Msgbox % message

    if (team = 0) {
      InsertTrigger = t
    } else if (team = 1) {
      InsertTrigger = y
    }

    send {%InsertTrigger%}
    sleep, 100

    ; paste message
    SendRaw, %message%

    ; press enter
    Send {Enter}
  }


; --|
