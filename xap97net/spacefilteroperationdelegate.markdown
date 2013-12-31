---
layout: post
title:  Space Filter Operation Delegate
categories: XAP97NET
parent: implementing-and-using-a-space-filter.html
weight: 400
---

# Overview

An [ISpaceFilter](./ispacefilter-interface.html) implementation that acts as an adapter, delegating the execution of the filter life-cycle methods and specific operation, to pluggable reflection-based methods.

Using it, dismisses the need to implement the `ISpaceFilter` interface, and gives a more declarative filtering method.

There are two ways to use the `SpaceFilterOperationDelegate`:

- Attribute-based implementation.
- Method name-based implementation.

# Attribute-Based Implementation

The filter itself is a class that doesn't need to implement any interface. Instead, the filter methods are marked with specific attributes.

{% highlight java %}
public class SimpleAttributeFilter
{
  [OnFilterInit]
  public void Initialize()
  {
    // performs operation on initialization
  }

  [BeforeWrite]
  public void ReportBeforeWrite()
  {
    Console.WriteLine(DateTime.Now + ": Before Write");
  }
}
{% endhighlight %}

To use this class as the filter, simply use the `AttributeSpaceFilterConfigFactory` to create a [SpaceFilterConfig](./spacefilterconfig-class.html) instance, and use when starting a space [integrated with the space filter](./implementing-and-using-a-space-filter.html#Integrating the Space Filter with a space).

{% highlight java %}
AttributeSpaceFilterConfigFactory filterConfigFactory = new AttributeSpaceFilterConfigFactory();
filterConfigFactory.Filter = new SimpleAttributeFilter();

// use this filter config when starting a space
SpaceFilterConfig filterConfig = filterConfigFactory.CreateSpaceFilterConfig();
{% endhighlight %}

The `AttributeSpaceFilterConfigFactory` creates a [SpaceFilterConfig](./spacefilterconfig-class.html) instance, using a fully constructed `SpaceFilterOperationDelegate` as its Filter instance. The `SpaceFilterOperationDelegate` acts as the [ISpaceFilter](./ispacefilter-interface.html) implementation, and delegates the filter operation to the `SpaceAttributeFilter` instance.

# Method Name-Based Implementation

A method name-based filter has the same basic principle as the one above. However, instead of using attributes to mark the method, the method names are specified by properties.

{% highlight java %}
public class SimpleMethodNameFilter
{
  public void Initialize()
  {
    // performs operation on initialization
  }

  public void ReportBeforeWrite()
  {
    Console.WriteLine(DateTime.Now + ": Before Write");
  }
}

...

MethodNameSpaceFilterConfigFactory filterConfigFactory = new MethodNameFilterConfigFactory();
filterConfigFactory.Filter = new SimpleAttributeFilter();
filterConfigFactory.OnFilterInit = "Initialize";
filterConfigFactory.BeforeWrite = "ReportBeforeWrite";
// use this filter config when starting a space
SpaceFilterConfig filterConfig = filterConfigFactory.CreateSpaceFilterConfig();
{% endhighlight %}

# How the SpaceFilterOperationDelegate Works

The `SpaceFilterOperationDelegate` holds a map of `FilterOperationDelegateInvoker` for each filtered operation, which contains the logic that is used to delegate the filter operation to the supplied method.

The supplied method parameters (e.g. in the code example above, the `ReportBeforeWrite` method) must maintain a certain structure:

- A no parameter method callback - e.g. `ReportBeforeWrite()`.
- A single parameter: the parameter can either be an [ISpaceFilterEntry](./ispacefilterentry-interface.html), or the actual template object wrapped by the entry.

{% infosign %} Note, if using actual types, this delegate filters out all the types that are not assignable to it - e.g. `ReportBeforeWrite(ISpaceFilterEntry entry)`, or `ReportBeforeWrite(SimpleMessage message)`.

- Two parameters: the first one maps to the previous option, the second one is the `FilterOperation` - e.g. `ReportBeforeWrite(SimpleMessage message, FilterOperation operation)`.
- Three parameters: the first two map to the previous option, the third one is a `SecurityContext` - e.g.  `ReportBeforeWrite(SimpleMessage message, FilterOperation operation, SecurityContext securityContext)`.

Some filter operations have two entries, and therefore have a similiar, but different structure:

- A no parameter method callback - e.g. `ReportAfterUpdate()`
- A single parameter: the parameter can either be an [ISpaceFilterEntry](./ispacefilterentry-interface.html) or the actual template object wrapped by the entry.

{% infosign %} Note, if using actual types, this delegate filters out all the types that are not assignable to it - e.g. `ReportAfterUpdate(ISpaceFilterEntry entry)`, or `ReportAfterUpdate(SimpleMessage message)`.

- Two parameters: the first one maps to the previous option, the second is the same as the first one, since multiple entries always have two entries (mainly for update operations).
- Three parameters: the first two map to the previous option, the third one is the `FilterOperation`.
- Four parameters: the first three map to the previous option, the fourth one is a `SecurityContext`.

The filter initialization method parameter structure is different. It can receive no parameters, or one parameter which is an `ISpaceProxy`.

If your filter needs to do things upon termination, implement the `IDisposable` interface, and the `Dispose()` method will be invoked when the space is shutting down.

{% lampon %} When your filter method needs to update the entry itself, [ISpaceFilterEntry](./ispacefilterentry-interface.html) should be used, and a call to `UpdateObject` needs to be made.
