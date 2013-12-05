---
layout: post
title:  LINQ
categories: XAP97NET
parent: querying-the-space.html
weight: 200
---

{% compositionsetup %}
{% summary %}Querying the space using LINQ{% endsummary %}

# Overview

XAP.NET includes a custom LINQ provider, which enables developers to take advantage of their existing .NET skills to query the space without learning a new language.
To enable the provider add the following `using` statement: 
{% highlight csharp linenos %}
using GigaSpaces.Core.Linq; 
{% endhighlight %}

This brings the `Query<T>` extension method into scope, which is the entry point for writing LINQ queries. For example: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Name == "Smith" 
            select p; 

foreach (var person in query) 
{ 
    // ... 
} 
{% endhighlight %}

Another option is to convert the LINQ query to a space query, which can be used with any of the space proxy query operations. For example: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Name == "Smith" 
            select p; 
var result = spaceProxy.Take<Person>(query.ToSpaceQuery()); 
{% endhighlight %}
And finally, you can create an `ExpressionQuery` with a predicate expression: 
{% highlight csharp linenos %}
var result = spaceProxy.Take<Person>(new ExpressionQuery<Person>(p => p.Name == "Smith")); 
{% endhighlight %}
{%tip%}While LINQ is a great syntax for querying a data source, it cannot leverage XAP-specific features (removing results, batching, fifo, transactions, notifications and more). This gap is bridged with `ExpressionQuery`, which allows you to use LINQ with any space query operation.{%endtip%}

{%infosign%} Only LINQ queries that can be translated to an equivalent [SQLQuery](./sqlquery.html) are supported. A LINQ query that cannot be translated will throw an exception at runtime with a message which indicates which part of the query is not supported. 

# Indexing 

It is highly recommended to use indexes on relevant properties to increase performance. For more information see [Indexing](./indexing.html). 

# Supported LINQ operators 

The following LINQ operators are supported:

