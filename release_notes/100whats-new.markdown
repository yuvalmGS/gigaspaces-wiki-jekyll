---
layout: post
title:  What's New
categories: RELEASE_NOTES
parent: xap100.html
weight: 100
---

This page lists the main new features in XAP 10.0 (Java and .Net editions). It's not an exhaustive list of all new features. For a full change log for 10.0 please refer to the [new features](./100new-features.html) and [fixed issues](./100fixed-issues.html) pages.


{%panel%}

- [Native Integration with Solid State Drives](#1)

- [Global HTTP Session Sharing](#2)

- [Query Aggregations](#3)

- [Optimized Initial Data Load](#4)

- [Elastic Management of XAP Using Cloudify](#5)

- [Custom Change Operation](#6)

- [Performance improvement for reg ex query](#7)

- [Jetty 9 support](#8)

- [Web UI Enhancements](#9)


{%endpanel%}




{%anchor 1%}

# Native Integration with Solid State Drives

XAP 10 introduces a new Storage interface allowing an external storage mechanism (one that does not reside on the JVM heap) to act as storage medium for the data in the IMDG. This storage model allows the IMDG to interact with the storage medium for storing IMDG data.

{%learn%}/xap100adm/blobstore-cache-policy.html{%endlearn%}

{%anchor 2%}

# Global HTTP Session Sharing

XAP 10 Global HTTP Session Sharing includes the following new features:

- Delta update support – changes identified at the session attribute level.
- Better serialization (Kryo instead of xstream)
- Compression support
- Principle / Session ID based session management. Allows session sharing across different apps with same SSO
- Role based SSO Support
- Better logging

{%javalearn%}/xap100/global-http-session-sharing.html{%endjavalearn%}


{%anchor 3%}

# Query Aggregations

XAP lets you perform aggregations across the Space. There is no need to retrieve the entire data set from the Space to the client side , iterate the result set and perform the aggregation. The Aggregators allow you to perform the entire aggregation activity at the Space side avoiding any data retrieval back to the client side. Only the result of each aggregation activity performed with each partition is returned back to the client side where all the results are reduced and returned to the client application.

Example:

{%inittab%}
{%tabcontent Java%}
{% highlight java %}
import static org.openspaces.extensions.QueryExtension.*;
...
SQLQuery<Employee> query = new SQLQuery<Employee>(Employee.class,"country=? OR country=? ");
query.setParameter(1, "UK");
query.setParameter(2, "U.S.A");

// retrieve the maximum value stored in the field "age"
Number maxAgeInSpace = max(space, personSQLQuery, "age");
/// retrieve the minimum value stored in the field "age"
Number minAgeInSpace = min(space, personSQLQuery, "age");
// Sum the "age" field on all space objects.
Number combinedAgeInSpace = sum(space, personSQLQuery, "age");
// Sum's the "age" field on all space objects then divides by the number of space objects.
Double averageAge = average(space, personSQLQuery, "age");
// Retrieve the space object with the highest value for the field "age".
Person oldestPersonInSpace = maxEntry(space, personSQLQuery, "age");
/// Retrieve the space object with the lowest value for the field "age".
Person youngestPersonInSpace = minEntry(space, personSQLQuery, "age");
{% endhighlight %}
{%endtabcontent%}
{%tabcontent .Net%}
{% highlight c# %}
using GigaSpaces.Core.Linq;
...
var queryable = from p in spaceProxy.Query<Person>("Country='UK' OR Country='U.S.A'") select p;
// retrieve the maximum value stored in the field "Age"
int maxAgeInSpace = queryable.Max(p => p.Age);
// retrieve the minimum value stored in the field "Age"
int minAgeInSpace = queryable.Min(p => p.Age);
// Sum the "Age" field on all space objects.
int combinedAgeInSpace = queryable.Sum(p => p.Age);
// Sum's the "Age" field on all space objects then divides by the number of space objects.
double averageAge = queryable.Average(p => p.Age);
// Retrieve the space object with the highest value for the field "Age".
Person oldestPersonInSpace = queryable.MaxEntry(p => p.Age);
// Retrieve the space object with the lowest value for the field "Age".
Person youngestPersonInSpace = queryable.MinEntry(p => p.Age);
{% endhighlight %}
{%endtabcontent%}
{%endinittab%}


{%section%}
{%column width=50% %}
{%endcolumn%}
{%column width=10% %}
{%javalearn%}/xap100/aggregators.html{%endjavalearn%}
{%endcolumn%}
{%column width=10% %}
{%netlearn%}/xap100net/aggregators.html{%endnetlearn%}
{%endcolumn%}
{%endsection%}

{%anchor 4%}

# Optimized Initial Data Load

You can now control the initial load with metadata. Using the `@SpaceInitialLoadQuery` annotation lets you define a method that implements the query for a Space class that should be pre loaded.

Example:

{%highlight java%}
public class InitialLoadQueryExample {

    @SpaceInitialLoadQuery(type="com.example.domain.MyClass")
    public String initialLoad(ClusterInfo clusterInfo) {
        Integer num = clusterInfo.getNumberOfInstances(), instanceId = clusterInfo.getInstanceId();
        return "propertyA > 50 AND routingProperty % " + num + " = " + instanceId;
    }
}
{%endhighlight%}

{%javalearn%}/xap100/space-persistency-initial-load.html{%endjavalearn%}


{%anchor 5%}

# Elastic Management of XAP Using Cloudify 

{%anchor 6%}

# Custom Change Operation

The change API now includes an option for custom change operation. The user can implement his own change operation in case the built-in operations (increment, add, remove, set, etc.) do not suffice.

{%javalearn%}/xap100/change-api-custom-operation.html{%endjavalearn%}


{%anchor 7%}

# Performance improvement for reg ex query

Free text search and Regular Expression queries can use indexes now, which will improve performance.

{%section%}
{%column width=50% %}
{%endcolumn%}
{%column width=10% %}
{%javalearn%}/xap100/query-free-text-search.html{%endjavalearn%}
{%endcolumn%}
{%column width=10% %}
{%netlearn%}/xap100net/query-free-text-search.html{%endnetlearn%}
{%endcolumn%}
{%endsection%}


{%anchor 8 %}

# Jetty 9 support

With this new version it is possible to use Jetty version 9.

{%javalearn%}/xap100/web-jetty-processing-unit-container.html#jetty-version{%endjavalearn%}


{%anchor 9%}

# Web UI Enhancements




