# LabOps: Automation and Security testing playground

## Introduction

This repo is a fusion of smaller initiatives, forming an ongoing journey with automated infrastructure and logging. It uses Packer, Terraform, and Ansible on an ESXi and vCenter instance (both 8.0; trial versions) to spin up, configure, and customise Windows and Linux systems. Falco, Auditd, and Apache logging are enabled for Linux hosts, along with Auditbeat as an optional log shipper (uses Auditd). Event logs are used for Windows and are configured to include the most important log sources (documented but not currently automated). Finally, there is an adversary simulation proof-of-concept using a custom C# Sliver C2 stager.

### Features

- Packer is used to create VMDK/OVF files based on (either local or remote) iso files.
- Terraform is used to provision virtual machines based on Packer's exported iso files.
- Ansible is used to apply post-provisioning to Terraform's provisioned machines.

## Project Setup

A small amount of work goes into getting this project to work

See the [environment setup](https://github.com/nakmuaycactus/LabOps/wiki/Environment-Setup) wiki page for a detailed overview of setting up the ESXi/vCenter environment

Once the environment has been set up and configured, clone the repo using:
    
    https://github.com/nakmuaycactus/LabOps.git

See the [configurations setup](https://github.com/nakmuaycactus/LabOps/wiki/Configuration-Setup) wiki page for a detailed overview of modifying required configuations to get the project to work your specific enviroment

To use the project, run 

    sh build.sh
    
and 

    sh provision.sh

## Featured VMs

* Rocky Linux

  * Configured to have Packer, Terraform, and Ansible for recursive provisioning - This VM can act as the control node for the lab.

* Ubuntu Linux

  * Includes an intentionally vulnerable web app with vulnerabilities like susceptibility to SQLi, web shell uploads and brute force attacks.

  * The VM is additionally set up with different logging types and technology, including Auditd, Auditbeat, Falco, and Apache logging.

* Kali Linux

  * Standard Kali install for now, perhaps sliver and caldera eventually

* Windows Server 2022

  * Standard Windows Server 22 install, will be a domain controller eventually

* Windows 10

  * Standard Windows 10 desktop, will be domain joined eventually

* Windows Server 2016

  * Dead broke for now...
