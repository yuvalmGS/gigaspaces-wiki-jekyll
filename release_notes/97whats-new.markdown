---
layout: post
title:  What's new
categories: RELEASE_NOTES
parent: xap97.html
weight: 100
---

{%summary%} What's new in XAP 9.7 {%endsummary%}

# Overview

This page lists the main new features in XAP 9.7 (Java and .Net editions). It's not an exhaustive list of all new features. For a full change log for 9.7 please refer to the [new features](97new-features.html) and [fixed issues](97new-features.html) pages. 

# LINQ Support for XAP.NET 

LINQ (which stands for Language-Integrated Query) is a feature of the .Net framework and allows the user to use SQL like syntax within their code to filter and select subsets information from various data sources (relational and non relational databases, arrays, collections, etc.). XAP.NET 9.7 implements a custom LINQ provider which allows the developer to use LINQ experessions to query the space. Here's an example: 

{% highlight csharp %}
var query = from p in spaceProxy.Query<Person>() 
2             where p.Name == "Smith" 
3             select p; 
4 
5 foreach (var person in query) 
6 { 
7     // ... 
8 } 
{% highlight %}

For more details please refer to the [LINQ reference page](/xap97net/linq.html) in the XAP.Net 9.7 documentation. 

# Change API Enhancements
The change API now includes an option to get the previous value ofa changed field. XAP 9.7 also includes a new mechanism called [Change Extension](/xap97/change-extension.html) that excapsulates common usage patterns (such as Add and Get) into simpler to use API calls. Here's an example for an add and get operation that uses the change extenstion mechanism:

{% highlight java %} 
GigaSpace space = // ... obtain a space reference
Integer id = ...;
IdQuery<WordCount> idQuery = new IdQuery<WordCount>(WordCount.class, id, routing);
Integer newCounter = ChangeExtension.addAndGet(space, idQuery, "counter", 1);
{% highlight %}

# Unique Indexes 

You can now add a uniqueness constraint for indexes fields, making sure that values stay unique for that fields in the boundaries of a single space partition. This available for both [Java](/xap97/indexing-unique.html) and [.Net](/xap97net/indexing-unique.html). Here's an example for how it's defined: 


{% inittab %}
{% tabcontent Java %}
@SpaceClass
public class Person
{
  @SpaceIndex(type=SpaceIndexType.BASIC, unique = true)
  private String lastName;

  @SpaceIndex(type=SpaceIndexType.BASIC)
  private String firstName;

  @SpaceIndex(type=SpaceIndexType.EXTENDED)
  private Integer age;
{% endtabcontent%}

{% tabcontent .Net %}
{% highlight csharp %} 
[SpaceClass]
public class Person
{

    ...
    [SpaceIndex(Type=SpaceIndexType.Basic)]
    public String FirstName{ get; set;}

    [SpaceIndex(Type=SpaceIndexType.Basic, Unique=true)]
    public String LastName{ get; set; }

    [SpaceIndex(Type=SpaceIndexType.Extended)]
    public int? Age{ get; set; }
}

{% highlight %}
{% endtabcontent%}
{% endinittab%}

# Zone Controlled Deployment

# MongoDB External Data Source

# Advanced Projections support

# Immutable Objects Support

# Zone controlled deployment

# Grid activity broken down to clients on GUI

# Better Separation of Thread Pools 

# Better Detection of Hung Operations

# New Documentation Infrastructure and Enhanced Search 







