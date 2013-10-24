---
layout: xap96
title:  Change API Advanced
page_id: 61867447
---

{% compositionsetup %}
{% summary %}This page covers the Change API more advanced scenarios.{% endsummary %}

# Change and SpaceSynchronizationEndpoint

A `SpaceSynchronizationEndpoint` implementation can make use of the [Change API](/xap96/change-api.html) and support change operation, this way allowing the network utilization to be more optimized by sending only the change set to the mirror service instead of the fully updated object. By default the mirror service starts in a mode which does not support change, hence, any change operation done on the space is being replicated as a regular update to the mirror service. You could provide an implementation that does support change and configure the space to send the supported change operations to the mirror with only the required data to apply the change. Following is an example of how can one obtain the change set from a `DataSyncOperation`.

{% section %}
{% column %}
Asynchronous Persistence
![change-space-datasource-async.jpg](/attachment_files/change-space-datasource-async.jpg)
{% endcolumn %}
{% column %}
Synchronous Persistence
![change-space-datasource-sync.jpg](/attachment_files/change-space-datasource-sync.jpg)
{% endcolumn %}
{% endsection %}

{% highlight java %}
public class MySpaceSynchronizationEndpoint extends SpaceSynchronizationEndpoint {

  @Override
  public void onOperationsBatchSynchronization(OperationsBatchData batchData){
    for (DataSyncOperation dataSyncOperation : batchData.getBatchDataItems()){
      switch(dataSyncOperation.getDataSyncOperationType()){
        case CHANGE:
          DataSyncChangeSet dataSyncChangeSet = ChangeDataSyncOperation.getChangeSet(dataSyncOperation);
          for (ChangeOperation changeOperation : dataSyncChangeSet.getOperations()){
            switch(changeOperation.getName()){
              case IncrementOperation.NAME:
                String path = IncrementOperation.getPath(changeOperation);
                int delta = IncrementOperation.getDelta(changeOperation).intValue();
                // ... handle increment operation
                break;
              case SetOperation.NAME:
                String path = SetOperation.getPath(changeOperation);
                Object value = SetOperation.getValue(changeOperation);
                // ... handle set operation
                break;
              case ...
            }
          }
          break;

      ...
      }
    }
  }
  ..

}
{% endhighlight %}

Once you have an implementation that supports some or all of the change operations, the space need to be configured in a way which specifies which change operations are supported by the mirror, and that is in order for it to know which operations can be sent to the mirror as change and which operations needs to be converted to full update. following an example of how to configure a space with mirror which supports: `set`, `unset` and `increment` change operations.

{% highlight xml %}
<os-core:space id="space" url="/./mySpace" mirror="true">
    <os-core:properties>
        <props>
            <prop key="cluster-config.mirror-service.change-support">
                set, unset, increment
            </prop>
        </props>
    </os-core:properties>
</os-core:space>
{% endhighlight %}

Here is the full list of change operations:

{: .table .table-bordered}
|ChangeSet operation|Mirror Change Support Name|ChangeOperation class|Comment|
|:------------------|:-------------------------|:--------------------|:------|
|**ChangeSet.set**|set|SetOperation| |
|**ChangeSet.unset**|unset|UnsetOperation| |
|**ChangeSet.increment**|increment|IncrementOperation| |
|**ChangeSet.decrement**|increment|IncrementOperation|will be increment with negative value|
|**ChangeSet.addToCollection**|addToCollection|AddToCollectionOperation| |
|**ChangeSet.addAllToCollection**|addAllToCollection|AddToCollectionOperation| |
|**ChangeSet.removeFromCollection**|removeFromCollection|RemoveFromCollectionOperation| |
|**ChangeSet.putInMap**|putInMap|PutInMapOperation| |
|**ChangeSet.removeFromMap**|removeFromMap|RemoveFromMapOperation| |

# Change and Replication Filters

When using [Replication Filter](/xap96/cluster-replication-filters.html), one can extract the `DataSyncChangeSet` from the `IReplicationFilterEntry` in the same way as extracting it from a `DataSyncOperation` by using the
`ChangeDataSyncOperation` class in the following way:

{% highlight java %}
public class MyReplicationFilter implements IReplicationFilter {
  ...

  @Override
  public void process(int direction, IReplicationFilterEntry replicationFilterEntry,
                String remoteSpaceMemberName) {
     if (replicationFilterEntry.getOperationType() == ReplicationOperationType.CHANGE){
        DataSyncChangeSet changeSet = ChangeDataSyncOperation.getChangeSet(replicationFilterEntry);
        // ... do something in filter
     }
  }
}
{% endhighlight %}

# Change and Space Filters

[Space Filter](/xap96/space-filters.html) can intercept a `FilterOperationCodes.BEFORE_CHANGE` and `FilterOperationCodes.AFTER_CHANGE` events, and in that events the `DataSyncChangeSet` can be extracted from the ISpaceFilterEntry using the `ChangeDataSyncOperation.getChangeSet(IFilterEntry)` method.
