---
layout: post
title:  The Grid Service Manager
page_id: 61867037
---

{% compositionsetup %}
{% summary page|70 %}Manages Processing Unit deployments and GigaSpaces Containers{% endsummary %}

# Overview

The Grid Service Manager (GSM), is a special infrastructure service, responsible for managing [The Grid Service Container](./the-grid-service-container.html)s. The GSM accepts user deployment and undeployment requests of Processing Units, and provisions them to the Service Grid Cloud accordingly.

The GSM monitors SLA breach events throughout the life-cycle of the application, and is responsible for taking corrective actions, once SLAs are breached.

{% lampon %} It is common to start two instances of GSM services within each Service Grid cloud, for high-availability reasons.

## Processing Unit Monitoring

GSMs monitor the Processing Unit instances running within each GSC. For each Processing Unit instance, a fault detection mechanism is maintained - pinging periodically.
After repeated failures, the GSM forcefully tries to destroy the instance and re-instantiate it on another GSC. If there are no more available GSCs, or instantiation failed on all attempts, the GSM adds the Processing Unit instance to a 'pending list' and will re-attempt either when - a new GSC starts or after a time delay

{% indent %}
![gsm1.jpg](/attachment_files/gsm1.jpg)
{% endindent %}

# Starting the GSM

The preferable way to start a GSM is using [The Grid Service Agent](./the-grid-service-agent.html). A GSM can be started on its own using the `\[GSHOME\]/bin/gsm.(bat/sh)` script (starts a GSM **with** embedded [Lookup Service](./the-lookup-service.html)), or using the `\[GSHOME\]/bin/gsm_nolus.(bat/sh)` script (starts a GSM **without** embedded [Lookup Service](./the-lookup-service.html)).

# Configuring the GSM

Configuring the GSM (and possibly system level settings for other services, such as the communication layer) can be done using system properties.

JVM parameters (system properties, heap settings etc.) that are shared between all components are best set using the `EXT_JAVA_OPTIONS` environment variable. However, starting from 7.1.1, specific GSC JVM parameters can be easily passed using `GSM_JAVA_OPTIONS` that will be appended to `EXT_JAVA_OPTIONS`. If `GSM_JAVA_OPTIONS` is not defined, the system will behave as in 7.1.0. Both `EXT_JAVA_OPTIONS` and `GSM_JAVA_OPTIONS` can be added within the GSM script, or in a wrapper script.

{% inittab %}
{% tabcontent Linux %}

{% highlight java %}
#Wrapper Script
export GSM_JAVA_OPTIONS=-Xmx1024m

#call gsm.sh
. ./gsm.sh
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Windows %}

{% highlight java %}
@rem Wrapper Script
@set GSM_JAVA_OPTIONS=-Xmx1024m

@rem call gsm.bat
call gsm.bat
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

{% exclamation %} GSM specific configuration can be set using system properties (follows the \[component name\].[\property name\](\property name\) notation).
