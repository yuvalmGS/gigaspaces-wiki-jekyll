---
layout: post
title:  Controlling Serialization (Deprecated)
categories: XAP97
parent: advanced-topics.html
weight: 200
---

{% note title=This implementation is deprecated starting from version 9.0 %}
The implementation described in this page is deprecated since version 9.0 in favor of an enhanced implementation described [here](./storage-types---controlling-serialization.html)
{% endnote %}

{% summary %}Controlling the Space Object non-primitive serialization mode when written/read from the space. {% endsummary %}

# Overview

GigaSpaces using a unique approach when transporting space objects from one process to another (client-space, space-space). By default, objects are not serialized using the regular [Java serialization approach](http://java.sun.com/developer/technicalArticles/Programming/serialization/), but using GigaSpaces serialization technology. You have several options to control GigaSpaces serialization:

- Default mode - Active when your Space class doesn't implement [Externalizable](http://java.sun.com/j2se/1.5.0/docs/api/java/io/Externalizable.html). You may choose one of the Serialization mode listed below to control the way the space object fields are serialized.
- [Implement Externalizable](./externalizable-support-(deprecated).html) - In this case, only the Native Serialization is supported. This mode allows you to have total control on the object transport.

With the Default mode (when the space class doesn't Implement Externalizable), you can control the serialization mode of **Space Class non-primitive fields** when they are written or read from the space (remote or embedded) using the following space property:

{% highlight java %}
space-config.serialization-type
{% endhighlight %}

Optional Values:

- 0 - Native Serialization (Default)
- 1 - Light Serialization
- 2 - Full Serialization
- 3 - Compressed Serialization

## Primitive and non-primitive fields

- Primitive field types includes: java.lang.String, byte, short, int, long, float, double, char, boolean and their `java.lang.` form: java.lang.Byte ,java.lang.Short, java.lang.Integer, java.lang.Long, java.lang.Float, java.lang.Double, java.lang.Character and java.lang.Boolean.
- Non-primitive field types includes: Arrays of Primitive types, user defined classes , Array of user defined Classes, Collections, etc.

# Setting the serialization-type

## Setting the serialization-type via the pu.xml

Here is example how you can set the serialization-type when using the pu.xml:

{% highlight java %}
<os-core:space id="space" url="/./myDataGrid">
	<os-core:properties>
		<props>
			<prop key="space-config.serialization-type">1</prop>
		</props>
	</os-core:properties>
</os-core:space>
{% endhighlight %}

## Setting the serialization-type via the deploy command

Here is example how you can set the serialization-type when using the [deploy-space](./deploy-space-gigaspaces-cli.html) command. The same approach can be used when using the [deploy](./deploy---gigaspaces-cli.html) command:

{% highlight java %}
gs deploy-space -cluster schema=partitioned-sync2backup total_members=2,1 -properties embed://space-config.serialization-type=1 myDataGrid
{% endhighlight %}

# Which Serialization mode Should I use?

{: .table .table-bordered}
| Colocated business logic | Space class with large collections | Recommended Serialization mode|
|:-------------------------|:-----------------------------------|:------------------------------|
| No | No| Native |
| Yes | Yes| Native + `Externalizable` implementation |
| Yes | No| Native |
| No | Yes| Light |

- A space class with primitive fields used with a remote client, would not enjoy major performance boost by implementing `Externalizable` or using Light, Full or Compressed Serialization modes. In this case, the **Native Serializable mode** having the space class as is (not Implementing `Serializable` or `Externalizable` will result good write and read performance. All the fields within the space class must be `Serializable`.

- A Space class with non-primitive fields (especially with large collections) implementing the `Externalizable` interface used with a remote client should be used when a colocated business logic (polling/notify container, Task) reading this object. In this case non-primitive objects are stored in their original form. This will avoid the need to de-serialize the non-primitive fields when reading these.

- When having a remote client that write and read objects from the space where you don't need the non-primitive fields to be stored in their original form, but in their serialized form, using the **Light Serialization** mode should provide better performance. This will serialize the non-primitive objects in the client side, store these in a binary form in the space, and later de-serialize these at the client side only when the object will be read.

# Default Serialization Flow

When a client performs a space operation using a remote space (a space running in a different VM than the client program), the POJO non-primitive fields used with the write/update operation, or POJO template non-primitive fields used with the read/take/notify operation are serialized into a special object (packet) and sent to the space. Primitive fields are copied into the packet object. When the POJO or the template packet arrives to the space, non-primitive are de-serialized and their  fields (primitive and non-primitive types) are stored within the space using a generic data structure, or it is used to find a matching objects (read/take/notify) in the space. When a read/take operation is called, the matching object data is serialized and sent back to the client program. When the matching object arrives into the client program VM, it is de-serialized and used by the client application.

{% indent %}
![serialization1.jpg](/attachment_files/serialization1.jpg)
{% endindent %}

The POJO fields values and its meta-data information are extracted in run-time (marshaled), and transferred into the space using GigaSpaces generic portable object. When sent back to the client as a result of a read/take operation, the object is de-marshaled and used by the client application.

{% exclamation %} **writeObject and readObject**
If the POJO class implements [Serializable](http://docs.oracle.com/javase/1.5.0/docs/api/java/io/Serializable.html) interface) with the `writeObject()` and `readObject()` methods, these methods **are not called** when the object is serialized.

# Externalizable Serialization Flow

When the Space Class implements the [Externalizable](http://docs.oracle.com/javase/1.5.0/docs/api/java/io/Externalizable.html) interface, `readExternal` and `writeExternal` are called, you may control the stream transferred across the network. The [Externalizable Support (Deprecated)](./externalizable-support-(deprecated).html) includes details about this advanced option.

{% indent %}
![serialization2.jpg](/attachment_files/serialization2.jpg)
{% endindent %}

{% infosign %} Space Class POJO fields types must be Serializable/Externalizable, since they need to be serialized using the regular Java serialization.

# Default mode - Serialization options

Below are the supported serialization modes for non-primitive fields:

{: .table .table-bordered}
| Serialization Mode | Description |
|:-------------------|:------------|
| Native Serialization (0) | Non-primitive fields are transferred to and stored at the space using their Java Native serialization methods. When using the `Native` serialization mode, the space relies on the implementation of `hashCode()` and `equals()` methods when performing matching. You should make sure these are implemented correctly for non-Primitive fields. This mode is optimized when accessing the space in embedded mode.{% wbr %}When running in embedded mode, Space object fields **are passed by reference** to the space. Extra caution should be taken with non-primitive non-mutable fields such as collections (`HashTable, Vector`). Changes made to those fields outside the context of the space will impact the value of those fields in the space and may result in unexpected behavior. For example, index lists aren't maintained because the space is unaware of the modified field values. For those fields it is recommended to pass a cloned value rather then the reference itself. Passing a cloned value is important when several threads access the Object fields - for example application threads and replication threads.|
| Light (1) | Non-primitive fields are transferred to and stored at the space as marshalled objects `com.j_spaces.kernel.lrmi.MarshObject`. With this mode there is no need to implement `hashCode()` and `equals()` when performing matching on non-primitive fields. |
| Full Serialization (2) | Non-primitive fields are transferred to and stored at the space as marshalled objects (see [Javadoc](http://docs.oracle.com/javase/1.5.0/docs/api/java/rmi/MarshalledObject.html)). This mode impacts the performance and should be used only when other serialization modes are not viable. |
| Compressed (3) | Non-primitive fields are Compressed before transferred into the space and stored within the space in compressed mode. This option is useful when the object includes fields with a relatively large amount of data such as XML data (DOM objects). This mode speeds up the access to remote space and reduces the space memory footprint when dealing with large entries. The compression algorithm using the `java.util.zip` package. |

{% tip %}
For additional optimization when serializing objects, refer to the [Externalizable Support (Deprecated)](./externalizable-support-(deprecated).html) section.
{% endtip %}

## Embedded Mode

- Native mode -- non-primitive Space Object field types are not serialized -- the space stores the references of the non-primitive fields. This mode provides the best performance. In multi-threaded environments, be careful when accessing the non-primitive fields after their parent Object has been stored into the space.

- Light/Full Serialization mode -- non-primitive Space Object field types are serialized -- the space stores a clone of the fields object. This impacts the performance.

### Reading and Changing Object in Embedded Mode without Writing it Back

GigaSpaces do not store the object reference within the space, but stores the object non-primitive references and the primitive fields data within the space within a document based structure. When having multiple threads accessing the same object simultaneously, you should **clone the object after you read it** and use the clone copy when updating the writing it back into the space.
If you read an object from the space and change it without writing it back, you might modify one of its complex type fields that another thread holding its reference.
(other thread might be replication thread...If there is also an index on this field the index won't be updated...)

## Remote mode

In remote mode, the Object's non-primitive fields are serialized where the serialization mode determine how it is done:

- Native mode -- non-primitive Object fields are serialized using Java Serialization. These are de-serialized at the space side before they are stored inside the space.
- Light mode -- when non-primitive fields are serialized, they are wrapped with GigaSpaces special Marshaled Object. When stored inside the space, these field are **not de-serialized**, but stored as in their serialized form. This provide better performance when  writing and reading objects with large collections/maps. With the light serialization mode, you can't index and query fields within nested objects.
- Full mode -- supports the [JavaSpace specification](http://java.sun.com/products/jini/2.1/doc/specs/html/js-spec.html). When serialized, non-primitive fields are wrapped with a [MarshalledObject](http://docs.oracle.com/javase/1.5.0/docs/api/java/rmi/MarshalledObject.html). The `MarshalledObject` is de-serialized at the space side before it is stored, allowing you to perform matching using these fields. This mode is slower compared other options.
- Compressed mode -- non-primitive fields are compressed before being sent to the space at the client side. These are stored in compressed form within the space.

With Space Classes that implements [Externalizable](./externalizable-support-(deprecated).html) make sure you use `Native` Serialization mode. In many cases this is the best way to boost remote space access. Externalizable based classes are not relevant for embedded space mode.
