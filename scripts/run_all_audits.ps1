# run_all_audits.ps1
# Runs all audits (IAM, VPC, S3) and pushes results to GitHub

Write-Host "Starting all audits..."

# IAM Audit
powershell.exe -ExecutionPolicy Bypass -File "C:\Users\vishw\cloud-security-audit\scripts\audit_iam.ps1"

# VPC Audit
powershell.exe -ExecutionPolicy Bypass -File "C:\Users\vishw\cloud-security-audit\scripts\audit_vpc.ps1"

# S3 Audit
powershell.exe -ExecutionPolicy Bypass -File "C:\Users\vishw\cloud-security-audit\scripts\s3_audit.ps1"

# Change to project root
Set-Location "C:\Users\vishw\cloud-security-audit"

# Git commands
git add reports/*.txt reports/*.json reports/*.csv
git commit -m "Automated audit reports update"
git push origin main

Write-Host "`nReports pushed to GitHub successfully!"
