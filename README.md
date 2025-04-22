```markdown
# AWS Flask App Infra Setup

This repository contains Terraform configurations and CI/CD pipelines to provision and manage AWS infrastructure for
deploying a Flask-based Python application. It supports both automated provisioning and deployment using Jenkins.

## 🚀 Features

- 🏗️ Infrastructure-as-Code with **Terraform**
- ☁️ Deploys to **AWS** using EC2, VPC, Subnets, Security Groups, IAM, and more
- 🔐 Secure credential management via Jenkins Credentials or GitHub Secrets
- 🛠️ CI/CD automation with **Jenkins Pipeline** and **GitHub Actions**
- 📦 Modular and reusable Terraform code

## 📁 Project Structure

AWS-Flask-App-Infra-Setup/
├── jenkins/
│   └── Jenkinsfile               # Jenkins pipeline script
├── .github/
│   └── workflows/
│       └── terraform.yml         # GitHub Actions workflow for Terraform
├── modules/
│   ├── networking/               # VPC, subnets, route tables
│   ├── ec2/                      # EC2 instance setup
│   ├── security-groups/         # Security group definitions
│   └── iam/                      # IAM roles and policies
├── main.tf                      # Root Terraform config
├── variables.tf                 # Input variables
├── outputs.tf                   # Output variables
└── README.md                    # You're here!

## 🧰 Prerequisites

- AWS account with programmatic access (IAM user with permissions)
- Terraform CLI (v1.3+ recommended)
- Jenkins server (if using Jenkins)
- GitHub repository & secrets (if using GitHub Actions)

## 🔧 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/KushalNishad/AWS-Flask-App-Infra-Setup.git
cd AWS-Flask-App-Infra-Setup
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Plan and Apply Infrastructure
```bash
terraform plan
terraform apply
```

### 4. CI/CD Pipeline (Jenkins)

- Add AWS credentials to Jenkins:
  - ID: `aws-credentials-kushal`
  - Type: AWS Credentials
- Run the Jenkins pipeline from the `Jenkinsfile`

### 5. CI/CD Pipeline (GitHub Actions)

- Add GitHub Secrets:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
- GitHub Actions will automatically run on `push` to `main`

## 🧹 Tear Down

To destroy all resources:
```bash
terraform destroy
```

## 📝 To-Do

- [ ] Add ALB or ELB integration
- [ ] Add RDS module for persistent storage
- [ ] Integrate Docker and ECS
- [ ] Add monitoring (CloudWatch / Prometheus)

## 📷 Demo Screenshots (Coming Soon)

## 🙋‍♂️ Author

**Kushal Nishad**  
🔗 [GitHub](https://github.com/KushalNishad) | [LinkedIn](https://www.linkedin.com/in/kushal-nishad/)

---

```

Let me know if you'd like to add:
- Project logo or architecture diagram
- Example Terraform output
- Flask app repo link / deployment test URL
- Deployment flow explanation

I can tailor the README more for personal projects, job portfolios, or team collaboration!
