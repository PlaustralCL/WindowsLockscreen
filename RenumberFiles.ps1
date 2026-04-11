# Renumber the files in image_collection consecutively, starting at 1001.


function RenumberFileNames {
    <#
    .SYNOPSIS
    Renames files in .\image_collection to be a series of integers.
    
    .PARAMETER i
    The starting integer. The first file will use this as the name and 
    each remaining file name will be incremented by 1.
    #>
    param ([int]$i)
    $fileList = Get-ChildItem ".\image_collection" -File
    $fileList | ForEach-Object {     
        $oldFileName = $_.FullName
        $newFileName = [string]$i + ".jpg"
        Rename-Item $oldFileName -NewName $newFileName
        $i++ 
    }   
}

# Determine if the current files are named in the 1000s. If so, first
# renumber them using a different series, e.g., 4000. This will prevent errors
# from potentially having duplicate names.

$currentFirstFile = Get-ChildItem ".\image_collection" -Name | Select-Object -First 1

if ($currentFirstFile -eq "1001.jpg") {
    RenumberFileNames(4001)    
} 

RenumberFileNames(1001)