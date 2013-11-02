---
layout: xap97net
title:  Reading Entries
categories: XAP97NET
page_id: 63799307
---


{% summary %}Reading entries from the space{% endsummary %}


# Overview

Entries can be retrieved from the space using the `Read` method. A read operation queries the space for an entry matching the provided [template|Query Template Types], and returns a copy of that entry (or null, if no match is found).
The returned object is a copy of the entry stored in the space, which means that changing the returned object does not affect the entry stored in the space.

{% refer %}See [Storing and Retrieving Entries|Storing and Retrieving Entries#Retrieving an Entry - Read] for basic reading demonstration.{% endrefer %}

This page demonstrates basic space operations using a class called `Person`:


{% highlight java %}
public class Person
{
   private String _name;
   private String _country;

   public String Name
   {
      get { return _name; }
      set { _name = value; }
   }

   public String Country
   {
      get { return _country; }
      set { _country = value; }
   }

   public Person()
   {
   }
}
{% endhighlight %}


{% refer %}See also the [Object Metadata] and [GS.XML Metadata] sections for details about the GigaSpaces class decorations you may specify.{% endrefer %}

# Blocking Read

Calling `Read` searches the space for a matching entry. If no match is found, the call returns immediatly with null.
In some scenarios an application may need to poll the space until a matching entry is available. Instead of calling read and doing a `Thread.Sleep()` in a loop, you can use the `timeout` argument to get a blocking behaviour. For example:

{% highlight java %}
Person template = new Person();
// This call will block until a matching Person is available or 10 seconds have elapsed.
Person p = proxy.Read(template, 10000);
{% endhighlight %}


If the space contains a Person when the call is executed, it will return immediately. If the space does not contain a Person, the call will block until someone writes a Person to the space, or until the timeout has elapsed (in which case null is returned).
Calling `Read` without a timeout argument will use the default value stored in `ISpaceProxy.DefaultTimeout`, which is zero by default.
Calling `Read` with a timeout argument ignores `ISpaceProxy.DefaultTimeout`.

# Reading from a Partitioned Cluster

In a partitioned cluster each entry is stored in a specific partition, according to its routing property. When reading from such a cluster, if the routing property is specified in the template, the read request is sent directly to the relevant partition (which may or may not contain a match). If the routing property is not specified, the read request is broadcasted to all the cluster members, looking for a match. Naturally queries which include the routing property are more efficient (no broadcast means less network traffic) and faster (the proxy does not have to wait for a response from multiple members).

Setting the routing property is usually done using the `SpaceRouting` attribute. For example, to set the `Country` property as the routing property of the `Person` class:

{% highlight java %}
public class Person
{
   ...
   [SpaceRouting]
   public String Country
   {
      get { return _country; }
      set { _country = value; }
   }
   ...
}
{% endhighlight %}


{% refer %}For more information about routing, see [SpaceRouting|Object Metadata#Routing] or [GS.XML Metadata].{% endrefer %}
{% exclamation %} **Note:** depanlinkBlocking readtengahlink#Blocking Readbelakanglink is not supported on a clustered proxy.

# Improving performance

If a certain property is commonly used when querying the space, you can instruct the space to index it for faster retrieval. Moreover, if one of the object's properties is marked as `SpaceID` and is used in the template, the matching mechanism will recognize it and use it to optimize the search.

{% refer %}See also [Unique Constraints|Object Metadata#Unique Constraints]. {% endrefer %}
{% refer %}See also [Indexing|Object Metadata#Indexing]. {% endrefer %}

# When a Template Matches More Than One Entry

Let's examine the following piece of code:

{% highlight java %}
Person p1 = new Person();
p1.Name = "Alice";
proxy.Write(p1);
Person p2 = new Person();
p2.Name = "Bob";
proxy.Write(p2);
Person result1 = proxy.Read(new Person());
Person result2 = proxy.Read(new Person());
{% endhighlight %}


Assuming the space was empty and no one else is accessing the space at the same time:
**Q)** What's in result1?
**A)** The result could be either Alice or Bob - the space does not guarantee order.
**Q)** What's in result2?
**A)** The result could be either Alice or Bob - the space does not guarantee order, and since read operations do not affect the space, a previous read does not affect the next read.

If you're interested in reading multiple entries at once, you can use the `ReadMultiple` operation. This operation is very similiar to the `Read` operation but it returns an array of entries instead of a single result. To limit the maximum number of results use the `maxItems` argument (default is `Int32.MaxValue`).

{% exclamation %} Calling `ReadMultiple` operation with a large `maxItems` argument is dangerous - if the space contains many matching entries the result set will be very large, which will impact the network traffic and performance, and possibly result in an out of memory exception. for more information, see the `IReadOnlySpaceProxy.GetSpaceIterator`.

{% refer %}If you're interested in guaranteeing First-In-First-Out, see [FIFO support]. {% endrefer %}
