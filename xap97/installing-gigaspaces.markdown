---
layout: post
title:  Installing GigaSpaces
categories: XAP97
---

{% compositionsetup %}{% compositionsetup %}
{% summary %}Requirements and how to install GigaSpaces with Windows, Linux or Unix.{% endsummary %}

# Overview

GigaSpaces is 100% pure Java, and therefore can run on any UNIX or Windows machine that supports Java.

# Prior to Installation

**Prior to the GigaSpaces installation, make sure**:

- JDK 1.6 is installed (
{% color red %}**see note [below](#jdk)**{% endcolor %}
):
    - [JDK 1.6](http://java.sun.com/javase/downloads/index.jsp) -- download the latest update (for example, **JDK 6 Update 39**)

- The `JAVA_HOME` environment variable points to the correct JDK (not JRE) directory before running GigaSpaces. For example, `D:\Java\jdk1.6.0_39`.
- The `JAVA_HOME` environment variable should be added to the beginning of the `Path` environment variable. For example, `%JAVA_HOME%\bin;SystemRoot%\system32;%SystemRoot%;%SystemRoot%`
- Optional: Your network and machines running GigaSpaces are configured to have multicast enabled. See the [Multicast Configuration](./how-to-configure-multicast.html) section for details on how to enable multicast.
- You have reviewed the **[Supported Platforms](./supported-platforms.html)** section.
- Set the `NIC_ADDR` environment variable to have the machine IP.

# Installation

{% toczone minLevel=2|maxLevel=2|type=flat|separator=pipe|location=top %}

## Installing on Windows

1. Unzip the ZIP file (using your favorite unzip tool, for example, WinZip) to the location of your choice. Unzipping the file creates a `<GigaSpaces Root>` directory with several sub-directories. An example for the name of the ZIP file will be `{{ site.latest_build_filename }}`.
1. After unzipping the ZIP file, you should have the following files and folders under the `<GigaSpaces Root>` folder:

![win_dirtree_XAP95.jpg](/attachment_files/win_dirtree_XAP95.jpg)

{% lampon %} **What's Next?**

- To verify a local installation, a remote installation, and the cluster configuration, refer to the [Testing System Environment](./testing-system-environment.html) section.
- See the [Quick Start Guide](./quick-start-guide.html) for your first steps with GigaSpaces.

## Installing on Linux

1. Move into the directory where you want to install GigaSpaces XAP, e.g. `opt`, and issue the following `unzip` command, supplying the path to the name of the GigaSpaces zip file -- `gigaspaces-edition-versionNumber-version/milestone-build.zip`. For example:

{% highlight java %}
unzip {{ site.latest_build_filename }}
{% endhighlight %}

1. Make sure all `sh` file(s) in the `/bin` and the `/examples` directory are in executable mode, meaning you can run them from your machine. To check this, use the `ls \-all` command for the relevant directory, and make sure that `x` is included in the file permissions.
1. Make sure all the machines running GigaSpaces can ping each other and their hosts file include the machine IP.

{% lampon %} **What's Next?**

- To verify a local installation, a remote installation, and the cluster configuration, refer to the [Testing System Environment](./testing-system-environment.html) section.
- See the [Quick Start Guide](./quick-start-guide.html) for your first steps with GigaSpaces.

{% endtoczone %}

{% anchor 1 %}

# Mixing Versions

## Mixing GigaSpaces versions/builds

Mixing clients and Space servers from different GigaSpaces Major Releases:Clients running on 8.0 can run against {% latestxaprelease %} servers. 8.0 servers cannot be part of the same cluster with {% latestxaprelease %} servers.

## Mixing Different GigaSpaces JARs in Same Deployment Environment

{% exclamation %} GigaSpaces components (space, cluster of spaces, Processing Unit, GSM, GSC, LUS, Mahalo, GUI, CLI) can run only with the same GigaSpaces JARs (i.e., the same version and same build number).

{% anchor 2 %}

# Important Tips

{% anchor jdk %}

## Use JDK and not JRE

It is recommended to use a JDK (Java Development Kit), and not a JRE (Java Runtime Environment), which can be used for runtime only and not for development. However, if you do decide to use a JRE, make sure the `JAVA_HOME` environment variable points to the correct JRE directory.

You should also remove specific JDK command-line arguments, like `\-server`, which do not exist in JRE.

## Performance Tips

Before you begin working with GigaSpaces, it is recommended to review the [Performance Tuning and Considerations](./performance-tuning-and-considerations.html) sections and apply some of the required changes. For example, you must update the [**max file descriptors limit**](./tuning-infrastructure.html#Max Processes and File Descriptors Limit) before you begin.

{% info %}
 The recommendation is to review at least the following sections:

- [Tuning Infrastructure](./tuning-infrastructure.html)
- [Tuning GigaSpaces Performance - Basics](./tuning-gigaspaces-performance---basics.html)
- [Tuning Java Virtual Machines](./tuning-java-virtual-machines.html)
- [Benchmarking the platform](./moving-into-production-checklist.html)
{% endinfo %}
