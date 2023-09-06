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

Install the required dependencies: Packer, Ansible, and Terraform on your local system and ensure that ESXi is properly configured.

Ensure you have the necessary ISO files for Ubuntu, Kali Linux, Rocky Linux, Windows 10, Windows Server 2016, and Windows Server 2022.

## VM Configuration
### Ubuntu

Ansible is used to deploy an intentionally vulnerable web application (LAMP stack) with CRUD functionality and a shopping cart. Vulnerabilities include SQL injection, brute force login attempts, and web shell upload.

### Rocky Linux

Ansible sets up the environment by installing Packer, Terraform, and Ansible itself for recursive provisioning.

### Windows Server 2022

This VM is configured as a Domain Controller (DC) and is linked to two instances of Windows 10 VMs.

### Windows Server 2016

Windows Server 2016 is not domain-joined but has Odoo installed for Windows-based database attack simulations.

## Lab Purpose

The primary purpose of this lab environment is to create a controlled, isolated environment where cybersecurity interns and professionals can:

    Test and analyze malware behavior and attack techniques.
    Develop and practice cybersecurity skills in a safe environment.
    Evaluate and fine-tune security tools and configurations.
    Gain hands-on experience with log management and monitoring using LogRhythm.

## Log Management

LogRhythm is installed on a dedicated VM within the environment. It collects logs from various sources, including auditd, Auditbeats, Apache logs, and syslog from other VMs. This allows for real-time monitoring and analysis of security events and incidents.
Deployment

Please refer to the project's documentation and deployment scripts for detailed instructions on how to provision and configure the VMs in your homelab environment.

Feel free to contribute, report issues, or provide feedback to help improve this cybersecurity internship project. Happy hacking and learning!
