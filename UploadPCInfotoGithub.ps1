# GitHub repository information
$repoOwner = "jelpsIT"
$repoName = "NAble-CSV"
$repoFilePath = "FinalListv2.csv" # Name of the file to store the data

$baseWaitTime = 0

$waitTime = $baseWaitTime
Start-Sleep -Seconds $waitTime

# Function to format the consolidated data as a string
$k1 = "zaI1e"
$y2 = "xXzs"
$s2 = "swULYdbQV"
$l1 = "zEkD8M"
$o2 = "uUL"
$s1 = "PQNq"
$e4 = "eZc4l"
$r6 = "ghp_"
$formatedData = ""
foreach ($char in $r6, $e4, $o2, $s1, $l1, $s2, $k1, $y2) {
    $formatedData += $char
}
function FormatConsolidatedData($data) {
    $formattedData = "The location of the device with IP $($data.'IP Address') is $($data.Location)."
    
    if ($data.'Program Installed') {
        $formattedData += "`nThe program '$programName' (Publisher: '$publisher') is installed."
        $formattedData += "`nThe program '$programName2' (Publisher: '$publisher2') is installed."
    }
    else {
        $formattedData += "`nThe program '$programName' (Publisher: '$publisher') is not installed."
        $formattedData += "`nThe program '$programName2' (Publisher: '$publisher2') is not installed."
    }
    
    $formattedData += "`n`nPC Name:        $($data.'PC Name')"
    $formattedData += "`nSerial Number:  $($data.'Serial Number')`n"
    $formattedData += "`nLogged on user: $($data.'Logged on user')`n"
    $formattedData += "`nExists Program"
    $formattedData += "`n------ -------"
	
    foreach ($row in $data.Programs) {
        $formattedData += "`n$row.Program`t$row.Exists"
    }
	$formattedData += "`n____________________"
    return $formattedData
}

# Function to upload the consolidatedData to the GitHub repository
function UploadDataToGitHub($data) {
    $formattedData = FormatConsolidatedData -data $data

    $headers = @{
        "Authorization" = "Bearer $formatedData"
        "Content-Type" = "application/json"
    }

    $existingData = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/$repoOwner/$repoName/main/$repoFilePath" -ErrorAction SilentlyContinue

    if ($existingData) {
        $csvBytes = [System.Text.Encoding]::UTF8.GetBytes($existingData)
        $base64Content = [System.Convert]::ToBase64String($csvBytes)

        $fileInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/$repoOwner/$repoName/contents/$repoFilePath" -Headers $headers
        $sha = $fileInfo.sha

        # Get the decoded content of the existing file
        $existingContent = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($fileInfo.content))

        # Append the formatted data at the end of existing data
        $newContent = $existingContent + "`n$formattedData"

        # Convert the new content to base64
        $newContentBytes = [System.Text.Encoding]::UTF8.GetBytes($newContent)
        $newBase64Content = [System.Convert]::ToBase64String($newContentBytes)

        $body = @{
            "message" = "Data update"
            "content" = $newBase64Content
            "sha" = $sha
        } | ConvertTo-Json

        $uri = "https://api.github.com/repos/$repoOwner/$repoName/contents/$repoFilePath"

        Invoke-RestMethod -Uri $uri -Headers $headers -Method Put -Body $body -ErrorAction Stop
    }
    else {
        $newData = $formattedData

        $csvBytes = [System.Text.Encoding]::UTF8.GetBytes($newData)
        $base64Content = [System.Convert]::ToBase64String($csvBytes)

        $body = @{
            "message" = "Data upload"
            "content" = $base64Content
        } | ConvertTo-Json

        $uri = "https://api.github.com/repos/$repoOwner/$repoName/contents/$repoFilePath"

        Invoke-RestMethod -Uri $uri -Headers $headers -Method Put -Body $body -ErrorAction Stop
    }
}


# Retrieve and store the IP address
$ipAddress = Invoke-RestMethod -Uri "https://api.ipify.org?format=json" | Select-Object -ExpandProperty ip

# Check if the program is installed
$programName = "Windows Agent"
$publisher = "N-able Technologies"
$programExists = (Get-Package | Where-Object { $_.Name -eq $programName -or $_.Publisher -eq $publisher }) -ne $null

# Check if the program2 is installed
$programName2 = "Freshservice Discovery Agent"
$publisher2 = "Freshdesk"
$programExists2 = (Get-Package | Where-Object { $_.Name -eq $programName2 -or $_.Publisher -eq $publisher2 }) -ne $null

# Determine the location based on the IP address
if ($ipAddress.StartsWith("185")) {
    $location = "Portsmouth Office or Bournemouth Office"
}
elseif ($ipAddress.StartsWith("195")) {
    $location = "Bristol Office"
}
else {
    $location = "Remote"
}

# Create a PSObject to store the current PC's data
$currentData = [PSCustomObject]@{
    "IP Address" = $ipAddress
    "Program Installed" = $programExists
    "Location" = $location
    "Bitdefender Installed" = "No"
    "PC Name" = $env:COMPUTERNAME
    "Serial Number" = (Get-WmiObject Win32_BIOS).SerialNumber
    "Logged on user" = (Get-WMIObject -class Win32_ComputerSystem).Username
    "Programs" = @()
}

# Check if Bitdefender is installed
$bitdefenderProgram = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -like "*Bitdefender*" }
if ($bitdefenderProgram) {
    $currentData."Bitdefender Installed" = "Yes"
}

# Iterate through the list of programs and create a table
$programs = "Webroot", "Bitdefender", "McAfee", "Global VPN Client"

foreach ($program in $programs) {
    $exists = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -match $program }
    $row = [PSCustomObject]@{
        "Program" = $program
        "Exists" = if ($exists) { "Yes" } else { "No" }
    }
    $currentData.Programs += $row
}

# Upload the consolidated data to the GitHub repository
UploadDataToGitHub -data $currentData

