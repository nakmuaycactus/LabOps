#!/bin/bash

#Packer
cd packer
packer build -force -var-file=UL-pkrvars.hcl template.pkr.hcl
ssh-keygen -R 192.168.3.151
#packer build -force -var-file=packer/RL-pkrvars.hcl packer/template.pkr.hcl
#packer build -force -var-file=packer/KL-pkrvars.hcl packer/template.pkr.hcl

#Terraform
#terraform init terraform-main.tf
#terraform plan terraform-main.tf
#terraform build terraform-main.tf

#Ansible
cd ../ansible
ansible-playbook -i=hosts playbook.yml
