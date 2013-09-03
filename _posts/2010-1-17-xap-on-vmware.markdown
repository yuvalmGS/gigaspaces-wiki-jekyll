---
layout: post
title:  XAP on VMWare
categories: XAP96
page_id: 61867301
---

{% summary %}GigaSpaces XAP VMWare virtual appliance{% endsummary %}

# Overview

This section describes the details of GigaSpaces XAP 7.0.2 VMWare package. Please click [GigaSpaces XAP 7.0.2 on CentOS 5.4](http://www.gigaspaces.com/tempfiles/VMWare-Packages/GigaSpaces-XAP7.0.2-CentOS5.4.zip) to download the package.

# VM Spec

- Two CPU
- 4GB RAM
- 8GB Hard Drive
- One ethernet adapter

# Credentials

- Username: root
- Password: CentOS54

# GigaSpaces information

- GigaSpaces Version: GigaSpaces XAP Premium 7.0.2 build 3900
- GigaSapces path: /opt/gigaspaces

# Software information

	

- Java version: 1.6.0_17, 64-bit
- Java path: /opt/jdk1.6.0_17
- Apache Ant version: 1.7.0
- Apache Ant path: /opt/apache-ant-1.7.0

# Default settings

- The startup script that is loaded during operating system startup is  /etc/init.d/gsvmstartup. The script is loaded during the boot level 3. The script performs the following steps:

1. overrides GigaSpaces variables, such as LOOKUPGROUPS, NIC_ADDR etc.
1. invokes GS_HOME/bin/gs-agent.sh with default settings. The following processes will run on each machine:
    1. One global Grid Service Manager  or in short GSM (in total two Global GSMs. It means that if one deploys three virtual machines, the third one will contain only two GSCs without GSM, because two global GSMs have been  already loaded on first two VMs)
    1. Two local Grid Service Containers, or in short GSCs

- Users are highly encouraged to use this script to override variables.

{% whr %}
