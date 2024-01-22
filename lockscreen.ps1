# Randomly selects a file name from the folder. This file will be copied to a
# designated location to be the lock screen image. A copy of the file name as
# well as the timestamp the change was made is recorded in a local log file.

# For this to successfully change the lock screen image, the following updates
# to the registry had to be made:
# Edit your registry and create the following key : 
# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP] 
# add the REG_DWORD(32) Hex val: LockScreenImageStatus=00000001 
# add the REG_SZ: LockScreenImagePath=\sharePath\lockscreen.jpg 
# add the REG_SZ: LockScreenImageUrl=\sharePath\lockscreen.jpg

# While the above registry changes are in effect, the lock screen image cannot
# be changed from the normal GUI in Settings. The registry settings will need to
# be deleted. This also means that the lock screen cannot be changed from a
# single picutre to a slideshow.

# A daily task in the task scheduler has been created, UpdateLockscreen, to
# change the lock screen image each morning, or as soon as the computer is run
# that day.

$FileName = Get-ChildItem -Path c:\wallpaper\wallpaper\ -Name | Get-Random
Copy-Item c:\wallpaper\wallpaper\$FileName -Destination c:\wallpaper\lockscreen\lockscreen.jpg

# Add the the name of the selected image to the log file
$TimeStamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
Add-Content -Path c:\wallpaper\log.txt -Value ($TimeStamp + " " + $FileName)