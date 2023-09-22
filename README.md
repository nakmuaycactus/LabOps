# autoAD: An automated Active Directory and Linux homelab

## Introduction

The aim of this project is to deploy a combined fully functional Windows Active Directory and multi-flavoured Linux homelab with the press of a script. This project uses a mixture of packer, terraform and ansible against an ESXi and (somewhat optionally) Vcenter setup to firstly create baseline images for a number of Windows and Linux flavours and secondly provision the baseline images into automated VMs.

### Features

- Packer is used to create vmdk/ovf files based on (either locally or remotly hosted) iso files.
- Terraform is used to provision virtual machines based on packer's exported iso files.
- Ansible is used to apply post-provisioning to to terraform's provisioned machines.

## Environment Setup

To get started, follow these steps to set up your environment:

Clone this repository to your local machine:

    git clone https://github.com/nakmuaycactus/autoAD.git

Install the required dependencies on your local system and ensure that ESXi/Vcenter is properly configured.

- Packer  - https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
- Terraform - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Ansible - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
    
Optionally download any necessary ISO files:

- Windows 10      - https://www.microsoft.com/en-au/software-download/windows10ISO
- Win Server 2022 - https://info.microsoft.com/ww-landing-windows-server-2022.html
- Win Server 2016 - https://info.microsoft.com/ww-landing-windows-server-2016.html
- Ubuntu Linux    - https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso
- Rocky Linux     - https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.2-x86_64-dvd.iso 
- Kali Linux      - https://www.kali.org/get-kali/#kali-platforms

## Build vmdk/ovf files by running packer
    sh build.sh

## Provision VMs by running terraform/ansible
    sh provision.sh

## Featured VMs

### Rocky Linux

Configured to have Packer, Terraform, and Ansible for recursive provisioning - This VM acts as the control node for the lab.

### Ubuntu Linux

Includes an intentionally vulnerable web-app with vulnerabilities including suspectibility to SQLi, webshell uploads and brute force.
The VM is additionally setup with different logging types and technology, including Auditd, Auditbeat, Falco, and Apache logging.

### Kali Linux

Standard Kali install for now...

### Windows Server 2022

Standard Windows Server 22 install for now, will be a domain controller eventually... 

### Windows 10

Standard Windows 10 desktop for now, will be domain joined eventually... 

### Windows Server 2016
