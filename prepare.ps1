Param (
    [string]$rootdir = ".\"
)

If ($PSVersionTable.PSVersion.Major -gt 2) {
    Start-Transcript -OutputDirectory "$pwd\logs"
}

"Getting path of Anaconda3"
Get-Command "conda" -ErrorAction SilentlyContinue -ErrorVariable ProcessError | Split-Path
if ($ProcessError) {
    Write-Host "Anaconda installation not Found. Please install Anaconda3 and make sure it is in the system path."    
    Exit
}

python .\prepare.py --rootdir $rootdir

Write-Host "Creating Conda Indexes.."
conda index "$rootdir\Packages\noarch"
conda index "$rootdir\Packages\win-32"
conda index "$rootdir\Packages\win-64"

Write-Host "Listing indexes"
Get-ChildItem -Path "$rootdir\Packages" -Recurse -Filter *.index*
Get-ChildItem -Path "$rootdir\Packages" -Recurse -Filter *repodata*


Write-Host "All done. Now run the deploy.bat script to offline install Orange3 and its add-ons."

If ($PSVersionTable.PSVersion.Major -gt 2) {
    Stop-Transcript
}
