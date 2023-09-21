#!/bin/bash

cd terraform
terraform init
terraform plan -out="terraplan"
terraform apply "terraplan"

ssh-keygen -R 192.168.3.151
ssh-keygen -R 192.168.3.152

cd ../ansible

ansible-galaxy collection install community.general
ansible-galaxy collection install community.vmware
ansible-galaxy collection install community.mysql

ansible-playbook -i=hosts esxi.yml
echo "Waiting 60 seconds for VMs to turn on"
sleep 1m
ansible-playbook -i=hosts ubuntu.yml rocky.yml
