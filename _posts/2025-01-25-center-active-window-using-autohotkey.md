---
layout: post
title: 'Center active window using AutoHotkey'
date: 2025-01-25 14:57:00 +0700
---

_A simple solution for centering windows across multiple monitors._

Managing windows across multiple displays can be cumbersome. While Windows offers basic snapping functionality, precisely centering windows requires manual repositioning. This post presents a concise AutoHotkey script that automates window centering with a simple keyboard shortcut.

### The script

Features:

- Hotkey: `Win + C` for instant centering
- Automatically detects which monitor contains the active window
- Respects taskbar positioning and reserved screen space
- Compatible with Windows 10/11 and AutoHotkey v2
- Works with multiple monitors, including ultrawide displays

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

### Implementation guide

1. **Install AutoHotkey v2+** ([Download here](https://www.autohotkey.com/)).
2. **Save the script** with a `.ahk` extension, such as `CenterWindow.ahk`.
3. **Execute the script** by right-clicking and selecting "Run Script". For persistent availability, [add it to startup](https://www.autohotkey.com/docs/v2/FAQ.htm#Startup).

### Customization options

- **Alternative hotkeys**: Modify `#c` to use different key combinations:
  - `^!c` for `Ctrl + Alt + C`
  - `#!Down` for `Win + Alt + Down Arrow`

  Reference the [AutoHotkey Hotkey Documentation](https://www.autohotkey.com/docs/v2/howto/WriteHotkeys.htm) for more options.

- **Add animation**: Implement [smooth transitions](https://www.autohotkey.com/docs/v2/lib/WinMove.htm#Remarks) if desired.

### Known limitations

- **Administrative windows** (Task Manager, elevated Command Prompt) require running the script with administrative privileges.
- **Fullscreen applications** may ignore window positioning commands.
- **Ultrawide monitor users** can adjust horizontal positioning by modifying the centering calculation:
  ```javascript
  newX := monitorLeft + (monitorRight - monitorLeft - W) / 3  ; Position 1/3 from left
  ```

### How it works

The script functions through three key mechanisms:

**1. Position detection**
```javascript
CoordMode("Mouse", "Screen")
MouseGetPos(&mouseX, &mouseY)
```
This establishes screen-level coordinates to handle multi-monitor setups properly.

**2. Monitor identification**
```javascript
Loop MonitorGetCount() {
    MonitorGetWorkArea(A_Index, &mLeft, &mTop, &mRight, &mBottom)
    if (X >= mLeft && X < mRight && Y >= mTop && Y < mBottom) {
        monitorNumber := A_Index
        break
    }
}
```
This loop determines which monitor contains the active window by comparing window coordinates against each display's boundaries.

**3. Centering calculation**
```javascript
newX := monitorLeft + (monitorRight - monitorLeft - W) / 2
newY := monitorTop + (monitorBottom - monitorTop - H) / 2
```
These formulas calculate the optimal window position, accounting for usable screen area (excluding taskbars and docks) and window dimensions.

### Conclusion

This lightweight AutoHotkey solution provides efficient window management across multiple displays. With a single keyboard shortcut, you can instantly center any window on its current monitor, eliminating manual repositioning.