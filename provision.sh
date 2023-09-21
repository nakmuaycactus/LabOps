#!/bin/bash

cd terraform
terraform init
terraform plan -out="terraplan"
terraform apply "terraplan"

ssh-keygen -R 192.168.3.151
ssh-keygen -R 192.168.3.152

cd ../ansible
ansible-playbook -i=hosts esxi.yml
sleep 1m
ansible-playbook -i=hosts ubuntu.yml rocky.yml
