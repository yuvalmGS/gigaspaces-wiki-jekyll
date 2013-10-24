---
layout: xap97net
title:  ID Queries
categories: XAP97NET
page_id: 63799334
---

{summary}How to query the space using entry ID{summary}

h1. Overview

The space can be queried for entries using [Template Matching] or [SQLQuery], but sometimes we know the exact id of the entry we need and prefer a faster solution. This is where id-based queries come handy.

h1. Reading an Entry By ID

When you would like to access an object using its ID for read and take operations you should first specify the ID field. You can specify it via {{@SpaceId (autogenerate=false)}} annotation:
{code}

[SpaceId (autoGenerate=false)]
public String getEmployeeID() {
    return employeeID;
}
{code}

To read the object back from the space using its ID and the {{readById}} operation:
{code}
GigaSpace gigaSpace;
Employee myEmployee = gigaSpace.readById(Employee.class , myEmployeeID , routingValue);
{code}

h1. Reading Multiple Entries by IDs
The following shows how to read multiple objects using their IDs:
{code}
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

{code}

{tip}See [Parent Child Relationship] for a full usage example of the {{readByIds}} operation.
ReadById is intended to objects with meaningful ids,if used with auto-generate="true" ids,the given object type will be ignored.{tip}
