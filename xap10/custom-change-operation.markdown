---
layout: post
title:  Custom Change Operation
categories: XAP10
parent: change-api.html
weight: 100
---

{% compositionsetup %}
{% summary %}This page describes how to implement a custom change operation and how to use it.{% endsummary %}

# What is a custom change operation

A custom change operation lets the user to to implement its own change operation in case the built-in operations do not suffice. This is a very powerful capability but it must be used with extreme care.

# How to implement and use it

The implementation should extend the abstract `CustomChangeOperation` class and implement both `getName` and `change` methods.
Following is an example of a change operation which multiply an integer property value:

{% highlight java %}
public static class MultiplyIntegerChangeOperation extends CustomChangeOperation {
  private static final long serialVersionUID = 1L;
  private final String path;
  private final int multiplier;

  public MultiplyIntegerChangeOperation(String path, int multiplier) {
    this.path = path;
    this.multiplier = multiplier;
  }

  @Override
  public String getName() {
    return "multiplyInt";
  }
  
  public String getPath() {
	return path;
  }
  
  public int getMultiplier() {
	return multiplier;
  }

  @Override
  public Object change(MutableServerEntry entry) {
    //Assume this is an integer property, if this is not true an exception will be thrown and the change operation will fail
    int oldValue = (int)entry.getPathValue(path);
    int newValue = oldValue * multiplier;
    entry.setPathValue(path, newValue);
    return newValue;
  }  
}
{% endhighlight %}

Using it will be like any other change operation, while providing this custom implementation:

{% highlight java %}
gigaSpace.change(query, new ChangeSet().custom(new MultiplyIntegerChangeOperation("votes", 2));
{% endhighlight %}

# What does the name means (getName() implementation)

The custom operation is treated like the built-in change operations, in fact they are built-in implementations of the same mechanism, therefore the operation should have a unique name which is used in all the relevant places as described in [Change API Advanced](./change-api-advanced.html), such as configuring which operation are supported by a `SpaceSynchronizationEndpoint` implementation, using it inside space and replication filters to identify which custom change operation is executed etc.

# Guidlines which must be followed

When implementing a custom change operation the following guidliness must be followed and fully understood.
1. The provided {@link MutableServerEntry} is wrapping the actual object which is kept in space, therefore it is crucial to understand when a value is retrieved from the entry 
it points to the actual reference in the data structure of the space. The content of this reference should not be changed as it will affect directly the object in space and will
break data integrity, transaction and visibility scoping (transaction abort will not restore the previous value). Changing a value should always be done via the {@link MutableServerEntry#setPathValue(String, Object)}. 
Moreover, if you want to change a property within that value by invoking a method on that object (e.g. if the value is a list, adding an item to the list) 
first you must clone the fetched value first, and invoke the method on the cloned copy otherwise, for the reason explained here, 
you will change the existing data structure in the space without going the proper data update path and break data integrity.

Following is an example that adds the element 2 into an ArrayList that exists in the entry under a property named "listProperty" , 
the result sent to client if requested is the size of the collection after the change, note that we clone the ArrayList before modifying it as explained here.
	 
{% highlight java %}
public Object change(MutableServerEntry entry) {
  ArrayList oldValue = (ArrayList)entry.getPathValue("listPropery");
  if (oldValue == null)
    throw new IllegalStateException("No ArrayList instance exists under the given path 'listProperty', 
	           					     in order to add a value an ArrayList instance must exist");
  Collection newValue = (ArrayList)oldValue.clone()
  newValue.add(2);
  int size = newValue.size();
  entry.setPathValue("listProperty", newValue);
  return size;
}
{% endhighlight %}
	 
{% info %}
`getPathValue`, `setPathValue` operations supports nested paths, it will traverse on properties and map keys if the path contains '.' in it (e.g. "myPojo.mapProperty.key")
{% endinfo %}	  
1. When using a replicated topology (e.g. backup space, gateway, mirror) the change operation itself is replicated (and *NOT* the modified entry). 
Hence, it is imperative that this method will always cause the exact same affect on the entry assuming the same entry was provided, for example it should not rely 
on variables that may change between executions, such as system time, random, machine name etc.
If the operation is not structured that way, the state can be inconsistent in the different locations after being replicated 
1. When creating a custom change operation always have this in the back of your mind - "With great power comes great responsibility".

# You custom operation and integration points

Using the custom operation along with [Replication Filter](./cluster-replication-filters.html), [Space Filter](./space-filters.html) and [Space Synchronization Endpoint](./space-synchronization-endpoint-api.html) is supported
and it is the same as the built-in operations. You can get a reference to the instance of the `CustomChangeOperation` by checking its name (or `instanceof`) and casting to the specific type.

{% highlight java %}
DataSyncChangeSet dataSyncChangeSet = ChangeDataSyncOperation.getChangeSet(dataSyncOperation);
Collection<ChangeOperation> operations = dataSyncChangeSet.getOperations();
for(ChangeOperation operation : operations) {
  if (operation.getName().equals("multiply") {
    String path = ((MultiplyIntegerChangeOperation)operation).getPath();
	int multiplier = ((MultiplyIntegerChangeOperation)operation).getMultiplier();    
    // ... do something with the path and multiplier
  }
  //...
}
{% endhighlight %}