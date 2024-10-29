$dailyNotesPath = ""
$files = Get-ChildItem $dailyNotesPath -Filter *.txt
$latestDate = Get-Date "01/01/1980 00:00 AM"
$latestFileName = ""

foreach ($file in $files) {
	try {
		$fileName = $file.BaseName
		$fileDate = [datetime]::parseexact($fileName, "yyyy-MMM-dd", $null)
		if ($fileDate -gt $latestDate) {
			$latestDate = $fileDate
			$latestFileName = $file.Name
		}
	}
	catch { }
		
}

$newFileName = Get-Date -UFormat "%Y-%b-%d.txt"
$newFileName = $dailyNotesPath + "\" + $newFileName
Write-Output ("created " + $newFileName)
Copy-Item $latestFileName -Destination $newFileName
& $newFileName