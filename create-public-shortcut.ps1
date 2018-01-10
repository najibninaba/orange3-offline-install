If ($PSVersionTable.PSVersion.Major -gt 2) {
    Start-Transcript -OutputDirectory "$pwd\logs"
}


"Getting path of Anaconda3"
$CondaPath = Get-Command "conda" -ErrorAction SilentlyContinue -ErrorVariable ProcessError | Split-Path
if ($ProcessError) {
    Write-Host "Anaconda installation not Found. Please install Anaconda3 and make sure it is in the system path."    
    Exit
}
$AnacondaPath = Split-Path $CondaPath

$IconFileExists = Test-Path ".\orange.ico"
If ($IconFileExists -eq $False) {
    Write-Host "Orange icon not found. Please run the prepare.bat script."
    Exit
}

$AnacondaShareDir = $AnacondaPath + "\share\orange3"
$DirExists = Test-Path $AnacondaShareDir
If ($DirExists -eq $False) {
    New-Item -Path $AnacondaShareDir -ItemType "directory"
}

$AnacondaIconFilePath = $AnacondaShareDir + "\orange.ico"
$IconFilePathExists = Test-Path $AnacondaIconFilePath
If ($IconFilePathExists -eq $False) {
    "Copying Orange icon to " + $AnacondaShareDir
    Copy-Item .\orange.ico $AnacondaShareDir
} 

$Orange3Env = & "python" get-orange-env.py
$Orange3ShortCut = "C:\Users\Public" + "\Desktop\Orange3.lnk"

$TargetPath = $AnacondaPath + "\python.exe"
$TargetArguments = $AnacondaPath + "\cwp.py " + "$Orange3Env" + " " + "$Orange3Env" + "\python.exe -m Orange.canvas"


"Creating Orange3 Shortcut"
$Shell = New-Object -ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut($Orange3ShortCut)
$ShortCut.TargetPath = $TargetPath;
$ShortCut.Arguments = $TargetArguments;
$ShortCut.WindowStyle = 1;
$ShortCut.IconLocation = $AnacondaShareDir + "\orange.ico";
$ShortCut.Description = "Orange3";
$ShortCut.Save()

If ($PSVersionTable.PSVersion.Major -gt 2) {
    Stop-Transcript
}