---
layout: xap97net
title:  The In-Memory Data Grid
categories: XAP97NET
page_id: 63799389
---

{% compositionsetup %}
{summary:page|60}Explains the concepts of the GigaSpaces In-Memory Data Grid (the Space), how to access it, and how to configure advanced capabilities, such as persistency, eviction, etc.{summary}

# Overview

This section describes the GigaSpaces In-Memory Data Grid (IMDG or the Space) implementation, also known as the Space. The Space enables your application to read data from it, and write data to it in various ways. It also deals with various configuration aspects, such as space topologies, persistency to an external data source and memory management facilities.

!GRA:Images2^archi_imdg.jpg!

# Key Use Cases for the Space

### The Space as the System of Record

One of the unique concepts of GigaSpaces is that its In-Memory Data Grid serves as the system of record for your application.
This means that all or major parts of your application's data are stored in the Space and your data access layer interacts with it via the various Space APIs. This allows for ultra-fast read and write performance, while still maintaining a high level of reliability and fault tolerance. Reliability and fault tolerance are maintained via data replication to peer space instances in the cluster, and eventual persistency to a relational database if needed.

### The Space as a cache

GigaSpaces IMDG supports a variety of caching scenarios. Using GigaSpaces IMDG as a cache or as a system of record provides the following benefits:
- Low latency: In-Memory Data access time without any disk usage.
- Data access layer elasticity: Scale out/up on demand to leverage additional machine resources.
- Less load on the database layer: Since the cache will offload the database, you will have less contention generated at the database layer.
- Continuous High-Availability: Zero downtime of your data access layer with the ability to survive system failures without any data loss.

The [Caching Scenarios] describes the different caching options supported by GigaSpaces.

# Characteristics of a Space

The space has a number of determining characteristics that should be configured when it is created, as described below:
{toc-zone:minLevel=1|maxLevel=3|type=list|separator=pipe|location=top}

### The Space Clustering Topology

The Space can have a single instance, in which case it runs on a single Virtual Machine (VM), or multiple instances, in which case it can run on multiple VMs.
When it has multiple instances, the Space can run in a number of [topologies|Space Topologies] which determine how the data is distributed across those VMs. In general, the data can be either **replicated**, which means it resides on all of the VMs in the cluster, or **partitioned**, which means that the data is distributed across all of the VMs, each containing a different subset of it. With a partitioned topology you can also assign one or more backup space instances for each partition.

!GRA:Images^topologies.jpg!

### Master-Local Space

Regardless of the Space's topology, you can also define a [Local Cache | Client Side Caching] for space clients. The Local Cache caches space entries recently used by the client, or a predefined subset of the central space's data (often referred to as a **Continuous Query**).
The data cached on the client side is kept up to date by the server. If Space client A changes a Space entry that resides in a client B's local cache, the Space makes sure to update client B's cache.

### The Replication Mode

When running multiple space instances, in many cases the data is replicated from one Space instance to another. This can happen in a replicated topology (in which case every change to the data is replicated to all of the space instances that belong to the space) or in a partitioned topology (in this case you choose to have backups for each partition).
There are two replication modes; synchronous and asynchronous. With synchronous replication, data is replicated to the target instance as it is written. So the client code which writes, updates or deletes data, waits until replication to the target is completed.
With asynchronous replication, replication is done in a separate thread, and the calling client does not wait for the replication to complete.

### Persistency Configuration

The Space is an In-Memory Data Grid. As such its capacity is limited to the sum of the memory capacity of all the VMs on which the space instances run.
In many cases, you have to deal with larger portions of data, or load a subset of a larger data set, which resides in an external data source such as a relational database, into the space.
The space supports many [persistency options|Persistency], allowing you to easily configure how it interacts with an external relational database, or a more exotic source of data.
It supports the following options, from which you can choose:
- Cache warm-up: load data from an external data source on startup.
- Cache read through: read data from the external data source when it is not found in the space.
- Cache write through: write data to the external data source when it is written to the space.
- Cache write behind (also known as asynchronous persistency): write data to the external data source asynchronously (yet reliably) to avoid the performance penalty.

