Param (
    [string]$rootdir = ".\"
)

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

Write-Host "All done. Now run the deploy.bat script to offline install Orange3 and its add-ons."
