#!/usr/bin/env bash
title() {
    local color='\033[1;37m'
    local nc='\033[0m'
    printf "\n${color}$1${nc}\n"
}

title "Install Python and Ansible"
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install -y curl wget ansible git make python-pip

title "Install roles from Ansible Galaxy"
sudo ansible-galaxy install viasite-ansible.zsh
sudo ansible-galaxy install robertdebock.ara

sudo echo "export ASF_HOME=/etc/appliance-setup-framework" >> ~/.bashrc
exec bash

title "Download distribution into $ASF_HOME"
sudo git clone --recurse https://github.com/rinshadka/appliance-setup-metrics $ASF_HOME

title "Prepare appliance secrets configuration"
sudo cp $ASF_HOME/conf/appliance.secrets-tmpl.ansible-vars.yml $ASF_HOME/conf/appliance.secrets.ansible-vars.yml

title "Prepare postgres secrets configuration"
sudo cp $ASF_HOME/conf/postgres.secrets.ccf-tmpl-conf.jsonnet $ASF_HOME/conf/postgres.secrets.ccf-conf.jsonnet

title "Prepare grafana secrets configuration"
sudo cp $ASF_HOME/conf/grafana.secrets.ccf-tmpl-conf.jsonnet $ASF_HOME/conf/grafana.secrets.ccf-conf.jsonnet

title "Prepare CCF container directory"
sudo ln -s $ASF_HOME/metricsnet-ccf-containers /opt/metricsnet-ccf-containers

title "Provision ARA setup playbook"
sudo ansible-playbook -i "localhost," -c local $ASF_HOME/playbooks/ara.ansible-playbook.yml

title "Provision ZSH setup playbook for $(whoami)"
sudo ansible-playbook -i "localhost," -c local $ASF_HOME/playbooks/zsh.ansible-playbook.yml --extra-vars="zsh_user=$(whoami)"

echo "****************************************************"
echo "** ASF boostrapping process is complete.          **"
echo "** ---------------------------------------------- **"
echo "** Exit the shell, then log back in to continue   **"
echo "** the appliance setup process.                   **"
echo "****************************************************"
