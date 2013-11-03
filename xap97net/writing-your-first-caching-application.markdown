---
layout: xap97net
title:  Writing Your First Caching Application
categories: XAP97NET
page_id: 63799409
---

{% compositionsetup %}

{% summary %}This tutorial shows how an application interacts with a GigaSpaces Data Grid, clustered in either a replicated, partitioned, master-local, or local-view topology. The application either actively reads data or registers for notifications.
{% endsummary %}

{% anchor 1 %}

# Overview

Different applications might have different caching requirements. Some applications require on-demand loading from a remote cache, due to limited memory; others use the cache for read-mostly purposes; transactional applications need a cache that handles both write and read operations and maintains consistency.

In order to address these different requirements, GigaSpaces provides an In-Memory Data Grid that is policy-driven. Most of the policies do not affect the actual application code, but rather affect the way each Data Grid instance interacts with other instances. The policies allow the Data Grid to be configured in almost any topology; most common topologies are predefined in the GigaSpaces product and do not require editing policies.

In this tutorial, you will use GigaSpaces to implement a simple application that writes and retrieves user accounts from the GigaSpaces In-Memory Data Grid, clustered in the most common topologies - replicated, partitioned, master-local and local-view. The application will either actively read data or ask to be notified when data is written to or modified in the Data Grid.

## GigaSpaces Data Grid - Basic Terms

- **Data Grid instance** - an independent data storage unit, also called a cache. The Data Grid is comprised of all the Data Grid instances running on the network. depanimageDGA-DataGrid.jpgtengahimage/attachment_files/xap97net/DGA-DataGrid.jpgbelakangimage
- **Space** - a distributed, shared, memory-based repository for objects. A space runs in a _space container_ - this is usually transparent to the developer. In GigaSpaces each Data Grid instance is implemented as a space, and the Data Grid is implemented as a cluster of spaces organized in one of several predefined topologies. depanimageDGA-GigaSpacesDataGrid.jpgtengahimage/attachment_files/xap97net/DGA-GigaSpacesDataGrid.jpgbelakangimage
- **Grid Service Container** - a generic container that can run one or more space instances (together with their space containers) and other services. This container is launched on each machine that participates in the Data Grid, and hosts the Data Grid instances. depanimageDGA-ServiceGridDataGrid.jpgtengahimage/attachment_files/xap97net/DGA-ServiceGridDataGrid.jpgbelakangimage
- **Replication** - a relationship in which data is copied between two or more Data Grid instances, with the aim of having the same data in some or all of them. depanimageDGA-Replication2.jpgtengahimage/attachment_files/xap97net/DGA-Replication2.jpgbelakangimage
- **Syncronous replication** - replication in which applications using the Data Grid are blocked until their changes are propagated to all Data Grid instances. This guarantees that everyone sees the same data, but reduces performance.

- **Asyncronous replication** - replication in which changes are propagated to Data Grid instances in the background; applications do not have to wait for their changes to be propagated. Asynchronous replication does not negatively effect performance, but on the other hand, changes are not instantly available to everyone.

- **Partitioning** - new data or operations on data are routed to one of several Data Grid instances (partitions). Each Data Grid instance holds a subset of the data, with no overlap. Partitioning is done according to an _index field_ in the data - operations are routed to partitions based on the value of this field. depanimageDGA-Partitioning2.jpgtengahimage/attachment_files/xap97net/DGA-Partitioning2.jpgbelakangimage
- **Topology** - a specific configuration of Data Grid instances. For example, a replicated topology is a configuration in which some or all Data Grid instances replicate data between them. In GigaSpaces, Data Grid topologies are defined by _cluster policies_ (explained in the following section).

- **Reading** - one way to retrieve data from the Data Grid, which will be used in this tutorial, is to call the space _read_ operation, supplying a _read template_ object which specifies what needs to be read.

- **Notifications** - GigaSpaces allows applications to be notified when changes are made to objects in the Data Grid. Applications register in advance to be notified about specific events. When these events occur, a notification is triggered on the application, which delivers the actual data that triggered the event.

## GigaSpaces Clustering Concepts

In GigaSpaces, a _cluster_ is a grouping of several spaces running in one or more containers. For an application trying to access data, the cluster appears as one space, but in fact consists of several spaces which may be distributed across several physical machines. The spaces in the cluster are also called _cluster members_.

