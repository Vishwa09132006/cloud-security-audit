# audit_vpc.ps1
# Define report file paths
$txtReport = "C:\Users\vishw\cloud-security-audit\reports\vpc_audit.txt"
$jsonReport = "C:\Users\vishw\cloud-security-audit\reports\vpc_audit.json"
$csvReport = "C:\Users\vishw\cloud-security-audit\reports\vpc_audit.csv"

# Run the AWS CLI command and parse JSON
$results = aws ec2 describe-vpcs | ConvertFrom-Json

# Show raw results in console
Write-Host "Raw Results:"
$results

# Save reports
$results.Vpcs | Out-File $txtReport
$results.Vpcs | ConvertTo-Json -Depth 3 | Out-File $jsonReport
$results.Vpcs | Export-Csv -Path $csvReport -NoTypeInformation

Write-Host "Reports saved to: $txtReport, $jsonReport, $csvReport"
