# Define report paths
$txtReport  = "../reports/iam_audit.txt"
$jsonReport = "../reports/iam_audit.json"
$csvReport  = "../reports/iam_audit.csv"

# Save reports
$results | Format-Table | Out-File $txtReport   # human-readable
$results | ConvertTo-Json -Depth 3 | Out-File $jsonReport   # structured JSON
$results | Export-Csv -Path $csvReport -NoTypeInformation   # structured CSV

Write-Host "IAM audit complete. Reports saved to:"
Write-Host " - $txtReport"
Write-Host " - $jsonReport"
Write-Host " - $csvReport"

