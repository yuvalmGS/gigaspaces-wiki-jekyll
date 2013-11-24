---
layout: post
title:  Navigation
parent: plugin.html
weight: 400
categories: HOWTO
---


#### Anchor

{%panel%}

{% anchor gsm %}
[Grid Service Manager](#gsm)

[GSM](#gsm)

{%panel title=Markdown|bgColor=white%}

{%raw%}
{% anchor gsm %}
Grid Service Manager

The grid service manager

\[GSM](#gsm)

{%endraw%}
{% endpanel %}

{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}
{% endpanel %}


#### Children

{%panel%}

{%children%}

{%panel bgColor=white | title=Markdown %}

{%raw%}
{%children%}
{%endraw%}
{% endpanel %}
{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}
{% endpanel %}


#### Learn more

{%panel%}

{%learn%}http://docs.gigaspaces.com/xap97/space-url.html{%endlearn%}

{%panel bgColor=white | title=Markdown %}

{%raw%}
{%learn%}http://docs.gigaspaces.com/xap97/space-url.html{%endlearn%}
{%endraw%}
{% endpanel %}
{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}
{% endpanel %}



### Next

{%panel%}

 TODO

{%panel bgColor=white | title=Markdown %}

{%raw%}

{%next%}http://docs.gigaspaces.com/xap97/space-url.html{%endnext%}

{%endraw%}

{% endpanel %}

{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}

{% endpanel %}



#### Refer

{%panel%}

{%refer%}See [XAP 9.7](http://docs.gigaspaces.com/xap97/index.html){%endrefer%}

{%panel bgColor=white |title=Markdown %}
{%raw%}
{% refer %}See [XAP 9.7](http://docs.gigaspaces.com/xap97/index.html){%endrefer%}
{%endraw%}
{% endpanel %}
{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}
{% endpanel %}


#### Summary
Creates a summary section at the top of the page. The section will include the text in the markup help, and shortcut links to all h1 titles in the page (every title which is prefixed by a single # sign).

{%panel%}
{%summary%} This page describes ...{%endsummary%}

# Section 1

# Section 2

{%panel bgColor=white | title=Markdown %}
{%raw%}
{%summary%} This page describes ...{%endsummary%}
{%endraw%}
{% endpanel %}
{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}
{% endpanel %}


#### Table of Contents

{%panel%}

{% toczone minLevel=1|maxLevel=3|type=list|separator=pipe|location=top %}

 ### The Space Clustering Topology

 The space can have a single instance, in which case it runs on a single JVM, or multiple instances, in which case it can run on multiple JVMs.
 When it has multiple instances, the space can run in a number of [topologies](./space-topologies.html) which determine how the data is distributed across those JVMs. In general, the data can be either **replicated**, which means it resides on all of the JVMs in the cluster, or **partitioned**, which means that the data is distributed across all of the JVMs, each containing a different subset of it. With a partitioned topology you can also assign one or more backup space instances for each partition.

 ![topologies.jpg](/attachment_files/topologies.jpg)

 ### Master-Local Space

 Regardless of the space's topology, you can also define a "local cache" for space clients, which caches space entries recently used by the client, or a predefined subset of the central space's data (this is often referred to as **Continuous Query**).
 The data cached on the client side is kept up-to-date by the server, so whenever another space client changes a space entry that resides in a certain client's local cache, the space makes sure to update that client.

 ### The Replication Mode

{% endtoczone %}

{%panel bgColor=white | title=Markdown %}
{%raw%}

{% toczone minLevel=1|maxLevel=3|type=list|separator=pipe|location=top %}

 ### The Space Clustering Topology

 The space can have a single instance, in which case it runs on a single JVM, or multiple instances, in which case it can run on multiple JVMs.
 When it has multiple instances, the space can run in a number of [topologies](./space-topologies.html) which determine how the data is distributed across those JVMs. In general, the data can be either **replicated**, which means it resides on all of the JVMs in the cluster, or **partitioned**, which means that the data is distributed across all of the JVMs, each containing a different subset of it. With a partitioned topology you can also assign one or more backup space instances for each partition.

 ![topologies.jpg](/attachment_files/topologies.jpg)

 ### Master-Local Space

 Regardless of the space's topology, you can also define a "local cache" for space clients, which caches space entries recently used by the client, or a predefined subset of the central space's data (this is often referred to as **Continuous Query**).
 The data cached on the client side is kept up-to-date by the server, so whenever another space client changes a space entry that resides in a certain client's local cache, the space makes sure to update that client.

 ### The Replication Mode

{% endtoczone %}

{%endraw%}
{% endpanel %}
{%panel bgColor=white | title=Parameters%}
minLevel
maxLevel
type
separator
location
{% endpanel %}
{% endpanel %}



#### Try it out

{%panel%}

{%try%}https://github.com/Gigaspaces/xap-tutorial/tree/master/cassandra{%endtry%}

{%panel bgColor=white | title=Markdown %}
{%raw%}
{%try%}https://github.com/Gigaspaces/xap-tutorial/tree/master/cassandra{%endtry%}
{%endraw%}
{% endpanel %}
{%panel bgColor=white | title=Parameters%}
None
{% endpanel %}
{% endpanel %}
















# Section 1

# Section 2








