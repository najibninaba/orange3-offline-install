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
