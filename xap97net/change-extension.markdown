---
layout: xap97net
title:  Change Extension
categories: XAP97NET
---

{% compositionsetup %}
{% summary %}This page covers the Change Extension extension methods.{% endsummary %}

# Overview

The `ChangeExtension` provides extension methods of `ISpaceProxy` on top of the [Change API](./change-api.html) that simplify the common use cases of the `Change` operation.

# Add and Get operation

A common usage pattern is to increment a numeric property of a specific entry and needing the updated value after the increment was applied.
Using the `AddAndGet` operation you can do that using one method call and get an atomic add and get operation semantics.
Following is an example of incrementing a property named `Counter` inside an entry of type `WordCount`:

{% highlight java %}
ISpaceProxy space = // ... obtain a space reference
Guid id = ...;
IdQuery<WordCount> idQuery = new IdQuery<WordCount>(id, routing);
int? newCounter = ISpaceProxy.AddAndGet(idQuery, "Counter", 1);
{% endhighlight %}

{% exclamation %} You should use the primitive wrapper types as the operation semantic is to return null if there is no object matching the provided id query

{% info %}
Add `using GigaSpaces.Core.Change.Extensions;` in order to have the extension methods available.
{% endinfo %}

