#!/bin/bash
# Run this on a new Ubuntu server to prep it for Ansible
sudo apt update
sudo apt install python3 python3-apt -y
sudo mkdir -p /home/alex/.ssh
echo "Server ready for Ansible management"
