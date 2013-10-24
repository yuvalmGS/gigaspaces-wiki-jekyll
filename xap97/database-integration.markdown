---
layout: xap97
title:  Database Integration
page_id: 61867029
---

{% summary %}This section describes Database Integration in SBA{% endsummary %}

# Overview

One of the first concerns people have when encountering space-based architecture is that the role of the database seems to be diminished. That makes sense. In SBA, the role of the database is different than in typical tier-based architecture - where the database is considered the only system of record and is more important than all of the other moving parts.

The location of the data should be considered, based on its life-span. For example, transaction state, which is only valid for a short itme, should not be stored in a database to achieve fault-tolerance. In SBA, this type of information is stored in memory, and the space provides fault-tolerance capabilities.

In space-based architectures, databases should be used to store information that has a much longer life cycle, i.e., data that doesn't change rapidly. As a general rule, information that is accessed and changed often is stored in the space - and thus, in memory - and data that's become static in some way, is stored in a traditional relational database, where reporting engines and other tabular access mechanisms can access it.

A database has an additional role in SBA, when there is a need to extend memory to physical storage.

SBA does not deny the use of a database, but suggests a more natural role for it. For this reason, integration with the database is core to GigaSpaces XAP.

# Types of Database Integration

### Reliable Asynchronous Persistence

In a high performance transactional system, we would like the transaction to be bound to space resources only, and the update of the backing database be done after the transaction is complete, asynchronous to the transaction. The synchronization between the in-memory system of record and the database, should be reliable as well.

GigaSpaces XAP provides a Mirror Service as a means to achieve [reliable asynchronous persistency](./asynchronous-persistency-with-the-mirror.html).

The typical cluster topology is of reliable partitioning (partitions with backups) connected to the mirror service, which persists to the database.

The mirroring service is one-way only - from the space cluster to the database or other data source.

### Data Source Integration

GigaSpaces XAP provides two extension points (`SpaceDataSource`/`SpaceSynchronizationEndpoint` to data source integration. GigaSpaces provides a built-in [Hibernate](./hibernate-space-persistency.html) implementation of these extensions. For implementation details please refer to [Space Persistency APIs Implementation ](./space-persistency.html) in the Programmer's Guide.

These extension points are used by the space to store and retrieve data from data sources (e.g. databases).

{% tip title=About Memory Volatility %}
One of the common questions when it comes to memory as a critical system of record, is its volatility. There is no doubt that in-memory storage is much faster than disk storage, however, how can we guarantee information completeness if the data is stored in memory?
In order to preserve data, it is common topology to make sure that each memory copy has a replica. In addition it is important to put both replicas on different hardware, in order to eliminate single points of failures. If for some reason a single copy is not enough, we create as many copies as we need.
{% endtip %}

{% whr %}
{% refer %}**Next chapter:** [Product Architecture](./product-architecture.html){% endrefer %}
