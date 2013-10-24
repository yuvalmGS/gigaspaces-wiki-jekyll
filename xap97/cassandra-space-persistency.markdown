---
layout: xap97
title:  Cassandra Space Persistency
page_id: 61867169
---

{% compositionsetup %}

{% summary %} A Cassandra Space Persistency Solution {% endsummary %}

# Overview

The [Apache Cassandra Project™](http://cassandra.apache.org) is a scalable multi-master database with no single points of failure. The Apache Cassandra Project develops a highly scalable second-generation distributed database, bringing together Dynamo's fully distributed design and Bigtable's ColumnFamily-based data model.

Cassandra is in use at Digg, Facebook, Twitter, Reddit, Rackspace, Cloudkick, Cisco, SimpleGeo, Ooyala, OpenX, and more companies that have large, active data sets. The largest production cluster has over 100 TB of data in over 150 machines. Data is automatically replicated to multiple nodes for fault-tolerance. Replication across multiple data centers is supported. Failed nodes can be replaced with no downtime. Every node in the cluster is identical. There are no network bottlenecks. There are no single points of failure.

# Cassandra Space Data Source and Space Synchronization Endpoint

GigaSpaces comes with built in implementations of [Space Data Source](./space-data-source-api.html) and [Space Synchronization Endpoint](./space-synchronization-endpoint-api.html) for Cassandra, called `CassandraSpaceDataSource` and `CassandraSpaceSynchronizationEndpoint`, respectively.

{% indent %}
![CassMirrorNew.jpg](/attachment_files/CassMirrorNew.jpg)
{% endindent %}

{% comment %}
For information about the two see: [Cassandra Space Data Source](./cassandra-space-data-source.html) and [Cassandra Space Synchronization Endpoint](./cassandra-space-synchronization-endpoint.html).
{% endcomment %}

For further details about the persistency APIs used see [Space Persistency](./space-persistency.html).

# Cassandra Space Data Source

{% include ./cassandra-space-data-source.markdown %}

# Cassandra Space Synchronization Endpoint

{% include ./cassandra-space-synchronization-endpoint.markdown %}
