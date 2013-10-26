---
layout: xap97net
title:  Product Architecture
categories: XAP97NET
page_id: 63799417
---

{summary}This section describes the architecture of the GigaSpaces XAP product.{summary}

GigaSpaces XAP is built from the following sub-systems:
- [**An SLA-Driven Container**|#SLA-Driven Container] -- provides the virtualization capabilities
- [**A Unified Clustering Layer**|#Unified In-Memory Clustering] -- responsible for a single clustering model across all the product's functionality. This capability is built on top of the space infrastructure.
- [**Core Middleware**|#Core Middleware] -- space-based runtime services which provide data, messaging and processing implementation.
- [**Lightweight Application Containers**|#Lightweight Application Containers] -- application container services provide runtime support for applications.
- [**Developers API and Components**|#Developers API and Components] -- the API layer and a component model (building blocks) for application developers.

Each sub-system (layer) is responsible for providing application server capabilities, and the bottom layers provide services to the upper layers. Figure 1 provides a representation of the sub-systems which compose the entire GigaSpaces XAP product.

!GS6:Images^XAP Architecture Overview.jpg|align=center!
{center} ~**Figure 1. Architecture overview for GigaSpaces XAP**~ {center}

# SLA-Driven Container

{toc-zone:location=top|maxLevel=2|minLevel=2|type=flat|separator=pipe}
{comment}TODO_NIV - Change to internal link when available.{comment}
An SLA-Driven Container, also known as the [Service Grid|XAP71:Service Grid Processing Unit Container], is responsible for abstracting the physical characteristics of the host machines from the application deployment.

The Service Grid is simply a set of runtime container processes deployed on multiple physical machines, which together form a virtual runtime cloud.  Once the cloud is formed, applications can be deployed for execution across the cloud, without a need to define specific host machine characteristics.

In addition, as its name implies, the Service Level Guarantee and management is an essential part of this sub-system's responsibilities.

When it comes to provisioning and monitoring large-scale systems, the ability to specifically define the location of each node in the cluster becomes very laborious.

{comment}TODO_NIV - Change to internal link when available.{comment}
The Service Grid takes a [pre-defined application-required SLA|XAP71:Service Grid Processing Unit Container#ServiceGridProcessingUnitContainer-SLAPolicy], and makes sure that it is met during deployment and runtime, throughout the application's life-cycle.

To clarify, here is an example of an application SLA:
1. Deploy 50 instances of each Processing Unit.
2. Make sure each processing unit has one backup.
3. Make sure primary and backups of the same Processing Unit are not deployed to the same VM.
4. Make sure primary and backup of the same Processing Unit are not deployed on the same physical server.

In this type of example, the Service Grid is responsible for making sure that one hundred Processing Units are deployed into the Service Grid cloud. Once the SLA is breached, (for example, if a machine which contains a Processing Unit fails), the Service Grid is responsible for re-provisioning all the Processing Units previously deployed on this machine into other Grid Service Containers (see definition below), in other available machines.

(i) Note: The logical separation between multiple Service Grid instances is defined by a Lookup Group. A lookup group is a logical name associated with each Service Grid component. This is the prime way of separating between multiple Service Grid clusters run on the same network.

## Grid Service Agent (GSA)

{comment}TODO_NIV - Change to internal link when available.{comment}
The Grid Service Agent (GSA) acts as a process manager that can spawn and manage Service Grid processes (Operating System level processes) such as [Grid Service Manager|XAP95:The Grid Service Manager] and [Grid Service Container|XAP95:The Grid Service Container].

Usually, a single GSA is run per machine. The GSA allows to spawn [Grid Service Managers|#gsm], [Grid Service Containers|#gsc], and other processes. Once a process is spawned, the GSA assigns a unique id for it and manages its life cycle. The GSA will restart the process if it exits abnormally (exit code different than 0), or if a specific console output has been encountered (for example, OutOfMemoryError).

(on) Though Grid Service Manager, Grid Service Container, and other processes can be started independently, it is preferable that they will be started using the GSA, thus allowing to easily monitor and manage them.

{anchor:gsm}

## Grid Service Manager (GSM)

The [Grid Service Manager (GSM)|XAP95:The Grid Service Manager], is a special infrastructure service, responsible for managing the Service Grid containers. The GSM accepts user deployment and undeployment requests, and provisions the Service Grid cloud accordingly.
The GSM monitors SLA breach events throughout the life-cycle of the application, and is responsible for taking corrective actions, once SLAs are breached.

(i) It is common to start two instances of GSM services within each Service Grid cloud, for high-availability reasons.

{comment}TODO_NIV - Change to internal link when available.{comment}
The GSM service usually contains the [Lookup Service|XAP95:Lookup Service Configuration] and the Webster codebase server as part of its standard configuration. This configuration can be changed by providing additional parameters in the GSM startup script.

{anchor:gsc}

## Grid Service Container (GSC)

A Grid Service Container (GSC) is a container which hosts Processing Units (see description below). The GSC can be perceived as an agent, a node on the grid, which is controlled by the GSM. The GSM provides commands of deployment and undeployment of the Processing Units into the GSC. The GSC reports its status to the GSM.

Another aspect of a GSC is its ability to host Processing Units. The GSC uses AppDomains to make sure that various Processing Units are isolated from one another within the same GSC.

{comment}TODO_NIV - Change to internal link when available.{comment}
It is common to start several GSCs on the same physical machine, depending on the machine CPU and memory resources.
The deployment of multiple GSCs on a single machine creates a virtual Service Grid. The fact is that GSCs are providing a layer of abstraction on top of the physical layer of hosts. This concept enables deployment of clusters on various deployment topologies of enterprise data centers and public clouds.
{toc-zone}

# Unified In-Memory Clustering

{toc-zone:location=top|maxLevel=2|minLevel=2|type=flat|separator=pipe}
The role of clustering in GigaSpaces XAP is to provide scaling, load-balancing and high-availability. The main difference between GigaSpaces XAP and other clustering alternatives, is the use of a single clustering model for all middleware core capabilities. This means that the data and the services collocated with it, are equally available. An example of how useful this is, is that when a primary node fails, and another node acts as its backup, both application components, i.e. data and messaging, become active at the same time.

The ability to support a unified clustering model is a direct result of the underlying space-based clustering model. For more information on the concept of space, please refer to [Space - Concepts and Capabilities|Concepts#Space - Concepts and Capabilities].

## Scaling

In space-based architecture, adding additional cluster nodes, results in a linear addition of compute power and memory capacity. This results in the application's ablility to support a higher workload, without adding to latency or application complexity.

## Load Balancing

GigaSpaces XAP's ability to distribute the processing load and/or storage across the cluster nodes, results in the ability to support high and fluctuating throughput, in addition to large volumes of data.

GigaSpaces XAP also supports content-based balancing, in addition to other technical balancing procedures, such as round-robin, random and connection affinity. The full power of content-based routing, results in the ability to predict the physical location of the data, and to make sure that processing is routed into the same partition. This results in in-process computation, which leads to lower latencies and higher throughput.

## High Availability

High Availability (HA) is key to business critical applications, and it is a common requirement from the application server, to support it. The basic requirement of high availability, is that failing services and application components will continue on different backup servers, without service disruption.

The key challenge with HA is state management. The typical solution for servers without state recovery capabilities is to remain 'stateless', and to store the state in a single shared storage - database or some kind of shared file system. However these solutions are very costly, since they result in synchronization and remote access to physical disks. In addition, the session state can be large, which means it introduces network latency into every update of data - even when that data is limited to the current transaction.

As GigaSpaces XAP has distributed shared memory capabilities, it is very simple and efficient to preserve high availability of stateful applications. The application state is replicated into backup nodes, resulting in immediate recovery in cases of fail-over and high-performance high-availability.

The GigaSpaces XAP solution does not require a compromise between stateless application complexity, performance and resiliency.
{toc-zone}

# Core Middleware

As an application server, GigaSpaces XAP provides integrated, memory-based runtime capabilities. The core of these capabilities is backed by the space technology - for more information, please refer to [Space - Concepts and Capabilities|Concepts#Space - Concepts and Capabilities].

**The core middleware capabilities are:**
{toc-zone:type=list|location=top}

## In-Memory Data Grid

An In-Memory Data Grid (IMDG) is the way of storing data across a grid of memory nodes. This service provides the application with:
1. Data storage capabilities.
2. Data query capabilities - single object, multiple object and aggregated complex queries.
3. Caching semantics - the ability to retrieve information from within-memory data structures.
4. Ability to execute business logic within the data - similar to database storage procedure capabilities.

It is important to note that the IMDG, although a memory-based service, is fully transactional, and follows the ACID (Atomicity, Concurrency, Isolation and Durability) transactional rules.

The IMDG uses the unified clustering layer, to provide a highly available and reliable service.

{comment}TODO_NIV - Change to ISpaceProxy link when available.{comment}
The main API to access the IMDG service, is the [{{ISpaceProxy}} interface|Writing Your First Application]. Please refer to the [Programmer's Guide|Programmer's Guide] for usage examples.

## Messaging Grid

The messaging grid aspect of the space, provides messaging capabilities such as:
1. Event-Driven capabilities - the ability to build event-driven processing applications. This model enables fast (in-memory-based) asynchronous modular processing, resulting in a very efficient and scalable processing paradigm.
2. Asynchronous production and consumption of information.
3. One-to-one, Many-to-One, One-to-Many and Many-to-Many relationships.
{comment}TODO_NIV - Add link when available.{comment}
4. FIFO ordering.
{comment}TODO_NIV - Add link when available.{comment}
5. Transactionality.

The core APIs used for messaging are the [Notify Container|Notify Container Component] and [Polling Container|Polling Container Component] components. More information can be found in the [Programmer's Guide|Event Driven Architecture].

## Processing Services

Processing services include parallel processing capabilities.

### Parallel Processing

Sometimes the scalability bottleneck is within the processing capabilities. This means that there is a need to gain more processing power to be executed concurrently. In other words, there is a need for parallel processing. When there is no state involved, it is common to spawn many processes on multiple machines, and to assign a different task to each process.

However, the problem becomes much more complex when the tasks for execution require sharing of information. GigaSpaces XAP has built-in services for parallel processing. The master/worker pattern is used, where one process serves as the master and writes objects into the space, and many worker services each take work for execution and share the results. The workers then request a new piece of work, and so on. This pattern is important in practice, since it automatically balances the load.

### Compute Grid

Compute grid is a mechanism that allows you to run user code on all/some nodes of the grid, so that the code can run in collocation with the data.

Compute grids are an efficient solution when a computation requires a large data set to be processed, so that moving the code to where the data is, is much more efficient than moving the data to where the code is.

The efficiency derives from the fact that the processing task is sent to all the desired grid nodes concurrently. A partial result is calculated using the data on that  particular node, and then sent back to the client, where all the partial results are reduced to a final result.

The process is widely known as map/reduce, and is used extensively by companies like Google whenever a large data set needs to be processed in a short amount of time.

### Business Logic Hosting

Another aspect of processing is business logic hosting. This is covered in Lightweight Application Containers below.
{toc-zone}

# Lightweight Application Containers

{toc-zone:location=top|maxLevel=2|minLevel=2|type=flat|separator=pipe}
Lightweight application containers provide a business logic execution environment at the node level. They also translate SBA semantics and services to the relevant container development framework implementation.

The Grid Service Container (GSC) is responsible for providing Grid capabilities, whereas the lightweight container implementation is responsible at the single VM level.

For this reason, this architecture is very powerful, as it enables applications to take advantage of the familiar programming models and services at the single VM level, and in addition provides grid capabilities and services on top.

GigaSpaces XAP provides several default implementations as part of the product, and an additional plugin API, to enable other technology integrations.

**Current implementations supported by GigaSpaces XAP**:
{toc-zone:type=list|location=top}

More information on the usage of the above integrations can be found in the [Programmer's Guide].

## .NET  - Abstract container

The Abstract Processing Unit Container bridges the gap between Java and .NET, and provides a .NET abstract class which can be extended for implementing .NET containers as well as developing processing units from scratch.

This allows .NET SBA applications  to run business services and .NET code, collocated with the data stored within the space.

## .NET  - Basic container

The [Basic Processing Unit Container|Basic Processing Unit Container] extends the Abstract Container and simplifies tasks commonly used in processing units, such as starting an embedded space, hosting a service, activating an event container, etc.

## C++ Container

Much like the .NET Abstract Container, the [C++ container|XAP95:CPP Processing Unit] provides a native C++ runtime environment for [C++ SBA|XAP95:XAP CPP] applications.

## Java - Spring Container

The Spring framework container integration is built-in to XAP, and provides the ability to take advantage of [Spring framework|http://www.springframework.org/about] components, programming model and capabilities.

The Spring framework provides very elegant abstractions, which makes it very easy to build layered and decoupled applications.

## Jetty Web Container

Jetty is a very popular web container, which provides support for JEE [web container|XAP95:Web Processing Unit Container] specification services such as: Servlet, JavaServer Pages, JavaServer Faces, and others.

The [integration with the Jetty web container|XAP95:Web Jetty Processing Unit Container], allows you to run JEE web applications (.war files) on top of GigaSpaces XAP.

## Mule

Mule is a very popular open source Enterprise Services Bus implementation in Java. The [Mule container integration|XAP95:Mule ESB] allows you to run a Mule application on top of the GigaSpaces XAP, and gain scalability, performance and high-availability, with almost no changes to the Mule application.
{toc-zone}

# Developers API and Components

{toc-zone:location=top|maxLevel=2|minLevel=2|type=flat|separator=pipe}

## Overview

The application interface is designed to make space-based development easy, reliable, and scalable. In addition, the programming model is non-intrusive, based on a simple POCO programming model and a clean integration point with other development frameworks.

The XAP.NET API can be divided into the following parts:

## Core

The core module of XAP.NET provides APIs for direct access to space. The main interface is the {{ISpaceProxy}} interface, which enables the basic interaction with the space. The core components include basic infrastructure support such as Space construction, storing and retrieving objects from the space, subscribing for notifications, etc.

## Events

The events module is built on top of the core module, and provides POCO-based event processing components through the event containers. The event module enables simple construction of event-driven applications.

The events module includes components for simplified EDA/Service Bus development. These components allow [unified event-handling|Space Events] and provide two mechanisms for event-generation: a [polling container|Polling Container Component] uses polling received operations against the space, and a [notify container|Notify Container Component] which uses the space's built-in notification support.

## Remoting and Service Virtualization

The Remoting module provides capabilities for clients to access remote services. Remoting in GigaSpaces XAP is implemented on top of the space and the common clustering model, which provides location transparency, fail-over, and performance to remote service invocations.

Remoting can be viewed as the alternative to Web Services or WCF, as it provides most of their capabilities as well as supporting synchronous and asynchronous invocations and distributed service invocations which makes it easy to implement and consume map/reduce services.

## Integrations

This package contains integrations with non-XAP components. For more information please refer to the Programmers Guide.

{toc-zone}

{whr}
{refer} **Next chapter**: [Terminology]{refer}