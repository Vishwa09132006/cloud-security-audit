# s3_audit.ps1
# Audit S3 buckets for public access and encryption

# Get all buckets in JSON format
$buckets = aws s3api list-buckets --query "Buckets[].Name" --output json | ConvertFrom-Json

# Prepare report paths
$txtReport = "../reports/s3_audit.txt"
$jsonReport = "../reports/s3_audit.json"
$csvReport = "../reports/s3_audit.csv"

# Initialize arrays for structured output
$results = @()

foreach ($bucket in $buckets) {
    Write-Output "Auditing bucket: $bucket"

    # Check bucket encryption
    try {
        $encryption = aws s3api get-bucket-encryption --bucket $bucket --output json | ConvertFrom-Json
        $encryptionStatus = "Enabled"
    } catch {
        $encryptionStatus = "Not Enabled"
    }

    # Check public access block
    try {
        $publicAccess = aws s3api get-bucket-acl --bucket $bucket --output json | ConvertFrom-Json
        $isPublic = $publicAccess.Grants | Where-Object { $_.Grantee.URI -like "*AllUsers*" }
        if ($isPublic) {
            $publicStatus = "Public"
        } else {
            $publicStatus = "Private"
        }
    } catch {
        $publicStatus = "Unknown"
    }

    # Save structured results
    $results += [PSCustomObject]@{
        BucketName       = $bucket
        EncryptionStatus = $encryptionStatus
        PublicStatus     = $publicStatus
    }
}

# Save TXT
$results | Format-Table | Out-File $txtReport

# Save JSON
$results | ConvertTo-Json -Depth 3 | Out-File $jsonReport

# Save CSV
$results | Export-Csv -Path $csvReport -NoTypeInformation

Write-Output "S3 audit complete. Reports saved to: $txtReport, $jsonReport, $csvReport"
