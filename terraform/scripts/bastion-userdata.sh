#!/bin/bash
# Update and install AWS CLI and other utilities
apt update -y
apt install -y awscli jq unzip

# Add the EC2 instance IP to hostname
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
EC2_NAME=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=Name" --region $REGION --output text --query 'Tags[0].Value')
hostnamectl set-hostname $EC2_NAME

# Setup SSH configuration for easier access to private instances
cat > /home/ubuntu/.ssh/config << EOF
Host 10.*.*.*
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
    User ubuntu
    IdentityFile ~/.ssh/id_rsa
EOF

# Set proper permissions
chmod 600 /home/ubuntu/.ssh/config
chown ubuntu:ubuntu /home/ubuntu/.ssh/config

# Install helpful utilities
apt install -y htop iotop iftop tmux

echo "Bastion host setup complete!"