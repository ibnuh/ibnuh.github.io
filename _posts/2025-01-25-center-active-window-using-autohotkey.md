---
layout: post
title: 'Center active window using AutoHotkey'
date: 2025-01-25 14:57:00 +0700
---

I use multiple monitors and I kept wanting to center a window on whatever screen I was looking at. Windows doesn't have a shortcut for that, so I wrote a quick AutoHotkey script. Hit `Win + C` and it centers the active window on its current monitor, accounting for the taskbar. Works on multiple monitors and ultrawides.

### The script

```javascript
; Center active window
#c::  {
    WinGetPos(&X, &Y, &W, &H, "A")
    CoordMode("Mouse", "Screen")
    MouseGetPos(&mouseX, &mouseY)
    monitorNumber := MonitorGetPrimary()

    ; Find which monitor the window is actually on
    Loop MonitorGetCount() {
        MonitorGetWorkArea(A_Index, &mLeft, &mTop, &mRight, &mBottom)
        if (X >= mLeft && X < mRight && Y >= mTop && Y < mBottom) {
            monitorNumber := A_Index
            break
        }
    }

    ; Calculate perfect center for THAT monitor
    MonitorGetWorkArea(monitorNumber, &monitorLeft, &monitorTop, &monitorRight, &monitorBottom)
    newX := monitorLeft + (monitorRight - monitorLeft - W) / 2
    newY := monitorTop + (monitorBottom - monitorTop - H) / 2
    WinMove newX, newY,,, "A"
}
```

### Setup

1. Install [AutoHotkey v2+](https://www.autohotkey.com/).
2. Save the script as a `.ahk` file, like `CenterWindow.ahk`.
3. Run the script by right-clicking and selecting "Run Script". If you want it to run on startup, [follow this](https://www.autohotkey.com/docs/v2/FAQ.htm#Startup).

### Changing the hotkey

You can change `#c` to whatever key combo you prefer:
- `^!c` for `Ctrl + Alt + C`
- `#!Down` for `Win + Alt + Down Arrow`

Check the [AutoHotkey hotkey docs](https://www.autohotkey.com/docs/v2/howto/WriteHotkeys.htm) for more options. You can also add [smooth transitions](https://www.autohotkey.com/docs/v2/lib/WinMove.htm#Remarks) if you want animation.

### Things to know

- Admin windows (Task Manager, elevated Command Prompt) need the script to run as admin too.
- Fullscreen apps might ignore the window positioning.
- On ultrawides, you can tweak the horizontal positioning:
  ```javascript
  newX := monitorLeft + (monitorRight - monitorLeft - W) / 3  ; Position 1/3 from left
  ```

### How it works

Here's what the script does step by step:

```javascript
CoordMode("Mouse", "Screen")
MouseGetPos(&mouseX, &mouseY)
```
This tells AutoHotkey to use screen coordinates instead of window-relative ones, which matters when you have multiple monitors.

```javascript
Loop MonitorGetCount() {
    MonitorGetWorkArea(A_Index, &mLeft, &mTop, &mRight, &mBottom)
    if (X >= mLeft && X < mRight && Y >= mTop && Y < mBottom) {
        monitorNumber := A_Index
        break
    }
}
```
This loops through all monitors and checks which one the window is actually on by comparing the window position against each monitor's boundaries.

```javascript
newX := monitorLeft + (monitorRight - monitorLeft - W) / 2
newY := monitorTop + (monitorBottom - monitorTop - H) / 2
```
Then it calculates the center position using the monitor's usable area (minus taskbar and docks) and the window size.
