# LabOps: Automation and Security testing playground

## Introduction

This repo is a fusion of smaller initiatives, forming an ongoing journey with automated infrastructure and logging. It uses Packer, Terraform, and Ansible on an ESXi and vCenter instance (both 8.0; trial versions) to spin up, configure, and customise Windows and Linux systems. Falco, Auditd, and Apache logging are enabled for Linux hosts, along with Auditbeat as an optional log shipper (uses Auditd). Event logs are used for Windows and are configured to include the most important log sources (documented but not currently automated). Finally, there is an adversary simulation proof-of-concept using a custom C# Sliver C2 stager.

### Featured VMs

* Rocky Linux
  * Acts as the control node for the lab
  * Configured to have Packer, Terraform, and Ansible for recursive provisioning
* Ubuntu Linux
  * Generic Linux server
  * Includes an intentionally vulnerable web app with susceptibility to SQLi, web shell uploads, and weak credentials.
* Kali Linux
  * Red team box
* Windows Server 2022
  * Domain Controller and/or multipurpose server
* Windows 10
  * Generic Windows workstation

## Project Setup

Some work goes into getting this project to work.

See the [environment setup](https://github.com/nakmuaycactus/LabOps/wiki/Environment-Setup) wiki page for a detailed overview of setting up the required environment

Once the environment has been set up and configured, clone the repo using:
    
    https://github.com/nakmuaycactus/LabOps.git

See the [configurations setup](https://github.com/nakmuaycactus/LabOps/wiki/Configuration-Setup) wiki page for a detailed overview of modifying required configuations to get the project to work your specific enviroment

To use the project, run 

    sh build.sh
    
and 

    sh provision.sh
