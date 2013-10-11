---
layout: post
title:  XAP on Rackspace
page_id: 61867376
---

{% summary %}GigaSpaces XAP on Rackspace Enterprise Cloud{% endsummary %}

# Overview

This section describes the steps required to run GigaSpaces on Racksapce. Racksapce provides cloud infrastructure as a service (IaaS), while GigaSpaces provides a cloud enabled middleware platform. The combination of the two provides enterprise grade application platform as a service on the cloud.
This solution enables developing, testing and deploying production grade applications on to the Racksapce cloud environment. Applications can be written in Java, .NET or both.

# Prerequisites

Before using the solution, please make sure you have a valid account within Racksapce in order to log in to the Racksapce cloud console.
To get started simply point your web browser to the to the [Racksapce cloud portal](http://www.rackspacecloud.com/) and press the customer login button

# Components and Terminology

The solution contains the following components:

- Linux CentOs 5.3 image with 4 GB memory and GigaSpaces XAP installed - used as XAP runtime servers

# Running In-Memory-Data-Grid

In order to running IMDG to be used by applications installed within the Rackspace cloud, the following steps should be followed:

- Download [The GigaSpaces integration package for Rackspace](http://wiki.gigaspaces.com/wiki/download/attachments/61867186/gs-rackspace.zip) and unzip it.
- Edit gs-rackspace/config/config.xml and provide your Rackspace username and API key.
- Run gs-rackspace/bin/startDataGrid.sh with 2 parameters: minimum data grid capacity size (in Gigabytes) and maximum data grid capacity (e.g `startDataGrid.sh 4 16`). This will take a few minutes, in which the script will do the following:
    - Start the required number of servers on the Rackspace cloud based on the required data grid capacity
    - Installs GigaSpaces XAP and the Java virtual machine on the instantiated servers
    - Start the GigaSpaces [runtime components](/xap96/the-runtime-environment.html)
    - Deploys a Space (in memory data grid) on these servers

- Once the script has competed, a Gigaspaces Space URL will be displayed at the end. The Space URL is an address that should be passed by your application to the GigaSpace API when connecting to the data grid. For more details please refer to [this page](/xap96/deploying-and-interacting-with-the-space.html#InteractingwiththeSpace-AccessingtheSpace).

# Example - Running an In Memory Data Grid (IMDG)

In this example we'll load an In Memory Data Grid. After completing this example, you should be able to run your own applications on top of GigaSpaces within the Rackspace cloud.

1. Log in to the Rackspace admin console
    1. Go to the [Rackspace](http://www.rackspacecloud.com/) web site and press the **customer login** button to login
    1. Provide your credentials and login Rackspace Web Console
![rackspace11.jpg](/attachment_files/rackspace11.jpg)
!rackspace11.jpg!

1. Download [The GigaSpaces integration package for Rackspace](http://wiki.gigaspaces.com/wiki/download/attachments/61867186/gs-rackspace.zip) and unzip it to a local directory
1. Run the command `gs-rackspace/bin/startDataGrid.sh 4 16` from the directory to which you unzipped the integration package. This will load 2 [GSM](/xap96/the-runtime-environment.html#TheRuntimeEnvironment-TheGigaSpacesManager (GSM)) machines and 2 Runtime machines (containing [GSCs](/xap96/the-runtime-environment.html#TheRuntimeEnvironment-TheGigaSpacesContainer (GSC)) according the minimum and maximum data grid capacity you specified (4GB which exceeds a single machine capacity)
![rackspace2.jpg](/attachment_files/rackspace2.jpg)

1. After a few minutes, once all the server initialization process has completed and the data grid has been instantiated, the script will print a Space URL which you can use to connect to the data from within your application.

{% note title=Windows Support %}
The integration package uses Unix style shell scripts to interact with the Rackspace cloud. To run the integration package from a windows machine, you will need to install [Cygwin](http://www.cygwin.com/) and run the script from it.
{% endnote %}
