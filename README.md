✅ What the Script Now Does
Step	Action
1	Updates package list
2	Installs Python 3
3	Installs Ansible (new!)
4	Creates SSH directory
5	Creates Ansible workspace (~/ansible/)
6	Creates example inventory file
7	Creates ansible.cfg configuration
8	Shows installed versions





# Ansible Server Management

![Ansible](https://img.shields.io/badge/Ansible-2.9+-red)
![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-orange)
![License](https://img.shields.io/badge/License-MIT-green)

Ansible playbooks and scripts for managing Ubuntu servers, including monitoring, updates, and health checks.

## 📋 Prerequisites

- Ansible installed on control node
- SSH access to target servers
- Python 3 on target servers

## 🚀 Quick Start

### 1. Clone the repository
```bash
git clone https://github.com/vaiz1982/Ansible-server-management.git
cd Ansible-server-management





cp inventory.ini.example inventory.ini
# Edit inventory.ini with your server details







ansible -i inventory.ini monitoring_group -m ping




📊 Available Playbooks
Playbook	Purpose	Command
health-check.yml	Complete server health check	ansible-playbook playbooks/health-check.yml -i inventory.ini
update-server.yml	Update all packages and reboot if needed	ansible-playbook playbooks/update-server.yml -i inventory.ini
reboot-server.yml	Safe server reboot with verification	ansible-playbook playbooks/reboot-server.yml -i inventory.ini
install-tools.yml	Install common monitoring tools	ansible-playbook playbooks/install-tools.yml -i inventory.ini
security-updates.yml	Install only security updates	ansible-playbook playbooks/security-updates.yml -i inventory.ini







# Check uptime
ansible -i inventory.ini monitoring_group -m command -a "uptime"

# Check disk usage
ansible -i inventory.ini monitoring_group -m command -a "df -h"

# Check memory
ansible -i inventory.ini monitoring_group -m command -a "free -h"

# Check reboot status
ansible -i inventory.ini monitoring_group -m shell -a "test -f /var/run/reboot-required && echo 'Reboot required' || echo 'No reboot needed'"






# Update package cache
ansible -i inventory.ini monitoring_group -m apt -a "update_cache=yes"

# Upgrade all packages
ansible -i inventory.ini monitoring_group -m apt -a "upgrade=dist"

# Install a package
ansible -i inventory.ini monitoring_group -m apt -a "name=htop state=present"








📈 Monitoring Scripts
Run the monitoring script:
./scripts/monitor.sh


Or use the health check script:
./scripts/server-status.sh






🎯 Quick Aliases
Add to ~/.bashrc:

alias server-status='ansible -i ~/ansible-server-management/inventory.ini monitoring_group -m shell -a "uptime && echo && df -h / && echo && free -h"'
alias reboot-server='ansible -i ~/ansible-server-management/inventory.ini monitoring_group -m reboot -a "reboot_timeout=300"'
alias update-server='ansible-playbook ~/ansible-server-management/playbooks/update-server.yml -i ~/ansible-server-management/inventory.ini'





📝 Notes
Always test playbooks on non-production servers first

Backup important data before system updates

Use --check flag for dry runs: ansible-playbook playbook.yml --check

🔒 Security
Never commit inventory.ini or private keys to GitHub

Use environment variables or Ansible Vault for sensitive data

Review all playbooks before running them on production servers







System Information
# Get ALL system facts (very detailed)
ansible -i inventory.ini monitoring_group -m setup

# Get specific facts
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_os_family"
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_memory_mb"
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_processor_*"
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_disk*"
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_architecture"
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_kernel"





Network Information
# Get network interfaces
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_interfaces"

# Get default IPv4 address
ansible -i inventory.ini monitoring_group -m setup -a "filter=ansible_default_ipv4"

# Get all IP addresses
ansible -i inventory.ini monitoring_group -m command -a "ip addr show"

# Show routing table
ansible -i inventory.ini monitoring_group -m command -a "ip route show"

# Show open ports
ansible -i inventory.ini monitoring_group -m command -a "ss -tlnp"







User Information
# List all users
ansible -i inventory.ini monitoring_group -m command -a "cat /etc/passwd | cut -d: -f1"

# Who is logged in
ansible -i inventory.ini monitoring_group -m command -a "who"

# Last logins
ansible -i inventory.ini monitoring_group -m command -a "last -10"

# Sudo users
ansible -i inventory.ini monitoring_group -m command -a "grep '^sudo' /etc/group"






Package Information
# List installed packages count
ansible -i inventory.ini monitoring_group -m shell -a "dpkg -l | wc -l"

# Check if specific package is installed
ansible -i inventory.ini monitoring_group -m command -a "dpkg -l | grep nginx"

# List recently installed packages
ansible -i inventory.ini monitoring_group -m shell -a "grep ' install ' /var/log/dpkg.log | tail -20"

# Check available updates
ansible -i inventory.ini monitoring_group -m shell -a "apt list --upgradable 2>/dev/null | head -20"







Service Information
# List all running services
ansible -i inventory.ini monitoring_group -m shell -a "systemctl list-units --type=service --state=running --no-pager"

# Check specific service status
ansible -i inventory.ini monitoring_group -m service -a "name=ssh state=started"

# Show failed services
ansible -i inventory.ini monitoring_group -m shell -a "systemctl --failed"








Disk & Storage Information
# Disk usage
ansible -i inventory.ini monitoring_group -m command -a "df -h"

# Inode usage
ansible -i inventory.ini monitoring_group -m command -a "df -i"

# Find large files (>100MB)
ansible -i inventory.ini monitoring_group -m shell -a "find / -type f -size +100M 2>/dev/null | head -20"

# Mounted filesystems
ansible -i inventory.ini monitoring_group -m command -a "mount | column -t"










Process Information
# Top 5 CPU consuming processes
ansible -i inventory.ini monitoring_group -m shell -a "ps aux --sort=-%cpu | head -6"

# Top 5 memory consuming processes
ansible -i inventory.ini monitoring_group -m shell -a "ps aux --sort=-%mem | head -6"

# Process count
ansible -i inventory.ini monitoring_group -m shell -a "ps aux | wc -l"

# Zombie processes
ansible -i inventory.ini monitoring_group -m shell -a "ps aux | grep defunct"










Security Information
# Check failed login attempts
ansible -i inventory.ini monitoring_group -m command -a "grep 'Failed password' /var/log/auth.log | tail -10"

# Check for root logins
ansible -i inventory.ini monitoring_group -m command -a "grep 'root' /var/log/auth.log | tail -10"

# Check SSH configuration
ansible -i inventory.ini monitoring_group -m command -a "grep -E 'PermitRootLogin|PasswordAuthentication' /etc/ssh/sshd_config"

# Check firewall status
ansible -i inventory.ini monitoring_group -m command -a "sudo ufw status"












🎯 Quick Reference: Working vs Not Working
✅ CORRECT	❌ WRONG
ansible-playbook playbook.yml	./playbook.yml
ansible-playbook -i inventory.ini playbook.yml	ansible-playbook playbook.yml (no inventory)
ansible_user=ubuntu (for Ubuntu EC2)	ansible_user=root (unless configured)
Private IPs when inside AWS	Public IPs when inside AWS (slower, cost)
chmod 600 key.pem	chmod 644 key.pem






📊 Testing Your Setup
Test 1: Basic Connectivity
ansible -i inventory.ini monitoring_group -m ping
# Expected: "pong" from all servers




Test 2: Ad-hoc Command
ansible -i inventory.ini monitoring_group -m command -a "uptime"
# Expected: uptime output from all servers





Test 3: Run a Playbook
ansible-playbook -i inventory.ini playbooks/health-check.yml
# Expected: Successful execution on all servers






🔒 Security Best Practices
Never commit inventory.ini or private keys to GitHub

Use specific IPs in security groups (0.0.0.0/0 is risky)

Rotate SSH keys regularly

Use Ansible Vault for sensitive data

Run playbooks with --check first for dry run












🙏 Acknowledgments
This troubleshooting guide was built from real-world experience and common mistakes encountered while learning Ansible on AWS EC2.










💡 Bonus: Create a Cheat Sheet
cat > CHEATSHEET.md << 'EOF'
# Ansible Quick Reference

## Most Common Commands
```bash
# Test connection
ansible -i inventory.ini all -m ping

# Run ad-hoc command
ansible -i inventory.ini all -m command -a "uptime"

# Run playbook
ansible-playbook -i inventory.ini playbook.yml

# Run playbook with check (dry run)
ansible-playbook -i inventory.ini playbook.yml --check

# Run playbook with verbose output
ansible-playbook -i inventory.ini playbook.yml -vvv











Common Inventory Patterns
# Public IPs (from outside AWS)
[group]
54.x.x.x ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/key.pem

# Private IPs (inside same VPC)
[group]
172.31.x.x ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/key.pem

# Local testing
[local]
localhost ansible_connection=local







Now anyone who uses your repository will learn from your struggles and avoid the same mistakes! 🎉







🔥 Approach 1: Shut Down the OS (Stops the server's operating system)
This uses the IP address from your inventory to SSH into the server and run a shutdown command
One-liner command:
ansible -i inventory.ini monitoring_group -m command -a "sudo shutdown -h now"




