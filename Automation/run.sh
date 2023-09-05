#!/bin/bash

#Build VMs
#Linux
cd packer/linux
packer init template.pkr.hcl
packer build -force -var-file=UL-pkrvars.hcl template.pkr.hcl
ssh-keygen -R 192.168.3.151
packer build -force -var-file=RL-pkrvars.hcl template.pkr.hcl
ssh-keygen -R 192.168.3.152
#packer build -force -var-file=KL-pkrvars.hcl template.pkr.hcl
#ssh-keygen -R 192.168.3.153

#Windows
#cd ../windows
#packer init template.pkr.hcl
#packer build -force -var-file=ser-22.pkrvars.hcl template.pkr.hcl
#ssh-keygen -R 192.168.3.154
#packer build -force -var-file=win-10.pkrvars.hcl template.pkr.hcl
#ssh-keygen -R 192.168.3.155
#packer build -force -var-file=ser-16.pkrvars.hcl template.pkr.hcl
#ssh-keygen -R 192.168.3.156

#Setup VMs
cd ../../ansible
ansible-playbook -i=hosts esxi.yml
ansible-playbook -i=hosts ubuntu.yml
ansible-playbook -i=hosts rocky.yml
