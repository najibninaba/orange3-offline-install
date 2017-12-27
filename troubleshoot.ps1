Start-Transcript -OutputDirectory "$pwd\logs"

$CondaPath = Get-Command "conda" -ErrorAction SilentlyContinue -ErrorVariable ProcessError | Split-Path
if ($ProcessError) {
    Write-Host "Anaconda installation not Found. Please install Anaconda3 and make sure it is in the system path."    
    Exit
}


"================================="
"Current Conda Version"
"================================="
conda --version

"================================="
"Current Python Version"
"================================="
python --version

"================================="
"Current PATH"
"================================="
"$env:Path"

"================================="
"Current NLTK_DATA setting"
"================================="
"$env:NLTK_DATA"

"================================="
$CondaPath = Get-Command conda.exe | Split-Path
"================================="
"Current Conda Path"
"$CondaPath"
"================================="
"Current Anaconda Path"
$AnacondaPath = Split-Path $CondaPath
"$AnacondaPath"
"================================="
"Current Orange Contrib Path"
$OrangeContribPath = $AnacondaPath + "\Lib\site-packages\orangecontrib"
"$OrangeContribPath"
"================================="
"Contents of orangecontrib directory"
Get-ChildItem -Path $OrangeContribPath -Recurse
"================================="


$Orange3ShortCut = $env:USERPROFILE + "\Desktop\Orange3.lnk"
$FileExists = Test-Path $Orange3ShortCut
If ($FileExists -eq $True) {
    $sh = New-Object -ComObject WScript.Shell
    $target = $sh.CreateShortcut($Orange3ShortCut)
    $ShortcutInfo = $target | Format-List

    "Orange3 Shortcut Info:"
    "$ShortCutInfo"
    "================================="
} else {
    "Orange3 Shortcut not found!"
}

"Packages Repo"
"================================="
Get-ChildItem -Recurse .\Packages | Select Directory, BaseName
"================================="

"Current Orange Contrib Path"
$OrangeContribPath = $AnacondaPath + "\Lib\site-packages\orangecontrib"
"$OrangeContribPath"
"================================="
"Contents of orangecontrib directory"
Get-ChildItem -Path $OrangeContribPath -Recurse
"================================="

Stop-Transcript
