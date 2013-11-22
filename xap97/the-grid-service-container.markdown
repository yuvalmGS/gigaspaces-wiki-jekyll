---
layout: post
title:  The Grid Service Container
categories: XAP97
parent: the-runtime-environment.html
weight: 200
---

{% compositionsetup %}
{% summary page|70 %}A container which hosts Processing Unit Instances provisioned to it by the GSM{% endsummary %}

# Overview

A Grid Service Container (GSC) is a container which hosts Processing Unit Instances (actual instances of a deployed Processing Unit). The GSC can be perceived as a node on the grid, which is controlled by [The Grid Service Manager](./the-grid-service-manager.html). The GSM provides commands of deployment and un-deployment of the Processing Unit instances into the GSC. The GSC reports its status to the GSM.

Another aspect of a GSC is its ability to host Processing Units. The GSC class loading hierarchy makes sure that various Processing Units are isolated from one another within the same GSC.

It is common to start several GSCs on the same physical machine, depending on the machine CPU and memory resources.

The deployment of multiple GSCs on a single or multiple machines creates a virtual Service Grid. The fact is that GSCs are providing a layer of abstraction on top of the physical layer of machines. This concept enables deployment of clusters on various deployment typologies of enterprise data centers and public clouds.

# Starting the GSC

The preferable way to start a GSC is using [The Grid Service Agent](./the-grid-service-agent.html). A GSC can be started on its own using the `\[GSHOME\]/bin/gsc.(bat/sh)` script.

# Configuring the GSC

Configuring the GSC (and possibly system level settings for other services, such as the communication layer) can be done using system properties.

JVM parameters (system properties, heap settings etc.) that are shared between all components are best set using the `EXT_JAVA_OPTIONS` environment variable. However, starting from 7.1.1, specific GSC JVM parameters can be easily passed using `GSC_JAVA_OPTIONS` that will be appended to `EXT_JAVA_OPTIONS`. If `GSC_JAVA_OPTIONS` is not defined, the system will behave as in 7.1.0. Both `EXT_JAVA_OPTIONS` and `GSC_JAVA_OPTIONS` can be added within the GSC script, or in a wrapper script.

{% inittab %}

{% tabcontent Linux %}

{% highlight java %}
#Wrapper Script
export GSC_JAVA_OPTIONS=-Xmx1024m

#call gsc.sh
. ./gsc.sh
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Windows %}

{% highlight java %}
@rem Wrapper Script
@set GSC_JAVA_OPTIONS=-Xmx1024m

@rem call gsc.bat
call gsc.bat
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

{% exclamation %} GSC specific configuration can be set using system properties (follows the \[component name\].\[property name\] notation).
