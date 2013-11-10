---
layout: post
title:  New Data Grid
page_id: 62717993
---

 {% compositionsetup %}{% summary page|60 %}A .......{% endsummary %}

# Overview

{% inittab 00|bottom %}
{% tabcontent Hello %}

{% inittab deck011|top %}
{% tabcontent Windows %}

{% highlight java %}
.\gs-agent.bat gsa.global.esm 1 gsa.gsc 2 gsa.global.lus 2 gsa.global.gsm 2
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Unix/Mac/Linux %}

{% highlight java %}
./gs-agent.sh gsa.global.esm 1 gsa.gsc 2 gsa.global.lus 2 gsa.global.gsm 2
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

{% endtabcontent %}

{% endinittab %}

GigaSpace's XAP can be used as a scalable application platform on which you can host your Java applications, similar to JEE and web containers. However, XAP's IMDG can also be used in standalone Java applications. The IMDG can be used in different scenarios; Embedded, Remote, Local/View and Task Execution. The following examples show how to use the GigaSpace IMDG with your application for the different scenarios.
In order to run these examples use the following installation instructions:

- Download the latest version of GigaSpace XAP from [here](http://www.gigaspaces.com/LatestProductVersion)
- Unzip the distribution into a working directory; GS_HOME
- Start your favorite Java IDE
- Create a new project
- Include all files from the GS_HOME/lib/required in the classpath
- Include GS_HOME/gs_license.xml in the classpath

# Concepts

................
.......

## Acquiring and Installing XAP

Acquiring XAP is simple: download an archive from the [Current Releases](http://www.gigaspaces.com/LatestProductVersion) page.
Installing XAP is just as easy - since it's just an archive, unzip it into a directory of your choice.
On Windows, for example, one might install it into `C:\tools\`, leading to an installation directory of `C:\tools\{{ site.latest_gshome_dirname }}`.

In a UNIX environment, you might install it into `/usr/local/`, which would result in a final installation directory of `/usr/local/{{ site.latest_gshome_dirname }}`.

You can also download the Java code for these examples [here ](https://github.com/croffler/Tutorials/tree/master/XAP%20Java%20Tutorial)

Throughout the tutorial we will use the following Class Model for the example code.
![ClassDiagram.png](/attachment_files/ClassDiagram.png)

{% note %}
Any POJO can be used to interact with the data grid. The POJO needs to implement a default constructor, setters and getters for every property you want to store in the Space and the @SpaceId attribute annotation needs to be added.
{% endnote %}

#Embedded Cache
An embedded cache runs within the application's memory address space. The space is accessed by reference without going through a network or involving serialization de-serialization calls.

{% indent %}
![embedded-space.jpg](/attachment_files/embedded-space.jpg)
{% endindent %}

####Example

#Remote Cache

{% indent %}
![remote-space.jpg](/attachment_files/remote-space.jpg)
{% endindent %}

# Client Side caching

GigaSpaces supports client side caching of space data within the client application's JVM. When using client-side caching, the user essentially uses a two-layer cache architecture: The first layer is stored locally, within the client's JVM, and the second layer is stored within the remote master space. The remote master space may be used with any of the supported deployment topologies. Client-side cache should be used when the application performs repetitive read operations on the same data. You should not use client-side caching when the data in the master is very frequently updated or when the read pattern of the client tends to be random (as opposed to repetitive or confined to a well-known data set).

There are two variations provided:
•Local Cache - This client side cache maintains any object used by the application. The cache data is loaded on demand (lazily), based on the client application's read activities.
•Local View - This client side cache maintains a specific subset of the entire data, and client side cache is populated when the client application is started.

# Local Cache

A Local Cache is a client side cache that maintains a subset of the master space's data based on the client application's recent activity. The local cache is created empty, and whenever the client application executes a query the local cache first tries to fulfill it from the cache, otherwise it executes it on the master space and caches the result locally for future queries.

#### When to use a local cache?

Use local cache in case you are not sure which information you need in the client cache and you want to read it in a dynamic manner. Therefore the local cache is more suitable for query by ID scenarios.

{% indent %}
![local_cache.jpg](/attachment_files/local_cache.jpg)
{% endindent %}

#### Example

Creating a local cache is similar to creating a GigaSpace, except that we wrap the space with a local cache before handing it to the GigaSpace. The local cache can be configured by using LocalCacheSpaceConfigurer. For exmaple:

{% highlight java %}
// Initialize remote space configurer:
UrlSpaceConfigurer urlConfigurer = new UrlSpaceConfigurer("jini://*/*/mySpace");
// Initialize local cache configurer
LocalCacheSpaceConfigurer localCacheConfigurer = new LocalCacheSpaceConfigurer(urlConfigurer);
// Create local cache:
GigaSpace localCache = new GigaSpaceConfigurer(localCacheConfigurer).gigaSpace();
{% endhighlight %}

# Local View

A Local View is a Client Side Cache that maintains a subset of the master space's data, allowing the client to read distributed data without performing any remote calls or data serialization.
Data is streamed into the client local view based on predefined criteria (a collection of SQLQuery objects) specified by the client when the local view is created.
During the local view initialization, data is loaded into the client's memory based on the view criteria. Afterwards, the local view is continuously updated by the master space asynchronously - any operation executed on the master space that affects an entry which matches the view criteria is automatically propagated to the client.

#### When to use a local view?

Use local view in case you can encapsulate the information you need to distribute in predefined query(ies). The local view is based on the replication mechanism and ensures your data synchronization and consistency with the remote space. The local view is read only.

{% indent %}
![local_view.jpg](/attachment_files/local_view.jpg)
{% endindent %}

#### Example

Creating a local view is similar to creating a GigaSpace instance, except the space should be wrapped with a local view before exposing it as a GigaSpace. The local view can be configured via Spring using LocalViewSpaceFactoryBean or the <os-core:local-view> Spring tag, or in code using LocalViewSpaceConfigurer. For exmaple:

{% highlight java %}
UrlSpaceConfigurer urlConfigurer = new UrlSpaceConfigurer("jini://*/*/mySpace");

// Create the view criteria for the local view
SQLQuery<PurchaseOrder> sqlQuery = new SQLQuery<PurchaseOrder>(
PurchaseOrder.class, "orderState = ?");
sqlQuery.setParameter(1, EPurchaseOrderState.PROCESSED);

LocalViewSpaceConfigurer localViewConfigurer = new LocalViewSpaceConfigurer(urlConfigurer).addViewQuery(sqlQuery);

// Create local view:
GigaSpace localView = new GigaSpaceConfigurer(localViewConfigurer).gigaSpace();
{% endhighlight %}

# Data Grid

The XAP data grid requires a number of components to be deployed and started successfully, such as the [lookup service](./the-lookup-service.html), the [grid service container](./the-grid-service-container.html) and the [grid service manager](./the-grid-service-manager.html). The simplest way to start all of these components is to fire up a [grid service agent](./the-grid-service-agent.html) on every machine you wish to run a data grid node on.
The agent is responsible for bootstrapping the GigaSpaces cluster environment implicitly, and starting all of the required components. All agents use a peer to peer communication between one another to ensure a successful cluster wide startup of all infrastructure components.

Once all agents have started, you can issue a few simple API calls from within your application code to bootstrap the data grid and interact with it, by using the [GigaSpaces Elastic Middleware](http://wiki.gigaspaces.com/wiki/display/XAP95/Elastic+Processing+Unit) capabilties.
These API calls will provision a data grid on the GigaSpaces cluster based on the capacity and other SLA requirements specified in the API calls.

The following example shows how to run the GigaSpaces Data Grid within your application.

#### Running the GigaSpaces XAP Data Grid

A GigaSpaces node is best facilitated through the use of a service called the "[Grid Service Agent](http://wiki.gigaspaces.com/wiki/display/XAP95/The+Grid Service+Agent
)", or GSA.
The simplest way to start a node with GigaSpaces is to invoke the GSA from the GigaSpaces bin directory, preferably in its own command shell (although you can easily start a background process with `start` or `nohup` if desired):

{% inittab deck01|top %}
{% tabcontent Windows %}

{% highlight java %}
.\gs-agent.bat gsa.global.esm 1 gsa.gsc 2 gsa.global.lus 2 gsa.global.gsm 2
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Unix/Mac/Linux %}

{% highlight java %}
./gs-agent.sh gsa.global.esm 1 gsa.gsc 2 gsa.global.lus 2 gsa.global.gsm 2
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

#### Connecting to a Data Grid

In order to create a data grid, you need to first deploy it onto the GigaSpaces cluster. It's actually fairly easy to write some code that can connect to an existing data grid, or deploy a new one if the datagrid doesn't exist.

First, make sure your application's classpath includes the includes the [GigaSpaces runtime libraries](Setting classpath). In short, include all jars under `<XAP installation root>/lib/required` in your classpath. Then, connect to the datagrid. In the GigaSpace lingo, a data grid is called a _Space_, and a data grid node is called a _Space Instance_. The space is hosted within a _Processing Unit_, which is the GigaSpaces unit of deployment. The following snippets shows how to connect to an existing data grid or deploy a new one if such does not exist.

Creating and deploying an Elastic Data Grid

{% highlight java %}

try {
//create an admin instance to interact with the cluster
Admin admin = new AdminFactory().createAdmin();

//locate a grid service manager and deploy a partioned data grid with 2 primaries and one backup for each primary
GridServiceManager esm = admin.getGridServiceManagers().waitForAtLeastOne();
ProcessingUnit pu = esm.deploy(new SpaceDeployment(spaceName).partitioned(2, 1));
} catch (ProcessingUnitAlreadyDeployedException e) {
//already deployed, do nothing
}

//Once your data grid has been deployed, wait for 4 instances (2 primaries and 2 backups)
pu.waitFor(4, 30, TimeUnit.SECONDS);

//and finally, obtain a reference to it
GigaSpace gigaSpace = pu.waitForSpace().getGigaSpace();
{% endhighlight %}

You can also use a simple helper utility (DataGridConnectionUtility) that combines the two. It first look for a DataGrid instance and if one doesn't exist it will create a new one; it's trivial to alter the `getSpace()` method to increase the number of nodes or even scale dynamically as required. Read [this](./elastic-processing-unit.html) for more detailed information on how elastic scaling works.

{% tip %}
A The DataGridConnectionUtility class [is available on Github](https://github.com/Gigaspaces/bestpractices/blob/master/plains/src/main/java/org/openspaces/plains/datagrid/DataGridConnectionUtility.java), in the "plains" project.
{% endtip %}

With this class in the classpath, getting a datagrid reference is as simple as:

{% highlight java %}
GigaSpace space=DataGridConnectionUtility.getSpace("myGrid");
{% endhighlight %}

# Interacting with the Space

Once you've obtained a reference to the data grid, it's time to write some data to it.
You can write any POJO to the data grid, so long as it has a default constructor and a getter and setter for every property you want to store in the space. Here's an example for a simple POJO:

{% highlight java %}

import com.gigaspaces.annotation.pojo.SpaceClass;
import com.gigaspaces.annotation.pojo.SpaceId;

@SpaceClass
public class PurchaseOrder {

private UUID id;

private String number;

private BigDecimal totalCost;

private Date orderDate;

private Date shipDate;

public PurchaseOrder() {
}

@SpaceId
public UUID getId() {
return id;
}

public void setId(UUID id) {
this.id = id;
}

public String getNumber() {
return number;
}

public void setNumber(String number) {
this.number = number;
}
//
{% endhighlight %}

And now you can write and read objects from the space:

{% highlight java %}

gigaSpace.write(new Person(1, "Vincent", "Chase"));
gigaSpace.write(new Person(2, "Johny", "Drama"));
...
//read by ID
Person vince = gigaSpace.readById(Person.class, 1);

//read with SQL query
Person johny = gigaSpace.read(new SQLQuery(Person.class, "firstName=?", "Johny");

//readMultiple with template
Person[] vinceAndJohny = gigaSpace.readMultiple(new Person());
{% endhighlight %}

That's it, you're good to go!

