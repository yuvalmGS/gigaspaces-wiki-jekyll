---
layout: post
title:  Supported Platforms
categories: XAP97
parent: installation.html
weight: 100
---

{% summary %}Supported Platforms for GigaSpaces{% endsummary %}

# Tested & Certified Platforms

GigaSpaces XAP is 100% pure Java - *You can run GigaSpaces on every operating system that supports the Java Platform Standard Edition technology* -- i.e., Windows , Linux, Sun Solaris, Hewlett Packard HP-UX, IBM AIX, Apple Mac OS/X, etc.

The list below represents only the platforms that have been tested by GigaSpaces. 

{%infosign%} GigaSpaces components (space, cluster of spaces, Processing Unit, GSM, GSC, LUS, Mahalo, GUI, CLI) can run only with the same GigaSpaces JARs (i.e., the same version and build number). 

{% tip title=Recommended and Certified Environment %} 
GigaSpaces recommends that customers upgrade to a fully-supported environment, such as the latest GigaSpaces XAP and the latest Java 1.6/1.7 JDK.
{% endtip %}

## Java 
GigaSpaces XAP requires Java 6 or later. It is being tested on the following JVMs (32bit and 64bit):
 
* Oracle 6 - XAP was tested using Sun JVM version 643 and above. 
* Oracle 7 - XAP was tested using Sun JVM version 7u21 and above. 
* JRockit/BEA 1.6.x - XAP was tested using BEA JRockit(R) build 1.6.0_31-b05 
* IBM 1.6.0 - XAP was tested using IBM JVM version 1.6.0 IBM J9 VM (build 2.4, JRE 1.6.0 IBM J9 2.4 Linux amd64-64 jvmxa6460sr12-20121024_126067 (JIT enabled, AOT enabled) 

## Operating Systems
GigaSpaces is being tested on the following Operating Systems:
 
* Windows 2008 Server SP2 
* Linux RHEL 5.x/6.x 
* Solaris 10 

{%warning%}SUSE-10 sp3 has bugs which make OS network layer unreliable. This OS should be avoided with GigaSpaces.{%endwarning%} 

{%infosign%} For information on XAP.NET prerequisites see [XAP.NET Installation](..{{ site.latest_net_url }}/installation.html) 

{%infosign%} For information on XAP C++ prerequisites see [Installing CPP API Package](./installing-cpp-api-package.html) 

# Mixing GigaSpaces Versions 

The following is supported: 

* Runtime backward compatibility: Clients running on version 8.0 or later are compatible with servers running on version {{ site.latest_xap_release }}. 
* Binary compatibility: applications built using 8.0 or higher run without any code changes on a clean {{ site.latest_xap_release }} installation. 
* Servers (GSMs, GSCs and Space instances) running on any future service pack of version {{ site.latest_xap_release }} (e.g. {{ site.latest_xap_release }}.1) are guaranteed to work with older service packs of that version (e.g. {{ site.latest_xap_release }}.0). 

# Integrations with 3rd Party Products 
The following products/projects were tested and certified using GigaSpaces {{ site.latest_xap_release }}:
 
* Spring 3.2.4.RELEASE 
* Hibernate version 3.6.1.Final 
* Mule 3.3.0 
* Jetty 8.1.8.v20121106 
* Groovy 1.8.6 
* Maven 3.0.4 
* Hyperic SIGAR 1.6.5 
* Apache Cassandra 
