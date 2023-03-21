$url = "https://github.com/jelpsIT/duckery/raw/main/DumpEDID.exe"
$outputPath = "C:\temp\"

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


# add download bitdefender and xml file with user prompts 

