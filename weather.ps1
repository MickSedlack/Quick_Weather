# Plain powershell weather.
# Michael Sedlack
# May - 2026

#- Variables
$path = (Get-Item .).FullName
$date = get-date -Format dd-MM-HH
$radar = "https://radar.weather.gov/ridge/standard/KTBW_loop.gif"

if (!(Test-Path "$path\$date.gif")){ 
	$s = Invoke-WebRequest -Uri $radar -Outfile "$path\$date.gif"	
}

#- Filter for older files.
Get-ChildItem $path -Filter *.gif | 
Foreach-Object {
	$fullPath = "$path\$_"
	$lastWrite = (get-item $fullPath).LastWriteTime
	#Can take days, minutes, hours in variation
	$timespan = new-timespan -days 7

	if (((get-date) - $lastWrite) -gt $timespan) {
    		Remove-Item "$fullPath"
	}
}

#- Plain form to just show the gif
Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object System.Windows.Forms.Form
$Form.AutoSize = $true
$Form.StartPosition = "CenterScreen"
$gifBox = New-Object Windows.Forms.picturebox
$gifLink= (Get-Item -Path ".\$date.gif")
$img = [System.Drawing.Image]::fromfile($gifLink)
$gifBox.AutoSize = $true
$gifBox.Image = $img
$Form.Controls.Add($gifbox)
$gifBox.Enabled = $false
$Form.ShowDialog()
