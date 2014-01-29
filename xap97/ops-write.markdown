---
layout: post
title:  Write API
categories:
parent: ops-space.html
weight: 100
---


{% summary %}Describes the write API {% endsummary %}

# Overview


In order to write objects to the Space, you use the write method of the GigaSpace interface. The write method is used to write objects if these are introduced for the first time, or update them if these already exist in the space. In order to override these default semantics, you can use the overloaded write methods which accept update modifiers such as UpdateModifiers.UPDATE_ONLY.

{%section%}
{%column width=35% %}
{%endcolumn%}
{%column width=35% %}
![POJO_write.jpg](/attachment_files/POJO_write.jpg)
{%endcolumn%}
{%endsection%}


#### POJO Example

The following example writes an `Employee` object into the space:

{% highlight java %}
    UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("jini://*/*/mySpace");
    GigaSpace space = new GigaSpaceConfigurer(urlSpaceConfigurer.space())
 	.gigaSpace();

    Employee employee = new Employee("Last Name", new Integer(32));
    employee.setFirstName("first name");
    LeaseContext<Employee> lc = space.write(employee);
{% endhighlight %}

#### SpaceDocument Example

Here is an example how you create a SpaceDocument, register it with the space and then write it into the space:

{% inittab os_simple_space|top %}
{% tabcontent SpaceDocument %}
{%highlight java  %}
public SpaceDocument createDocumemt() {
     DocumentProperties properties = new DocumentProperties()
       .setProperty("CatalogNumber", "av-9876")
       .setProperty("Category", "Aviation")
       .setProperty("Name", "Jet Propelled Pogo Stick")
       .setProperty("Price", 19.99f)
       .setProperty("Tags",
            new String[] { "New", "Cool", "Pogo", "Jet" })
       .setProperty("Features",
            new DocumentProperties()
              .setProperty("Manufacturer", "Acme")
              .setProperty("RequiresAssembly", true)
              .setProperty("NumberOfParts", 42));

       return new SpaceDocument("Product", properties);
}
{%endhighlight%}
{% endtabcontent  %}

{% tabcontent Register %}

{%highlight java  %}
public void registerProductType(GigaSpace gigaspace) {
     // Create type descriptor:
     SpaceTypeDescriptor typeDescriptor = new SpaceTypeDescriptorBuilder(
		"Product").idProperty("CatalogNumber")
		.routingProperty("Category")
		.addPropertyIndex("Name", SpaceIndexType.BASIC)
		.addPropertyIndex("Price", SpaceIndexType.EXTENDED).create();
     // Register type:
     space.getTypeManager().registerTypeDescriptor(typeDescriptor);
}
{%endhighlight%}
{% endtabcontent  %}
{% tabcontent Write %}
{%highlight java  %}

   SpaceDocument document = this.createDocument();
   this.registerProductType( gigaspace );

   LeaseContext<SpaceDocument> lc = space.write(document);

{%endhighlight%}
{% endtabcontent  %}
{% endinittab   %}

{% togglecloak id=1 %}**Method summary...**{% endtogglecloak %}
{% gcloak 1 %}
Writes a new object to the space, returning its LeaseContext.

