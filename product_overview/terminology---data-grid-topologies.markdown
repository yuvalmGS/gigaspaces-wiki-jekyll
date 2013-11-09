---
layout: post
title:  Terminology - Data Grid Topologies
page_id: 61867088
---

{% summary page|65 %}GigaSpaces Data-Grid components {% endsummary %}

|[Basic Components](./terminology---basic-components.html)|Data Grid Topologies|[Space-Based Architecture](./terminology---space-based-architecture.html)|[Runtime Components](./terminology---runtime-components.html)|

# Data Grid

{% comment %}
=========================================

         Data Grid

=========================================
{% endcomment %}

{% comment %}
----------------------------
          Data Grid
----------------------------
{% endcomment %}

{% anchor Data Grid %}

{% section %}
{% column width=50% %}

#### In Memory Data Grid - IMDG, or Enterprise Data Grid - EDG

A set of space instances, typically running within their respective processing unit instances.
The space instances are connected to each other to form a space cluster.
The relations between the spaces define the [Data Grid Topology](#Data Grid Topology).

{% sub %}Key Sentence: A set of connected space instances holding objects form a space cluster{% endsub %}

{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_populated_data_grid.gif](/attachment_files/term_populated_data_grid.gif)

{% sub %}**A Data Grid with 3 Instances**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% anchor Data Grid Topology %}

# Data Grid Topologies

{% comment %}
----------------------------
          Primary Backup Data Grid
----------------------------
{% endcomment %}

{% anchor Primary Backup Data Grid %}

{% section %}
{% column width=50% %}

#### Primary Backup Data Grid

A Data Grid with a primary instance and one or more backup instances.
Destructive operations (write, update and take) are applied to the primary instance, and are replicated to the backup instance either synchronously or asynchronously.

{% sub %}Key Sentence: Objects in primary instance are replicated to its backup instance/s{% endsub %}

{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_primary_backup_text_data_grid.gif](/attachment_files/term_primary_backup_text_data_grid.gif)

{% sub %}**A Data Grid comprised of a primary instance with one backup instance**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
----------------------------
          Partitioned Data Grid
----------------------------
{% endcomment %}

{% anchor Partitioned Data Grid %}

{% section %}
{% column width=50% %}

#### Partitioned Data Grid

Each Data Grid instance (partition) holds a different subset of the objects in the Data Grid.
When the objects are written to this Data Grid, they are routed to the proper partition, according to a predefined attribute in the object that acts as the [routing](#Routing) index.

{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_partitioned_data_grid.gif](/attachment_files/term_partitioned_data_grid.gif)

{% sub %}**A Partitioned Data Grid with 3 Instances, each holding a different set objects**{% endsub %}

{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
----------------------------
          Routing
----------------------------
{% endcomment %}

{% anchor Routing %}

{% section %}
{% column width=50% %}

#### Routing

The mechanism that is in charge of routing the objects into and out of the corresponding partitions.
The routing is based on a designated attribute inside the objects that are written to the space, and is termed _Routing Index_.

{% sub %}Key sentence: Routing the mechanism that determines how object will be partitioned.{% endsub %}

{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_routing.gif](/attachment_files/term_routing.gif)

{% sub %}**Routing in a partitioned Data Grid with 3 instances**{% endsub %}

{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
--------------------------------------------------
          Primary Backup Partitioned Data Grid
--------------------------------------------------
{% endcomment %}

{% anchor Primary Backup Partitioned Data Grid %}

{% section %}
{% column width=50% %}

#### Primary Backup Partitioned Data Grid

A [partitioned Data Grid](#Partitioned Data Grid), with one or more [backup](#Primary Backup Data Grid) instances for each partition. Each of the Data Grid instances (partitions) holds a different subset of the objects in the Data Grid, and replicates this subset to its backup instance/s.

{% endcolumn %}

{% column width=30% %}
{% align center %}

![term_partitioned_primary_backup_data_grid.gif](/attachment_files/term_partitioned_primary_backup_data_grid.gif)

{% sub %}**A Primary Backup Partitioned Data Grid: 2 partitions, each replicates to one backup instance**{% endsub %}

{% endalign %}

{% endcolumn %}

{% endsection %}

{% tip %}
For details about scaling a running space cluster **in runtime** see the [Elastic Processing Unit]({%latestjavaurl%}/elastic-processing-unit.html) section.
{% endtip %}

|[Basic Components](./terminology---basic-components.html)|Data Grid Topologies|[Space-Based Architecture](./terminology---space-based-architecture.html)|[Runtime Components](./terminology---runtime-components.html)|
