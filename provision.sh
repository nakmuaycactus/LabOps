#!/bin/bash

cd terraform
terraform init
terraform plan -out="terraplan"
terraform apply "terraplan"

cd ../ansible
ansible-galaxy collection install community.general
ansible-galaxy collection install community.vmware
ansible-galaxy collection install community.mysql

ssh-keyscan -H 192.168.3.150 >> ~/.ssh/known_hosts
ansible-playbook -i=hosts esxi.yml
echo "Waiting 60 seconds for VMs to turn on"
sleep 1m

ssh-keyscan -H 192.168.3.151 >> ~/.ssh/known_hosts
ssh-keyscan -H 192.168.3.152 >> ~/.ssh/known_hosts
ssh-keygen -R 192.168.3.151
ssh-keygen -R 192.168.3.152
ansible-playbook -i=hosts ubuntu.yml rocky.yml