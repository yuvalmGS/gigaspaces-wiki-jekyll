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


<hr/>

- Define an id property 
Id property is essential for update operation and also there are a lot of "byId" operations that use the id to perform read/take/update very efficiently without fetching the whole object. 
Since 9.1 this is enforce by the protective mode
- Always define a routing property.
- Define an index on the properties you need to query. (this one is tricky, cause we don't want them to define indexes on every property)
- Don't change nested properties on embedded space
- Don't use externalizable unless you really know what you're doing 

<hr/>

#  Protective Modes

We at GigaSpaces occasionally pick up bad usage patterns which lead to common user errors, and try to improve the product to prevent it. Sometimes a plain validation is too harsh, as it might break backwards compatibility and prevent existing customers from upgrading to the latest version. In such cases we may create a *Protective Mode*, which means that the validation is on by default, but can be disabled using a system property. This protects new customers from repeating old mistakes, and encourages existing customers to fix their code (yet allows them to disable the protection if they choose so).

### Protective Mode: Type Without Space ID (Since 9.7)

Writing an entry to the space without a [space ID]({%latestjavaurl%}/query-by-id.html) is error-prone - it can lead to duplicate entries, bad performance and more. Starting 9.7 a new protective mode has been added to protect against writing such entries. this protective mode can be disabled using the `com.gs.protectiveMode.typeWithoutId` system property.

In case your application contains objects without an id you'll get the following exception:

It is highly recommended that you modify them and add a space ID.
If this is not feasible, it can be disabled using the follwoing system propety: `-Dcom.gs.protectiveMode.typeWithoutId=true`

### Protective Mode: Template with Primitive Properties Without Null Values (Since 9.7)

When querying the space using [template matching]({%latestjavaurl%}/query-template-matching.html), null properties are ignored and non-null properties are matched. Since primitive properties cannot be set to null, a `nullValue` can be assigned to a property to indicate a value which will be treated as null when using template matching. Starting 9.7 a new protective mode has been added to protect against querying with a template which contains one or more primitive properties without a `nullValue`, since such templates are likely to produce unexpected results. If your application uses template matching with such types, it is highly recommended that you define `nullValue` where appropriate, or switch to [SQLQuery]({%latestjavaurl%}/sqlquery.html) instead. If this is not feasible, this protective mode can be disabled using the `com.gs.protectiveMode.primitiveWithoutNullValue` system property.
