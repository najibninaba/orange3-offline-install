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

$DirExists = Test-Path "./Packages/noarch"
If ($DirExists -eq $False) {
    Write-Host "Packages directory not prepared. Please run the prepare.bat script."
    Exit
}

$DirExists = Test-Path "./Packages/win-32"
If ($DirExists -eq $False) {
    Write-Host "Packages directory not prepared. Please run the prepare.bat script."
    Exit
}

$DirExists = Test-Path "./Packages/win-64"
If ($DirExists -eq $False) {
    Write-Host "Packages directory not prepared. Please run the prepare.bat script."
    Exit
}

$DirExists = Test-Path "./nltk_data"
If ($DirExists -eq $False) {
    Write-Host "nltk_data directory not prepared. Please run the prepare.bat script."
    Exit
}

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

& "conda" config --set auto_update_conda false
"Removing existing orange3 environment"
& "conda" env remove -n orange3 -y

"Creating a new orange3 environment"
& "conda" create -n orange3 --clone root -y

"Installing Orange3 with Orange3-Text and Orange3-TimeSeries addons"
& "conda" install -n orange3 -y --channel ./Packages --override-channels --offline --no-update-dependencies orange3 orange3-text orange3-timeseries

$NLTK_DATA = "$env:APPDATA\Orange\nltk_data"
$DirExists = Test-Path $NLTK_DATA
If ($DirExists -eq $True) {Write-Host "$NLTK_DATA already exists.."}
Else {
    Write-Host "Copying nltk_data to $env:APPDATA\Orange\nltk_data..."
    # Copy-Item .\nltk_data $env:APPDATA\Orange\nltk_data -Recurse
    Robocopy.exe .\nltk_data $env:APPDATA\Orange\nltk_data /MIR
}
"Setting user environment variable NLTK_DATA.."
[Environment]::SetEnvironmentVariable("NLTK_DATA", "$NLTK_DATA", "User")

If ($PSVersionTable.PSVersion.Major -gt 2) {
    Stop-Transcript
}
