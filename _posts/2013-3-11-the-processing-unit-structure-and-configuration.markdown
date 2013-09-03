---
layout: post
title:  The Processing Unit Structure and Configuration
categories: XAP96
page_id: 61867075
---

{% compositionsetup %}
{% summary page|70 %}This page describes the processing unit directory structure{% endsummary %}

# The Processing Unit Jar File

Much like a JEE web application or an OSGi bundle, The Processing Unit is packaged as a .jar file and follows a certain directory structure which enables the GigaSpaces runtime environment to easily locate the deployment descriptor and load its classes and the libraries it depends on. A typical processing unit looks as follows:

{% highlight java %}
|----META-INF
|--------spring
|------------pu.xml
|------------pu.properties
|------------sla.xml
|--------MANIFEST.MF
|----com
|--------mycompany
|------------myproject
|----------------MyClass1.class
|----------------MyClass2.class
|----lib
|--------hibernate3.jar
|--------....
|--------commons-math.jar
{% endhighlight %}

The processing unit jar file is composed of several key elements:

- **`META-INF/spring/pu.xml`** (mandatory): This is the processing unit's deployment descriptor, which is in fact a [Spring](http://www.springframework.org) context XML configuration with a number of GigaSpaces-specific namespace bindings. These bindings include GigaSpaces specific components (such as the space for example). The `pu.xml` file typically contains definitions of GigaSpaces components ([space](/xap96/2013/05/25/the-in-memory-data-grid.html), [event containers](/xap96/2012/09/04/messaging-support.html), [remote service exporters](/xap96/2011/05/24/space-based-remoting.html)) and user defined beans which would typically interact with those components (e.g. an event handler to which the event containers delegate the events, or a service beans which is exposed to remote clients by a remote service exporter).

- **`META-INF/spring/sla.xml`** (not mandatory): This file contains SLA definitions for the processing unit (i.e. number of instances, number of backup and deployment requirements). Note that this is optional, and can be replaced with an <os:sla> definition in the `pu.xml` file. If neither is present, the [default SLA](/xap96/2013/08/26/configuring-the-processing-unit-sla.html) will be applied. Note, the `sla.xml` can also be placed at the root of the processing unit. SLA definitions can be also specified at the deploy time via the [deploy CLI](/xap96/2012/07/02/deploy---gigaspaces-cli.html) or
{javadocos:org/openspaces/admin/gsm/GridServiceManager|deploy API}
.
{% note %}
SLA definitions are only enforced when deploying the processing unit to the GigaSpaces service grid, since this environment actively manages and controls the deployment using the [GSM](/xap96/2011/09/07/the-grid-service-manager.html). When [running within your IDE](/xap96/2012/01/04/running-and-debugging-within-your-ide.html) or in [standalone mode](/xap96/2012/09/11/running-in-standalone-mode.html) these definitions are ignored.
{% endnote %}

- **`META-INF/spring/pu.properties`** (not mandatory): Enables you to externalize properties included in the `pu.xml` file (e.g. database connection username and password), and also set system-level deployment properties and overrides, such as JEE related deployment properties (see [this page](/xap96/2012/09/02/web-application-support.html) for more details) or space properties (when defining a space inside your processing unit). Note, the `pu.properties` can also be placed at the root of the processing unit.

- **User class files**: Your processing unit's classes (here under the com.mycompany.myproject package)

- **`lib`**: Other jars on which your processing unit depends, e.g. commons-math.jar or jars that contain common classes across many processing units.

