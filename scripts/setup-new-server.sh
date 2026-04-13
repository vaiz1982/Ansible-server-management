#!/bin/bash
# Complete server setup script for Ansible management
# Run this on a new Ubuntu server to prep it for Ansible

set -e  # Stop on error

echo "========================================="
echo "Setting up server for Ansible management"
echo "========================================="

# Update package list
echo "📦 Updating package list..."
sudo apt update

# Install Python (required for Ansible)
echo "🐍 Installing Python..."
sudo apt install -y python3 python3-apt python3-pip

# Install Ansible
echo "🚀 Installing Ansible..."
sudo apt install -y ansible

# Create .ssh directory for the current user
echo "🔐 Setting up SSH directory..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Create ansible directory structure
echo "📁 Creating Ansible directories..."
mkdir -p ~/ansible/inventories ~/ansible/playbooks ~/ansible/roles

# Check if inventory.ini exists, if not create example
if [ ! -f ~/ansible/inventories/inventory.ini ]; then
    cat > ~/ansible/inventories/inventory.ini << 'EOF'
[monitoring_group]
localhost ansible_connection=local

[monitoring_group:vars]
ansible_python_interpreter=/usr/bin/python3
