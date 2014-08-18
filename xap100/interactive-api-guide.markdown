---
layout: post100
title:  Interactive API Guide
categories: XAP100
weight: 100
parent: tutorials.html
---

{%summary%}{%endsummary%}

This guide provices setup instructions for the XAP Interactive Tutorial and some code snippets for the Interactive Shell usage.

The tutorial include an interactive shell that will allow you to execute the various XAP API for writing and reading data as well as open a groovy shell to write your own code and experience the full XAP API.

 
# Download and Install XAP

Getting XAP is simple: download it from the [Current Releases](http://www.gigaspaces.com/LatestProductVersion) page.

{%vbar title=Download and Install XAP %}
- Download and unzip the latest XAP release from the [downloads page](http://www.gigaspaces.com/xap-download)
- Unzip the distribution into a working directory; GS_HOME
- For this guide we will use `/home/user/xap-distribution` and `C:\xap-distribution` for Linux and Windows users respectively.
- Set the JAVA_HOME environment variable to point to the JDK root directory
{%endvbar%}


# Download and Run XAP Interactive Tutorial

The project is hosted on Github, download the [latest compatible version](https://github.com/Gigaspaces/XAP-Interactive-Tutorial/releases)

{%vbar title=Download and Install XAP %}
- Download the latest compatible version from [https://github.com/Gigaspaces/XAP-Interactive-Tutorial/releases](https://github.com/Gigaspaces/XAP-Interactive-Tutorial/releases)
- Unzip it to your favorite directory. For this guide we will use /home/user/xap-tutorial and C:\xap-tutorial for Linux and Windows users respectively. 
{%endvbar%}


# Starting a Service Grid

A Data Grid requires a [Service Grid](/product_overview/service-grid.html) to host it. A service grid is composed of one or more machines (service grid nodes) running a [Service Grid Agent](/product_overview/service-grid.html#gsa) (or `GSA`), and provides a framework to deploy and monitor applications on those machines, in our case the Data Grid.

In this tutorial you'll launch a single node service grid on your machine. To start the service grid, simply run the `gs-agent` script from the product's `bin` folder.

{% inittab%}
{% tabcontent Unix %}
{% highlight bash %}
./gs-agent.sh
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Windows %}
{% highlight bash %}
gs-agent.bat
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}

{% tip title=Optional - The Web Console %}
XAP provides a web-based tool for monitoring and management. From the `bin` folder start the `gs-webui` script, then browse to `localhost:8099`. Click the 'Login' button and take a look at the *Dashboard* and *Hosts* tabs - you'll see the service grid components created on your machine.
{% endtip %}

# Deploying the Data Grid

The Data grid can be deployed from command line, from the web management tool or via an Administration API. In this tutorial we'll use the command line.

Start a command line, navigate to the product's `bin` folder and run the following command:

{% inittab %}
{% tabcontent Unix %}
{% highlight bash %}
./gs.sh deploy-space -cluster total_members=2,1 myDataGrid
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Windows %}
{% highlight bash %}
gs.bat deploy-space -cluster total_members=2,1 myDataGrid
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}
  
This command deploys a Data Grid (aka space) called **myDataGrid** with 2 partitions and 1 backup per partition (hence the `2,1` syntax). 

If you're using the web console mentioned above to see what's going on, you'll see the data grid has been deployed.
 
{%info%}
Note that the Lite edition is limited to a single partition - if you're using it type `total_members=1,1` instead.
{%endinfo%}

# Running the Tutorial

First, we need to point to XAP distribution directory by setting the GS_HOME environment variable.

{% inittab %}
{% tabcontent Unix %}
{% highlight bash %}
export GS_HOME="/home/user/xap-distribution/"
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Windows %}
{% highlight bash %}
set GS_HOME="C:\xap-distribution"
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}

To start the tutorial simply run:

{% inittab %}
{% tabcontent Unix %}
{% highlight bash %}
./start_tutorial.sh
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Windows %}
{% highlight bash %}
start_tutorial.bat
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}
<br>

## Option 1 - XAP Demo

This option demonstrates `XAP API` calls such as writing, reading and querying data to/from the deployed `myDataGrid`.
<br>
<br>

## Option 2 - XAP 10 New API

