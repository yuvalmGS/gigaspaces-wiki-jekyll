---
layout: post
title:  Failover Detection and Tuning
categories: XAP97
parent: configuring-the-system.html
weight: 200
---

{% summary page|70 %}This page describes how to calculate the duration of various failover scenarios and what configuration parameters control it{% endsummary %}

{% note %}
Please read [infrastructure tuning directions](./tuning-infrastructure.html) before reading this page
{% endnote %}

# Overview

This page uses the following terminology:

- **Process failure**: a process that was killed (using `kill -9` for example), not a suspended process
- **Machine failure**: a machine shutdown or crash (not a machine halt)

In each of the failover scenarios, this page describes the steps that are involved in the failover scenario, how long they take and which parameters control their duration. The overall failover time is consisted of the duration of each of the steps.

The configuration parameters that are specified for each failover step are described in the table listed at the buttom of this page.

# Primary Space Process or Primary Space Machine Failure

**Approximate Default Duration**: up to 10 seconds
This scenario deals with primary space failure either as a result of a process failure or a machine failure. It is assumed that a backup space exists and is fully functional in the cluster.

The failover is measured from the client perspective, i.e. if the client performed a certain operation, this is the time that it takes to complete when a failover occurs during the operation.
For example, if you requried a failover time of under 15 seconds, there's no to change any of the default settings.

## Server Side Failover Process

**Approximate Default Duration**: up to 9 seconds
This part of the failover process represents the time it takes for a backup space to identify the primary space failure and become primary.
Here are the formulas for calculating the failover time (each parameter is described in the table below). The specified times are based on the out-of-the-box default values.
The active election times are reffring to the active election process. Please refer to [this page](./split-brain-and-active-election--general-definition.html) for more details about the active election process.

{% highlight java %}
[Failover Time] = [Primary Failure Detection Time] + [Primary Election Time]

[Primary Failure Detection Time] = [Invocation Delay] + [Invocation Retry Count] * [Retry Timeout] = ~1.3sec

[Primary Election Time] = 7 * ([Yield Time] + [Communication Latency (constant)])
{% endhighlight %}

## Client failover (client side)

\[Standby Wait Time\] is the only relevant parameter. It can add at most 1 second to the overall failover time.

# Client Notification about Failure of Both Primary & Backup Space Processes

**Approximate Default Duration**: up to 40 seconds
In this scenario the entire partition fails and there is no primary failure detection and primary election process. This represents the time it takes for the client application to discover that there is no space for it to work with.

## Client Side Failover

{% highlight java %}
[Connection Retries] * ( [Failover Find Timeout] + [Standby Wait Time] )
{% endhighlight %}

# Configuration Parameters

{: .table .table-bordered}
| Property | Name | Type | Description | Default Value | Space or Client Side? |
|:---------|:-----|:-----|:------------|:--------------|:----------------------|
|**Invocation Delay**| cluster-config.groups.group.fail-over-policy.active-election.fault-detector.invocation-delay | XPath property | Backup failure detection ping interval | 1000 millis |	Space Side |
|**Retry Count**| cluster-config.groups.group.fail-over-policy.active-election.fault-detector.retry-count|XPath property | Backup failure detection retry attemps on failure | 3 | Space Side|
|**Retry Timeout**|cluster-config.groups.group.fail-over-policy.active-election.fault-detector.retry-timeout|XPath property| Time between retries| 100ms| Space Side |
|**Yield Time**|cluster-config.groups.group.fail-over-policy.active-election.yield-time|XPath Property|The time to wait between active election phases|	1000 millis|Space Side|
|**Request Timeout**|com.gs.transport_protocol.lrmi.request_timeout|System Property|After this time the connection watchdog suspect there's a network disconnection and checks the connection status| 30 seconds | Client and Space Side|
|**Connect Timeout**|com.gs.transport_protocol.lrmi.connect_timeout| System Property |The time it takes to try and create a new connection | 5 seconds | Client and Space Side|
|**Standby Wait Time**|com.gs.failover.standby-wait-time |System Property| If aclient detects that the backup is not active yet, it will this time between each detection retry | 1 second |Client Side|
|**Inactive Retry Limit**|com.gs.client.inactiveRetryLimit|System Property| If a client detects that the backup is not active yet, it will attempt this amount of retries| 20	|Client Side|
|**Connection Retries**|space-config.proxy-settings.connection-retries|XPath Property|The amount of times a client will try to find a space if it detects that there is no space available|10|Space Side|
|**Failover Find Timeout**|cluster-config.groups.group.fail-over-policy.fail-over-find-timeout|XPath Property|How long will the client wait to get a connection to the space (on each retry) |2000 millis|Space Side|
|**Liveness Detector Frequency**|com.gs.cluster.livenessDetectorFrequency|System Property| The delay between attemps to lookup for failed space instance | 10000 millos|Client and Space Side|
|**Liveness Monitor Frequency**|com.gs.cluster.livenessMonitorFrequency|System Property| The delay between ping attemps to live space instance that were not accessed recently|	5000ms|Client and Space Side|
