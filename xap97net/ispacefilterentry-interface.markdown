---
layout: post97
title:  ISpaceFilterEntry Interface
categories: XAP97NET
weight: 100
parent: implementing-and-using-a-space-filter.html
---

# ISpaceFilterEntry interface

An `ISpaceFilterEntry` represents an object in the context of a filter operation, and allows you to interact with it.

This interface consists of 2 methods and 2 properties.

{% highlight java %}
public interface ISpaceFilterEntry
{
  // Gets the object type
  Type ObjectType { get; }

  // Gets the object itself
  object GetObject();

  // Update the object contained within this entry state
  void UpdateObject(object obj);

  // Gets the notify type (relevant for Notification filter operations)
  DataEventType NotifyType { get; }
}
{% endhighlight %}

When using the `ISpaceFilterEntry`, performance issues should be taken into consideration. This interface is designed to be used in a lazy evaluation fashion. `GetObject` and `UpdateObject` are evaluated only when called, and they reduce performance. Therefore they should only be used when necessary.

{% refer %}For a full SpaceFilter implementation and usage demo, visit the **[Space Filter Demo](./space-filter-demo.html)** section.{% endrefer %}
