# 🚀 Uber Clone - Infrastructure as Code Project

This project demonstrates a production-ready infrastructure setup for a ride-sharing application using Terraform, Ansible, and AWS services. It implements modern DevOps practices and cloud architecture principles.

## 📋 Project Overview

The project consists of three main components:
1. **Infrastructure (Terraform)**: AWS infrastructure provisioning
2. **Application (Next.js)**: Uber clone application
3. **Deployment (Ansible)**: Application deployment automation

## 🏗️ Infrastructure Architecture

### Key Components
- 🔒 **Secure VPC** with public and private subnets across multiple AZs
- 🌐 **Internet Gateway & NAT Gateway** for controlled internet access
- 🔐 **Security Groups** for tight network control
- 💾 **Amazon RDS (Multi-AZ)** with read replica in private subnets
- 📦 **S3 Buckets** with IAM policies for app data and state
- 📈 **Highly available app tier** with EC2 instances
- 💬 **Bastion host** for secure SSH access

### Environment Strategy
- **Development**: Smaller instances, single AZ, minimal redundancy
- **Production**: Larger instances, multi-AZ, full redundancy

## 🛠️ Prerequisites

- Terraform >= 1.5.x
- AWS CLI configured
- SSH key pair
- Ansible >= 2.9
- Node.js >= 18.x (for application)
- Docker (optional)

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd capstone-project
   ```

2. **Initialize Infrastructure**
   ```bash
   cd terraform/env/dev  # or prod
   terraform init
   terraform plan
   terraform apply
   ```

3. **Deploy Application**
   ```bash
   cd ../ansible
   ansible-playbook -i inventory.ini playbook.yml
   ```

## 📁 Project Structure

```
.
├── terraform/           # Infrastructure as Code
│   ├── modules/        # Reusable Terraform modules
│   └── env/           # Environment-specific configs
├── ansible/           # Deployment automation
│   ├── playbooks/     # Ansible playbooks
│   └── inventory/     # Server inventories
└── uber-clone/        # Application code
    ├── components/    # React components
    └── pages/        # Next.js pages
```

## 🔐 Security Features

- All app and DB resources in private subnets
- Bastion host for controlled SSH access
- IAM roles with least privilege
- Security groups with strict rules
- Encrypted S3 buckets
- Multi-AZ deployment for high availability

## 🔄 State Management

Terraform state is stored in S3 with DynamoDB locking:
```hcl
terraform {
  backend "s3" {
    bucket         = "uber-clone-terraform-state"
    key            = "env/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

## 🧹 Clean Up

To destroy the infrastructure:
```bash
cd terraform/env/dev  # or prod
terraform destroy
```

## 📝 License

MIT License - see LICENSE file for details

## 🙋‍♂️ Support

For support:
1. Check the troubleshooting guides in each component
2. Review existing issues
3. Create a new issue with:
   - Component affected (Terraform/Ansible/App)
   - Detailed description
   - Steps to reproduce
   - Environment details