{%highlight java%}
<T> LeaseContext<T> write(T entry, long lease, long timeout, WriteModifiers modifiers)
<T> LeaseContext<T> write(T entry)
<T> LeaseContext<T> write(T entry, long lease)
<T> LeaseContext<T> write(T entry, WriteModifiers modifiers)
{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | Default | Unit|
|:-----|:------------|:--------|:----|
| T          | POJO, SpaceDocument|| |
|lease       |Time to live | Lease.FOREVER| milliseconds |
|timeout     |The timeout of an update operation, in milliseconds. If the entry is locked by another transaction wait for the specified number of milliseconds for it to be released. | 0  |  milliseconds |
|[WriteModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/gigaspaces/client/WriteModifiers.html)|Provides modifiers to customize the behavior of write operations | UPDATE_OR_WRITE  |  |
|[LeaseContext](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/j_spaces/core/LeaseContext.html) |LeaseContext is a return-value encapsulation of a write operation.||

Note: Writing an object into a space might generate [notifications](./notify-container.html) to registered objects.

[Java Doc](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html#write(T))
{%endgcloak%}

# Time To Live

To write an object into the space with a limited time to live you should specify [a lease value](./leases---automatic-expiration.html) (in millisecond). The object will expire automatically from the space.

{% highlight java %}
   gigaSpace.write(myObject, 10000)
{% endhighlight %}


# Write Multiple
When writing a batch of objects into the space, these should be placed into an array to be used by the `GigaSpace.writeMultiple` operation. The returned array will include the corresponding `LeaseContext` object.


![POJO_write_multi.jpg](/attachment_files/POJO_write_multi.jpg)



#### Example

{% highlight java %}

   Employee emps[] = new Employee[2];
   emps[0] = new Employee("Last Name A", new Integer(10));
   emps[1] = new Employee("Last Name B", new Integer(20));
try {
    LeaseContext[] leaseContexts = space.writeMultiple(emps);
    for (int i = 0;i<leaseContexts.length ; i++) {
        System.out.println ("Object UID " + leaseContexts[i].getUID() + " inserted into the space");
    }
} catch (WriteMultipleException e) {
    IWriteResult[] writeResult = e.getResults();
    for (int i = 0;i< writeResult.length ; i++) {
        System.out.println ("Problem with Object UID " + writeResult ");
    }
}
{% endhighlight %}


{% togglecloak id=2 %}**Method summary...**{% endtogglecloak %}
{% gcloak 2 %}
Writes new objects to the space, returning its LeaseContexts.

{%highlight java%}
<T> LeaseContext<T>[] writeMultiple(T[] entries)
<T> LeaseContext<T>[] writeMultiple(T[] entries, long lease)
<T> LeaseContext<T>[] writeMultiple(T[] entries, long[] leases, WriteModifiers modifiers)
<T> LeaseContext<T>[] writeMultiple(T[] entries, long lease, WriteModifiers modifiers)
<T> LeaseContext<T>[] writeMultiple(T[] entries, WriteModifiers modifiers)
{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | default |
|:-----|:------------|:-------- |
|T          | POJO, SpaceDocument||
|lease       |Time to live | Lease.FOREVER|milliseconds|
|timeout     | The timeout of an update operation, in milliseconds. If the entry is locked by another transaction wait for the specified number of milliseconds for it to be released. | 0  |
|[WriteModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/gigaspaces/client/WriteModifiers.html)|Provides modifiers to customize the behavior of write operations | UPDATE_OR_WRITE  |
|[LeaseContext](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/j_spaces/core/LeaseContext.html) |LeaseContext is a return-value encapsulation of a write operation.| |

Note:
Writing an object into a space might generate [notifications](./notify-container.html) to registered objects.
{% endgcloak  %}


# Return Previous Value

When updating an object which already exists in the space, in some scenarios it is useful to get the previous value of the object (before the update). This previous value is returned in result `LeaseContext.getObject()` when using the `RETURN_PREV_ON_UPDATE` modifier.

![write_return_prev-value.jpg](/attachment_files/write_return_prev-value.jpg)

{% highlight java %}
  LeaseContext<MyData> lc = space.write(myobject,WriteModifiers.RETURN_PREV_ON_UPDATE.add(WriteModifiers.UPDATE_OR_WRITE));
  MyData previousValue = lc.getObject();
{% endhighlight %}

{% info %}
Since in most scenarios the previous value is irrelevant, the default behavior is not to return it (i.e. `LeaseContext.getObject()` return null). The `RETURN_PREV_ON_UPDATE` modifier is used to indicate the previous value should be returned.
{%endinfo%}



# Modifiers

TODO

For further details on each of the available modifiers see:

- [WriteModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/gigaspaces/client/WriteModifiers.html)


{%comment%}
You may configure default modifiers for the write operations in the `GigaSpace` interface. The default modifiers can be configured in the following manner:


For further details on each of the available modifiers see:

- [WriteModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/gigaspaces/client/WriteModifiers.html)



{% inittab os_simple_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}

<os-core:space id="space" url="/./space" />
<os-core:giga-space id="gigaSpace" space="space">
  <os-core:read-modifier value="FIFO"/>
  <os-core:change-modifier value="RETURN_DETAILED_RESULTS"/>
  <os-core:clear-modifier value="EVICT_ONLY"/>
  <os-core:count-modifier value="READ_COMMITTED"/>
  <os-core:take-modifier value="FIFO"/>

  <!-- to add more than one modifier, simply include all desired modifiers -->
  <os-core:write-modifier value="PARTIAL_UPDATE"/>
  <os-core:write-modifier value="UPDATE_ONLY"/>
</<os-core:giga-space>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}

<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
  <property name="url" value="/./space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
  <property name="space" ref="space" />
  <property name="defaultWriteModifiers">
    <array>
      <bean id="updateOnly"
        class="org.openspaces.core.config.modifiers.WriteModifierFactoryBean">
        <property name="modifierName" value="UPDATE_ONLY" />
      </bean>
      <bean id="partialUpdate"
        class="org.openspaces.core.config.modifiers.WriteModifierFactoryBean">
        <property name="modifierName" value="PARTIAL_UPDATE" />
      </bean>
    </array>
  </property>
</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}

IJSpace space = // get Space either by injection or code creation

GigaSpace gigaSpace = new GigaSpaceConfigurer(space)
  .defaultWriteModifiers(WriteModifiers.PARTIAL_UPDATE.add(WriteModifiers.UPDATE_ONLY))
  .defaultReadModifiers(ReadModifiers.FIFO)
  .defaultChangeModifiers(ChangeModifiers.RETURN_DETAILED_RESULTS)
  .defaultClearModifiers(ClearModifiers.EVICT_ONLY)
  .defaultCountModifiers(CountModifiers.READ_COMMITTED)
  .defaultTakeModifiers(TakeModifiers.FIFO)
  .gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

Any operation on the configured proxy will be treated as if the default modifiers were explicitly passed. If a certain operation requires passing an explicit modifier and also wishes to merge the existing default modifiers, the following  pattern should be used:

{% highlight java %}
   GigaSpace gigaSpace = ...
   gigaSpace.write(someObject, gigaSpace.getDefaultWriteModifiers().add(WriteModifiers.WRITE_ONLY));
{% endhighlight %}


For further details on each of the available modifiers see:

- [com.gigaspaces.client.ReadModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/ReadModifiers.html)
- [com.gigaspaces.client.WriteModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/WriteModifiers.html)
- [com.gigaspaces.client.TakeModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/TakeModifiers.html)
- [com.gigaspaces.client.CountModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/CountModifiers.html)
- [com.gigaspaces.client.ClearModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/ClearModifiers.html)
- [com.gigaspaces.client.ChangeModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html?com/gigaspaces/client/ChangeModifiers.html)
{%endcomment%}
