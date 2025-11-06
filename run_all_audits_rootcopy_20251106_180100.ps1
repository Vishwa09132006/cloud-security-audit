# --- Setup SSH agent and GitHub connection ---
try {
    # Try starting ssh-agent service (safe if already running)
    Start-Service ssh-agent -ErrorAction Stop
    Write-Host "ssh-agent service started successfully."
} catch {
    Write-Host "ssh-agent service could not start; trying manual start..."
    Start-Process -NoNewWindow -FilePath "C:\Windows\System32\OpenSSH\ssh-agent.exe" -ArgumentList "-s"
    Start-Sleep -Seconds 2
}

# Add your private SSH key (replace id_ed25519 with id_rsa if that's your file)
$keyPath = "$env:USERPROFILE\.ssh\id_ed25519"
if (Test-Path $keyPath) {
    ssh-add $keyPath | Out-Null
    Write-Host "SSH key added successfully."
} else {
    Write-Host "SSH key not found at $keyPath"
}

# Test GitHub connection (optional but useful for debugging)
ssh -T git@github.com | Write-Host
Write-Host "--- GitHub SSH setup complete ---`n"
# ----------------------------------------------

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
