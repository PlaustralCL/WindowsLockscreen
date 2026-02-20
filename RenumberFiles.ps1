# Renumber the files in image_collection consecutively, starting at 1001.

$i = 1001
$fileList = Get-ChildItem ".\image_collection" -File
$fileList | ForEach-Object {     
    Rename-Item $_.FullName -NewName "$($i).jpg" 
    $i++ 
}
