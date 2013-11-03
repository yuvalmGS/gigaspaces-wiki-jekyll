---
layout: xap97net
title:  Terminology - Space-Based Architecture
categories: XAP97NET
page_id: 63799428
---

**Summary** - GigaSpaces components from a functional perspective.
|depanlinkBasic Componentstengahlink./terminology---basic-components.htmlbelakanglink|depanlinkData Grid Topologiestengahlink./terminology---data-grid-topologies.htmlbelakanglink||Space-Based Architecture|depanlinkRuntime Componentstengahlink./terminology---runtime-components.htmlbelakanglink|

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

- Each processing unit instances holds a depanlinkpartitionedtengahlink./terminology---data-grid-topologies.html#Partitioned Data Gridbelakanglink space instance and one or more services that are registered on events on that specific partition. Together they form an application cluster. If the cluster is required to be highly available, each primary partition has one or more backup partitions, which run in their own processing unit instances. These instances are inactive, and become active only when their primary partition fails.

- Each Processing Unit instance handles only the data sent to the space partition it runs.

- Clients interact with the system by writing and updating objects in the space cluster, and the services on each processing unit instance react to object written to that specific instance. In an SBA application, the data will be partitioned in such a way that the services that is triggered as a result will not have to read or write data from other partitions, thus achieving data affinity and in memory read and write speeds. .

- The system can be scaled by simply increasing the number of space partitions and their corresponding processing unit instances.

- When deployed onto the depanlinkService Gridtengahlink./terminology---runtime-components.html#Service Gridbelakanglink, self-healing and SLA capabilities are added.

- Full monitoring and management during runtime are available through the depanlinkManagement UItengahlink./terminology---runtime-components.html#Management UIbelakanglink.

{% align center %}


depanimagesba_with_backup.jpgtengahimage/attachment_files/xap97net/sba_with_backup.jpgbelakangimage

{% sub %}**An SBA implementation, with 3 primary instances and one backup for each them, accessed by two client applications**{% endsub %}

{% endalign %}
{% endsection %}

|depanlinkBasic Componentstengahlink./terminology---basic-components.htmlbelakanglink|depanlinkData Grid Topologiestengahlink./terminology---data-grid-topologies.htmlbelakanglink||Space-Based Architecture|depanlinkRuntime Componentstengahlink./terminology---runtime-components.htmlbelakanglink|