A **_cluster group_** is a logical collection of cluster members, which defines how these members interact. The only way to define relationships between clustered spaces in GigaSpaces, is to add them to a group and define policies. A cluster can contain several, possibly overlapping groups, each of which defines some relations between some cluster members - this provides much flexibility in cluster configuration.

A GigaSpaces cluster group can have one or more of the following policies:
- **Replication Policy** - defines replication between two or more spaces in the cluster, and replication options such as synchronous/asynchronous and replication direction.
- **Load Balancing Policy** - because user requests are submitted to the entire cluster, there is a need to distribute the requests between cluster members. The load balancing policy defines an algorithm according to which requests are routed to different members. For example, in a replicated topology, requests are divided evenly between cluster members; in a partitioned topology they are routed according to the partitioning key.
- **Failover Policy** - defines what happens when a cluster member fails. Operations on the cluster member can be transparently routed to another member in the group, or to another cluster group.

A **_cluster schema_** defines the cluster schema type. GigaSpaces provides predefined cluster schemas for all common cluster topologies. Each topology is a certain combination of replication, load balancing and failover policies.

## Data Grid Topologies Shown in this Tutorial

|| Topology and Description || Common Use || Options ||
| **Replicated** ([view diagram|dg_a_topology2a.gif])
 Two or more space instances with replication between them. | Allowing two or more applications to work with their own dedicated data store, while working on the same data as the other applications. | * Replication can be synchronous (slower but guarantees consistency) or asynchronous (fast but less reliable, as it does not guarantee identical content).
- Space instances can run within the application (embedded - allows faster read access) or as a separate process (remote - allows multiple applications to use the space, easier management).
- **In this tutorial:** two remote spaces, synchronous replication. |
| **Partitioned** ([view diagram|dg_a_topology3.gif])
 Data and operations are split between two spaces (partitions) according to an index field defined in the data. An algorithm, defined in the Load-Balancing Policy, maps values of the index field to specific partitions. | Allows the In-Memory Data Grid to hold a large volume of data, even if it is larger than the memory of a single machine, by splitting the data into several partitions. | * Several routing algorithms to chose from.
- With/without backup space for each partition.
- **In this tutorial:** Two spaces, hash-based routing, with backup. |
| **Master-Local** ([view diagram|dg_a_topology4.gif])
 Each application has a lightweight, embedded cache, which is initially empty. The first time data is read, it is loaded from a master cache to the local cache (lazy load); the next time the same data is read, it is loaded quickly from the local cache. Later on data is either updated from the master or evicted from the cache.     | Boosting read performance for frequently used data. A useful rule of thumb is to use a local cache when over 80% of all operations are read operations. | * The master cache can be clustered in any of the other topologies: replicated, partitioned, etc.
- **In this tutorial:** The master cache comprises two spaces in a partitioned topology. |
| **Local-View** ([view diagram|dg_a_topology5.gif])
 Similar to master-local, except that data is pushed to the local cache. The application defines a filter, using a spaces _read template_ or an SQL query, and data matching the filter is streamed to the cache from the master cache. | Achieving maximal read performance for a predetermined subset of data. | * The master cache can be clustered in any of the other topologies: replicated, partitioned, etc.
- **In this tutorial:** The master cache comprises two spaces in a partitioned topology. |

The cluster schema supported are:
- Synchronous replication - sync_replicated
- A-Synchronous replication - async_replicated
- Partitioned with backup - partitioned-sync2backup


{% tip %}
The master-local and local-view topologies do not need their own schemas, because the local cache is defined on the client side.
{% endtip %}


{% anchor 2 %}

# Deploying the Data Grid

Now that you have a little background about the GigaSpaces Data Grid and the topologies used in this tutorial, the first step is to deploy the Data Grid.

To deploy the Data Grid instances, you will run a GigaSpaces Agent (a "GSA"), which starts a lookup service ("LUS"), a management service ("GSM"), and two generic container instances ("GSCs") by default. In real deployment environments, physical machines will normally run a subset of these services; for example, most physical participants in a cluster will run a single GSC through the agent but not a GSM or LUS.

// depanimagenet-gsagent-startmenu.giftengahimage/attachment_files/xap97net/net-gsagent-startmenu.gifbelakangimage

