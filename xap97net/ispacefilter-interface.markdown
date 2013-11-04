---
layout: xap97net
title:  ISpaceFilter Interface
categories: XAP97NET
page_id: 63799397
---

# ISpaceFilter Interface

The `ISpaceFilter` interface implements IDisposable and consists of 3 additional methods.

{% highlight java %}
public interface ISpaceFilter : IDisposable
{
  void Init(ISpaceProxy proxy, string filterId, IDictionary<string, string> customProperties, FilterPriority priority)
  {
    // performs operation on initialization
  }
  void Process(SecurityContext securityContext, ISpaceFilterEntry entry, FilterOperation operation)
  {
    // performs single entry filter operations
  }

  void Process(SecurityContext securityContext, ISpaceFilterEntry firstEntry, ISpaceFilterEntry secondEntry, FilterOperation operation)
  {
    // performs two entries filter operations, such as update
  }
  //IDisposable implementation
  void Dispose()
  {
    // performs operation when the filter is being disposed
  }
}
{% endhighlight %}

The FilterOperation enum specifies which space operation is being executed and at which stage. For example, a write operation will result in two filter Process method calls, one before the write is executed (BeforeWrite) and one after the write is executed (AfterWrite). These give the filter two hook points to intervene in the process.

Both Process methods receive either one or two [ISpaceFilterEntry](./ispacefilterentry-interface.html) entries. These entries represent the objects in the context of the filtered operation. For example, in the case of a BeforeWrite filter operation, the space filter entry will contain the object that is being written to the space.

{% lampon %} If the filter uses the proxy received by the `Init` method, one should be careful not to cause recursive calls. For example, if your filter is filtering Before Write operations, and inside one of the Process methods there's a call to write, an infinite loop might occur.