### Eviction Policy and Memory Management

Since the Space is memory-based, it is essential to verify that it does not overflow and crash. The Space's memory can be managed and a memory overflow prevented by:

- **Eviction policy**. The space supports two eviction policies: `ALL_IN_CACHE` and `LRU` (Least Recently Used). With `LRU`, the Space starts to evict the least used entries when it becomes full. The `ALL_IN_CACHE` policy never evicts anything from the Space.
- **Memory manager**. The memory manager allows you to define numerous thresholds that control when entries are evicted (in case you use `LRU`), or when the space simply blocks clients from adding data to it.
Combined, these two facilities enable better control of your environment and ensure that the memory of the Space instances in your cluster do not overflow.

### Reactive Programming

GigaSpaces and its Space-Based-Architecture embrace the [reactive programming|http://en.wikipedia.org/wiki/Reactive_programming] approach. Reactive programming with GigaSpaces includes:
- [Data Event Listener | Event Listener Container]: [Polling Container | Polling Container Component], [Notify Container | Notify Container Component]
- [Local View and Local Cache | Client Side Caching]
- [Task Execution over the Space]
- [Asynchronous Operations|The GigaSpace Interface#Asynchronous Operations]
- [Drools Rule Engine Integration|SBP: Drools Rule Engine Integration]: Available from a 3rd party.

{toc-zone}

# APIs to Access the Space

The Space supports a number of APIs to allow for maximum flexibility to Space clients when accessing the Space:
- The core [Space API|The ISpaceProxy Interface], which is the most recommended, allows you to read objects from the Space based on various criteria, write objects to it, remove objects from it and get notified about changes made to objects. This API supports transactions.

{% info title=Accessing the Space from Other Languages %}
The code space API is also supported in [Java|XAP95:In Memory Data Grid] and [C++|XAP CPP]. This allows clients to access the space via these languages. It also supports [interoperability|Platform Interoperability in GigaSpaces] between languages, so in effect you can write an object to the space using one language, say C++, and read it with another, say Java
{% endinfo %}

- The [Document API|Document (Schema-Free) API] allows you to develop your application in a schema-less manner. Using map-like objects, you can add attributes to data types in runtime.

# Services on Top of the Space

Building on top of the core API, the Space also provides [higher level services|Services on Top of the Data Grid] onto the application. These services, along with the space's basic capabilities, provide the full stack of middleware features that you can build your application with.
[The Task Execution API|Task Execution over the Space] allows you send your code to the space and execute it on one or more  nodes in parallel, accessing the space data on each node locally.
[Event containers|Messaging and Events] use the core API's operations and abstract your code from all the low level details involved in handling the event, such as event registration with the space, transaction initiation, etc. This has the benefit of abstracting your code from the lower level API and allows it to focus on your business logic and the application behavior.
[Space-Based Remoting|Space Based Remoting] allows you to use the space's messaging and code execution capabilities to enable application clients to invoke space side services transparently, using an application specific interface. Using the space as the transport mechanism for the remote calls, allows for location transparency, high availability and parallel execution of the calls, without changing the client code.

# The Space as the Foundation for Space-Based Architecture

Besides its ability to function as an in-memory data grid, the Space's core features and the services on top of it, form the foundation for [Space-Based Architecture (SBA)|A Typical SBA Application]. By using SBA, you can gain performance and scalability benefits not available with traditional tier-based architectures, even when these include an in-memory data grid, such as the Space.
The basic unit of scalability in SBA is the [processing unit|Processing Unit Container]. The Space can be embedded into the processing unit, or accessed remotely from it. When embedded into the processing unit, local services, such as event handler and service exposed remotely over the Space, can interact with the local space instance to achieve unparalleled performance and scalability. The Space's built-in support for data partitioning is used to distribute the data and processing across the nodes, and for scaling the application.

# What's Next

It is recommended that you read the following sections next:
- [Space Topologies]
- [Deploying and Interacting with the Space]

{section-page:na}