To start the GS-Agent, open the Windows start menu, and navigate to the GigaSpaces XAP .NET submenu. In it, you will find another set of submenus associated with .Net 2.0 and .Net 4.0. Within one of those, select the GigaSpaces Agent menu item and run it; this will open up a shell window and execute the GSA, which itself will start up a number of other services.

Next, start up the GigaSpaces Management Center, from the same menu. This is an application that allows deployment and monitoring for XAP deployments.

{% anchor deploying %}

**To deploy the Data Grid:**

1. Inside the Management Center, on the toolbar at the top, click the **Launch Data Grid** ( depanimagedg_a_icon1-6.5rc2.jpgtengahimage/attachment_files/xap97net/dg_a_icon1-6.5rc2.jpgbelakangimage) button. This is how you deploy a data grid.

 depanimagedeploy_button-6.5rc2.jpgtengahimage/attachment_files/xap97net/deploy_button-6.5rc2.jpgbelakangimage

The following page showing the Data Grid attribute fields is displayed:

 depanimageDeployment_Wizard_EDG_set-myDataGrid-6.5rc2.jpgtengahimage/attachment_files/xap97net/Deployment_Wizard_EDG_set-myDataGrid-6.5rc2.jpgbelakangimage

1. In the **Data Grid Name** field, type the name `myDataGrid` as shown above. This name represents the Data Grid you are deploying in the Management Center. This name will be given to all spaces in the cluster. Remember this space name - you will use it when running the client application and connecting to the Data Grid.
2. In the **Space Schema** field, leave the space schema as **default**. This field allows you to specify whether the space instances in the cluster should be persistent (data automatically persisted to a database) or not. You will not use persistency in this tutorial.
3. In this page of the wizard you will define the Data Grid topology by filling the **Cluster Info** area, do one of the following:
    - **If you want to deploy the Data Grid in a _replicated topology_**, From the **Cluster schema** drop-down menu, select the **sync_replicated* option. This option uses the `sync_replicated`, which has synchronous replication between all cluster members. This option refers to a single space or a cluster of spaces (in one of several common topologies) with no backup.
        - Select the number of spaces (Data Grid instances) in your replicated cluster. Deploy a cluster with 2 spaces, by typing the number `2` into **Number of Instances** field.
The following shows the settings for the replicated topology:

 depanimageDeployment_Wizard_EDG_set-myDataGrid-2-Syncreplicated-6.5rc2.jpgtengahimage/attachment_files/xap97net/Deployment_Wizard_EDG_set-myDataGrid-2-Syncreplicated-6.5rc2.jpgbelakangimage

    - **If you want one of the other topologies,** **_partitioned, master-local or local-view_**, from the **Cluster schema** drop-down menu, select the **partitioned** option. This option refers to a single space with a backup, or a partitioned cluster of spaces with backups.
        - You need to select the number of partitions. Specify two partitions by typing `2` into the **Number of Instances** field. This option uses the `partitioned`. Specify one backup for each partition, by typing `1` into the **Number of backups** field. When using the partitioned cluster with backups the cluster schema used is the `partitioned-sync2backup`.
The following shows the settings for the partitioned (with backup) topology:

 depanimageDeployment_Wizard_EDG_set-myDataGrid-2-1-Partitioned-6.5rc2.jpgtengahimage/attachment_files/xap97net/Deployment_Wizard_EDG_set-myDataGrid-2-1-Partitioned-6.5rc2.jpgbelakangimage

    - For both topologies you need to **select a Grid Service Manager (GSM) for deployment** from the table placed in the bottom area of the page.
The table might include more than one Grid Service Manager. If so, look for the specific manager you launched - you can find it according to the **Machine** field (look for the machine on which you ran the Grid Service Manager). Click your Grid Service Manager to select it.

 depanimageDeployment_Wizard_EDG_cut-GSM_Select.jpgtengahimage/attachment_files/xap97net/Deployment_Wizard_EDG_cut-GSM_Select.jpgbelakangimage

4. Click **Deploy** to deploy the cluster. Deployment status is displayed (Here for the two replicated Data Grid instances):

 depanimageDeployment_Wizard_EDG_InProcess-myDataGrid-2-SyncRep.jpgtengahimage/attachment_files/xap97net/Deployment_Wizard_EDG_InProcess-myDataGrid-2-SyncRep.jpgbelakangimage
 {% infosign %} In the master-local and local-view topologies, the master cache can in principle be clustered in any topology - partitioned, replicated, etc. (or can be a single space). The master-local/local-view aspect of the topology is specified on the client side: when the client connects to the cluster or space (the master cache), it specifies if it wants to start a local cache and how this cache should operate.

 depanimageDeployment_Wizard_EDG_Provisioned-myDataGrid-2-SyncRep.jpgtengahimage/attachment_files/xap97net/Deployment_Wizard_EDG_Provisioned-myDataGrid-2-SyncRep.jpgbelakangimage

