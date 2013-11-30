---
layout: post
title:  Your First Data Grid Application
categories: TUTORIAL
weight: 200
parent: xap-tutorials.html
---


{% summary page %}This page explains how to start and use a XAP [Data Grid]({%latestjavaurl%}/the-in-memory-data-grid.html) from within another Java process, catering to quick and self-sufficient embedding of XAP within another, external application.{% endsummary %}

GigaSpaces XAP can be used as a scalable application platforom on which you can host your Java application, similar to JEE and web containers. However, GigaSpaces XAP's in memory data grid can also be embedded within another Java application which is not hosted within the XAP platform. This section describes the steps required to start and access the XAP data grid from within external Java processes.

# General Description

The XAP data grid requires a number of components to be deployed and started successfully, such as the [lookup service]({%latestjavaurl%}/the-lookup-service.html), the [grid service container]({%latestjavaurl%}/service-grid.html#gsc) and the [grid service manager]({%latestjavaurl%}/service-grid.html#gsm). The simplest way to start all of these components is to fire up a [grid service agent]({%latestjavaurl%}/service-grid.html#gsa) on every machine you wish to run a data grid node on.
The agent is responsible for bootstrapping the GigaSpaces cluster environment implicitly, and starting all of the required components. All agents use a peer to peer communication between one another to ensure a successful cluster wide startup of all infrastructure components.


![POJO_write.jpg](/attachment_files/POJO_write.jpg)
![POJO_write.jpg](/attachment_files/POJO_read.jpg)



Once all agents have started, you can issue a few simple API calls from within your application code to bootstrap the data grid and interact with it, by using the [GigaSpaces Elastic Middleware]({%latestjavaurl%}/elastic-processing-unit.html) capabilties.
These API calls will provision a data grid on the GigaSpaces cluster based on the capacity and other SLA requirements specified in the API calls.

The following example shows how to run the GigaSpaces Data Grid within your application.

# Running the GigaSpaces XAP Data Grid

## Acquiring and Installing XAP

Acquiring XAP is simple: download an archive from the [Current Releases](http://www.gigaspaces.com/LatestProductVersion) page.
Installing XAP is just as easy - since it's just an archive, unzip it into a directory of your choice.
On Windows, for example, one might install it into `C:\tools\`, leading to an installation directory of `C:\tools\{{ site.latest_gshome_dirname }}`.

In a UNIX environment, you might install it into `/usr/local/`, which would result in a final installation directory of `/usr/local/{{ site.latest_gshome_dirname }}`.

## Running the GigaSpaces Agent

A GigaSpaces node is best facilitated through the use of a service called the "[Grid Service Agent]({%latestjavaurl%}/service-grid.html#gsa)", or GSA.
The simplest way to start a node with GigaSpaces is to invoke the GSA from the GigaSpaces bin directory, preferably in its own command shell (although you can easily start a background process with `start` or `nohup` if desired):

{% highlight java %}
.\gs-agent.bat gsa.global.esm 1 gsa.gsc 2 gsa.global.lus 2 gsa.global.gsm 2
{% endhighlight %}

{% highlight java %}
./gs-agent.sh gsa.global.esm 1 gsa.gsc 2 gsa.global.lus 2 gsa.global.gsm 2
{% endhighlight %}

## Connecting to a Data Grid

In order to create a data grid, you need to first deploy it onto the GigaSpaces cluster. It's actually fairly easy to write some code that can connect to an existing data grid, or deploy a new one if the datagrid doesn't exist.

First, make sure your application's classpath includes the includes the [GigaSpaces runtime libraries]({%latestjavaurl%}/setting-classpath.html). In short, include all jars under `<XAP installation root>/lib/required` in your classpath. Then, connect to the datagrid. In the GigaSpace lingo, a data grid is called a _Space_, and a data grid node is called a _Space Instance_. The space is hosted within a _Processing Unit_, which is the GigaSpaces unit of deployment. The following snippets shows how to connect to an existing data grid or deploy a new one if such does not exist.

Creating and deploying an Elastic Data Grid

{% highlight java %}
try {
    //create an admin instance to interact with the cluster
    Admin admin = new AdminFactory().createAdmin();

    //locate a grid service manager and deploy a partioned data grid with 2 primaries and one backup for each primary
    GridServiceManager esm = admin.getGridServiceManagers().waitForAtLeastOne();
    ProcessingUnit pu = esm.deploy(new SpaceDeployment(spaceName).partitioned(2, 1));
} catch (ProcessingUnitAlreadyDeployedException e)  {
    //already deployed, do nothing
}

//Once your data grid has been deployed, wait for 4 instances (2 primaries and 2 backups)
pu.waitFor(4, 30, TimeUnit.SECONDS);

//and finally, obtain a reference to it
GigaSpace gigaSpace = pu.waitForSpace().getGigaSpace();
{% endhighlight %}


{% note %}*Lite edition support a single partition*
If you are using the Lite edition use this:
{% highlight java %}
ProcessingUnit pu = esm.deploy(new SpaceDeployment(spaceName).partitioned(1, 1));
....
pu.waitFor(2, 30, TimeUnit.SECONDS);
{% endhighlight %}
{% endnote %}


You can also use a simple helper utility (DataGridConnectionUtility) that combines the two. It first look for a DataGrid instance and if one doesn't exist it will create a new one; it's trivial to alter the `getSpace()` method to increase the number of nodes or even scale dynamically as required. Read [this]({%latestjavaurl%}/elastic-processing-unit.html) for more detailed information on how elastic scaling works.

{% tip %}
A The DataGridConnectionUtility class [is available on Github](https://github.com/Gigaspaces/bestpractices/blob/master/plains/src/main/java/org/openspaces/plains/datagrid/DataGridConnectionUtility.java), in the "plains" project.
{% endtip %}

With this class in the classpath, getting a datagrid reference is as simple as:

{% highlight java %}
GigaSpace space=DataGridConnectionUtility.getSpace("myGrid");
{% endhighlight %}

# Interacting with the Data Grid

Once you've obtained a reference to the data grid, it's time to write some data to it.
You can write any POJO to the data grid, so long as it has a default constructor and a getter and setter for every property you want to store in the space. Here's an example for a simple POJO:

{% highlight java %}
import com.gigaspaces.annotation.pojo.SpaceClass;
import com.gigaspaces.annotation.pojo.SpaceId;

@SpaceClass
public class Person {
    private Integer ssn;
    private String firstName;
    private String lastName;

    //default constructor, required
    public Person() {}

    public Person(Integer ssn, String firstName, String lastName) {
        this.ssn = ssn;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    @SpaceId
    public Integer getSsn() {
        return ssn;
    }

    public void setSsn(Integer ssn) {
        this.ssn = ssn;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}
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

# What's Next?

Read more about the GigaSpaces runtime environment, how to model your data in a clustered environment, and how to levarage the power capabilties of the Space.

- [Elastic Processing Unit]({%latestjavaurl%}/elastic-processing-unit.html)
- [Modeling and Accessing Your Data]({%latestjavaurl%}/modeling-and-accessing-your-data.html)
- [Deploying and Interacting with the Space]({%latestjavaurl%}/deploying-and-interacting-with-the-space.html)
- [The GigaSpaces Runtime Environment]({%latestjavaurl%}/the-runtime-environment.html)

