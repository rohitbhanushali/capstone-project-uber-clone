#!/bin/bash
# Update system and install required packages
apt update -y
apt install -y docker.io awscli jq unzip

# Start and enable Docker
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Add the EC2 instance IP to hostname
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
EC2_NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=Name" --region $REGION --output text --query 'Tags[0].Value')
hostnamectl set-hostname $EC2_NAME

# Get AWS account ID using IMDSv2
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
ACCOUNT_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .accountId)

# Wait for IAM role to apply
sleep 10

# Authenticate with ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.ap-south-1.amazonaws.com

# Pull and run container
docker stop uber-clone || true
docker rm uber-clone || true
docker pull ${ACCOUNT_ID}.dkr.ecr.ap-south-1.amazonaws.com/uber-clone:latest
docker run -d \
  -p 80:3000 \
  --restart always \
  --name uber-clone \
  --log-driver awslogs \
  --log-opt awslogs-group=/app/uber-clone \
  --log-opt awslogs-region=ap-south-1 \
  ${ACCOUNT_ID}.dkr.ecr.ap-south-1.amazonaws.com/uber-clone:latest

# Install CloudWatch agent for monitoring
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb
systemctl start amazon-cloudwatch-agent
systemctl enable amazon-cloudwatch-agent

echo "App server setup complete!"