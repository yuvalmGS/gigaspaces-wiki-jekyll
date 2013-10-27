---
layout: xap97net
title:  Terminology - Data Grid Topologies
categories: XAP97NET
page_id: 63799407
---

**Summary** - GigaSpaces components from a functional perspective.
|[Basic Components|Terminology - Basic Components]||Data Grid Topologies|[Space-Based Architecture|Terminology - Space-Based Architecture]|[Runtime Components|Terminology - Runtime Components]|

# Data Grid

{comment}=========================================

         Data Grid

========================================={comment}
{comment}----------------------------
          Data Grid
----------------------------{comment}
{% anchor Data Grid %}
{section}

{% column width=50% %}

#### In Memory Data Grid (IMDG) or Enterprise Data Grid (EDG)

A set of space instances, typically running within their respective processing unit instances.
The space instances are connected to each other to form a space cluster.
The relations between the spaces define the [Data Grid Topology|#Data Grid Topology].

~Key Sentence: A set of connected space instances holding objects form a space cluster~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_populated_data_grid.gif!

~**A Data Grid with 3 Instances**~
{% endalign %}

{% endcolumn %}

{section}
{% anchor Data Grid Topology %}

# Data Grid Topologies

{comment}----------------------------
          Primary Backup Data Grid
----------------------------{comment}
{% anchor Primary Backup Data Grid %}
{section}

{% column width=50% %}

#### Primary Backup Data Grid

A Data Grid with a primary instance and one or more backup instances.
Operations that do not modify any data (e.g. read, count) are performed only on the primary instance. Operations that modify data, sometimes called destructive operations (e.g. write, take) are performed on the primary instance and are are replicated to the backup instance either synchronously or asynchronously.

~Key Sentence: Objects in primary instance are replicated to its backup instance/s~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_primary_backup_text_data_grid.gif!

~**A Data Grid comprised of a primary instance with one backup instance**~
{% endalign %}

{% endcolumn %}

{section}
{comment}----------------------------
          Partitioned Data Grid
----------------------------{comment}
{% anchor Partitioned Data Grid %}
{section}

{% column width=50% %}

#### Partitioned Data Grid

When the Data Grid needs to hold large amounts of data, it is possible to partition the data across multiple instances.
Each Data Grid instance (partition) holds a different subset of the objects in the Data Grid.
When the objects are written to this Data Grid, they are routed to the proper partition, according to a predefined property in the object that acts as the [routing|#Routing] index.

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_partitioned_data_grid.gif!

~**A Partitioned Data Grid with 3 Instances, each holding a different set objects**~

{% endalign %}

{% endcolumn %}

{section}
{comment}----------------------------
          Routing
----------------------------{comment}
{% anchor Routing %}
{section}

{% column width=50% %}

#### Routing

The mechanism that is in charge of routing the objects into and out of the corresponding partitions.
The routing is based on a designated property/field inside the objects that are written to the space, and is termed _Routing Index_ or _Routing Property_.

~Key sentence: Routing the mechanism that determines how object will be partitioned.~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_routing.gif!

~**Routing in a partitioned Data Grid with 3 instances**~

{% endalign %}

{% endcolumn %}

{section}
{comment}--------------------------------------------------
          Primary Backup Partitioned Data Grid
--------------------------------------------------{comment}
{% anchor Primary Backup Partitioned Data Grid %}
{section}

{% column width=50% %}

#### Primary Backup Partitioned Data Grid

A [partitioned Data Grid|#Partitioned Data Grid], with one or more [backup|#Primary Backup Data Grid] instances for each partition. Each of the Data Grid instances (partitions) holds a different subset of the objects in the Data Grid, and replicates this subset to its backup instance/s.

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_partitioned_primary_backup_data_grid.gif!

~**A Primary Backup Partitioned Data Grid: 2 partitions, each replicates to one backup instance**~

{% endalign %}

{% endcolumn %}

{section}


|[Basic Components|Terminology - Basic Components]||Data Grid Topologies|[Space-Based Architecture|Terminology - Space-Based Architecture]|[Runtime Components|Terminology - Runtime Components]|