---
layout: sbp
title:  Terminology - Space-Based Architecture
categories: XAP97NET
page_id: 63799428
---

*Summary* - GigaSpaces components from a functional perspective.
|[Basic Components|Terminology - Basic Components]|[Data Grid Topologies|Terminology - Data Grid Topologies]||Space-Based Architecture|[Runtime Components|Terminology - Runtime Components]|

# Space-Based Architecture
{comment}=========================================

         Space Based Architecture

========================================={comment}
{comment}---------------------------------------
          Space Based Architecture
---------------------------------------{comment}
{anchor:Space Based Architecture}
{section}
*A Space-Based Architecture (SBA) implementation* is a set of Processing Units, with the following properties:

- Each processing unit instances holds a [partitioned|Terminology - Data Grid Topologies#Partitioned Data Grid] space instance and one or more services that are registered on events on that specific partition. Together they form an application cluster. If the cluster is required to be highly available, each primary partition has one or more backup partitions, which run in their own processing unit instances. These instances are inactive, and become active only when their primary partition fails.

- Each Processing Unit instance handles only the data sent to the space partition it runs.

- Clients interact with the system by writing and updating objects in the space cluster, and the services on each processing unit instance react to object written to that specific instance. In an SBA application, the data will be partitioned in such a way that the services that is triggered as a result will not have to read or write data from other partitions, thus achieving data affinity and in memory read and write speeds. .

- The system can be scaled by simply increasing the number of space partitions and their corresponding processing unit instances.

- When deployed onto the [Service Grid|Terminology - Runtime Components#Service Grid], self-healing and SLA capabilities are added.

- Full monitoring and management during runtime are available through the [Management UI|Terminology - Runtime Components#Management UI].

{% align center %}

!GRA:Images^sba_with_backup.jpg!

~*An SBA implementation, with 3 primary instances and one backup for each them, accessed by two client applications*~

{% endalign %}
{section}

|[Basic Components|Terminology - Basic Components]|[Data Grid Topologies|Terminology - Data Grid Topologies]||Space-Based Architecture|[Runtime Components|Terminology - Runtime Components]|