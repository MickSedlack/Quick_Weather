$path = (Get-Item .).FullName
$commpath = '"$path\weather.ps1"'
$strCommand = "powershell -WindowStyle hidden -file $($commpath)"

Invoke-Expression $strCommand