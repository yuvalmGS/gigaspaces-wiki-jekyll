---
layout: post
title:  XAP ESM on Cisco UCS
categories: XAP97
parent: cloud-and-virtualization.html
weight: 100
---

{% compositionsetup %}
{% summary %}This page describes the GigaSpaces Elastic Data Grid deployment on the Cisco Unified Computing System (UCS) platform, using the Elastic Service Manager{% endsummary %}

# Overview

The GigaSpaces [Elastic Service Manager](http://www.gigaspaces.com/wiki/display/XAP71/The+Elastic+Service+Manager) allows a user to deploy a data grid that can scale out and in to meet changing demands. A simple handler interface is used to request additional computing resources and to release ones that are no longer required.
![GigaSpaces-Cisco Integration.png](/attachment_files/GigaSpaces-Cisco Integration.png)

## Cisco UCS

The Cisco Unified Computing System is a next-generation data center platform that:

- Unites computing, networking, storage access, and virtualization into a cohesive system
- Integrates a low-latency, lossless 10 Gb Ethernet unified network fabric with enterprise-class, x86-architecture servers

For more details about UCS, please go to [http://www.cisco.com/en/US/netsol/ns944/](http://www.cisco.com/en/US/netsol/ns944/)

## UCS Manager

The Cisco Unified Computing System includes an innovative XML API which offers you a programmatic way to integrate or interact with any of the over 9,000 managed objects in UCS. Managed objects are abstractions of UCS physical and logical components such as adaptors, chassis, blade servers, and fabric interconnects.

Developers can use any programming language to generate XML documents containing UCS API methods. The complete and standard structure of the UCS XML API makes it a powerful tool that is simple to learn and implement.

The UCS Manager API allows a developer to provision bare-metal machines and set them up according to your requirements, including configuring pools of compute resources, MAC addresses and SAN WWN addresses. These features make it an ideal scalable platform that GigaSpaces can leverage to scale out its Data Grid and application server. For more details about the UCS Manager, please see their website at [http://developer.cisco.com/web/unifiedcomputing/home](http://developer.cisco.com/web/unifiedcomputing/home)

## Scaling Agent

The scaling agent is an implementation of the GigaSpaces ESM Scaling Handler interface that uses the UCS Manager API to handle GigaSpaces scaling events.&nbsp; The scaling handler interface is copied in the code segment below, and the design of the UCS Elastic Scale Handler is also explained in greater detail in the following sections.

# Prerequisites

- Obviously, you will need access to UCS hardware to run this demo. If you do not have a UCS system available locally, consider contacting the [UCS developer program](http://developer.cisco.com/web/unifiedcomputing/start) to arrange access to a hosted sandbox or to an emulator of the UCS Manager module.

- Download the GigaSpaces ESM package for UCS attached to this page, or get the most up to date version in the OpenSpaces source code repository at: [http://svn.openspaces.org/cvi/trunk/ucs/](http://svn.openspaces.org/cvi/trunk/ucs/)

- Update the 'ucs.properties' file in the package with your UCS Manager user name and password.

# Data Grid deployment control flow

Deployment of a data grid is initiated by connecting to a running instance of the ESM, and requesting a new data grid deployment. From this point on, the ESM controls the provisioning and removal of resources.

Here is the control flow of a typical deployment

1. Client looks up an existing ESM.
1. If an existing machine is not available, a new one is provisioned from the UCS Manager. An 'agentless' installer uploads all application files to the new server and launches an initialization script that starts a GigaSpaces Agent, Lookup Service, GSM and ESM.
1. Client connects to the ESM via the GigaSpaces [Admin API](http://www.gigaspaces.com/wiki/display/XAP7/Administration+and+Monitoring+API) and requests a new Data Grid deployment, specifying the [scaling handler](http://www.gigaspaces.com/wiki/display/XAP71/Custom+Elastic+Scale+Handler+Example) to use.
1. ESM provisions new servers from the UCS Manager as required to meet the grid requirements. If no longer required, the ESM will power down these machines.

# How to Run the Demo

The project source code includes a demo application called _com.gigaspaces.ucs.deploy.ESMDemo_. This class will initialize a data grid and performs some basic operations on it. This is the best place to start. Here you can change the test grid's settings, like its capacity and availability, and see how they affect the grid deployment.

## The code

{% inittab demo|top %}
{% tabcontent Deploy %}

{% highlight java %}
final Admin admin = new AdminFactory().addLocator(locator).createAdmin();
final String gridName = "myElasticDataGrid";
// Use the Admin API to deploy an elastic grid
final ElasticServiceManager esm = admin.getElasticServiceManagers().waitForAtLeastOne();
final ProcessingUnit pu = esm.deploy(new ElasticDataGridDeployment(gridName).elasticScaleHandler(
new ElasticScaleHandlerConfig("com.gigaspaces.ucs.scaleHandler.UCSElasticScaleHandler")
.addProperty("Uri", props.getProperty("UCS_URI"))
.addProperty("UCSUsername", props.getProperty("UCSUsername"))
.addProperty("UCSPassword", props.getProperty("UCSPassword"))
.addProperty("SSHUsername", props.getProperty("SSHUsername"))
.addProperty("SSHPassword", props.getProperty("SSHPassword"))
.addProperty("locator", locator)
.addProperty("lookupGroup", props.getProperty("lookupGroup"))
.addProperty("gridName", gridName)
.addProperty("BladePoolName", props.getProperty("BladePoolName"))
.addProperty("macPoolName", props.getProperty("macPoolName"))
.addProperty("Template", props.getProperty("Template"))
.addProperty("Organization", props.getProperty("Organization"))
.addProperty("serverNamePrefix", props.getProperty("serverNamePrefix"))
.addProperty("localDir", props.getProperty("remoteDir"))
.addProperty("remoteDir", props.getProperty("remoteDir"))
).capacity("1G","2G").highlyAvailable(true).publicDeploymentIsolation().maximumJavaHeapSize("250m").initialJavaHeapSize("250m"));
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Handler Interface %}

{% highlight java %}
public interface ElasticScaleHandler {
public void init(ElasticScaleHandlerConfig config);

public boolean accept(Machine machine);

public void scaleOut(ElasticScaleHandlerContext context);

public void scaleIn(Machine machine);
}
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

## Seeing it in action

A video file attached to this page shows the demo code in action.

# Design of the UCS Elastic Scale handler

This section describes the implementation of the elastic handler used in the UCS integration (see the _com.gigaspaces.ucs.scaleHandler.UCSElasticScaleHandler_ in the downloadable package. The handler uses the UCS manager XML API, so an understanding of this API is important. The UCS Manager API programmer's guide is available [here](http://www.cisco.com/en/US/docs/unified_computing/ucs/sw/api/ucs_api_book.html).

## UCS Manager API integration

This section describes the main technical details of the integration with the UCS Manager API.

### XML handling

The handler uses JAXB to marshal and unmarshal the XML documents used by the Manager API. Domain objects were generated by the JAXB compiler from the xsd schema files that are available from Cisco (and also in the project sources). XML documents are sent to the UCS Manager over HTTP/S using the Apache [HttpClient](http://hc.apache.org/httpcomponents-client/) library.

### JAXB fastBoot

By default, JAXB loads all domain classes at start-up in order to  speed up marshaling/unmarshaling. Unfortunately, this means that a large  number of domain classes can cause a significantly delay during start-up, and the UCS  Management domain is quite large. To avoid this delay we use the  fastBoot option which loads domain object the first time they are used.  As the number of classes actually used by the handler is fairly small,  the delay is relatively small.

### Service facade

The service facade is a class that wraps the UCS Manager API and exposes the functionality that the handler requires. It implements the main methods of the UCS Manager API (_login, configConfMo, configResolveChildren, configResolveClass_, etc..) as well as various methods used by the handler in handling GigaSpaces events, i.e. starting and stopping machines.

## Agentless Installation

The GigaSpaces elastic handler does not require any prior installation of applications or libraries on a newly booted machine. Instead, the handler will transfer all required files to the new machine over a secure copy connection (i.e. port 22) and will then launch a script (again, over ssh) that will set up the files as required and launch the GigaSpaces agent. From this point on, the ESM will manage this machine according to the current demands on the cluster.
As a result, all that is required of the system administrator is to set up a Linux operating system on the UCS blades (CentOS 5.5 was used for testing) and to enable ssh. Everything else is handled by the installer.

The application files and scripts used by the installer can be modified to adapt them to a specific deployment scenario.

# Considerations

- The GigaSpaces UCS Scaling handler expects a newly powered on server to load a linux based operating system and enable ssh. Installation and set up of the operating system should be handled before attempting to deploy a data grid on these machines.