Depending on the type of deployment you performed, you should see that either two spaces (two replicated Data Grid instances) or four spaces (two Data Grid partitions with one backup each) were provisioned to the host running the Grid Service Containers.
5. **If this is not the first topology** you are deploying, and you are already familiar with the client application, skip to depanlinkRunning Client, Testing Notifications and Verifying Topologiestengahlink#runningbelakanglink.

{% infosign %} You deployed the the Data Grid using the Management Center and its Deployment Wizard. An alternative way deploying a single space instance can be done by using the `SpaceInstance` command.

{% anchor 3 %}

# The Client Application

In this tutorial, we provide a sample application that consists of the following components:
- **A Data Loader** that writes data to the Data Grid.
- **A Simple Reader** that reads data directly from the Data Grid (using spaces _read_).
- **A Notified Reader** that registers for notifications on the Data Grid and is notified when data is written by the Data Loader.
You can run one or more reader of either or both types.
- **An `Account` object**, defined as a .Net PONO , which represents the data in the Data Grid. It has the following fields: `userName`, `accountID` and `balance`.

## Getting Source Code and Full Client Package

**The source code** of all three components, and the scripts used to run them, remains the same for all Data Grid topologies described above. To view the source code, use the links below:
- Full source code for Data Loader: [DataLoader.cs|EX:Data Grid A .NET - Basic Topologies - DataLoader.cs]
- Full source code for Simple Reader: [SimpleReader.cs|EX:Data Grid A .NET - Basic Topologies - SimpleReader.cs]
- Full source code for Notified Reader: [NotifiedReader.cs|EX:Data Grid A .NET - Basic Topologies - NotifiedReader.cs]
- Full source code for the `Account` object: [Account.cs|EX:Data Grid A .NET - Basic Topologies - Account.cs]

**The full .NET client package** can be found at the following path: `<GigaSpaces Root>\NET vX\examples\DataGrid\`.

## Client Operating Process (In Brief)

1. When you run the Data Loader, it:
    - Connects to the Data Grid and clears it from all data.

    - Creates a new `Account` object, with a certain `userName` and `accountID`. The Account also has a `Balance` field, which is obtained by calculating `AccountID*10`.
    - Writes 100 `Account` instances with IDs 1 through 100 to the Data Grid, using a write operation.
1. When you run a Simple Reader, it reads all the `Account` instances in the Data Grid, then reads them again every few seconds, until you close it.
2. When you run a Notified Reader, it registers for notification on the `Account` class, and starts listening for notifications. When `Account` objects are written to the Data Grid, the Notified Reader immediately receives notifications from the Data Grid. The notifications include the `Account` objects themselves.
3. If you run more 'Simple Readers' or 'Notified Readers', they repeat step 2 or 3 above, respectively.

## How the Client Application Connects to the Data Grid

The application connects to the space using the GigaSpaces `GigaSpacesFactory.FindSpace(spaceUrl)` method. This is a method that accepts a _space URL_, discovers the space, and returns a proxy that allows the application to work with the space. The URL is usually not defined in the client application itself, but is supplied to it as an argument when it is started.

In this tutorial, we will use a space connection URL similar to the following:

    jini://*/*/myDataGrid

- This URL uses the Jini protocol, which enables dynamic discovery of the space (the client does not need to know which machines are participating in the Data Grid).
- `\*/\*/myDataGrid` specifies that the client wants to connect to a cluster in which all the spaces are called `myDataGrid`, regardless of which physical machines participate in the cluster.
- **`useLocalCache`** is an additional parameter, not shown above, which launches a local cache in the connecting application. This is necessary for the master-local and local-view topologies.

{% infosign %} The URL above is used by the application to **connect** to the space (a cluster of spaces in this case), so it is called a _space connection URL_. This should not be confused with a _space start URL_, a similar form of URL which can be used to **start** a space. In this tutorial, you will not use a space start URL, rather you will start the spaces using the GS-UI, as described below.

{% anchor notif %}
