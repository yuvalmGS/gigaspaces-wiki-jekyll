---
layout: post
title:  API Best Practices
categories: XAP97
weight: 200
parent: none
---

{%wbr%}

{%section%}

{%column width=90% %}
This guide contains the API guidelines that should be followed when using XAP to achieve best performance and avoid common mistakes
{%endcolumn%}
{%endsection%}

# API Best Practices and Protective Mode

The following guidelines are highly recommended to build robust and efficient applications as well as to avoid common mistakes. 
We design XAP to be very robust and provide clear exceptions when the usage is wrong. 
Sometimes a plain validation is too harsh, as it might break backward-compatibility and prevent existing customers from upgrading to the latest version. 
For such cases we created the *Protective Mode*, which means that the validation is on by default, but can be disabled using a system property. This protects new customers from repeating old mistakes, and encourages existing customers to fix their code (yet allows them to disable the protection if they choose so).

## Define an id property 

Id property is essential for update operation and also XAP has a rich set of operations that use the id to perform read/take/update very efficiently without fetching the whole object. 
Since 9.1 this is enforce by the protective mode:

### Protective Mode: Type Without Space ID (Since 9.7)

Writing an entry to the space without a [space ID]({%latestjavaurl%}/query-by-id.html) is error-prone - it can lead to duplicate entries, bad performance and more. Starting 9.7 a new protective mode has been added to protect against writing such entries. this protective mode can be disabled using the `com.gs.protectiveMode.typeWithoutId` system property.

In case your application contains objects without an id you'll get the following exception:

`com.gigaspaces.client.protective.ProtectiveModeException: Cannot introduce a type named 'MyClass' without an id property defined...`

It is highly recommended that you modify them and add a space ID.
If this is not feasible, it can be disabled using the following system property: `-Dcom.gs.protectiveMode.typeWithoutId=false`

## Define a routing property.

Routing property is used to partition the data across different partitions.
It is recommended to define such property explicitly to control how data is partitioned and avoid common mistakes like writing data to the wrong partition.

See more info on [routing property]({%latestjavaurl%}/routing-in-partitioned-spaces.html).

### Protective Mode: Object Without Routing Value(Since 9.7)

Starting 9.7 a new protective mode has been added to protect against writing entries with null value routing.
In case your application contains objects without routing you'll get the following exception:

`com.gigaspaces.client.protective.ProtectiveModeException: Operation is rejected - no routing value provided when writing an entry of type 'MyClass' in a partitioned space. A routing value should be specified within the entry's property named 'myRoutingProperty'. Missing a routing value would result in a remote client not being able to locate this entry as the routing value will not match the partition the entry is located.... `


It is highly recommended that you modify them and add a routing value.
If this is not feasible, and you know what you're doing, it can be disabled using the following system property: `-Dcom.gs.protectiveMode.wrongEntryRoutingUsage=false`

### Protective Mode: Wrong Routing Property(Since 9.7)

Starting 9.7 a new protective mode has been added to protect against writing entries with a wrong routing value.
In case your application writes directly to one of the partitions and assigns the wrong routing value you'll get the following exception:

`com.gigaspaces.client.protective.ProtectiveModeException: Operation is rejected - the routing value in the written entry of type 'MyClass' does not match this space partition id. The value within the entry's routing property named 'symbol' is 100 which matches partition id 1 while current partition id is 2`


It is highly recommended that you modify them and set the right routing.
If this is not feasible, and you knwo what you're doing, it can be disabled using the following system property: `-Dcom.gs.protectiveMode.wrongEntryRoutingUsage=false`


## Don't use primitive types. If you must, then assign null values.

This is enforced by the protective mode:

### Protective Mode: Template with Primitive Properties Without Null Values (Since 9.7)

When querying the space using [template matching]({%latestjavaurl%}/query-template-matching.html), null properties are ignored and non-null properties are matched. Since primitive properties cannot be set to null, a `nullValue` can be assigned to a property to indicate a value which will be treated as null when using template matching. 

See [primitive types matching]({%latestjavaurl%}/query-template-matching.html#primitive-types)

Starting 9.7 a new protective mode has been added to protect against querying with a template which contains one or more primitive properties without a `nullValue`, since such templates are likely to produce unexpected results. 

If your application uses template matching with such types, you'll get the following exception:
`com.gigaspaces.client.protective.ProtectiveModeException: Operation is rejected - template matching on type MyClass is illegal because it has primitive properties without null value: id (int)...`

It is highly recommended that you define `nullValue` where appropriate, or switch to [SQLQuery]({%latestjavaurl%}/sqlquery.html) instead. 

If this is not feasible, this protective mode can be disabled using the following system property: `-Dcom.gs.protectiveMode.primitiveWithoutNullValue=false` 



## Define an index on the properties you need to query. 

TBD

## Don't change nested properties on embedded space

TBD

## Don't use externalizable unless you really know what you're doing 

TBD
