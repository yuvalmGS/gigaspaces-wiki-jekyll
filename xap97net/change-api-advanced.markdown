---
layout: xap97net
title:  Change API Advanced
categories: XAP97NET
page_id: 64325389
---

{% compositionsetup %}
{% summary %}This page covers the Change API more advanced scenarios.{% endsummary %}

# Obtaining Change detailed results

By default, the change result will only contain the number of entries which were changed during the operation. In order to get more details (requires more network traffic) the ChangeModifiers.ReturnDetailedResults should be used. When using this modifier the result will contain the list of entries which were changed including the change affect that took place on each entry.
You can use this in order to know what was the affect, for instance what is the value of a numeric property after the increment operation was applied on it.

{% highlight java %}
ISpaceProxy space = // ... obtain a space reference
Guid id = ...;
IdQuery<Account> idQuery = new IdQuery<Account>(id, routing);
IChangeResult<Account> changeResult = space.Change(idQuery, new ChangeSet().Increment("balance.euro", 5.2D), ChangeModifiers.ReturnDetailedResults);
foreach(IChangedEntryDetails<Account> changedEntryDetails in changeResult.Results) {
  //Will get the first change which was applied to an entry, in our case we did only single increment so we will have only one change operation.
  //The order is corresponding to the order of operation applied on the `ChangeSet`.
  IChangeOperationResult operationResult = changedEntryDetails.ChangeOperationsResults[0];
  double newValue = IncrementOperation.GetNewValue(operationResult);
  ...
}
{% endhighlight %}

Here is the full list of change operations:

{: .table .table-bordered}
|ChangeSet operation|ChangeOperation class|Comment|
|:------------------|:--------------------|:------|
|**ChangeSet.Set**|SetOperation| |
|**ChangeSet.Unset**|UnsetOperation| |
|**ChangeSet.Increment**|IncrementOperation| |
|**ChangeSet.Decrement**|IncrementOperation|will be increment with negative value|
|**ChangeSet.AddToCollection**|AddToCollectionOperation| |
|**ChangeSet.AddRangeToCollection**|AddRangeToCollectionOperation| |
|**ChangeSet.RemoveFromCollection**|RemoveFromCollectionOperation| |
|**ChangeSet.SetInDictionary**|SetInDictionaryOperation| |
|**ChangeSet.RemoveFromDictionary**|RemoveFromDictionaryOperation| |

For the common use case you can use the [Change Extension](./change-extension.html) class which provide extension methods to `ISpaceProxy` which simplify the most common use cases and allow you to do simple operation such as an atomic `AddAndGet` operation. This extension are a syntactic sugaring on top of the above API.
