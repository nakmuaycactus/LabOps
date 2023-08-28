#!/bin/bash

#Linux
cd Linux
#Packer
cd packer
packer init template.pkr.hcl
packer build -force -var-file=UL-pkrvars.hcl template.pkr.hcl
ssh-keygen -R 192.168.3.151
packer build -force -var-file=RL-pkrvars.hcl template.pkr.hcl
ssh-keygen -R 192.168.3.152
packer build -force -var-file=KL-pkrvars.hcl template.pkr.hcl
ssh-keygen -R 192.168.3.153

#Terraform
# cd../terraform
#terraform init terraform-main.tf
#terraform plan terraform-main.tf
#terraform build terraform-main.tf

#Ansible
cd ../ansible
ansible-playbook -i=hosts esxi.yml
ansible-playbook -i=hosts ubuntu.yml
ansible-playbook -i=hosts rocky.yml
../../