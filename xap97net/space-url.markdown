---
layout: post97
title:  Space URL
categories: XAP97NET
parent: the-ispaceproxy-interface.html
weight: 200
---

{% summary %}A Space URL is the address of the space, used to create a new space or find an existing one{% endsummary %}

# Overview

A **Space URL** is a string that represents an address of a space. In short, there are two forms of space URLs:

* **Embedded** (e.g. `/./mySpace`) - Find an embedded (in-process) space called *mySpace*. If it doesn't exist it will be created automatically. 
* **Remote** (e.g. `jini://*/*/mySpace`) - Find a remote space (hosted outside this process) called *mySpace*. If it doesn't exist an exception will be thrown.

To find or create a space, use the `GigaSpacesFactory.FindSpace()` method:
{%highlight csharp %}
ISpaceProxy spaceProxy = GigaSpacesFactory.FindSpace("/./spaceName")
{%endhighlight%}

For more information on working with the proxy see [ISpaceProxy](the-ispaceproxy-interface.html).

When using a [processing unit](basic-processing-unit-container.html), the space can be configured from the `pu.config` file:
{%highlight xml %}
<BasicContainer>
    <SpaceProxies>
        <add Name="MySpace" Url="/./mySpace"/>
    </SpaceProxies>
</BasicContainer>
{%endhighlight%}

# Embedded Space

An **Embedded** space is a space that is hosted in your process. The URL format for locating such a space is:
{% highlight xml %}
/./<spaceName><?key1=val1><&keyN=valN>
{% endhighlight %}

For example, to find an embedded space called `foo` use `/./foo`.

If the requested space does not exist, it is automatically created and returned. If you wish to look for an existing space only, use `create=false` property (e.g. `/./foo?create=false`) - this will throw an exception if the requested space does not exist.

# Remote Space

A **Remote** space is a space that is hosted in a different process. The URL format for locating such a space is:

{% highlight xml %}
jini://<hostName>:<port>/<containerName>/<spaceName><?key1=val1><&keyN=valN>
{% endhighlight %}

For example, to find a remote space called `foo` use `jini://*/*/foo`.

Let's examine that format:

* `jini://` - The prefix indicates to search for the space using the *JINI Lookup Service* protocol.
* `<hostName>:<port>` - Address of the JINI Lookup Service. Use `*` for multicast search, or specify a list of hostnames/ip addresses.   
* `<containerName>` - Indicates a specific member in the cluster to find. Use `*` for finding any cluster member.
* `<spaceName>` - Name of space to find.

{% infosign %} For more information regarding unicast and multicast lookup, see [Loouk Service Configuration]({%currentadmurl%}/network-lookup-service-configuration.html).