---
layout: xap97net
title:  The Application Layer
categories: XAP97NET
page_id: 63799378
---


{% summary %}This section describes the GigaSpaces Application Layer.{% endsummary %}


Each XAP.NET application is composed of one or more scalable modules, and contains one or more business logic code components, domain model objects (entries), in-memory data storage, messaging, and event processing code.

A module in SBA is called a Processing Unit. This is the smallest unit for cross-cluster scaling. This unit is used for design, development, testing, packaging and deployment.

# Processing Unit


{% comment %}
TODO_NIV - Change to internal link when available.
{% endcomment %}

A depanlinkProcessing Unittengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP95/Packaging+and+Deploymentbelakanglink is the unit of scale. It is an application component, provided by the application developer, which is deployed to be run on several GSC instances.

The Service Grid is responsible for taking a single copy of a Processing Unit, and creating several instances on multiple GSCs.

In technical details, a Processing Unit is a collection of one or more assemblies and a configuration file, packaged as a single unit of scale. Assemblies are usually composed of Services and Domain objects, which are part of the application. The configuration file is used to define the relationship between the Processing Unit components.

**There are several types of Processing Units**:

{% comment %}
TODO_NIV - Change to internal link when available.
{% endcomment %}

- depanlink**.NET** Processing Unittengahlink./processing-units.htmlbelakanglink -  has its code components in .NET, and may contain a space component.
- depanlink**Java** Processing Unittengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP95/Packaging+and+Deploymentbelakanglink - has code components in Java, and may contain a space component.
- depanlink**Web** Processing Unittengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP95/Web+Processing+Unit+Containerbelakanglink - contains web applications. This Processing Unit can be packaged as a standard JEE WAR (Web Archive) file, and may contain a space component.
- depanlink**EDG** Processing Unittengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP95/The+Processing+Unit+Structure+and+Configuration#dataOnlyPUsbelakanglink - contains space component(s) only.

A Processing Unit package structure is defined, based on the technology:
- A **.NET** Processing Unit is packaged as a directory structure. For more information, please refer to the depanlinkXAP.NET Programmer's Guidetengahlink./processing-units.htmlbelakanglink.
- A depanlink**Java** Processing Unittengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP95/The+Processing+Unit+Structure+and+Configurationbelakanglink is packaged usually as a JAR file, modeled after the Spring DI structure. The package can also be within a file structure based on the same structure.
- A depanlink**Web** Processing Unittengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP95/Web+Processing+Unit+Container#Deploymentbelakanglink is packaged as a standard JEE WAR file.

# Data-Only Processing Unit (EDG)

In some cases there is a need to deploy an In Memory Data Grid (IMDG) only. For this reason there is a special Processing Unit called EDG - Enterprise Data Grid which can be deployed into the Service Grid. The EDG Processing Unit provides IMDG capabilities, and is accessed using the GigaSpace APIs.

An EDG Processing Unit is usually used in caching scenarios, when there is a need to provide the front-end of an information system or a database.

The value of an EDG Processing Unit is that its SLA is still maintained by the Service Grid.

# Collocation of Business Logic and Data

One of the key values of SBA, as explained above, is the ability to collocate data, business logic and messaging. A typical Processing Unit will contain, within the boundaries of the same Processing Unit, a space instance and business logic services.

The services will usually operate on data that is stored within the same space partition, providing memory access within the same process address space. This mode of interaction allows the minimal latency possible, as data is accessed by reference, as opposed to serialization required for out-of-process communication. Further more operation performance is maximal, as context switches are minimal.

Scalability is reached by deploying multiple instances of the same Processing Unit. Spaces of various Processing Units form a space cluster. However, each service within a particular Processing Unit accesses information on its own space partition.