In this option, we go over and use two new features of XAP 10 API 
<br>
- [Query Aggregations](http://docs.gigaspaces.com/release_notes/100whats-new.html#3)
<br>
- [Custom Change Operation](http://docs.gigaspaces.com/release_notes/100whats-new.html#6)
<br>
<br>

## Option 3 - Interactive Shell 

This option opens an interactive shell, a Groovy shell with `GigaSpace` classes preloaded, which allows you to freely try the `XAP API`.

Following are some code snippets that facilitates the interaction with the Interactive Shell:
<br>

#### Defining required variables and connecting to the space
{% highlight java %}
//import EngineerPojo class
import demo.EngineerPojo;
//define the gridname that we will be interacting with
gridname = "myDataGrid";
//connect and verify that the processing unit (gridname) is deployed and print number of instances.
admin = new AdminFactory().useDaemonThreads(true).createAdmin();
pus = admin.getProcessingUnits().waitFor(gridname, 10, TimeUnit.SECONDS);
assert (pus != null), "Unable to find ${gridname}, please make sure it is deployed."
assert pus.waitFor(1), "Unable to find ${gridname}, please make sure it is deployed."
println "Found " + pus.getInstances().length + " space instances";
{% endhighlight %}
<br>

#### Defining the `GigaSpace` object
For more information see: [GigaSpace API](http://www.gigaspaces.com/docs/JavaDoc10.0/org/openspaces/core/GigaSpace.html)
{% highlight java %}
gigaSpace = admin.getProcessingUnits().getProcessingUnit(gridname).getSpace().getGigaSpace();
{% endhighlight %}
<br>

#### Writing and Reading EngineerPojo object
{% highlight java %}
//Write EngineerPojo object to the space
engineerPojo = new EngineerPojo(123456789, "EngineerPojo Pojo Object", "English");
gigaSpace.write(engineerPojo);

//Read an EngineerPojo object from space.
gigaSpace.read(new EngineerPojo());
{% endhighlight %}
<br>

#### Write EnginerPojo object with dynamic properties set. dynamicProperties field is annotated with @DynamicProperties annotation.
{% highlight java %}
engineerPojoWithDynamicProperties = new EngineerPojo(987654321, "EngineerPojo Pojo Object With Dynamic Properties", "Hebrew")
dynamicProperties = new DocumentProperties().setProperty("company","GigaSpaces").setProperty("age","24");
engineerPojoWithDynamicProperties.setDynamicProperties(dynamicProperties);
gigaSpace.write(engineerPojoWithDynamicProperties);
{% endhighlight %}
<br>

#### Write EngineerPojo object using Document API
{% highlight java %}
engineerPojoDocument = new SpaceDocument("demo.EngineerPojo");
engineerPojoDocument.setProperty("id", 321654987);
engineerPojoDocument.setProperty("name", "EngineerPojo Document Object");
engineerPojoDocument.setProperty("language", "Hebrew");
engineerPojoDocument.setProperty("age", 21);

gigaSpace.write(engineerPojoDocument);
{% endhighlight %}
<br>

#### Read multiple objects from the space with the criteria: language=Hebrew
{% highlight java %}
engineerPojoQuery = new EngineerPojo();
engineerPojoQuery.setLanguage("Hebrew");
writtenEngineerPojos = gigaSpace.readMultiple(engineerPojoQuery);
for (obj in writtenEngineerPojos) {
    println obj
}
{% endhighlight %}
<br>

#### Introduce EngineerDocument object to the space with support for dynamic properties
{% highlight java %}
spaceTypeDescriptor = new SpaceTypeDescriptorBuilder("EngineerDocument").idProperty("id").supportsDynamicProperties(true).addFixedProperty("id", "Integer").addFixedProperty("name", "String").create();
gigaSpace.getTypeManager().registerTypeDescriptor(spaceTypeDescriptor);
spaceDocuments = new SpaceDocument[10];
for (int i=0; i<10; i++) {
    spaceDocument = new SpaceDocument("EngineerDocument");
    spaceDocument.setProperty("id", 1000+i);
    spaceDocument.setProperty("name", "EngineerDocument Document Object ("+i+")");
    spaceDocument.setProperty("company", "GigaSpaces");
    spaceDocument.setProperty("age", String.valueOf(i));
    spaceDocuments[i] = spaceDocument;
}
gigaSpace.writeMultiple(spaceDocuments);
{% endhighlight %}
<br>

#### Read a random EngineerDocument object from the space
{% highlight java %}
gigaSpace.read(new SpaceDocument("EngineerDocument"));
{% endhighlight %}
<br>

# What's Next?

[The Full XAP Java Tutorial](./java-home.html) will introduce you to the basic concepts and functionalities of XAP. Many ready to run examples are provided.

Read more about the GigaSpaces runtime environment, how to model your data in a clustered environment, and how to leverage the power capabilities of the Space.

- [Elastic Processing Unit](./elastic-processing-unit.html)
- [Modeling and Accessing Your Data](/sbp/modeling-your-data.html)
- [Deploying and Interacting with the Space](./administrators-guide.html)
- [The GigaSpaces Runtime Environment]({%currentadmurl%}/the-runtime-environment.html)

