# Place the Following Snippet in your profile.ps1

$i=0
$lib_home = "D:\Path\To\My\CmdLets\"
New-PSDrive -Name scripts -PSProvider filesystem -root $lib_home -ErrorAction SilentlyContinue | Out-Null
 
Write-Host "################################################################################" -ForegroundColor Red
Write-Host "Scripts Loading..."
Write-Host "Location: $lib_home" 
Write-Host " "
Get-ChildItem -Path scripts: -Recurse | Where { $_.attributes -ne "directory" } | ForEach-Object {
    [string]::Join([environment]::NewLine, (Get-Content -Path $_.fullname)) | Invoke-Expression
	Write-Host ("{0:00#}" -f $i)" : "$_.name
    $i++
}
Write-Host "################################################################################" -ForegroundColor Red
