---
layout: post
title:  Locating Clustered Space Instances
categories: XAP96
page_id: 61867229
---

{% summary %}Using `SpaceFinder` to search for clustered space/cache instances in the network. {% endsummary %}

# Overview

GigaSpaces provides&nbsp;the [SpaceFinder](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/j_spaces/core/client/SpaceFinder.html) class that can be used to&nbsp;locate spaces on the network. The `SpaceFinder` takes a URL string or an array of URL strings as a parameter, and tries to locate a space according to the URL value and order (when using an array of URLs).

When a space belongs to a failover or load-balancing group in a cluster, it registers a clustered proxy rather than a regular cluster in directory services like JNDI and Jini Lookup Service.

When writing an application against a GigaSpaces cluster, it is sometimes necessary to find an arbitrary space in the cluster based on the cluster name or group, rather than to specify the space name explicitly. This results in more flexibility, since it unties the application from a specific space member, and increases availability whenever a particular space member is unavailable.

For this reason, the includes lookup of a space member that belongs to a cluster. The following are common URLs you can use to look up a proxy of a space that belongs to cluster C and group G:

    jini://<host>/*/*?clustername=C
    jini://<host>/*/*?clustername=C&clustergroup=G

These URLs are uncoupled from a specific container or space name (the '*' is a wildcard replacement). The _`clustergroup`_ parameter can be used to limit the search to a specific failover group.

For example, to find a proxy in cluster C using Jini multicast discovery, use the following URL:

    jini://*/*/*?clustername=C

You may also define **multiple spaces URL using semi colon** {% color black %}separated{% endcolor %} URLs. The `SpaceFinder` tries to locate the space according to the order of the URLs. The first space proxy found is returned to the caller. For example:
    
    rmi://host1/container1/space1;rmi://host2/container2/space2;rmi://host3/container3/space3

{% lampon %} To use a unicast instead of or with multicast service discovery, refer to the [How do I Use/Set Unicast (Jini Locators) Discovery?](/xap96/2012/10/09/lookup-service-configuration.html#How do I Use/Set Unicast (Jini Locators) Discovery?) section.
