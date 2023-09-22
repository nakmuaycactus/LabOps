# autoAD: Automated Active Directory and Linux Home Lab

## Introduction

This project aims to deploy a combined fully functional Windows Active Directory and multi-flavoured Linux home lab with the run of a script. This project combines the use of Packer, Terraform and Ansible together with an ESXi and (somewhat optionally) vCenter setup to - firstly - create baseline images for several Windows and Linux flavours and - secondly - provision the baseline images into automated VMs.

### Features

- Packer is used to create VMDK/OVF files based on (either local or remote) iso files.
- Terraform is used to provision virtual machines based on Packer's exported iso files.
- Ansible is used to apply post-provisioning to Terraform's provisioned machines.

## Environment Setup

**To get started, follow these steps to set up your environment:**

**1. Ensure that ESXi/Vcenter is properly configured.**

**2. Create a new virtual machine if necessary**

Testing was done on a [Rocky Linux 9.2 VM](https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.2-x86_64-dvd.iso) with 200GB+ memory

**3. Clone this repository to your control node VM:**

    git clone https://github.com/nakmuaycactus/autoAD.git

**4. Install the required dependencies on your local system.**

- [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

Example for Rocky 9.2

    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install packer
    sudo yum -y install terraform
    pip3.11 install --include-deps ansible
        
**5. Optionally download any necessary ISO files:**

- [Windows 10](https://www.microsoft.com/en-au/software-download/windows10ISO)
- [Win Server 2022](https://info.microsoft.com/ww-landing-windows-server-2022.html)
- [Win Server 2016](https://info.microsoft.com/ww-landing-windows-server-2016.html)
- [Ubuntu Linux](https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso)
- [Rocky Linux](https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.2-x86_64-dvd.iso)
- [Kali Linux](https://cdimage.kali.org/kali-2023.3/kali-linux-2023.3-installer-amd64.iso)

## Instructions

### Build VMDK/OVF files by running Packer
    sh build.sh

### Provision VMs by running Terraform/Ansible
    sh provision.sh

## Featured VMs

### Rocky Linux

Configured to have Packer, Terraform, and Ansible for recursive provisioning - This VM can act as the control node for the lab.

### Ubuntu Linux

Includes an intentionally vulnerable web app with vulnerabilities like susceptibility to SQLi, web shell uploads and brute force attacks. 
The VM is additionally set up with different logging types and technology, including Auditd, Auditbeat, Falco, and Apache logging.

### Kali Linux

Standard Kali install for now, perhaps sliver and caldera eventually

### Windows Server 2022

Standard Windows Server 22 install, will be a domain controller eventually

### Windows 10

Standard Windows 10 desktop, will be domain joined eventually

### Windows Server 2016

Dead broke for now...
