---
layout: post
title:  Indexing
categories: XAP97
---

{% compositionsetup %}
{% summary %} Using indexes to improve performance. {% endsummary %}

# Overview

When a space is looking for a match for a read or take operation, it iterates over non-null values in the template, looking for matches in the space. This process can be time consuming, especially when there are many potential matches. To improve performance, it is possible to index one or more properties. The space maintains additional data for indexed properties, which shortens the time required to determine a match, thus improving performance.

# Choosing which Properties to Index

One might wonder why properties are not always indexed, or why all the properties in all the classes are not always indexed. The reason is that indexing has its downsides as well:

- An indexed property can speed up read/take operations, but might also slow down write/update operations.
- An indexed property consumes more resources, specifically memory footprint per entry.

# When to Use Indexing

Naturally the question arises of when to use indexing. Usually it is recommended to index properties that are used in common queries. However, in some scenarios one might favour less footprint, or faster performance for a specific query, and adding/removing an index should be considered.

{% lampon %}  Remember that "Premature optimization is the root of all evil". It is always recommended to benchmark your code to get better results.

# Index Types

The index type is determined by the **`SpaceIndexType`** enumeration. The index types are:

**`NONE`** - No indexing is used.
**`BASIC`** - Basic index is used - this speeds up equality matches (equal to/not equal to).
**`EXTENDED`** - Extended index - this speeds up comparison matches (bigger than/less than).

# Indexing at Design-time

Specifying which properties of a class are indexed is done using annotations or gs.xml.

{% inittab %}
{% tabcontent Annotations %}

{% highlight java %}
@SpaceClass
public class Person
{
    private String lastName;
    private String firstName;
    private Integer age;

    ...
    @SpaceIndex(type=SpaceIndexType.BASIC)
    public String getFirstName() {return firstName;}
    public void setFirstName(String firstName) {this.firstName = firstName;}

    @SpaceIndex(type=SpaceIndexType.BASIC)
    public String getLastName() {return lastName;}
    public void setLastName(String name) {this.lastName = name;}

    @SpaceIndex(type=SpaceIndexType.EXTENDED)
    public Integer getAge() {return age;}
    public void setAge(Integer age) {this.age = age;}
}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent XML %}

{% highlight java %}
<gigaspaces-mapping>
    <class name="com.gigaspaces.examples.Person" persist="false" replicate="false" fifo="false" >
        <property name="lastName">
            <index type="BASIC"/>
        </property>
        <property name="firstName">
            <index type="BASIC"/>
        </property>
        <property name="age">
             <index type="EXTENDED"/>
        </property>
    </class>
</gigaspaces-mapping>
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

## Inheritance

By default, a property's index is inherited in sub classes (i.e. if a property is indexed in a super class, it is also indexed in a sub class). If you need to change the index type of a property in a subclass you can override the property and annotate it with `@SpaceIndex` using the requested index type (to disable indexing use `NONE`).

# Indexing at Run-time

Indexes can be added dynamically at run-time using the GigaSpaces Management Center GUI or via API using the `GigaSpaceTypeManager` interface.

{% exclamation %} Removing an index or changing an index type is currently not supported.

# Nested Properties Indexing

An index can be defined on a nested property to improve performance of nested queries - this is highly recommended.

Nested properties indexing uses an additional `@SpaceIndex` attribute - **`path()`**.

## The `SpaceIndex.path()` Attribute

The **`path()`** attribute represents the path of the property within the nested object.

Below is an example of defining an index on a nested property:

{% inittab example|top %}
{% tabcontent Single Index Annotation %}

{% highlight java %}
@SpaceClass
public class Person {
    private int id;
    private Info personalInfo;
    private String description;
    //getter and setter methods
    ...

    // this defines and EXTENDED index on the personalInfo.socialSecurity property
    @SpaceIndex(path = "socialSecurity", type = SpaceIndexType.EXTENDED)
    public Info getPersonalInfo() {
         return personalInfo;
    }
}

public static class Info implements Serializable {
	private String name;
	private Address address;
	private Date birthday;
	private long socialSecurity;
	private int _id;
	//getter and setter methods
}

public static class Address implements Serializable {
	private int zipCode;
	private String street;
	//getter and setter methods
}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Multiple Indexes Annotation %}

{% highlight java %}
@SpaceClass
public static class Person {
	private int id;
	private Info personalInfo;
	private String description;
	private HashMap<String, String> map;

	//getter and setter methods
	...

	// this defines several indexes on the same personalInfo property
	 @SpaceIndexes( { @SpaceIndex(path = "socialSecurity", type = SpaceIndexType.EXTENDED),
			  @SpaceIndex(path = "address.zipCode", type = SpaceIndexType.BASIC)})
	public Info getPersonalInfo() {
		 return personalInfo;
	}

