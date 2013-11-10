---
layout: post
title:  POJO Support
page_id: 61867112
---

{% compositionsetup %}
{% summary %}GigaSpaces JavaSpaces API Plain Old Java Object support - the [POJO](http://en.wikipedia.org/wiki/Plain_Old_Java_Object).{% endsummary %}

# Overview

GigaSpaces JavaSpaces `POJO` support allows you to use `JavaBean` classes as space domain classes, and perform space operations using these objects. POJO domain Classes should follow rules similar to the ones defined by [JPA](http://en.wikipedia.org/wiki/Java_Persistence_API), [Hibernate](http://www.hibernate.org/hibernate) and other domain class frameworks.

# POJOs as Data Objects

One of the differences between the `GigaSpace` interface and the classic `net.jini.Space.JavaSpace` interface is its support for POJOs as Space entries. The `JavaSpace` interface is rather intrusive and forces objects that are written to the Space to implement the `net.jini.core.entry.Entry` interface, and mark any field to be stored on the Space as `public`.

The `GigaSpace` interface fully supports POJOs, and is less intrusive than the original `JavaSpace` interface. Although `Entry` is still supported, this is discouraged, and you should only use POJOs as a Space data object.

In terms of preconditions, your POJO classes need to follow the JavaBeans conventions, i.e. have a no-argument constructor, and declare a getter and setter to every field you want saved on the Space. Also, they cannot implement the `net.jini.core.entry.Entry` interface (there shouldn't be any reason to do that anyway, since it is an empty tagging interface). The POJO class does not have to implement `java.io.Serializable`, but its properties must. The reason for this, is that the POJOs fields are extracted when written to the Space, and stored in a special tuple format that enables the Space to index and analyze them more easily. Therefore the actual POJO is not sent over the network, but rather its properties.

### Providing Metadata to the Space about the POJO Class

When writing POJOs to the Space, you can provide some metadata about the POJO's class to the space, using Java 5 annotations, or an XML configuration. This overview uses annotation to provide metadata. For a complete reference to POJO annotations and XML configuration, refer to the [POJO Metadata](./pojo-metadata.html) section.

Here is an overview of the most commonly used POJO annotations:

- `@SpaceClass`: Class level annotation - not mandatory. Used to mark a class that is written to the space (by default if you write a class to the space, it is marked as such automatically). Use this when you would like to provide additional metadata at the class level, such as whether or not this class is persisted to a database if [Persistency](./persistency.html) is configured on the Space.

- `@SpaceId`: The identifier property of the POJO. This property uniquely identifies the POJO within the space, and is similar to a primary key in a database. You can choose between an application-generated ID (`autoGenerate=false`), and an automatically-generated ID (`autoGenerate=true`).

- `@SpaceProperty`: Defines various attributes related to a POJO property - the null value if you are using a primitive property (e.g. `nullValue=-1`), and whether they should be indexed for faster querying (`index=BASIC`).

- `@SpaceVersion`: The version property of the POJO  - optional. Defines a property to be used to indicate the version of the instance (used to implement optimistic locking).

- `@SpaceRouting`: The routing property for the POJO. In a partitioned space, this controls how instances of a certain class are distributed across the partitions. When two instances (even of different classes), have the same value for their routing property, they end up in the same partition.

{% info title=Primitives or Wrapper Classes for POJO Properties? %}
GigaSpaces supports both primitives (`int`, `long`, `double`, `float`, etc.), and primitive wrappers (`java.lang.Integer`, `java.lang.Double`, etc.). In general, it is recommended that you use the primitive wrapper. This enables you to use the `null` values as a wildcard when using template matching (see below).

If you use primitives make sure you define the following for your POJO class:

- The `null` value for the property - since primitive types are not nullable, you have to indicate to the space a value that is treated as `null`. This is important for template matching (see below), where null values are considered as wildcards, and do not restrict the search.
- It is recommended that the initial value (assigned in the constructor) for this field matches the null value. This enables you to quickly create new instances, and use them as templates for template matching, without changing any property except the ones you want to use for matching.
{% endinfo %}

Here is a sample POJO class:

{% highlight java %}
@SpaceClass
public class Person {
    private Integer id;
    private String name;
    private String lastName;
    private Integer age;

    ...
    public Person() {}

    @SpaceId(autoGenerate=false)
    @SpaceRouting
    public Integer getId() { return id;}

    public void setId(Integer id) {  this.id = id; }

    @SpaceProperty(index=BASIC)
    public Long getLastName() { return lastName; }

    public void setLastName(String type) { this.lastName = lastName; }

    ...
}
{% endhighlight %}

GigaSpaces `POJO` rules:

- Do not implement the `net.jini.core.entry` interface.
- Follow the [JavaBeans specification](http://java.sun.com/javase/technologies/desktop/javabeans/docs/spec.html).
- Have private fields.
- Avoid using numeric [primitives](http://download.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html) (long , int) as the POJO fields. Use their relevant Object wrapper instead Long and Integer. This will avoid the need to specify a null-value and simplify query construction when using the [SQLQuery](./sqlquery.html).
- Have getter and setter methods for every field you would like to be stored within the space object.
- Include space class metadata decorations (indexed fields, affinity-keys, persisted mode, etc.).

{% info %}
 You can define space classes metadata by class and field level decorations. These can be defined via annotations or XML configurations files (*gs.xml file).
{% endinfo %}

{% exclamation %} This page deals with the POJO class as a space domain class, used to model the space, and store application data into the IMDG. POJO classes deployed as services into the Service Grid are described in the [Data Event Listener](./data-event-listener.html) and [Space Based Remoting](./space-based-remoting.html) sections. In these cases, the POJO class is used to process incoming data, or is invoked remotely.

# A POJO as a Space Domain Class

When using a POJO as a space domain class, follow these guidelines:

- A POJO class must implement a default (zero argument) constructor.
- A POJO class cannot implement the `net.jini.core.entry` interface; otherwise, it is treated differently.
- A POJO class should have space class metadata decorations using annotations or a `gs.xml` file with relevant metadata (indexes, version field, FIFO mode, persistency mode, primary key (i.e. `id`)). If neither are provided, the **defaults** are presumed. (The default settings might not always match your needs.)
- Getter/setter methods for fields that you want to be persisted in the space.
- Non-primitive fields must implement `Serializable` or `Externalizable`. For example, if you are using a POJO class that contains a nested class.
- When performing matching/queries using primitive fields (`int` , `long` , `double`, etc.) **the `nullValue` annotation or `null-value` tag must be specified** with relevant values, to function correctly.

{% highlight java %}
@SpaceProperty(nullValue="-1")
public int getEmployeeID()
{
	return employeeID;
}
{% endhighlight %}

- The ID field can be determined using the `@SpaceId` annotation or the `id` tag.
- When using POJOs, the **write operation** uses the [WriteModifiers.UPDATE_OR_WRITE](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/WriteModifiers.html) mode by default. This means that when the space already includes an object with the same UID (`@SpaceId(autoGenerate=false)` with the same value), the POJO is updated, and a new object is not inserted.
- When using `SpaceId(autoGenerate=true)`, the UID is stored inside the `SpaceId` field, causing an overhead when indexed.
- A `null` value as template is not supported. Use `new Object()` instead.
- A POJO class must implement the `Serializable` or `Externalizable` interface if used as a parameter for a remote call ([OpenSpaces remoting](./space-based-remoting.html)).
- When using the [org.openspaces.core.GigaSpace](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html) interface, you can use [generics](http://en.wikipedia.org/wiki/Generics_in_Java) when conducting space operations.
- The `@Spaceid` annotation or `id` tag must be declared when performing update operations.
- To persist a POJO object using the `ExternalDataSource` or via Mirror Service the `persist` decoration must have the value `true`.
- When a space is configured to use the `ExternalDataSource`, the `@Spaceid` annotation or `id` tag `auto-generate` attribute should be set to **`false`**. The object must include a unique value with the `SpaceId` field when written into the space.
- The `SpaceId` field can be `java.lang.String` type or any other type that implements the `toString()` which provides a unique value.
- Primitive `boolean` should not be used as a POJO field as this could lead to problems when using template based matching. `Boolean` should be used instead.
- [SQLQuery](./sqlquery.html) should not be used to query base abstract class.

## Controlling Space Class Fields Introduction

To force GigaSpaces to ignore a POJO field when the space class is introduced to the space you should use one of the following:

- Use the `@SpaceExclude` annotation on the getter method for the fields you don't want to be included as part of the space class.
- Use the `@SpaceClass(includeProperties=IncludeProperties.EXPLICIT)` class level annotation and use the `@SpaceProperty()` with each getter method for fields you would like to be considered as part of the space class.

## Space POJO Class medata data files

POJO space mapping files `gs.xml` files can be loaded from:

- `<CLASSPATH>\config\mapping` folder, or
- The same package where the class file is located using the format `<<Class Name>>.gs.xml`.

## Jini Entry Handling

All `net.jini.core.entry.Entry` based classes meta data methods are not supported with POJO based classes. These include: __setEntryInfo() , \__getEntryInfo() , \__setEntryUID() , \__getEntryUID() ,_\_getSpaceIndexedFields(). With POJO based space domain classes, meta data is declared using relevant annotations or xml tags. see the [POJO Metadata](./pojo-metadata.html) for details.

## Reference Handling

When running in embedded mode, Space object fields **are passed by reference** to the space. Extra caution should be taken with non-primitive none mutable fields such as collections (`HashTable, Vector`). Changes made to those fields outside the context of the space will impact the value of those fields in the space and may result in unexpected behavior.

For example, index lists aren't maintained because the space is unaware of the modified field values. For those fields it is recommended to pass a cloned value rather then the reference itself. Passing a cloned value is important when several threads access the Object fields - for example application threads and replication threads.

## Non-Indexed Fields

Non-Indexed fields that are not used for queries should be placed within a user defined class (payload object) and have their getter and setter placed within the payload class. This improves the read/write performance since these fields would not be introduced to the space class model.

{% tip %}
[Indexing](./indexing.html) is **critical** for good performance over large spaces. Don't forget to index properly with the @SpaceIndex(type=SpaceIndexType.BASIC) or @SpaceIndex(type=SpaceIndexType.EXTENDED) annotation or use the gs.xml equivalent.
{% endtip %}

{% include xap97/pojo-code-snippets.markdown %}
{% whr %}
{% refer %}**Next subchapter:** [POJO Metadata](./pojo-metadata.html) - This section deals with the annotations and gs.xml mapping file, troubleshooting procedures, considerations, UID generation and usage, as well as frequently used code snippets.{% endrefer %}
