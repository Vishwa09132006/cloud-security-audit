# run_all_audits.ps1
# Master script to run IAM, VPC, and S3 audits, save reports, and push them to GitHub.

Write-Host "Starting all audits..."

# Define paths
$projectRoot = "C:\Users\vishw\cloud-security-audit"
$reportDir   = Join-Path $projectRoot "reports"

# Ensure reports folder exists
if (!(Test-Path -Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir | Out-Null
}

# Run IAM Audit
Write-Host "`nRunning IAM audit..."
& "$projectRoot\scripts\audit_iam.ps1"

# Run VPC Audit
Write-Host "`nRunning VPC audit..."
& "$projectRoot\scripts\audit_vpc.ps1"

# Run S3 Audit
Write-Host "`nRunning S3 audit..."
& "$projectRoot\scripts\s3_audit.ps1"

Write-Host "`nAll audits completed. Reports saved to: $reportDir"

# Change directory to project root before git commands
Set-Location $projectRoot

# Git commit & push
try {
    git add reports/*.txt
    git add reports/*.json
    git add reports/*.csv
    git add scripts/*.ps1

    git commit -m "Automated audit report $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" --allow-empty
    git push origin main
    Write-Host "`n✅ Reports pushed to GitHub successfully!"
}
catch {
    Write-Host "`n⚠️ Git push failed: $($_.Exception.Message)"
}

# Exit cleanly for Task Scheduler
Write-Output "All audits completed successfully."
exit 0
