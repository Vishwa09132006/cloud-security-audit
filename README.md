# 🔐 Cloud Security Audit Automation

This project automates **AWS security audits** (IAM, S3, VPC) using PowerShell and pushes the results to GitHub daily.  
It showcases my ability to script, automate, and manage cloud security workflows — all skills required for a **Cloud Engineer / DevOps role**.

---

## 🚀 Features
- **IAM Audit** → Reports inactive users, policies, and MFA status.
- **S3 Audit** → Lists buckets, encryption status, and public access.
- **VPC Audit** → Captures VPC details, CIDR blocks, and configurations.
- **Automated GitHub Push** → Reports are committed & pushed daily with Task Scheduler.
- Outputs in **TXT, JSON, and CSV** formats for versatility.

---

## 📂 Project Structure

cloud-security-audit/
│── reports/ # Generated audit reports
│── scripts/ # PowerShell audit scripts
│── run_all_audits.ps1 # Master script to run everything
│── README.md # Project documentation

---

## 📊 Sample Report
Here’s an example from an IAM Audit Report (JSON):

``` json
{
  "UserName": "Alice",
  "MFAEnabled": true,
  "LastUsed": "2025-09-25"
}
```


## ⚡ Automation

A Windows Task Scheduler job runs run_all_audits.ps1 every day.

Reports are automatically staged, committed, and pushed to GitHub:

Automated audit report 2025-09-30 17:19:18

This ensures fresh reports are always available.

---

## 🛠️ Tech Stack

AWS CLI / PowerShell → Data collection

Git + GitHub → Version control & publishing

Windows Task Scheduler → Automation

---

## 📸 Screenshots  

### Run All Audits Script
![Run All Audits Pt.1](images/Screenshot%202025-10-01%20194805.png)
![Run All Audits Pt.2](images/Screenshot%202025-10-01%20194945.png)

### 🔑 Scripts
![IAM Audit Script](images/audit_iam.ps1screenshot.png)

![VPC Audit Script]()

![S3 Audit SCript]()

### Reports
![IAM Audit JSON](images/iam_audit.jsonscreenshot.png)

![VPC Audit JSON]()

![S3 Audit JSON]()


### GitHub Commit After Audit
![GitHub Commit]


### Task Scheduler Job Setup  
![Task Scheduler](images/screenshots/task_scheduler.png)  


---

## 👨‍💻 How to Run

1. Clone the repo:

``` bash
git clone https://github.com/Vishwa09132006/cloud-security-audit.git

```

2. Run all audits:

.\scripts\run_all_audits.ps1


3. Reports will appear in the reports/ folder.

---

## 🎯 Why This Project?

This project simulates a real-world cloud security auditing pipeline.
It demonstrates:

Cloud security awareness

Automation with scripting

Git + GitHub workflows

Infrastructure monitoring

---

## 📅 Future Improvements

Add EC2 + CloudTrail audits

Slack/Email notifications for critical findings

GitHub Actions workflow for CI/CD integration



