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

![image](https://github.com/user-attachments/assets/f07bad49-a077-487c-a510-1843a5307691)


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

# 🚕 Uber Clone Project

A full-stack Uber clone application built with Next.js, Firebase, Mapbox, and AWS services. This project demonstrates modern web development practices and cloud architecture.

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
- [Environment Setup](#-environment-setup)
- [Database Setup](#-database-setup)
- [Running the Application](#-running-the-application)
- [Testing](#-testing)
- [Deployment](#-deployment)
- [Project Structure](#-project-structure)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

- 🔐 User authentication with Firebase
- 🗺️ Real-time ride tracking with Mapbox
- 💰 Dynamic fare calculation
- 💳 Payment integration
- 🚗 Driver matching system
- 📱 Push notifications
- 📧 Email notifications
- 📤 Image upload to S3
- ⚡ Rate limiting
- 📚 API documentation
- 🛡️ Error handling
- ⏳ Loading states
- ✅ Testing setup

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

- [Node.js](https://nodejs.org/) (v18 or higher)
- [PostgreSQL](https://www.postgresql.org/download/) (v14 or higher)
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/products/docker-desktop) (optional)

You'll also need accounts for:
- [Firebase](https://firebase.google.com/)
- [Mapbox](https://www.mapbox.com/)
- [AWS](https://aws.amazon.com/) (optional for production)

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd uber-clone
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

## ⚙️ Environment Setup

1. **Create a `.env` file in the root directory**
   ```env
   # Database
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=uber_clone
   DB_USER=postgres
   DB_PASSWORD=your_postgres_password

   # Firebase
   NEXT_PUBLIC_FIREBASE_API_KEY=your_api_key
   NEXT_PUBLIC_FIREBASE_AUTH_DOMAIN=your_auth_domain
   NEXT_PUBLIC_FIREBASE_PROJECT_ID=your_project_id
   NEXT_PUBLIC_FIREBASE_STORAGE_BUCKET=your_storage_bucket
   NEXT_PUBLIC_FIREBASE_MESSAGING_SENDER_ID=your_sender_id
   NEXT_PUBLIC_FIREBASE_APP_ID=your_app_id

   # Mapbox
   NEXT_PUBLIC_MAPBOX_ACCESS_TOKEN=your_mapbox_token

   # Application
   NEXT_PUBLIC_APP_URL=http://localhost:3000
   NEXT_PUBLIC_API_URL=http://localhost:3000/api
   ```

2. **Get API Keys**
   - [Firebase Setup Guide](docs/firebase-setup.md)
   - [Mapbox Setup Guide](docs/mapbox-setup.md)
   - [AWS Setup Guide](docs/aws-setup.md)

## 💾 Database Setup

1. **Create the database**
   ```bash
   # Open PostgreSQL command prompt
   psql -U postgres

   # Create database
   CREATE DATABASE uber_clone;
   
   # Exit PostgreSQL
   \q
   ```

2. **Run migrations**
   ```bash
   npm run db:migrate
   ```

3. **Seed the database**
   ```bash
   npm run db:seed
   ```

## 🏃‍♂️ Running the Application

### Development Mode
```bash
npm run dev
```
The application will be available at `http://localhost:3000`

### Production Build
```bash
# Build the application
npm run build

# Start production server
npm start
```

### Docker Deployment
```bash
# Build Docker image
docker build -t uber-clone .

# Run container
docker run -p 3000:3000 --env-file .env uber-clone
```

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:watch

# Generate test coverage
npm run test:coverage
```

## 📁 Project Structure

```
uber-clone/
├── components/         # React components
├── pages/             # Next.js pages
├── public/            # Static files
├── styles/            # CSS styles
├── utils/             # Utility functions
├── config/            # Configuration files
├── models/            # Database models
├── scripts/           # Utility scripts
├── tests/             # Test files
├── ansible/           # Ansible deployment
└── terraform/         # Infrastructure as Code
```

## 🔧 Troubleshooting

### Common Issues

1. **Database Connection Issues**
   - Ensure PostgreSQL is running
   - Verify database credentials in `.env`
   - Check if database exists

2. **Firebase Authentication Issues**
   - Verify Firebase project setup
   - Check Firebase credentials
   - Ensure Firebase services are enabled

3. **Mapbox Issues**
   - Verify Mapbox token
   - Check token permissions

### Getting Help

- Check the [issues](https://github.com/yourusername/uber-clone/issues) page
- Review the [documentation](docs/)
- Join our [Discord community](https://discord.gg/your-discord)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Workflow

1. **Create a new branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**

3. **Run tests**
   ```bash
   npm test
   ```

4. **Run linting**
   ```bash
   npm run lint
   ```

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/)
- [Firebase](https://firebase.google.com/)
- [Mapbox](https://www.mapbox.com/)
- [AWS](https://aws.amazon.com/)
- [PostgreSQL](https://www.postgresql.org/)

## 📞 Support

- 📧 Email: your-email@example.com
- 💬 Discord: [Join our community](https://discord.gg/your-discord)
- 📝 Issues: [GitHub Issues](https://github.com/yourusername/uber-clone/issues)

---

Made with ❤️ by [Your Name]
