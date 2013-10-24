---
layout: xap97
title:  XAP on GoGrid
page_id: 61867244
---

{% summary %}GigaSpaces XAP on GoGrid Enterprise Cloud{% endsummary %}

# Overview

This section describes the steps required to run GigaSpaces on GoGrid. GoGrid provides cloud infrastructure as a service, IaaS while GigaSpaces provides a Platform as a Service (PaaS) software. The combination of the two provides enterprise grade application platform as a service on the cloud.
This solution enables developing, testing and even deploying production grade applications on to the GoGrid cloud environment. Application can be written in Java, .NET or even in both environments.

# Prerequisites

Before using the solution, please make sure you have a valid account within GoGrid in order to log in to the GoGrid cloud console.
To get started simply point to [GoGrid](http://www.gogrid.com) and press the customer login button.

# Components and Terminology

The solution contains the following components:

- Linux image with GigaSpaces XAP installed - used as XAP runtime servers
- Windows image with GigaSpaces XAP for Java and .NET installed - used as XAP runtime servers
- Administrative machine for the Linux image - used to control the runtime servers
- Administrative machine for the interoperable image - used to control the runtime servers

# Running In-Memory-Data-Grid

In order to running IMDG to be used by applications installed within the GoGrid cloud, the following steps should be followed:

- Login into the GoGrid cloud administrative console
- Launch one administrative machine and multiple runtime machines
- Deploy a datagrid from the administrative machine

# Running Applications

In order to run applications Java or .NET on the GoGrid cloud the following steps should be followed:

- Login into the GoGrid cloud administrative console
- Launch one administrative machine and multiple runtime machines
- Transfer the application files into the administrative machine using FTP or some other sort of file transfer mechanism
- Deploy the application processing unit from the administration machine to the runtime machines

# Example - Running the Java Data Example

In this example we'll run the data example which comes with every installation of GigaSpaces XAP within the GoGrid cloud. After completing this example, you should be able to run your own applications on top of GigaSpaces within the GoGrid cloud.

1. Log in to the GoGrid admin console
    - Go to the [GoGrid](http://www.gogrid.com) web site and press the **customer login** button to login
    - Provide your credentials and login GoGrid Web Console
![gogrid1.JPG](/attachment_files/gogrid1.JPG)

1. Add one admin machine
    - Select Add
    - Select Cloud Server
    - Select **GigaSpaces XAP 7.1.1 Admin** machine
![gogrid2.JPG](/attachment_files/gogrid2.JPG)
    - Provide name, description, ip address and memory for the machine. Use at least one GB of RAM for the admin machine
    - Press start for running the machine.

1. Add multiple runtime machines
    - Select Add
    - Select Cloud Server
    - Select **GigaSpaces XAP 7.1.1 Runtime** machine
    - Provide name, description, ip address and memory for the machine. Here you should use at least 4GB of RAM for each machine.
   For large deployments use at least 8GB of RAM.Save your details and wait machine allocation is finished.
    - Press start for running the machine.

    - Repeat this process multiple times to add several more runtime machines

1. Wait for all the needed machines to load
    - You should see the status of the started machine changed to **on** ![on1.jpg](/attachment_files/on1.jpg)

1. Open remote desktop (RDP) to the admin machine
    - From a windows desktop connect open **Remote Desktop Connection** to the Admin machine
    - Insert the public IP of the admin machine
    - Authenticate into the admin machine by using the username: **Administrator**
    - The password is automatically created on the GoGrid machine, navigate to support -> passwords, locate the IP of the machine in the table and insert that as the password on the Remote Desktop console

1. From the GigaSpaces UI select Deploy Application
    - Double click on on the 'Shortcut to gs-ui-start.bat' which fires up the GigaSpaces Management Center
    - You should be able to see all the runtime machines in the Hosts view within the GigaSpaces Management Center with GSC running in them
    - Launch the deployment wizard with deployment wizard button ![button.jpg](/attachment_files/button.jpg)

    - Navigate to the desktop DemoApp folder and select first the processor.jar processing unit, leave the wizard page empty to use the default settings. You can however modify those setting if you want to.

    - Repeat the previous process and select now the feeder.jar
    - Now you should be able to see feeder and processor processing units deployed into the GSCs.
![gs1.JPG](/attachment_files/gs1.JPG)
    - Navigate into the Space Browser tab and see the the content of the spaces keeps changing as the application is running
    - Select Clusters -> Statistics and see the statistics view of the running cluster
![gs2.JPG](/attachment_files/gs2.JPG)

Note: When using your own application you'll have to transfer the application file into the admin machine. Please see below for various options.

# Example - Running the Processing Unit .NET Example

1. Log in to the GoGrid admin console
    - Go to the [GoGrid](http://www.gogrid.com) web site and press the **customer login** button to login
    - Provide your credentials

1. Add one admin machine
    - Select Add
    - Select Cloud Server
    - Select **GigaSpaces XAP Interop 7.1.1 Admin** machine
    - Provide name, description, ip address and memory for the machine. Use at least one GB of RAM for the admin machine
    - Press start for running the machine.

1. Add multiple runtime machines
    - Select Add
    - Select Cloud Server
    - Select **GigaSpaces XAP Interop 7.1.1 Runtime** machine
    - Provide name, description, ip address and memory for the machine. Here you should use at least 4GB of RAM for each machine.
   For large deployments use at least 8GB of RAM.
    - Press start for running the machine.

    - Repeat this process multiple times to add several more runtime machines

1. Wait for all the needed machines to load
    - You should see the status of the started machine changed to **on** ![on1.jpg](/attachment_files/on1.jpg)

1. Open remote desktop (RDP) to the admin machine
    - From a windows desktop connect open **Remote Desktop Connection** to the Admin machine
    - Insert the public IP of the admin machine
    - Authenticate into the admin machine by using the username: **Administrator**
    - The password is automatically created on the GoGrid machine, navigate to support -> passwords, locate the IP of the machine in the table and insert that as the password on the Remote Desktop console

1. From the GigaSpaces UI select Deploy Application
    - Double click on on the 'Shortcut to Gs-ui.exe' which fires up the GigaSpaces Management Center
    - You should be able to see all the runtime machines in the Hosts view within the GigaSpaces Management Center with GSC running in them
    - Launch the deployment wizard
    - Navigate to the desktop DemoApp folder and select first the dataprocessor.zip processing unit, leave the wizard page empty to use the default settings. You can however modify those setting if you want to.
    - Repeat the previous process and select now the datafeeder.zip
    - Now you should be able to see feeder and processor processing units deployed into the GSCs.
    - Navigate into the Space Browser tab and see the the content of the spaces keeps changing as the application is running
    - Select Clusters -> Statistics and see the statistics view of the running cluster

Note: When using your own application you'll have to transfer the application file into the admin machine. Please see below for various options.

# File Transfer Options

## Using Remote Desktop to transfer Files

You can use the Remote Desktop to transfer files between remote windows machines. In order to do so, follow this:

- Open Remote Desktop
- Before connecting, press options -> Local Resources -> More
- Select the drive which you would like to share
- Connect to the remote machine
- Open My Computer and find the shared drive you used, for example:
  tsclinet\d
![rdp.jpg](/attachment_files/rdp.jpg)

## Using WinSCP to transfer Files

On linux machine it is common to transfer files over the SSH protocol. For transferring files from Linux to Windows machines and vice versa, use file transfer client like WinSCP to move files between the local machine and the remote linux machine.

{% whr %}

