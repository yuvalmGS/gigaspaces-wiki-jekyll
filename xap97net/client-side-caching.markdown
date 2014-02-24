---
layout: post
title:  Client Side Caching
categories: XAP97NET
parent: programmers-guide.html
weight: 2600
---

{% summary %} A client application may run a local cache (near cache), which caches data in the client application's local memory. Gigaspaces provides two options for interacting with a client-side cache: local cache and local view. Both the local cache and local view allow the client application to cache specific or recently used data within client JVM. The data is also updated automatically by the space when necessary. The local cache is ideal for situations where higher flexibility is required, while the local view is designed for more rigid and predefined, static data.{% endsummary %}

# Introduction

GigaSpaces supports client side caching of space data within the client application's memory. Client-side caching implements a two-layer cache architecture where the first layer is stored locally, within the client's memory, and the second layer is stored within the remote master space. The remote master space may be used with any of the supported deployment topologies.

**In-line cache with a client cache**:
![in-line_cache-local-cache.jpg](/attachment_files/dotnet/in-line_cache-local-cache.jpg)

**Side cache with a client cache**:
![side-cache-local-cache.jpg](/attachment_files/dotnet/side-cache-local-cache.jpg)

The client-side cache size is limited to the heap size of the client application's memory.

The client-side cache is updated automatically when the master copy of the object within the master space is updated.

There are two variations provided:

• [Local Cache](./local-cache.html) - This client side cache maintains any object used by the application. The cache data is loaded on demand (lazily), based on the client application's read activities.
• [Local View](./local-view.html) - This client side cache maintains a specific subset of the entire data, and client side cache is populated when the client application is started.

In both cases, once updates are performed (objects are added/updated/removed) on the master space, the master space propagates the changes to all relevant local views and caches.

{% tip %}
 Client cache is not enabled by default.
{% endtip %}

# When Should You Use a Client-Side Cache?

Client-side cache should be used when the application performs repetitive read operations on the same data. You should not use client-side caching when the data in the master is very frequently updated or when the read pattern of the client tends to be random (as opposed to repetitive or confined to a well-known data set).

In some cases where the relevant dataset size fits a single JVM (64 Bit JVM may also be utilized), the data may be maintained in multiple locations (JVMs) having it collocated to the application code (client or a service) as demonstrated below:

![local-cache-real-life.jpg](/attachment_files/dotnet/local-cache-real-life.jpg)

With the above architecture the client and the remote service has a local cache/view proxy that maintains a dataset that was distributed across the different partitions. In this scenario, readbyId or readByIds calls are VERY fast since they are actually local calls (semi-reference object access) that do not involve network utilization.

### When to use a local view?

Local views are most efficient when the information to be distributed can be encapsulated in predefined queries. The data in the local view is updated and updates the remote space using replication. Replication is the most efficient and reliable method for synchronizing and ensuring consistency with the remote space. The local view is read only.

### When to use a local cache?

The purpose of the local cache is to provide access to a more flexible dataset, where reading data is carried out in a more dynamic manner. The local cache is more suitable for query by id scenarios.
