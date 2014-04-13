---
layout: post
title:  Object Metadata
categories: XAP97NET
parent: modeling-your-data.html
weight: 400
---

{% summary %}{% endsummary %}



In general, every object can be stored in the space - it does not have to inherit from a base class, implement an interface, or have any attributes decorating it. It doesn't even have to be Serializable, although it is recommended as a design practice, to keep in-line with .NET standards. The only requirement is to have a parameterless constructor.

However, in many cases this generic approach is not enough. For example, you may want to exclude a specific field from being stored in the space, or specify that a certain property should be indexed for faster matching performance. In such cases (and others), you can use a set of attributes to customize the object's behaviour in the space.

If you don't want to (or can't) use XAP.NET attributes in your classes code, you can create an xml file that defines those behaviours, commonly called `gs.xml`.

{% info %}
Since working with attributes is usually simpler and easier, this page demonstrates all the features using attributes. However, every feature shown here can also be achieved using [`gs.xml`](./poco-gs.xml-metadata.html).
{%endinfo%}

# Including/Excluding Content from the Space

By default, all public members (fields and properties) in a class are stored in the space, whereas non-public members are ignored. Since classes are usually designed with private/protected fields and public properties wrapping them, in most cases the default behaviour is also the desired one.

To change this behaviour for a specific class, apply a `[SpaceClass]` attribute on that class, and use `IncludeProperties` and/or `IncludeFields` to specify which members should be included in the space. Both `IncludeProperties` and `IncludeFields` are an `IncludeMembers` enumeration, which can receive the following values:

- `IncludeMembers.All` -- all members are stored.
- `IncludeMembers.Public` -- public members are stored, and non-public members are ignored
- `IncludeMembers.None` -- all members are ignored.

#### Example 1 -- The default behaviour

{% highlight csharp %}
public class Person {...}
{% endhighlight %}

This is actually equivalent to the following declaration:

{% highlight csharp %}
[SpaceClass(IncludeFields=IncludeMembers.Public, IncludeProperties=IncludeMembers.Public)]
public class Person {...}
{% endhighlight %}

#### Example 2 -- To ignore all properties and store all the fields, including private ones

{% highlight csharp %}
[SpaceClass(IncludeFields=IncludeMembers.All, IncludeProperties=IncludeMembers.None)]
public class Person {...}
{% endhighlight %}

{% info title=Different Accessors for Properties %}
Starting with .NET v2.0, properties can have different accessors for getters and setters (e.g. public getter and private setter). In such cases, if either the getter or the setter is public, the space treats the property as public (i.e. `IncludeProperties=IncludeMembers.Public` means that this property is stored).
{% endinfo %}

{% info title=Read-Only Properties %}
Read-only properties (getter without setter) are stored in the space, but when the object is deserialized, the value is not restored, since there is no setter. This enables the space to be queried using such properties. There are two common scenarios for read-only properties:

- Calculated value -- the property returns a calculated value based on other fields/properties. This isn't a problem since no data is lost due to the 'missing' setter.
- Access protection -- the class designer wishes to protect the property from outside changes. This is probably a problem since the field value is lost. To prevent this problem, consider adding a private setter, or excluding the property and including the field (as explained next).
{% endinfo %}

To change the behaviour of a specific field/property, apply a `[SpaceProperty]` to include it, or a `[SpaceExclude]` to exclude it. These settings override the class-level settings.

#### Example 3 -- Storing all the Person properties except the Password property

{% highlight csharp %}
public class Person
{
    [SpaceExclude]
    public string Password {...}
}
{% endhighlight %}

# Indexing

If a property is commonly used in space queries, you can instruct the space to index that property for improved read performance. To do this, use the `[SpaceIndex]` attribute, and specify `Type=SpaceIndexType.Basic`.

{% highlight csharp %}
public class Person
{
    [SpaceIndex(Type=SpaceIndexType.Basic)]
    public string UserID {...}
}
{% endhighlight %}

{% info title=Indexing Pros and Cons %}
Indexing a property speeds up queries which use the property, but slows down write operations for that object (since the space needs to index the property). For that reason, indexing is off by default, and it's up to the user to decide which fields should be indexed.
{% endinfo %}

# Unique Constraints

When an object is stored in the space, the space generates a unique identifier and stores it along with that object. The unique identifier is commonly referred to as a Space ID or UID. In many cases, it's useful to have the object's space ID or to control it. Some examples:

- The Space ID can be used as a uniqueness constraint, preventing logically duplicate entries from being stored in the space.
- Queries performed with the UID are much faster, since the query mechanism can reduce the result set efficiently.

There are two modes of SpaceID that are supported:

- If you want the space to automatically generate the UID for you, specify `[SpaceID(AutoGenerate=true)]` on the property which should hold the generated ID. A SpaceID field that has AutoGenerate=true specified, must be of type `string`.
- If you want the space to generate the UID using a specific property's value, specify `[SpaceID(AutoGenerate=false)]` on that property.

