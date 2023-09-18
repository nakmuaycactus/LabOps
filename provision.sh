#!/bin/bash

cd terraform
terraform init
terraform plan -out="terraplan"
terraform apply "terraplan"

ssh-keygen -R 192.168.3.152
ssh-keygen -R 192.168.3.153
ssh-keygen -R 192.168.3.154

cd ../ansible
ansible-playbook -i=hosts esxi.yml ubuntu.yml rocky.yml
