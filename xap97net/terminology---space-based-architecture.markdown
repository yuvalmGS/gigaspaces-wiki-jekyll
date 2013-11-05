---
layout: xap97net
title:  Terminology - Space-Based Architecture
categories: XAP97NET
page_id: 63799428
---

**Summary** - GigaSpaces components from a functional perspective.
\|[Basic Components](./terminology---basic-components.html)\|[Data Grid Topologies](./terminology---data-grid-topologies.html)\|Space-Based Architecture\|[Runtime Components](./terminology---runtime-components.html)\|

# Space-Based Architecture

{% comment %}
=========================================

         Space Based Architecture

=========================================
{% endcomment %}

{% comment %}
---------------------------------------
          Space Based Architecture
---------------------------------------
{% endcomment %}

{% anchor Space Based Architecture %}

{% section %}
**A Space-Based Architecture (SBA) implementation** is a set of Processing Units, with the following properties:

- Each processing unit instances holds a [partitioned](./terminology---data-grid-topologies.html#Partitioned Data Grid) space instance and one or more services that are registered on events on that specific partition. Together they form an application cluster. If the cluster is required to be highly available, each primary partition has one or more backup partitions, which run in their own processing unit instances. These instances are inactive, and become active only when their primary partition fails.

- Each Processing Unit instance handles only the data sent to the space partition it runs.

- Clients interact with the system by writing and updating objects in the space cluster, and the services on each processing unit instance react to object written to that specific instance. In an SBA application, the data will be partitioned in such a way that the services that is triggered as a result will not have to read or write data from other partitions, thus achieving data affinity and in memory read and write speeds. .

- The system can be scaled by simply increasing the number of space partitions and their corresponding processing unit instances.

- When deployed onto the [Service Grid](./terminology---runtime-components.html#Service Grid), self-healing and SLA capabilities are added.

- Full monitoring and management during runtime are available through the [Management UI](./terminology---runtime-components.html#Management UI).

{% align center %}

![sba_with_backup.jpg](/attachment_files/xap97net/sba_with_backup.jpg)

{% sub %}**An SBA implementation, with 3 primary instances and one backup for each them, accessed by two client applications**{% endsub %}

{% endalign %}
{% endsection %}

\|[Basic Components](./terminology---basic-components.html)\|[Data Grid Topologies](./terminology---data-grid-topologies.html)\|Space-Based Architecture\|[Runtime Components](./terminology---runtime-components.html)\|