The default is `AutoGenerate=false`. Note that only one property in a class can be marked as a SpaceID property.

{% note %}
There is no need to explicitly index a field which is marked as SpaceID, because it is already indexed.
{%endnote%}

# Routing

When working with a clustered space, one of the properties in a class is used to determine the routing behaviour of that class within the cluster (i.e. how instances of that class are partitioned across the cluster's nodes). The routing property is determined according to the following rules:

1. The property marked with `[SpaceRouting]` attribute.
2. Otherwise, the property marked with `[SpaceID]` is used.
3. Otherwise, the first indexed property in alphabetical order is used.
4. Otherwise, the first property in alphabetical order is used.

Note that only one property in a class can be marked as a routing property.

{% tip title=Declare the routing property explicitly %}
It's highly recommended to explicitly declare which property is the routing property, and not rely on rules 2 and onward. Relying on those rules can lead to confusing problems (e.g. the SpaceID is changed, or an index is added to a property, etc.). Explicitly declaring the routing property makes your code clearer and less error-prone.
{% endtip %}

# Versioning

The space can keep track of an object's version (i.e. how many times it was written/updated in the space), and provide optimistic concurrency using that version information. For that end, the space needs to store the object's version in some property in the object. To specify that a property should be used for versioning, mark it with a `[SpaceVersion]` attribute. If no property is marked as a space version, the space does not store version information for that class.

Note that only one property in a class can be marked as a version property, and it must be of type `int`.

# NullValue

When a class contains a field or a property of not a nullable type, (for instance a primitive such as `int` or a struct such as `DateTime`), it is recommended to specify a null value for it that will be used when querying the space for that class. The `NullValue` attribute instructs the space to ignore this field when performing matching or partial update, when the content of the field in the template equals the defined `NullValue`.

{% info title=Nullables %}
It is recommended to avoid the usage of such fields and properties, and the need to define null values, by wrapping them with their corresponding Nullable, for instance Nullable<int> or Nullable<DateTime>.
{% endinfo %}

To specify a null value, the field or property should be marked with the `[SpaceProperty(NullValue = ?)]` attribute:

Example #1 - Null value on a primitive int

{% highlight csharp %}
public class Person
{
    [SpaceProperty(NullValue = -1)]
    public int Age {...}
}
{% endhighlight %}

Example #2 - Null value on DateTime

{% highlight csharp %}
public class Person
{
    [SpaceProperty(NullValue = "1900-01-01T12:00:00")]
    public DateTime BornDate {...}
}
{% endhighlight %}

# Mapping

By default, the name of the class in the space is the fully-qualified class name (i.e. including namespace), and the properties/fields names in the space equal to the .NET name. In some cases, usually in interoperability scenarios, you may need to map your .NET class name and properties to different names in the space. You can do that using the `AliasName` property on `[SpaceClass]` and `[SpaceProperty]`. For example, the following .NET Person class contains mapping to an equivalent Java Person class:

{% highlight csharp %}
namespace MyCompany.MyProject
{
    [SpaceClass(AliasName="com.mycompany.myproject.Person")]
    public class Person
    {
        [SpaceProperty(AliasName="firstName")]
        public String FirstName {...}
    }
}
{% endhighlight %}

For more information, see [GigaSpaces.NET - Interoperability With Non .NET Applications](./interoperability.html).

{% note title=AliasName and SqlQuery %}
When using space SqlQuery on an object with properties which are aliased, the query text needs to use the aliased property names. For more information about SqlQuery, see [GigaSpaces.NET - Sql Query](./query-sql.html).
{% endnote %}

# Persistency

The space can be attached to an external data source and persist its classes through it. A certain class can be specified if it should be persisted or not. To do this, use the `[SpaceClass(Persist=true)]` or `[SpaceClass(Persist=false)]` class level attribute.

{% highlight csharp %}
[SpaceClass(Persist=false)]
public class Person {...}
{% endhighlight %}

The default is `[SpaceClass(Persist=true)]`.

# Replication

Some cluster toplogies have replication defined, which means that some or all of the data is replicated between the spaces. In this case, it can be specified whether each class should be replicated or not, by using the `[SpaceClass(Replicate=true)]` or `[SpaceClass(Replicate=false)]` class level attribute.

{% highlight csharp %}
[SpaceClass(Replicate=false)]
public class Person {...}
{% endhighlight %}

The default is `[SpaceClass(Replicate=true)]`.

# FIFO

A class can be marked to operate in FIFO mode, which means that all the insert, removal and notification of this class should be done in First-in-First-out mode. It can be specified whether each class should operate in FIFO mode or not, by using the `[SpaceClass(Fifo=true)]` or `[SpaceClass(Fifo=false)]` class level attribute.

{% highlight csharp %}
[SpaceClass(Fifo=true)]
public class Person {...}
{% endhighlight %}

The default is `[SpaceClass(Fifo=false)]`.
