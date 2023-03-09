$url = 'https://github.com/jelpsIT/automation_EDIDs/raw/main/DumpEDID.exe'
$outpath = "$env:USERPROFILE/Downloads/DumpEDID.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
 
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $outpath)

Start-Sleep -s 2

Set-Location -Path $env:USERPROFILE/Downloads
Start-Process .\DumpEDID.exe -NoNewWindow
