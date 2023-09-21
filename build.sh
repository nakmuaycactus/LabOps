#!/bin/bash

cd packer
packer init linuxTemplate.pkr.hcl
packer build -force -var-file=flavours/UL-pkrvars.hcl linuxTemplate.pkr.hcl
packer build -force -var-file=flavours/RL-pkrvars.hcl linuxTemplate.pkr.hcl
packer build -force -var-file=flavours/KL-pkrvars.hcl linuxTemplate.pkr.hcl

packer init windowsTemplate.pkr.hcl
packer build -force -var-file=flavours/ser-22.pkrvars.hcl windowsTemplate.pkr.hcl
packer build -force -var-file=flavours/win-10.pkrvars.hcl windowsTemplate.pkr.hcl
#packer build -force -var-file=flavours/ser-16.pkrvars.hcl windowsTemplate.pkr.hcl