- [Any](http://msdn.microsoft.com/en-us/library/system.linq.queryable.any) - Returns true if there are any entries matching the query in the space, false otherwise.
- [Count](http://msdn.microsoft.com/en-us/library/system.linq.queryable.count) - Returns true if there are any entries matching the query in the space, false otherwise.
- [LongCount](http://msdn.microsoft.com/en-us/library/system.linq.queryable.longcount) - Same as `Count`, but returns `long` instead of `int`.
- [Single](http://msdn.microsoft.com/en-us/library/system.linq.queryable.single) - Returns the only matching entry from the space. Throws an exception if there are no matching entries or more than one match.
- [SingleOrDefault](http://msdn.microsoft.com/en-us/library/system.linq.queryable.singleordefault) - Returns the only matching entry from the space, or null if there are no matching entries. Throws an exception if there is more than one match.
- [OrderBy](http://msdn.microsoft.com/en-us/library/system.linq.queryable.orderby)/[OrderByDescending](http://msdn.microsoft.com/en-us/library/system.linq.queryable.orderbydescending)/[ThenBy](http://msdn.microsoft.com/en-us/library/system.linq.queryable.thenby)/[ThenByDescending](http://msdn.microsoft.com/en-us/library/system.linq.queryable.thenbydescending) - Specifies the order of the results.
- [Select](http://msdn.microsoft.com/en-us/library/system.linq.queryable.select) - Specifies if the entire entry is returned or a subset of its properties (see [Projection](#projection)).
- [Where](http://msdn.microsoft.com/en-us/library/system.linq.queryable.where) - Specifies the criteria used for querying the space (see [predicates](#predicates))

# Predicates 

The XAP LINQ provider supports various operators, as explained below. 
For the following code samples, assume the following classes are defined: 
{% highlight csharp linenos %}
public class Person 
{ 
    public String Name {get; set;} 
    public int NumOfChildren {get; set;} 
    public ICollection<String> Aliases {get; set;} 
    [SpaceProperty(StorageType = StorageType.Document)] 
    public Address HomeAddress {get; set;} 
    [SpaceProperty(StorageType = StorageType.Document)] 
    public IDictionary<String, Address> Addresses {get; set;} 
    [SpaceProperty(StorageType = StorageType.Document)] 
    public Car[] Cars {get; set;} 
} 

public class Address 
{ 
    public String City {get; set;} 
    public String Street {get; set;} 
} 

public class Car 
{ 
    public String Color {get; set;} 
    public String Manufacturer {get; set;} 
} 

{% endhighlight %}

## Equality Operators 
Use the standard `==` and `!=` operators for equals/not equals conditions, respectively. For example, to query for entries whose *Name* is *"Smith"*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Name == "Smith" 
            select p; 
{% endhighlight %}

## Comparison Operators 
Use the standard `>`, `>=`, `<`, and `<=` for comparisons, respectively. For example, to query for entries whose *NumOfChildren* is greater than *2*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.NumOfChildren > 2 
            select p; 
{% endhighlight %}

## Conditional Operators 
Use the standard `&&` and `||` for conditional and/or expressions, respectively. For example, to query for entries whose *Name* is *"Smith"* and *NumOfChildren* is greater than *2*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Name == "Smith" && p.NumOfChildren > 2 
            select p; 
{% endhighlight %}

## Nested Paths 

Nested paths can be traversed and queried using the dot (`.`) notation. For example, to query for entries whose *HomeAddress*'s *Street* equals *Main*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.HomeAddress.Street == "Main" 
            select p; 
{% endhighlight %}

Dictionary entries can be traversed as well. For example, to query for entries whose *Addresses* contains a *Home* key which maps to an `Address` whose *Street* equals *Main*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Adresses["Home"].Street == "Main" 
            select p; 
{% endhighlight %}

{%exclamation%} By default user-defined types are stored in the space in a binary format, which cannot be queried. If the path includes a user-defined type, the relevant property's storage type should be set to *Document*. For more information refer to [Property Storage Type](./property-storage-type.html). 

## Sub-strings 

The [System.String](http://msdn.microsoft.com/en-us/library/System.String) methods [Contains(String)](http://msdn.microsoft.com/en-us/library/dy85x1sa), [StartsWith(String)](http://msdn.microsoft.com/en-us/library/baketfxw) and [EndsWith(String)](http://msdn.microsoft.com/en-us/library/2333wewz) can be used to match sub-strings of a member. For example, to query for entries whose *Name* ends with *"Smith"*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Name.EndsWith("Smith") 
            select p; 
{% endhighlight %}

{%exclamation%} The `StartsWith` and `EndsWith` methods have multiple overloads, but only the single-parameter overload is supported in this LINQ provider. 

## Collection Membership 

The [Enumerable.Contains(T value)](http://msdn.microsoft.com/en-us/library/bb352880) extension method can be used to check if any of the collection match a specific value. For example, to query for entries whose *Aliases* contains *"Smith"*: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Aliases.Contains("Smith") 
            select p; 
{% endhighlight %}

In addition, the [Enumerable.Any(Func(T, bool))](http://msdn.microsoft.com/en-us/library/bb534972) extension method can be used to check if any of the collection items match a specific predicate. For example, to query for entries whose *Cars* contains a red honda: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where p.Cars.Any(c => c.Color == "Red" && c.Manufacturer == "Honda") 
            select p; 
{% endhighlight %}

Another option is to test if the member is part of a collection, (a.k.a IN clause in traditional SQL). For example, to query for entries whose *Name* is one of the items of a given array: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() 
            where new String[] {"Smith", "Doe"}.Contains(p.Name) 
            select p; 
{% endhighlight %}

{%exclamation%} By default user-defined types are stored in the space in a binary format, which cannot be queried. If the path includes a user-defined type, the relevant property's storage type should be set to *Document*. For more information refer to [Property Storage Type](./property-storage-type.html).  

# Projection 

{%exclamation%} Under Construction 

# Batch results 

Consider the following query: 
{% highlight csharp linenos %}
var query = from p in spaceProxy.Query<Person>() select p; 
foreach (var person in query) 
{ 
    // ... 
} 
{% endhighlight %}

The default implementation is to execute a `ReadMultiple` under the hood, which retrieves all the matching entries at once, then enumerates them one by one. However, if the size of the result is large, two potential problems can occur:
 
- All the entries must be fetched before processing starts, i.e. the last entry must be loaded before the first entry is iterated. 
- The size of the result might be too large for the client's memory, in which case the application will fail with an out of memory exception. 

The solution to both problem is the same - batching. For example, the previous example can be modified as such: 
{% highlight csharp linenos %}
var query = (from p in spaceProxy.Query<Person>() select p).Batch(100); 
foreach (var person in query) 
{ 
    // ... 
} 
{% endhighlight %}
The `Batch()` extension method instructs the provider to retrieve the results in batches not exceeding 100 entries each. This both protects the memory usage and allows processing to start before all entries are retrieved. 

{%infosign%} Batching is suitable for large result sets, but on small ones it actually slows performance down, as it require multiple remote calls to the space to retrieve the data instead of fetching it all at once.