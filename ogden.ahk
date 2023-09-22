SetTitleMatchMode, 2
;#IfWinActive - Google Chrome
#SingleInstance, force
DELAY_TIME := 72000     ;ms
max := 0
dem := 0
option := 0
rand := 0
job_reviewed := 0
NR:=0

sendNegaText(type)
{
    if(type = 1)
        {
            MouseClick, left, 582, 616
            send, NR
        }
    else if (type = 2)
        {
            MouseClick, left, 582, 616
            send, POP
        }
    else if (type = 3)
        {
            MouseClick, left, 582, 616
            send, AG
        }
    Sleep, 500
    send, {Enter}
    Sleep, 500
    MouseClick, left, 308, 455
    Sleep, 500
    MouseClick, left, 308, 531
    Sleep, 500
    MouseClick, left, 308, 610
    Sleep, 500
    MouseClick, left, 308, 600
    Sleep, 500
    MouseClick, left, 308, 763
    Sleep, 250
    If (type = 1)
        {
            Send, Missing content.
        }
    else if (type = 2)
        {
            Send, Policy problem.
        }
    else if (type = 3)
        {
            Send, This ad is in the language that I do not understand.
        }
    Sleep, 250
    Send, {Tab}
    Sleep, 250
    Send, {Enter}
}

sendText(ByRef rand)
{
    MouseClick, left, 308, 351
    Sleep, 500
    MouseClick, left, 308, 428
    Sleep, 500
    MouseClick, left, 308, 505
    Sleep, 500
    MouseClick, left, 308, 811
    Sleep, 500
    MouseClick, left, 308, 763
    Sleep, 250
    If (rand = 1)
    {
        Send, This ad was clear and detail, it looks good.
    }
    else if (rand = 2)
    {
        Send, This ad was useful. People should see this ad more.
    }
    else if (rand = 3)
    {
        Send, This ad is useful, It should appear more frequently.
    }
    else if (rand = 4)
    {
        Send, This ad is useful, it should be seen more.
    }
    else if (rand = 5)
    {
        Send, This ad looks good. It is clear and detailed. People should see this more.
    }
    else if (rand = 6)
    {
        Send, such an interesting ad, clear and deteailed also. There should be more ad like this.
    }
    else if(rand = 7)
    {
        Send, This ad looks nice, very informative also. People should see this.
    }
    else if (rand = 8)
    {
        Send, This ad is interesting, detailed also. People should see this.
        rand := 0
    }

    Sleep, 250
    Send, {Tab}
    Sleep, 250
    Send, {Enter}
}
splash_counter(job_reviewed, job_remaining, NR)
{
    SplashTextOn, 200, 80, Counter:, 
    (
    Jobs reviewed: %job_reviewed%
    Remaining: %job_remaining%
    NR: %NR%
    )
    WinMove, Counter:, , (A_ScreenWidth - 200), (A_ScreenHeight - 1080)
}
;END FUNCTION IMPLEMENTING
MsgBox, 0, READ THIS CAREFULLY!,
(
Press F2 to pause/continue the program
Press Esc to exit the program 
Alert!: Make sure that Unikey (or whatever program has the same function) has been turned off to use this program! 
)
InputBox, option, Enter your option!,
(
1. Once each time you press F2.
2. Loop mode, this will loop once each 72 seconds (50 times an hour).
    )
If (option = 1)
{
    max = 1
}
else if (option = 2)
{
    InputBox, max, Counter, 
    (
    How many times you want to have this program repeated?
    Note: Press F2 to start executing after this.
    )
}
Else{
    MsgBox, 0, ERROR!,
    (
    Program terminated due to inappropriate input value.
    )
    ExitApp,
}
If ErrorLevel
{
    MsgBox, 0, Canceled!,
    (
    You hit the cancel button, the program will be terminated then!
    )
    ExitApp
}

;Cover invalid input data type
If max is not integer
{
    MsgBox, 0, Error!, You did not enter a numberic data, this program will be terminated then!
    ExitApp
}
;end Cover invalid input data type

if WinExist("Google Chrome")
    WinActivate
job_remaining := max
Pause

if(option =1)
{
    Loop
    {
        rand := rand + 1
        sendText(rand)
        setTimer, Wincheck, off
        Pause
    }

}
else if(option = 2)
{
    ;splash_counter(job_reviewed,job_remaining)
    Loop 
    {
        Sleep, %DELAY_TIME% ;time between two ads reviewed
        dem := dem + 1
        rand := rand + 1
        sendText(rand)
        job_reviewed := job_reviewed + 1
        job_remaining := job_remaining - 1
        splash_counter(job_reviewed,job_remaining,NR)
        If (job_remaining <= 0)
        {
            setTimer, Wincheck, off
            MsgBox, 4, Done, Successfully executed!`nDo you want to use this program one more time?`nClick No to exit the program.
            IfMsgBox Yes
            Reload
            else
                ExitApp
        }
    }
}

return

F2::
    if WinExist("Google Chrome")
        WinActivate
    Pause,, 1 ;Pause Script off/on
    setTimer, WinCheck, 5

Return
F4::
    NR := NR + 1
    job_remaining := job_remaining -1
    job_reviewed := job_reviewed + 1
    splash_counter(job_reviewed,job_remaining,NR)
    ;Gui when nr, pop and others
    pause, on, 1
    Suspend
    OPTION_COUNT := 3

    GUI_WIDTH := 260
    GUI_HEIGHT := OPTION_COUNT * 40 + 10

    BUTTON_WIDTH := 200
    BUTTON_HEIGHT := 30

    Gui, Add, Button, x30 y10 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_NR, NR ;nr button
    Gui, Add, Button, x30 y50 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_POP, POP ; pop button
    Gui, Add, Button, x30 y90 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_AG, AG ; ag button
    Gui, Show, w%GUI_WIDTH% h%GUI_HEIGHT%, Option
    return

    _NR:
        Gui, hide
        Suspend
        pause, off
        sendNegaText(1)
        Sleep, 5000
        return

    _POP:
        Gui, hide
        Suspend
        pause, off
        sendNegaText(2)
        Sleep, 5000
        return

    _AG:
        Gui, hide
        Suspend
        pause, off
        sendNegaText(3)
    	Sleep, 5000
        return

    guiclose:
        ExitApp
        return
    ;End GUI
    

Return
WinCheck:
    IfWinNotActive, Google Chrome
    {
        IfWinNotActive, Option
        {
            MsgBox, 0, Warning!, Program has been paused because you are not in Chrome tab. `nReturn Chrome tab and press F2 to continue.
            Pause
        }
    }
Return

Esc::
ExitApp

