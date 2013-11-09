---
layout: xap97net
title:  ID Queries
categories: XAP97NET
page_id: 63799334
---

{% summary %}How to query the space using entry ID{% endsummary %}

# Overview

The space can be queried for entries using [Template Matching](./template-matching.html) or [SQLQuery](./sqlquery.html), but sometimes we know the exact id of the entry we need and prefer a faster solution. This is where id-based queries come handy.

# Reading an Entry By ID

When you would like to access an object using its ID for read and take operations you should first specify the ID field. You can specify it via `@SpaceId (autogenerate=false)` annotation:

{% highlight java %}

[SpaceId (autoGenerate=false)]
public String getEmployeeID() {
    return employeeID;
}
{% endhighlight %}

To read the object back from the space using its ID and the `readById` operation:

{% highlight java %}
GigaSpace gigaSpace;
Employee myEmployee = gigaSpace.readById(Employee.class , myEmployeeID , routingValue);
{% endhighlight %}

# Reading Multiple Entries by IDs

The following shows how to read multiple objects using their IDs:

{% highlight java %}
GigaSpace gigaSpace;

// Initialize an ids array
Integer[] ids = new Integer[] { ... };

// Set a routing key value (not mandatory but more efficient)
Integer routingKey = ...;

// Read objects from space
ReadByIdsResult<Employee> result = gigaSpace.readByIds(Employee.class, ids, routingKey);

// Loop through results
for (Employee employee : result) {
  // ...
}

{% endhighlight %}

{% tip %}
See [Parent Child Relationship]({%latestjavaurl%}/parent-child-relationship.html) for a full usage example of the `readByIds` operation.
ReadById is intended to objects with meaningful ids,if used with auto-generate="true" ids,the given object type will be ignored.
{% endtip %}

