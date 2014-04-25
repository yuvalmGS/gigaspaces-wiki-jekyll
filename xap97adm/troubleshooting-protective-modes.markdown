---
layout: post97adm
title:  Protective Modes
categories: XAP97ADM
weight: 150
parent: troubleshooting.html
---

{%summary%}{%endsummary%}
The following guidelines are highly recommended to build robust and efficient applications as well as to avoid common mistakes. 
XAP was designed to be very robust and provide clear exceptions when the usage is wrong.
Sometimes a plain validation is too harsh, as it might break backward-compatibility and prevent existing customers from upgrading to the latest version. 
For such cases the **Protective Mode** was introduced, which means that the validation is on by default, but can be disabled using a system property. This protects new customers from repeating old mistakes, and encourages existing customers to fix their code (yet allows them to disable the protection if they choose so).


# Id property

Id property is essential for update operation and also XAP has a rich set of operations that use the id to perform read/take/update very efficiently without fetching the whole object. 
Since 9.1 this is enforced by the protective mode:

Writing an entry to the space without a [space ID]({%currentjavaurl%}/query-by-id.html) is error-prone - it can lead to duplicate entries, bad performance and more.
In case your application contains objects without an id you'll get the following exception:

{%highlight bash%}
com.gigaspaces.client.protective.ProtectiveModeException: Cannot introduce a type named 'MyClass' without an id property defined...
{%endhighlight%}

{% note %}
It is highly recommended that you modify them and add a space ID.
If this is not feasible, it can be disabled using the following system property:
{%highlight bash%}
-Dcom.gs.protectiveMode.typeWithoutId=false
{%endhighlight%}
{% endnote %}


# Routing property

The routing property is used to partition the data across different partitions.
It is recommended to define such property explicitly to control how data is partitioned and avoid common mistakes like writing data to the wrong partition.

See more info on [routing property]({%currentjavaurl%}/routing-in-partitioned-spaces.html).

Starting 9.7 a new protective mode has been added to protect against writing entries with null value routing.
In case your application contains objects without routing you'll get the following exception:

{%highlight bash%}
com.gigaspaces.client.protective.ProtectiveModeException: Operation is rejected - no routing value provided when writing an entry of type 'MyClass' in a partitioned space.
{%endhighlight%}

A routing value should be specified within the entry's property named 'myRoutingProperty'. Missing a routing value would result in a remote client not being able to locate this entry as the routing value will not match the partition the entry is located....


{% note%}
It is highly recommended that you modify them and add a routing value.
If this is not feasible, you can disable it using the following system property:
{% highlight bash %}
-Dcom.gs.protectiveMode.wrongEntryRoutingUsage=false
{%endhighlight%}
{% endnote %}

In case your application writes directly to one of the partitions and assigns the wrong routing value you'll get the following exception:

{% highlight bash %}
com.gigaspaces.client.protective.ProtectiveModeException: Operation is rejected - the routing value in the written entry of type 'MyClass' does not match this space partition id. The value within the entry's routing property named 'symbol' is 100 which matches partition id 1 while current partition id is 2...
{% endhighlight %}

It is highly recommended that you modify them and set the right routing.

{% note%}
If this is not feasible, and you know what you're doing, it can be disabled using the following system property: 
{% highlight bash %}
-Dcom.gs.protectiveMode.wrongEntryRoutingUsage=false
{% endhighlight %}
{% endnote %}


# Primitive types

If you must use primitive property types, then assign null values. This is enforced by the protective mode since 9.7.

When querying the space using [template matching]({%currentjavaurl%}/query-template-matching.html), null properties are ignored and non-null properties are matched. Since primitive properties cannot be set to null, a `nullValue` can be assigned to a property to indicate a value which will be treated as null when using template matching.

See [primitive types matching]({%currentjavaurl%}/query-template-matching.html#primitive-types)

Starting 9.7 a new protective mode has been added to protect against querying with a template which contains one or more primitive properties without a `nullValue`, since such templates are likely to produce unexpected results. 

If your application uses template matching with such types, you'll get the following exception:

{% highlight java %}
com.gigaspaces.client.protective.ProtectiveModeException: Operation is rejected - template matching on type MyClass is illegal because it has primitive properties without null value: id (int)...
{% endhighlight %}


It is highly recommended that you define `nullValue` where appropriate, or switch to [SQLQuery]({%currentjavaurl%}/query-sql.html) instead.

{%note%}
If this is not feasible, this protective mode can be disabled using the following system property: 
{% highlight bash %}
-Dcom.gs.protectiveMode.primitiveWithoutNullValue=false
{% endhighlight %}
{%endnote%}


{%comment%}
## Define an index on the properties you need to query. 

TBD

## Don't change nested properties on embedded space

TBD

## Don't use externalizable unless you really know what you're doing 

TBD
{%endcomment%}