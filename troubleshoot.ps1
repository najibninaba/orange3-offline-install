$CondaPath = Get-Command "conda" -ErrorAction SilentlyContinue -ErrorVariable ProcessError | Split-Path
if ($ProcessError) {
    Write-Host "Anaconda installation not Found. Please install Anaconda3 and make sure it is in the system path."    
    Exit
}

$TimeStamp = Get-Date -Format o | foreach {$_ -replace ":", "."}
$LogFile = "$timestamp-orange3-offline.txt"

Add-Content $LogFile "Current PATH"
Add-Content $LogFile "==========================="
Add-Content $LogFile "$env:Path"
Add-Content $LogFile "==========================="

Add-Content $LogFile "Current NLTK_DATA setting"
Add-Content $LogFile "==========================="
Add-Content $LogFile "$env:NLTK_DATA"
Add-Content $LogFile "==========================="

Add-Content $LogFile "Path of conda.exe:"
Add-Content $LogFile "==========================="
$CondaPath = Get-Command conda.exe | Out-String
Add-Content $LogFile "$CondaPath"
Add-Content $LogFile "==========================="

$CondaPath = Get-Command conda.exe | Split-Path
$AnacondaPath = Split-Path $CondaPath
$OrangeContribPath = $AnacondaPath + "\Lib\site-packages\orangecontrib"

Add-Content $LogFile "Path of python.exe:"
Add-Content $LogFile "==========================="
$PythonPath = Get-Command python.exe | Out-String
Add-Content $LogFile "$PythonPath"
Add-Content $LogFile "==========================="

$Orange3ShortCut = $env:USERPROFILE + "\Desktop\Orange3.lnk"
$FileExists = Test-Path $Orange3ShortCut
If ($FileExists -eq $True) {
    $sh = New-Object -ComObject WScript.Shell
    $target = $sh.CreateShortcut($Orange3ShortCut)
    $ShortcutInfo = $target | Format-List | Out-String

    Add-Content $LogFile "Orange3 Shortcut Info:"
    Add-Content $LogFile "==========================="
    Write-Output $ShortcutInfo | Add-Content $LogFile
    Add-Content $LogFile "==========================="
} else {
    Add-Content $LogFile "Orange3 Shortcut not found!"
}

Add-Content $LogFile "Packages Repo"
Add-Content $LogFile "==========================="
Get-ChildItem -Recurse .\Packages | Select Directory, BaseName | Out-String | Add-Content $LogFile
Add-Content $LogFile "==========================="

Add-Content $LogFile "Orange Contrib Contents"
Add-Content $LogFile "==========================="
Get-ChildItem -Recurse $OrangeContribPath | Select Directory, BaseName | Out-String | Add-Content $LogFile
Add-Content $LogFile "==========================="
