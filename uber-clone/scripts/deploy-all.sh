#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a script exists
script_exists() {
    [ -f "$1" ] && [ -x "$1" ]
}

# Function to run a script and check its exit status
run_script() {
    local script=$1
    local description=$2
    
    echo -e "${YELLOW}Running $description...${NC}"
    if ! script_exists "$script"; then
        echo -e "${RED}Error: Script $script not found or not executable${NC}"
        exit 1
    fi
    
    if ! "$script"; then
        echo -e "${RED}Error: $description failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}$description completed successfully${NC}\n"
}

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"
for cmd in docker aws node npm; do
    if ! command_exists "$cmd"; then
        echo -e "${RED}Error: $cmd is not installed${NC}"
        exit 1
    fi
done

# Ensure we're in the scripts directory
cd "$(dirname "$0")" || exit 1

# Step 1: Setup environment variables
if [ ! -f "../config/.env" ]; then
    run_script "./setup-env.sh" "Environment setup"
else
    echo -e "${YELLOW}Environment file already exists. Skipping setup.${NC}"
fi

# Step 2: Validate environment variables
run_script "node validate-env.js" "Environment validation"

# Step 3: Initialize database
run_script "node init-db.js" "Database initialization"

# Step 4: Build and push Docker image
run_script "./deploy.sh" "Docker image deployment"

# Step 5: Deploy to EC2 instances
run_script "./ec2-deploy.sh" "EC2 deployment"

echo -e "${GREEN}Deployment completed successfully!${NC}" 