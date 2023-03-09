$url = 'https://github.com/jelpsIT/automation_EDIDs/raw/main/DumpEDID.exe'
New-Item -ItemType Directory -Path C:\Temp -Force
$outpath = "C:/temp/DumpEDID.exe"
Invoke-WebRequest -Uri $url -OutFile $outpath
 
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $outpath)

Start-Sleep -s 2
Set-Location -Path C:\temp

Start-Process .\DumpEDID.exe -NoNewWindow
