# Cyber Security Internship Project

This project aims to automate the setup of a versatile homelab environment for testing various cyber security scenarios. We use Packer and Ansible to provision and configure multiple virtual machines (VMs) from ISO files, including Ubuntu, Kali Linux, Rocky Linux, Windows 10, Windows Server 2016, and Windows Server 2022.

## Table of Contents

    Project Overview
    Environment Setup
    VM Configuration
    Lab Purpose
    Log Management
    Deployment

## Project Overview

In this project, we utilize the power of infrastructure-as-code (IaC) and configuration management tools to create a robust, automated cybersecurity homelab. The key components of this environment include:

    Packer: Used to create virtual machine images from ISO files for various operating systems.
    Ansible: Used to configure VMs, install software, and set up intentional vulnerabilities.
    ESXi: The entire environment runs within a standalone ESXi host, providing isolation and ease of management.
    LogRhythm: A dedicated VM for centralized log management and monitoring.

## Environment Setup

To get started, follow these steps to set up your environment:

Clone this repository to your local machine:

    git clone https://github.com/nakmuaycactus/autoAD.git

Install the required dependencies on your local system and ensure that ESXi is properly configured.

    Packer  - https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli
    Ansible - https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
    
Ensure you have the necessary ISO files:

    Windows 10      - https://www.microsoft.com/en-au/software-download/windows10ISO
    Win Server 2022 - https://info.microsoft.com/ww-landing-windows-server-2022.html
    Win Server 2016 - https://info.microsoft.com/ww-landing-windows-server-2016.html
    Ubuntu Linux    - https://releases.ubuntu.com/16.04/ubuntu-16.04.7-server-amd64.iso
    Rocky Linux     - https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.2-x86_64-dvd.iso 
    Kali Linux      - https://www.kali.org/get-kali/#kali-platforms

## Lab Purpose

The primary purpose of this lab environment is to create a controlled, isolated environment where cybersecurity interns and professionals can:

    Test and analyze malware behavior and attack techniques.
    Develop and practice cybersecurity skills in a safe environment.
    Evaluate and fine-tune security tools and configurations.
    Gain hands-on experience with log management and monitoring using LogRhythm.

## Lab Contents
### Rocky Linux
Configured to have Packer, Terraform, and Ansible itself for recursive provisioning.

### Ubuntu
Configured to include an intentionally vulnerable (LAMP stack) shopping cart web application with CRUD functionality. Vulnerabilities include SQL injections, brute forceable login page, and web shell uploads.

### Windows Server 2022

This VM is configured as a Domain Controller (DC) and is linked to two instances of Windows 10 VMs.

### Windows Server 2016

Windows Server 2016 is not domain-joined but has Odoo installed for Windows-based database attack simulations.

### Logrhythm

LogRhythm is installed on a dedicated VM within the environment. It collects logs from various sources, including auditd, Auditbeats, Apache logs, and syslog from other VMs. This allows for real-time monitoring and analysis of security events and incidents.
Deployment

## End

Please refer to the project's documentation and deployment scripts for detailed instructions on how to provision and configure the VMs in your homelab environment.

Feel free to contribute, report issues, or provide feedback to help improve this cybersecurity internship project. Happy hacking and learning!