	// this defines indexes on map keys
	@SpaceIndexes(	{@SpaceIndex(path="key1" , type = SpaceIndexType.BASIC),
			@SpaceIndex(path="key2" , type = SpaceIndexType.BASIC)})
	public HashMap<String, String> getMap() {
		return map;
	}
	public void setMap(HashMap<String, String> map) {
		this.map = map;
	}
}

public static class Info implements Serializable {
	private String name;
	private Address address;
	private Date birthday;
	private long socialSecurity;
	private int _id;
	//getter and setter methods
}

public static class Address implements Serializable {
	private int zipCode;
	private String street;
	//getter and setter methods
}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent XML %}

{% highlight xml %}
<gigaspaces-mapping>
    <class name="com.gigaspaces.examples.Person"  >
         <property name="personalInfo">
		<index path="socialSecurity" type = "extended"/>
		<index path="address.zipCode" type = "basic"/>
	</property>
    </class>
</gigaspaces-mapping>
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

The following is an example of query code that automatically triggers this index:

{% highlight java %}
SQLQuery<Person> query = new SQLQuery<Person>(Person.class,
	"personalInfo.socialSecurity<10000050L and personalInfo.socialSecurity>=10000010L");
{% endhighlight %}

{% infosign %} For more information, see [Nested Object Queries](./sqlquery.html#Nested Properties)

{% info title=Map based nested properties %}
Note that the same indexing techniques above are also applicable to Map-based nested properties, which means that in the example above the `Info` and `Address` classes could be replaced with a `java.util.Map<String,Object>`, with the map keys representing the property names.
{% endinfo %}

# Collection Indexing

An index can be defined on a Collection property (java.util.Collection implementation) or Array. Setting such an index means that each of the Collection's or Array's items is indexed. Setting an index on a Collection / Array done using the SpaceIndex.path() attribute where a Collection / Array property should be followed by "\[\*\]".

The following example shows how to define an index on a List of Integers:

{% highlight java %}
@SpaceClass
public class CollectionIndexingExample {
  private Integer id;
  private List<Integer> numbers;

  // Getter and setter methods...

  @SpaceIndex(path="[*]")   // This means that each Integer in the List is indexed.
  public List<Integer> getNumbers() {
    return this.numbers;
  }

}
{% endhighlight %}

The following query shows how to use the index:

{% highlight java %}
SQLQuery<CollectionIndexingExample> sqlQuery = new SQLQuery<CollectionIndexingExample>(
    CollectionIndexingExample.class, "numbers[*] = 30");
CollectionIndexingExample[] result = gigaspace.readMultiple(sqlQuery, Integer.MAX_VALUE);
{% endhighlight %}

{% exclamation %} See the [Free Text Search](./sqlquery.html#Free Text Search) section for more details.

### Nested property within a Collection

Its also possible to index a nested property within a collection.

The following example shows how to define an index on Book.id property which resides in a Collection property in Author:

{% highlight java %}
@SpaceClass
public class Author {
  private String name;
  private Collection<Book> books;

  // Getter and setter methods...

  @SpaceIndex(path="[*].id")   // This means that each Book.id in the Collection is indexed.
  public Collection<Book> getBooks() {
    return this.books;
  }
}

public class Book {
  private Integer id;
  private String name;

  // Getter and setter methods...

  public Integer getId() {
    return this.id;
  }
}
{% endhighlight %}

The following query shows how to take advantage of the defined index:

{% highlight java %}
SQLQuery<Author> sqlQuery = new SQLQuery<Author>(Author.class, "books[*].id = 57");
Author result = gigaspace.read(sqlQuery);
{% endhighlight %}

Setting an index on a Collection within a nested property is also accepted:

{% highlight java %}
@SpaceClass
public class Employee {
  private Long id;
  private Information information;

  // Getter and setter methods...

  @SpaceIndex(path="phoneNumbers[*]")
  public Information getInformation() {
    return this.information;
  }

}

public class Information {
  private Address address;
  private List<String> phoneNumbers;

  // Getter and setter methods...

  public List<String> getPhoneNumbers() {
    return this.phoneNumbers;
  }

}
{% endhighlight %}

{% info %}
Both @SpaceIndex(type=SpaceIndexType.BASIC) and @SpaceIndex(type=SpaceIndexType.EXTENDED) are supported.
{% endinfo %}

# Compound Indexing

A Compound Index is a space index composed from several properties or nested properties (aka paths). Each property of a compound index is called a segment and each segment is described by its path. The benefit of using a compound index is shorter scanning of potential matching entries - which is equivalent to the intersection of all the entries having the values described by the segments. In other words - when having a set of objects within the space where:
Condition A : Field X = 10 - have a million matching objects.
Condition B : Field Y = 100 - have a million matching objects
Condition C = Condition A AND Condition B = (Field X = 10 AND Field Y = 100) - have 10,000 matching objects

Using a Compound Index that will be based on field X and field Y will improve a query evaluating **Condition C** significantly.

An attribute can be a segment of several compound indexes, and can be indexed itself. Compound indexes can be only `BASIC` indices - they support equality based queries only. The name of the compound index is composed from the paths of its segments separated by a "+" sign.

{% info %}
All segments of a compound index must have consistent `hashCode()` and `equals()` methods implementation and must use the OBJECT [StorageType](./storage-types---controlling-serialization.html).
{% endinfo %}

## Creating a Compound Index using POJO Annotation

Compound indexes can be defined using annotations. The `CompoundSpaceIndex` and `CompoundSpaceIndexes` annotations should be used. The annotations are a type-level annotations.

Example: Below a compound index with two segments using annotations. Both are properties at the root level of the space class:

{% highlight java %}
@CompoundSpaceIndexes(
{ @CompoundSpaceIndex(paths = {"data1", "data2"}) }
)
@SpaceClass
public class Data {
	String id;
	String data1;
	String data2;
	// getter and setter methods - no properties need to be indexed
{% endhighlight %}

The benchmark has a space with different sets of space objects data:

{: .table .table-bordered}
|Condition|Scenario 1 matching objects|Scenario 2 matching objects|Scenario 3 matching objects|
|:--------|:--------------------------|:--------------------------|:--------------------------|
|data1 = 'A' |401,000| 410,000 | 400,000 |
|data2 = 'B' |100,000| 110,000 | 200,000 |
|data1 = 'A' AND data2 = 'B' |1000 | 10,000 | 100,000|

{% highlight java %}
SQLQuery<Data> query = new SQLQuery<Data>(Data.class,"data1='A' and data2='B'");
{% endhighlight %}

With the above scenario the Compound Index will improve the query execution dramatically. See below comparison for a query execution time when comparing a Compound Index to a single or two indexed properties space class with the different data set scenarios.

![compu_index_bench.jpg](/attachment_files/compu_index_bench.jpg)

## Creating a Compound Index using gs.xml

A Compound Index can be defined within the gs.xml configuration file. Example: The following a `gs.xml` describing a POJO named Data having a compound index composed from two segments:

{% highlight xml %}
<!DOCTYPE gigaspaces-mapping PUBLIC "-//GIGASPACES//DTD GS//EN" "http://www.gigaspaces.com/dtd/9_5/gigaspaces-metadata.dtd">
<gigaspaces-mapping>
    <class name="Data" >
        <compound-index paths="data1, data2"/>
        ...
    </class>
</gigaspaces-mapping>
{% endhighlight %}

## Creating a Compound Indexing for a Space Document

A Compound Space Index of a [space Document](./document-api.html) can be described by `pu.xml` configuration file. Example:

{% highlight xml %}
<os-core:space id="space" url="/./space" >
	<os-core:space-type type-name="Data">
		<os-core:compound-index paths="data1,data2"/>
	</os-core:space-type>
</os-core:space>
{% endhighlight %}

## Creating a Compound Index Dynamically

A Compound Space Index can be added dynamically using the `GigaSpaceTypeManager` interface. Example:

{% highlight java %}
AsyncFuture<AddTypeIndexesResult> indexesResultAsyncFuture = gigaSpace.getTypeManager()
	.asyncAddIndex("Data", new CompoundIndex (new String[]{"data1", "data2"}));
{% endhighlight %}

As the `CompoundIndex` is a subclass of the `SpaceIndex`, the `asyncAddIndex` method signature has not been changed.

## Considerations when using Compound Index

1. An index segment cannot be a collection or a path within collection.
1. All compound index segments must have an `Object` `StorageType`.

# Performance Tips

Properties that are not indexed and not used for queries can be grouped within a user defined class (also known as payload class). This improves the read/write performance since these properties would not be introduced to the space class model.

# Deprecated Indexing Options

## Implicit Indexing

If no properties are indexed explicitly, the space implicitly indexes the first **n** properties (in alphabetical order), where **n** is determined by the `number-implicit-indexes` property in the space schema.

{% exclamation %} Using this feature is not recommended, since adding/removing properties can have unexpected side effects. It is deprecated, and might be removed in future versions.

# Query Execution Flow

When a read, take, readMultiple, or takeMultiple call is performed, a template is used to locate matching space objects. The template might have multiple field values - some might include values and some might not (i.e. `null` field values acting as wildcard). The fields that do not include values are ignored during the matching process. In addition, some class fields might be indexed and some might not be indexed.

When multiple class fields are indexed, the space looks for the field value index that includes the smallest amount of matching space objects with the corresponding template field value as the index key.

The smallest set of space objects is the list of objects to perform the matching against (matching candidates). Once the candidates space object list has been constructed, it is scanned to locate space objects that fully match the given template - i.e. all non-null template fields match the corresponding space object fields.

{% infosign %} Class fields that are not indexed are not used to construct the candidates list.

