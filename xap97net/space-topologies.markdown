---
layout: xap97net
title:  Space Topologies
categories: XAP97NET
---

{% compositionsetup %}

{% summary page|60 %}Explains the topologies and clustering mechanism of the GigaSpaces in-memory data grid (the Space){% endsummary %}

# Overview

Different applications might have different caching requirements. Some applications require on-demand loading from an external, slower data source, due to limited memory. Others use the cache for read-mostly purposes. Transactional applications need a cache that handles write and read operations, maintains consistency and serves as the application's system of record.

In order to address these different requirements, GigaSpaces provides an in-memory data grid that is policy-driven. Most of the policies do not affect the actual application code, but rather affect the way each data grid instance interacts with other instances.

This section explains the topologies supported by XAP: Replicated, partitioned and master-local.

# GigaSpaces Data Grid: Basic Terms

- **Space (data grid) instance**: an independent data storage unit. The Space is comprised of all the space instances running on the network. ![DGA-DataGrid.jpg](/attachment_files/xap97net/DGA-DataGrid.jpg)
- **Space**: GigaSpaces data grid implementation. A distributed, shared, memory-based repository for objects. A space runs in a _space container_ which is usually transparent to the developer.
![DGA-GigaSpacesDataGrid.jpg](/attachment_files/xap97net/DGA-GigaSpacesDataGrid.jpg)

- **GigaSpaces Container (GSC)**: a generic container that can run one or more [processing units](./packaging-and-deployment.html). A space instance usually runs within a processing unit. The GSC is launched on each machine that participates in the space cluster, and hosts the space instances. ![DGA-ServiceGridDataGrid.jpg](/attachment_files/xap97net/DGA-ServiceGridDataGrid.jpg)
- **Remote vs. Collocated**: The Space can be remote to the application or collocated with the application. With Remote mode any space operation will involve network usage. With collocated mode, there is no network utilization. This mode improves the performance and latency with activities that performs space operations.
![remote_embedded_space_topology.jpg](/attachment_files/xap97net/remote_embedded_space_topology.jpg)

- **Replication**: A relationship in which data is copied between two or more space instances, with the aim of having the same data in some or all of them. ![DGA-Replication2.jpg](/attachment_files/xap97net/DGA-Replication2.jpg)
- **Synchronous replication**: Replication scheme in which space client applications are blocked until their changes are propagated to all peer spaces. This guarantees higher data consistency between space instances, at the expense of reduced performance since clients have to wait for the replication to complete before the operation is finished.

- **Asynchronous replication**: Replication mode in which changes are propagated to peer space instances in the background. Asynchronous replication uses separate thread(s) to the thread(s) which receive write requests from the client application. Therefore, the client application does not have to wait for their changes to be propagated to other space instances in order to complete the operation. With asynchronous replication the space can optimize replication by batching multiple updates into a single network call. Therefore, asynchronous replication allows for higher performance and throughput. The disadvantage is that data is less consistent between space instances and takes longer to get propagated.

- **Partitioning**: New data or operations on data are routed to one of several space instances (partitions). Each space instance holds a subset of the data, with no overlap. Partitioning is done according to the _routing field_ in the data object. Each object written to the space defines a routing field whose value is used to determine the partition to which the object will be sent. The space client side proxy guarantees that if two objects have the same value set for the routing field they will end up in the same partition, regardless of how many partitions are running. ![DGA-Partitioning2.jpg](/attachment_files/xap97net/DGA-Partitioning2.jpg)
- **Topology**: A specific configuration of space instances. For example, a replicated topology is a configuration in which all space instances replicate data between one another. In GigaSpaces, space topologies are defined by _clustering policies_ (see below).

{% info title=Replication Configuration %}
For more details on how to configure the replication mechanisms of the Space, refer to [Replication]({% currentjavaurl %}/replication.html) in the [Administrator's Guide](./administrator's-guide.html).
{% endinfo %}

# Data Grid Topologies

GigaSpaces XAP supports the following data grid topologies:

{: .table .table-bordered}
| Topology and Description | Common Use | Options |
| **Replicated** ([dg_a_topology2a.gif])<br/>Two or more space instances with replication between them. | Allowing two or more applications to work with their own dedicated data store, while working on the same data as the other applications. Also allows for load distribution between multiple space instances in read-intensive scenarios. | * Replication can be synchronous (slower but with better consistency) or asynchronous (faster but less reliable, as it does not guarantee consistency and immediate replication).<br/>- Space instances can run on the same memory as the application (embedded - allows faster read access) or in a separate process (remote - allows multiple applications to use the space, easier management). |
| **Partitioned** ([dg_a_topology3.gif])<br/>Data and operations are split between two or more space instances (partitions) according to a routing field defined in the data. | Allows the In-Memory Data Grid to hold large volumes of data, even if it is larger than the memory of a single machine, by splitting the data across several partitions. | * With/without backup space instance for each partition.<br/>- Business logic can be collocated with each partition and act on the data of the local partition. This is one of the principles of the SBA paradigm |
| **Local Cache** ([dg_a_topology4.gif])<br/>Each client has a lightweight, embedded cache (space instance), which is initially empty. Upon the first time data is read, it is loaded from a master space to the local cache (this is called lazy loading); the next time the same data is read, it is fetched quickly from the local cache without network access. Later on data is either updated from the master or evicted from the cache. For more information see [Local Cache](./local-cache.html)    | Boosting read performance for frequently used data. A useful rule of thumb is to use a local cache when over 80% of all operations are repetitive read operations. | * The master cache can be clustered in any of the other topologies: replicated, partitioned, etc. |
| **Local-View** ([dg_a_topology5.gif])<br/>Each client has a lightweight, embedded cache (space instance), which contains a subset of the mater space's data. The client defines which data is cached using a collection of SQL queries, and the master space pushes the matching data to the client's cache. For more information see [Local View](./local-view.html) | Achieving maximal read performance for a predetermined subset of the data. | * The master cache can be clustered in any of the other topologies: replicated, partitioned, etc.|

{% infosign %} The topologies above are provided in the GigaSpaces product as predefined cluster schemas. The schema names are:

- Synchronous replication - `sync-replicated`
- Asynchronous replication - `async-replicated`
- Partitioned with backup - `partitioned-sync2backup`
The local cache and local view topologies do not need their own schemas, because they are defined on the client side.

{% children %}
