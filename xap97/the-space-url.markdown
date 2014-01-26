---
layout: post
title:  URL
categories: XAP97
parent: the-space.html
weight: 200
---

{% summary %}A Space URL is a string that represents an address of a space.{% endsummary %}

# Overview

The **[SpaceURL](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/j_spaces/core/client/SpaceURL.html)** object is an address, passed to the `GigaSpace` API, used to connect to a space and remotely create new spaces, as well as to enable various characteristics.

# Usage

In order to locate a space you should specify its URL. The SpaceURL is used as part of the **[Space Component](./the-space-component.html#SpaceComponent-URLProperties)* and in set using the OpenSpaces *`UrlSpaceFactoryBean`** (and the deprecated `SpaceFinder.find`) API, cluster configuration, management tools as well as by GigaSpaces C++,.Net.

The general format of the space URL is:

{% highlight xml %}
<protocol>://<host name>:<port>/<container name>/<space name>?<properties>
{% endhighlight %}

{%comment%}
A more commonly used format is using the **[OpenSpaces Configurer API](./programmatic-api-(configurers).html)** e.g:
{%endcomment%}

{% highlight java %}
UrlSpaceConfigurer spaceConfigurer = new UrlSpaceConfigurer("/./space");
GigaSpace gigaSpace = new GigaSpaceConfigurer(spaceConfigurer).gigaSpace();

// ...

// shutting down / closing the Space
spaceConfigurer.destroy();
{% endhighlight %}

{: .table .table-bordered}
| Name | Description |
|:-----|:------------|
| Protocol | `[jini](java)`{% wbr %}- Jini -- Remote access using Jini for lookup{% wbr %}- Java -- Local (embedded) access |
| Host name/IP | The machine host name/IP running the space container. May be \* when Jini is used as a protocol. In this case the space is located using multicast or unicast with search path. |
| Port | The Jini lookup port. If no port is specified the default port will be used |
| Container Name | The name of the container that holds the space. May be \* when Jini is used as a protocol. In this case the container will be ignored when performing lookup and the space will be searched regardless of the container that holds it. |
| Space Name | The space name to search. The same name defined when space has been created via the Space browser or the `createSpace` utility. |
| Properties String | (Optional) named value list of [special properties](./the-space-properties.html). |



{%comment%}
{% exclamation %} Make sure your network and machines running GigaSpaces are configured to have multicast enabled. See the [How to Configure Multicast](./how-to-configure-multicast.html) section for details on how to enable multicast.
{%endcomment%}


## "." Space Container Notation

The Space URL uses the following notation to start a space: `/./<Space Name>`
For example: `/./mySpace`

When using that space URL the system will instantiate (create) a space instance named `mySpace` using the default schema configuration. The default schema is set to transient space configuration and it is equivalent to using the following URL:
    java://localhost:10098/mySpace_container/mySpace?schema=default

{% tip %}
You can use "." as the container name in the space URL. A value of "." as the container name will be translated to `<space name>_container` name. In the above example the container name is explicitly defined as `mySpace_container`.
{% endtip %}

When a URL is provided without the protocol (java) and host name (localhost), the `SpaceFinder/CacheFinder` treats /./mySpace as
    java://localhost:10098/mySpace_container/mySpace?schema=default

# Examples

#### Accessing Remote Space Using Jini Lookup Service - Unicast Discovery

- `JINI://hostname/*/myspace`
- `JINI://mylookuphost/mycontainername/myspace`

#### Accessing Remote Space Using the Jini Lookup Service - Multicast Discovery

- `JINI://*/mycontainername/myspace`
- `JINI://*/*/myspace`

#### Starting Embedded Space Using the Java Protocol

- `JAVA://containerHostName:port/myContainerName/spaceName`
- `/./mySpace (which translates to java://localhost:10098/containerName/mySpace?schema=default)`
- `/./mySpace?schema=cache (which translates to java://localhost:10098/containerName/mySpace?schema=cache)`

{% anchor 1 %}

#### Distributed Unicast-Based Lookup Service Support

In environments that do not support multicast, you can use the new `locators` space URL property to instruct the started space or a client to locate the Jini Lookup Service on specific host name and port.

The locators are used in a similar way to the `groups` URL property.

The locators can have a comma-delimited lookup hosts list:

{% highlight java %}
SpaceFinder.find("/./Space?groups=g1,g2,g3&locators=h1:port,h2:port,h3:port)
{% endhighlight %}

The following URL formats are now supported:

{% highlight java %}
jini://*/*/space_name?locators=h1:port,h2:port,h3:port
jini://host1:port1,....host n:port n/container-name/space_name
jini://host1:port1,....host n:port n/container-name/space_name?locators=h1:port,h2:port,h3:port
jini://host1:port1/container-name/space name?locators=h1:port,h2:port,h3:port
{% endhighlight %}

#### Running Replicated Space

To start three space instances using the [replicated cache topology](/product_overview/terminology---data-grid-topologies.html), which enables replicating their data and operations synchronously, you should have the following commands:

{% highlight java %}
gsInstance "/./mySpace?cluster_schema=sync_replicated&total_members=3&id=1"
gsInstance "/./mySpace?cluster_schema=sync_replicated&total_members=3&id=2"
gsInstance "/./mySpace?cluster_schema=sync_replicated&total_members=3&id=3"
{% endhighlight %}

To access the replicated space, the client application should use the following url:

{% highlight java %}
jini://*/*/mySpace
{% endhighlight %}

#### Running Partitioned Space

To start three space instances using the [partitioned cache topology](/product_overview/terminology---data-grid-topologies.html) where each partition stores different portions of the data, you should have the following calls:

{% highlight java %}
gsInstance "/./mySpace?cluster_schema=partitioned&total_members=3&id=1"
gsInstance "/./mySpace?cluster_schema=partitioned&total_members=3&id=2"
gsInstance "/./mySpace?cluster_schema=partitioned&total_members=3&id=3"
{% endhighlight %}

To access the partitioned space, the client application should use the following url:

{% highlight java %}
jini://*/*/mySpace
{% endhighlight %}

#### Running Embedded Space

You may run the replicated or partitioned space from within your application. In this case, the space instance will be running in the same memory address as the application - i.e. [embedded space](/product_overview/terminology---data-grid-topologies.html). See the following example for running three space instances in partitioned embedded mode.
Each `CacheFinder.find()` or `SpaceFinder.find()` call should be done from a different application process.

{% highlight java %}
IJSpace space = (IJSpace)SpaceFinder.find("/./mySpace?cluster_schema=partitioned&total_members=3&id=1");
IJSpace space = (IJSpace)SpaceFinder.find("/./mySpace?cluster_schema=partitioned&total_members=3&id=2");
IJSpace space = (IJSpace)SpaceFinder.find("/./mySpace?cluster_schema=partitioned&total_members=3&id=3");
{% endhighlight %}
