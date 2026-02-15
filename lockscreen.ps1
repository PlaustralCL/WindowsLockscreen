# Selects a file name from the image collection folder. This file will be copied to a
# designated location to be the lock screen image. A copy of the file name as
# well as the timestamp the change was made is recorded in a local log file.

$ImageCollectionFolder = "$PSScriptRoot\image_collection"
$DestinationPath = "$PSScriptRoot\daily_lockscreen_image"

$NumberOfImages = (Get-ChildItem -Path $ImageCollectionFolder -File).Count
$DayOfYear = (Get-Date).DayOfYear
$StartingNumber = 1001
$DailyNumber = ($DayOfYear % $NumberOfImages) + $StartingNumber
$ReplacementFileName = "$DailyNumber.jpg"
$PathToReplacementFile = Join-Path -Path $ImageCollectionFolder -ChildPath $ReplacementFileName

# Copy the selected file to the DailyLockScreen folder
Copy-Item $PathToReplacementFile -Destination "$DestinationPath\lockscreen.jpg"

# Add the the name of the selected image to the log file
$TimeStamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
Add-Content -Path "$PSScriptRoot\log.txt" -Value ($TimeStamp + " " + $ReplacementFileName)