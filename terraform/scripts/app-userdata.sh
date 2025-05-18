user_data = <<-EOF
#!/bin/bash
apt update -y
apt install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Wait for IAM role to apply (if instance has ECR access via role)
sleep 10

# Authenticate with ECR
eval $(aws ecr get-login --no-include-email --region ap-south-1)

# Pull and run container
docker stop uber-clone || true
docker rm uber-clone || true
docker pull <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/uber-clone:latest
docker run -d -p 3000:3000 --name uber-clone <aws_account_id>.dkr.ecr.ap-south-1.amazonaws.com/uber-clone:latest
EOF
