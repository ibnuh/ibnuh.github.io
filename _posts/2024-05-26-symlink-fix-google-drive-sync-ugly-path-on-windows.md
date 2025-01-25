---
layout: post
title: 'Symlink: Fix Google Drive Sync Ugly Path on Windows'
date: 2024-05-26 13:03:00 +0700
---

For some reason, google drive introduces a nasty feature where it will create a separate disk on windows, and then place the google drive files inside another folder called `My Drive`, that means more clicking and messing around to get into my files, this is often not necessary for regular users, where they would only have one drive.

Not to mention the disk they added is kinda _polluting_ **my** explorer view, why would I want a separate drive that will only contains one or two shortcut to a folder? madness. To battle this, I setup a symlink in Windows, I have tested this solution and all of the syncing works flawlessly on Windows 11.

### Changes

| After                     | Before #1          | Before #2                                    |
| ------------------------- | ------------------ | -------------------------------------------- |
| E:\Drive                | G:\My Drive      | E:\Google\ibnuhdev@gmail.com\My Drive      |
| E:\DriveRedacted        | H:\My Drive      | E:\Google\ibnuh@REDACTED.com\My Drive      |
| E:\DriveRedacted-Shared | H:\Shared drives | E:\Google\ibnuh@REDACTED.com\Shared drives |

### Disable Virtual Drive

Head into the Google Drive Preferences, and choose folder, setup an appropriate path where you would point the normal google drive path, you can follow my convention by appending the folder name with the google drive account, or do whatever you like, this will give us the `Before #2` result, and disable `Before #1`.

Now you can stop here, but I don't like having to click to another `My Drive` folder everytime, so see the next section.

![Disable ugly google drive virtual drive](/images/google_drive_ugly_mess.png)

### Adding Symlinks

A symbolic link (symlink) is a file-system object that points to another file system object. It's like creating a shortcut, but more powerful, as it allows seamless access as if it were part of the file system. Here's how to set it up:

1. Open PowerShell as an administrator.
2. Use the `New-Item` cmdlet to create the symlink.

```powershell
New-Item -ItemType SymbolicLink -Path E:\Drive -target "E:\Google\ibnuhdev@gmail.com\My Drive"
```

If you have multiple Google Drive accounts, you can create additional symlinks as needed. For example:

```powershell
New-Item -ItemType SymbolicLink -Path E:\DriveRedacted -target "E:\Google\ibnuh@REDACTED.com\My Drive"
```

By using symlinks, you can simplify access to your Google Drive files and avoid the clutter of additional virtual drives in your Explorer view. This method ensures all your syncing works seamlessly while keeping your file system tidy.
