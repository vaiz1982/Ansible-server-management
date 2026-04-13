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







