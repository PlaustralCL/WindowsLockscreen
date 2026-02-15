# Lockscreen update
Updates the windows lockscreen based on a selected image from the
image collection. This allows a rotating image to be displayed without the
ads that Microsoft includes in the default lockscreen.  The displayed image will
always have the same filename, however, the contents of the file will be replaced.

## Setup

### Registry Updates
The following changes to the registry are required:
- Edit your registry and create the following key: `[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP]`
    - Run the Registry Editor as Administrator. It can be found using the app search
    - Go to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
    - Right click on the `CurrentVersion` folder and select New -> Key
- add the REG_DWORD(32-bit) Hex val: `LockScreenImageStatus=00000001`
    - Right click on the right half of the screen (side without the folders)
    - Select New -> DWORD (32-bit) Value
    - Set the `Name` to `LockScreenImageStatus`
    - Set the `Data` to `00000001`    
- add the REG_SZ: `LockScreenImagePath=\<absolute path to image>\lockscreen.jpg` 
    - Right click on the right half of the screen (side without the folders)
    - Select New -> String Value
    - Set the `Name` to `LockScreenImagePath`
    - Set the `Data` to `<absolute path to image>\lockscreen.jpg`
- add the REG_SZ: `LockScreenImageUrl=\<absolute path to image>\lockscreen.jpg`
    - Right click on the right half of the screen (side without the folders)
    - Select New -> String Value
    - Set the `Name` to `LockScreenImageUrl`
    - Set the `Data` to `<absolute path to image>\lockscreen.jpg`
    
Source: https://web.archive.org/web/20251019141633/https://community.spiceworks.com/t/manage-lock-screen-image/1014209

### Task Scheduler
Set up a task in Task Scheduler to run every day. It can be at a set time or
after each startup. The goal is for powershell to have as little impact as possible
on the user when the task runs. To achieve this, we specify `-NoProfile` to prevent
spending time on reading the Powershell profile and `-WindowStyle Hidden` to minimize
the time the terminal is open and blocking the screen.
- In the action tab, the action should be `Start a program` 
    - Program/script: `Powershell.exe`
    - Add arguments: `-NoProfile -WindowStyle Hidden <absolute path to script>\lockscreen.ps1`    
