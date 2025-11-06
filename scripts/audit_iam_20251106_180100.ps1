# Run IAM audit
$results = aws iam list-users | ConvertFrom-Json

if (-not $results.Users -or $results.Users.Count -eq 0) {
    "No IAM users found." | Out-File $txtReport
    "[]" | Out-File $jsonReport
    "UserName" | Out-File $csvReport   # create empty CSV with header
}
else {
    $results.Users | Out-File $txtReport
    $results.Users | ConvertTo-Json -Depth 3 | Out-File $jsonReport
    $results.Users | Export-Csv -Path $csvReport -NoTypeInformation
}

Write-Host "`nIAM audit complete. Reports saved to:"
Write-Host " - $txtReport"
Write-Host " - $jsonReport"
Write-Host " - $csvReport"

