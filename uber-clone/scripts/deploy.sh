#!/bin/bash

# Exit on error
set -e

# Load environment variables
source ../config/.env

# Get ECR repository URI from Terraform output
ECR_REPO=$(aws ecr describe-repositories --repository-names uber-clone --query 'repositories[0].repositoryUri' --output text)

# Login to ECR
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_REPO

# Build the Docker image
docker build -t uber-clone .

# Tag the image
docker tag uber-clone:latest $ECR_REPO:latest

# Push the image to ECR
docker push $ECR_REPO:latest

echo "Successfully built and pushed Docker image to ECR" 