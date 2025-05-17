
# 🚀 Terraform AWS Infrastructure for Uber Clone

This project automates the provisioning of **highly available**, **secure**, and **scalable** AWS infrastructure using **Terraform**. It is designed to support a production-ready application like an Uber clone by incorporating modern cloud architecture principles such as fault tolerance, network segmentation, and infrastructure as code (IaC).

---

## 📌 Problem Statement

Modern applications demand highly available, secure, and scalable infrastructure. Manual cloud provisioning is error-prone, lacks version control, and is not easily reproducible. This project addresses the need to automate AWS infrastructure using Terraform, ensuring:

- Faster deployment cycles
- Reduced human error
- Improved security posture
- Cost optimization
- High availability for mission-critical applications

---

## 🛠️ Features & Architecture

- 🔒 **Secure VPC** with public and private subnets across multiple AZs
- 🌐 **Internet Gateway & NAT Gateway** for controlled internet access
- 🔐 **Security Groups** for tight network control
- 🧠 **Modular Terraform Codebase** for reusability and scalability
- 💾 **Amazon RDS (Multi-AZ) with Read Replica** in private subnets
- 📦 **S3 Buckets with IAM policies** for app data and backend state
- 📈 **Highly available app tier** (EC2 instances or containers)
- 💬 Optional: Bastion host for SSH access to private EC2

---

## 📁 Directory Structure

```
terraform/
│
├── main.tf               # Root Terraform config (calls modules)
├── variables.tf          # Global variables
├── outputs.tf            # Global outputs
├── backend.tf            # S3 remote backend config
│
├── modules/              # Reusable Terraform modules
│   ├── vpc/
│   ├── subnets/
│   ├── igw/
│   ├── nat-gateway/
│   ├── route-tables/
│   ├── security-groups/
│   ├── ec2/
│   ├── rds/
│   └── s3/
│
└── env/
    ├── dev/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── terraform.tfvars
    └── prod/
        └── ...
```

---

## 🚀 Getting Started

### ✅ Prerequisites

- Terraform >= 1.5.x
- AWS CLI configured (`aws configure`)
- SSH key pair (PEM file) available locally
- Git (optional but recommended)

---

### 🔧 Initialize and Deploy

```bash
cd terraform/env/dev

# Initialize Terraform
terraform init

# Review and plan infrastructure changes
terraform plan

# Apply the infrastructure
terraform apply
```

---

## 🔐 Security Best Practices

- All app and DB resources are provisioned in **private subnets**
- Bastion host (optional) used for controlled SSH access
- IAM roles and policies follow **principle of least privilege**
- Security groups restrict access by IP, port, and protocol
- S3 buckets are encrypted and access controlled

---

## 🔄 Remote Backend (S3)

Terraform uses an S3 bucket to store the remote state securely.

Example `backend.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "uber-clone-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

---

## 📦 Infrastructure Components

| Module          | Description |
|-----------------|-------------|
| `vpc`           | Creates a VPC with CIDR block and tags |
| `subnets`       | Public and private subnets across AZs |
| `igw`           | Internet Gateway for public subnet |
| `nat-gateway`   | NAT Gateway for private internet access |
| `route-tables`  | Route tables and associations |
| `security-groups` | Bastion, EC2, RDS SGs |
| `ec2`           | App and bastion servers |
| `rds`           | PostgreSQL/MySQL with read replica |
| `s3`            | App data and remote state bucket |

---

## 📌 TODO / Future Enhancements

- [ ] Add Auto Scaling Group for EC2
- [ ] Implement CloudWatch Monitoring & Alarms
- [ ] Add CI/CD pipeline using GitHub Actions or CodePipeline
- [ ] Use Application Load Balancer (ALB)
- [ ] Configure WAF for enhanced security
- [ ] Add Redis or ElastiCache for caching layer

---

## 🧹 Clean Up

To destroy all provisioned infrastructure:

```bash
terraform destroy
```

---

## 🤝 Contributing

Pull requests and issues are welcome! This project is designed as a learning tool for DevOps engineers, cloud architects, and students.

---

## 📄 License

MIT License — feel free to use and modify as needed.

---

## 🙋‍♂️ Support

If you're stuck, feel free to open an issue or reach out. Happy Terraforming! 🌍
