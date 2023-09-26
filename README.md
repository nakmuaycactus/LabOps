# LabOps: Automation and Security testing playground

## Introduction

This repo is a fusion of smaller initiatives, forming an ongoing journey with automated infrastructure and logging. It uses Packer, Terraform, and Ansible on an ESXi and vCenter instance (both 8.0; trial versions) to spin up, configure, and customise Windows and Linux systems. Falco, Auditd, and Apache logging are enabled for Linux hosts, along with Auditbeat as an optional log shipper (uses Auditd). Event logs are used for Windows and are configured to include the most important log sources (documented but not currently automated). Finally, there is an adversary simulation proof-of-concept using a custom C# Sliver C2 stager.

### Features

- Packer is used to create VMDK/OVF files based on (either local or remote) iso files.
- Terraform is used to provision virtual machines based on Packer's exported iso files.
- Ansible is used to apply post-provisioning to Terraform's provisioned machines.

## Project Setup

A small amount of work goes into getting this project to work

See the [environment setup](https://github.com/nakmuaycactus/autoAD/wiki/Environment-Setup) wiki page for a detailed overview of setting up the ESXi/vCenter environment

Once the environment has been set up and configured, clone the repo using:
    
    https://github.com/nakmuaycactus/LabOps.git

See the [configurations setup](https://github.com/nakmuaycactus/autoAD/wiki/Configuration-Setup) wiki page for a detailed overview of modifying required configuations to get the project to work your specific enviroment

To use the project, run 

    sh build.sh
    
and 

    sh provision.sh

## Featured VMs

See the [featured VMs](https://github.com/nakmuaycactus/autoAD/wiki/Featured-VMs) wiki page for a detailed overview of the different VMs that this project automates by default