- **`META-INF/MANIFEST.MF`** (not mandatory): This file could be used for adding additional jars to the processing unit classpath, using the standard `MANIFEST.MF` `Class-Path` property. (see [Manifest Based Classpath](/xap96/2013/03/11/the-processing-unit-structure-and-configuration.html#Manifest Based Classpath) for more details)

{% tip %}
You may add your own jars into the runtime (GSC) classpath by using the `PRE_CLASSPATH` and `POST_CLASSPATH` variables. These should point to your application jars.
{% endtip %}

# Sharing Libraries Between Multiple Processing Units

In some cases, multiple processing units use the same jar files. In such cases it makes sense to place these jar files in a central location accessible by all processing unit not repackage each of processing unit separately. Note that this is also useful for decreasing the deployment time in case your processing units contain a lot of 3rd party jars files. since it save a lot of the network overhead associated with downloading these jars to each of the GSCs. There are two options to achieve this:

1. The `<GigaSpaces root>/lib/optional/pu-common` directory: Placing jars in this directory means they will be loaded by each processing unit instance its own separate classloader (called the service classloader, see the [Class Loaders](#classloaders) section below). You can either place these jars in each GigaSpaces installation in your network, or point the `pu-common` directory to a shared location on your network by specifying this location in the `com.gs.pu-common` system property in each of the GSCs on your network.
1. The `<GigaSpaces root>/lib/platform/ext` directory: Placing jars in this directory means they will be loaded once by the GSC-wide classloader and not separately by each processing unit instance (this classloader is called the common classloader, see the [Class Loaders](#classloaders) section below). You can either place these jars in each GigaSpaces installation in your network, or point the `platform/lib/ext` directory to a shared location on your network by specifying this location in the `com.gigaspaces.lib.platform.ext` system property in each of the GSCs on your network.
{% note %}
For Database 3rd party jars (e.g. JDBC driver) we recommend using the second option (GSC-wide classloader)
{% endnote %}

# Runtime Modes

The processing unit can [run](/xap96/2011/09/07/deploying-and-running-the-processing-unit.html) in multiple modes.

When deployed on to the [GigaSpaces runtime environment](/xap96/2012/09/02/the-runtime-environment.html) or when running in [standalone mode](/xap96/2012/09/11/running-in-standalone-mode.html), all the jars under the `lib` directory of your processing unit jar, will be automatically added to the processing unit's classpath.

When [running within your IDE](/xap96/2012/01/04/running-and-debugging-within-your-ide.html), it is similar to any other Java application, i.e. you should make sure all the dependent jars are part of your project classpath.

# Deploying the Processing Unit to the GigaSpaces Service Grid

When deploying the processing unit to [GigaSpaces Service Grid](/xap96/2012/09/02/the-runtime-environment.html), the processing unit jar file is uploaded to the [GigaSpaces Manager (GSM)](/xap96/2011/09/07/the-grid-service-manager.html) and extracted to the `deploy` directory of the local GigaSpaces installation (located by default under `<GigaSpaces Root>/deploy`).

Once extracted, the [GSM](/xap96/2011/09/07/the-grid-service-manager.html) processes the deployment descriptor and based on that provisions processing unit instances to the running [GigaSpaces containers](/xap96/2013/03/18/the-grid-service-container.html).

Each GSC to which a certain instance was provisioned, downloads the processing unit jar file from the GSM, extracts it to its local work directory (located by default under `<GigaSpaces Root>/work/deployed-processing-units`) and starts the processing unit instance.

{% anchor dataOnlyPUs %}

# Deploying Data Only Processing Units

In some cases, your processing unit contains only a [Space](/xap96/2012/12/19/the-space-component.html) and no custom code.

One way to package such processing unit is to use the standard processing unit packaging described above, and create a processing unit jar file which only includes a [deployment descriptor](/xap96/2012/09/04/configuring-processing-unit-elements.html) with the required space definitions and SLA.

GigaSpaces also provides a simpler option via its built-in data-only processing unit templates (located under `<GigaSpaces Root>/deploy/templates/datagrid`. Using these templates you can deploy and run data only processing unit without creating a dedicated jar for them.

For more information please refer to [this section](/xap96/2011/09/07/deploying-and-running-the-processing-unit.html)
{alias:classloaders}

# Class Loaders

In general, classloaders are created dynamically when deploying a PU into a GSC. You **should not add your classes** into the GSC CLASSPATH. Classes are loaded dynamically into the generated classloader in the following cases:

- When the GSM sending classes into the GSC when the application deployed and when GSC is restarted.
- When the GSM sending classes into the GSC when the application scales.
- When a Task class or Distributed Task class and its dependencies are executed (space execute operation).
- When space domain classes and their dependencies (Data model) are used (space write/read operations)

Here is the structure of the class loaders when several processing units are deployed on the Service Grid (GSC):

{% highlight java %}
Bootstrap (Java)
                  |
               System (Java)
                  |
               Common (Service Grid)
             /        \
    Service CL1     Service CL2
{% endhighlight %}

The following table shows which user controlled locations end up in which class loader, and the important JAR files that exist within each one:

{: .table .table-bordered}
| Class Loader | User Locations | Built in Jar Files |
|:-------------|:---------------|:-------------------|
| Common | \[GSRoot\]/lib/platform/ext/\*.jar | gs-runtime.jar |
| Processing Unit Instance (Service Class Loader) | \[PU\]/, \[PU\]/lib/\*.jar, \[PU\]/META-INF/MANIFEST.MF Class-Path Entry, \[GSRoot\]/lib/optional/pu-common/\*.jar | gs-openspaces.jar, org.springframework\*.jar |
In terms of class loader delegation model, the service (PU instance) class loader uses a **parent last delegation mode**. This means that the processing unit instance class loader will first try and load classes from its own class loader, and only if they are not found, will delegate up to the parent class loader.

## Native Library Usage

When deploying applications using native libraries you should place the Java libraries (jar files) loading the native libraries under the `GSRoot/lib/platform/ext` folder. This will load the native libraries once into the common class loader.

## Permanent Generation Space

For applications that are using relatively large amount of third party libraries (PU using large amount of jars) the default permanent generation space size may not be adequate. In such a case, you should increase the permanent generation space size. Here are suggested values:

{% highlight java %}
-XX:PermSize=512m -XX:MaxPermSize=512m
{% endhighlight %}

# Manifest Based Classpath

It is possible adding additional jars to the processing unit classpath by having a manifest file located at `META-INF/MANIFEST.MF` and defining the property `Class-Path` 
as shown in the following example (using a simple `MANIFEST.MF` file):

{% highlight java %}
Manifest-Version: 1.0
Class-Path: /home/user1/java/libs/user-lib.jar 
 lib/platform/jdbc/hsqldb.jar 
 ${MY\_LIBS\_DIRECTORY}/user-lib2.jar 
 file:/home/user2/libs/lib.jar 

[REQUIRED EMPTY NEW LINE AT EOF]
{% endhighlight %}

In the previous example, the `Class-Path` property contains 4 different entries:

1. `/home/user1/java/libs/user-lib.jar` - This entry uses an absolute path and will be resolved as such.
1. `lib/platform/jdbc/hsqldb.jar` - This entry uses a relative path and as such its path is resolved in relative to the gigaspaces home directory.
1. `${MY\_LIBS\_DIRECTORY}/user-lib2.jar` - In this entry the `${MY\_LIBS\_DIRECTORY}` will be resolved if an environment variable named `MY_LIBS_DIRECTORY` exists, and will be expanded appropriately.
1. `file:/home/user2/libs/lib.jar` - This entry uses URL syntax

## The `pu-common` Directory

The `pu-common` directory may contain a jar file with a manifest file as described above located at `META-INF/MANIFEST.MF`. The classpath defined in this manifest will be shared by all processing units as described in [Sharing libraries](#SharingLibrariesBetweenMultipleProcessingUnits).

## Further details

1. If an entry points to a non existing location, it will be ignored.
1. If an entry included the `${SOME\_ENV\_VAL}` placeholder and there is no enviroment variable named `SOME\_ENV\_VAL`, it will be ignored.
1. Only file URLs are supported. (i.e http, etc... will be ignored)

Further details about the manifest file can be found [here](http://docs.oracle.com/javase/6/docs/technotes/guides/jar/jar.html#JAR%20Manifest).
