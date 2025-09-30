# audit_iam.ps1
# Audits IAM users and saves reports in TXT, JSON, and CSV

$reportDir  = "C:\Users\vishw\cloud-security-audit\reports"
$txtReport  = Join-Path $reportDir "iam_audit.txt"
$jsonReport = Join-Path $reportDir "iam_audit.json"
$csvReport  = Join-Path $reportDir "iam_audit.csv"

# Get IAM users
$results = aws iam list-users | ConvertFrom-Json

if ($results.Users.Count -eq 0) {
    # No users found
    "No IAM users found." | Out-File -FilePath $txtReport -Encoding utf8
    @{ Message = "No IAM users found." } | ConvertTo-Json | Out-File -FilePath $jsonReport -Encoding utf8
    @(@{ UserName = "None"; Arn = "None"; CreateDate = "None" }) | Export-Csv -Path $csvReport -NoTypeInformation
} else {
    # Write real data
    $results.Users | Out-File -FilePath $txtReport -Encoding utf8
    $results.Users | ConvertTo-Json | Out-File -FilePath $jsonReport -Encoding utf8
    $results.Users | Select-Object UserName, Arn, CreateDate | Export-Csv -Path $csvReport -NoTypeInformation
}

Write-Host "IAM audit complete. Reports saved to:"
Write-Host " - $txtReport"
Write-Host " - $jsonReport"
Write-Host " - $csvReport"


