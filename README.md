## Friend's Spending Tracker: Automated CI/CD Deployment with Flask

### 📑 Table of Contents
1. [AWS Flask App Infra Setup](#AWS-Flask-App-Infra-Setup)
   - [📁 Project Structure](#Project-Structure)
   - [🔧 Setup Instructions](#Setup-Instructions)
   - [📷 Demo Screenshots](#Demo-Screenshots)
2. [Setting up Jenkins Infra Structure with Terraform](#Jenkins-Infra-Setup)

### AWS Flask App Infra Setup
```markdown
This repository contains Terraform configurations and CI/CD pipelines to provision and manage AWS infrastructure for
deploying a Flask-based Python application. It supports both automated provisioning and deployment using Jenkins.

🚀 Features

- 🏗️ Infrastructure-as-Code with Terraform
- ☁️ Deploys to AWS using EC2, VPC, Subnets, Security Groups, ALB, RDS, Route 53, and Certificate Manager
- 🔐 Secure credential management via Jenkins Credentials
- 🛠️ CI/CD automation with Jenkins Pipeline
- 📦 Modular and reusable Terraform code
```

### Project Structure
```
├── terraform-infra-setup/
│   ├── modules/
│   │   ├── certificate-manager/           # ACM certificate provisioning
│   │   ├── hosted-zone/                   # Route 53 hosted zone setup
│   │   ├── jenkins/                       # EC2 instance setup for Jenkins
│   │   ├── load-balancer/                 # Load Balancer
│   │   ├── load-balancer-target-group/    # Load Balancer Target Group
│   │   ├── networking/                    # VPC, subnets, route tables
│   │   ├── rds/                           # MySQL for persistent storage
│   │   ├── security-groups/               # Security group definitions
│   │   ├── user-data-script/              # Script to install Python Flask application on EC2
│   ├── main.tf                            # Root Terraform config
│   ├── outputs.tf                         # Output variables
│   ├── provider.tf                        # Provider configuration
│   ├── terraform.tfvars                   # Variable values
│   ├── variables.tf                       # Input variables
└── Jenkinsfile                            # Jenkins pipeline script
└── README.md                              # You're here

```
### Prerequisites
```
- AWS account with programmatic access (IAM user with permissions)
- Terraform CLI (v1.3+ recommended)
- Jenkins server installation script
```
---

### Setup Instructions

#### 1. Clone the Repository
```
bash
git clone https://github.com/KushalNishad/AWS-Flask-App-Infra-Setup.git
cd AWS-Flask-App-Infra-Setup
```

#### 2. Initialize Terraform
```bash
terraform init
```

#### 3. Plan and Apply Infrastructure
```bash
terraform plan
terraform apply
```

#### 4. CI/CD Pipeline (Jenkins)
```bash
- Add AWS credentials to Jenkins:
  - ID: aws-credentials-kushal
  - Type: AWS Credentials
- Run the Jenkins pipeline from the Jenkinsfile
```
---

### 🧹 Tear Down

To destroy all resources:
```bash
terraform destroy
```

### 📝 To-Do

- [ ] Integrate Docker and ECS
- [ ] Add monitoring (CloudWatch / Prometheus)

### Demo Screenshots

---
### Jenkins-Infra-Setup
Follow GitHub Repo: https://github.com/KushalNishad/AWS-Jenkins-Infra-Setup.git

### 🙋‍♂️ Author

**Kushal Nishad**  
🔗 [GitHub](https://github.com/KushalNishad) | [LinkedIn](https://www.linkedin.com/in/kushal-nishad/)

---
