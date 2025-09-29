# s3_audit.ps1
# Define report file paths
$txtReport = "C:\Users\vishw\cloud-security-audit\reports\s3_audit.txt"
$jsonReport = "C:\Users\vishw\cloud-security-audit\reports\s3_audit.json"
$csvReport = "C:\Users\vishw\cloud-security-audit\reports\s3_audit.csv"

# Run AWS CLI command and parse JSON
$results = aws s3api list-buckets | ConvertFrom-Json

# Check if there are buckets
if ($results.Buckets.Count -eq 0) {
    Write-Host "No S3 buckets found."

    # Save message to reports instead of leaving them empty
    "No S3 buckets found." | Out-File $txtReport
    "[]" | Out-File $jsonReport
    "BucketName" | Out-File $csvReport
}
else {
    Write-Host "Raw Results:"
    $results.Buckets

    # Save reports
    $results.Buckets | Out-File $txtReport
    $results.Buckets | ConvertTo-Json -Depth 3 | Out-File $jsonReport
    $results.Buckets | Select-Object -Property Name, CreationDate | Export-Csv -Path $csvReport -NoTypeInformation
}

Write-Host "Reports saved to: $txtReport, $jsonReport, $csvReport"
