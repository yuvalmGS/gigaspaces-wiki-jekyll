---
layout: post100
title:  Initial Load
categories: XAP100
parent: space-persistency-overview.html
weight: 500
---


{% summary  %} {% endsummary %}



The XAP Data-Grid includes special interceptor that allow users to pre-load the Data-Grid with data before it is available for clients access. This interceptor called **Initial Load** and has a default implementation that is using the [Hibernate Space Persistency](./hibernate-space-persistency.html) implementation to load data from a database directly into the Data-Grid instances.

![eds_initial_load.jpg](/attachment_files/eds_initial_load.jpg)

To enable the initial load activity a `SpaceDataSource` should be specified. We distinguish between two modes of operation - if `SpaceSynchronizationEndpoint` is specified the mode is 'read-write', otherwise 'read-only'.

- **read-only** - Space will be loading data from the persistency layer once started. It will access the persistency layer in case of a cache miss (only when running in LRU cache policy mode).
- **read-write** - Space will be loading data from the persistency layer once started. It will write changes within the space back into the persistency layer in synchronous manner. For a-synchronous mode, the replication to the Mirror should be enabled and `SpaceSynchronizationEndpoint` should not be specified for the space but only for the mirror. The Mirror will be responsible to write the changes into the persistency layer.

Here is an example for a space configuration that performs only initial load from the database without writing back any changes into the database (replication to the Mirror service is not enabled with this example):

{% highlight xml %}
<os-core:embedded-space id="space" name="space" schema="persistent" space-data-source="hibernateSpaceDataSource">
    <os-core:properties>
        <props>
            <!-- Use ALL IN CACHE -->
            <prop key="space-config.engine.cache_policy">1</prop>
            <prop key="cluster-config.cache-loader.external-data-source">true</prop>
            <prop key="cluster-config.cache-loader.central-data-source">true</prop>
        </props>
    </os-core:properties>
</os-core:embedded-space>

<bean id="hibernateSpaceDataSource" class="org.openspaces.persistency.hibernate.DefaultHibernateSpaceDataSourceFactoryBean">
    <property name="sessionFactory" ref="sessionFactory"/>
</bean>
{% endhighlight %}

# Speeding-up Initial-Load

You can load 1TB data into a Data-Grid in less than 30 min by having each partition primary instance query a table column mapped to an object field storing the partition ID. This column should be added to every table. A typical setup to load 1TB in less than 30 min would be a database running on a multi-core machine with 1GB network and few partitions running on multiple multi-core machines. Without such initial-load optimization the more partitions the Data-Grid will have the initial-load time will be increased. Mapping the database files to SSD and using distributed database architecture (Nosql DB) would improve the initial-load time even further.

By default each Data-Grid primary partition loading its relevant data from the database and from there replicated to the backup instances.

All irrelevant objects are filtered out during the data load process. You may optimize this activity by instructing each Data-Grid primary instance to a load-specific data set from the database via a custom query you may construct during the initial load phase.

{% tip %}
The Initial Load is supported with the `partitioned-sync2backup` cluster schema. If you would like to pre-load a clustered space using the Initial-Load without running backups you can use the `partitioned-sync2backup` and have ZERO as the amount of backups.
{% endtip %}

# Custom Initial Load

To implement your own Initial Load when using the Hibernate `SpaceDataSource` you should implement the `initialDataLoad` method to construct one or more `DefaultScrollableDataIterator`.
See example below:

{% highlight java %}
import org.openspaces.persistency.hibernate.DefaultHibernateSpaceDataSource;
import org.openspaces.persistency.hibernate.iterator.DefaultScrollableDataIterator;
import com.gigaspaces.datasource.DataIterator;

public class SpaceDataSourceInitialLoadExample extends DefaultHibernateSpaceDataSource {
    @Override
    public DataIterator<Object> initialDataLoad() {
        String hquery = "from Employee where age > 30";
        DataIterator[] iterators = new DataIterator[1];
        int iteratorCounter = 0;
        int fetchSize = 100;
        int from = -1;
        int size = -1;
        iterators[iteratorCounter++] = new DefaultScrollableDataIterator(hquery, getSessionFactory(), fetchSize, from, size);

        //..  you can have additional DefaultScrollableDataIterator created with multiple queries

        return createInitialLoadIterator(iterators);
    }
}
{% endhighlight %}

# Controlling the Initial Load

Since each space partition stores a subset of the data, based on the entry routing field hash code value, you need to load the data from the database in the same manner the client load balance the data when interacting with the different partitions.

It is best to use a database query using the `MOD`, `number of partitions` and the `partition ID` to perform an identical action to that which is performed by a space client when performing write/read/take operations with partitioned space to route the operation into the correct partition.

Additional levels of customization can be achieved for loading only the relevant data into each partition.

## Custom Initial Load Queries

You can specify custom initial load queries for entry types, by writing a method that may receive an instance of `ClusterInfo` (or no parameter) and returns the 'where' clause of the query. You can place this method in any class, as long as it is annotated with `SpaceInitialLoadQuery` that holds the type for which the query applies. If the method is included inside a class that is marked with `SpaceClass`, there is no need to specify the query type. You can also write more than one such method in a class, as long as there is no duplicate query (globally) for the same type. For example:

{% highlight java %}
package com.example.lorem.ipsum;

import com.gigaspaces.annotation.pojo.SpaceInitialLoadQuery;

public class InitialLoadQueryExample {
    @SpaceInitialLoadQuery(type="com.example.domain.MyClass")
    public String foo(ClusterInfo clusterInfo) {
        Integer num = clusterInfo.getNumberOfInstances(), instanceId = clusterInfo.getInstanceId();
        return "propertyA > 50 AND routingProperty % " + num + " = " + instanceId;
    }
}
{% endhighlight %}

When the initial load process begins, the system will search for these methods by recursively scanning certain base packages in the classpath, which you should specify as the value of the `SpaceDataSource` property `initialLoadQueryScanningBasePackages'. An empty list means no scan.

## Initial Load Entries

The default behavior of the system is to search for any available entry metadata and load the entry as a whole, discarding of unneeded data afterwards. To avoid loading all entries, you can specify a list of initial load entries by creating the `SpaceDataSource`. Setting the property `initialLoadEntries` with a list of fully-qualified type names.

The system will try, by default, to identify the routing field for each entry type and to construct a simple partition-specific initial load query for this type. To suppress this augmentation of the initial load entries, set the `augmentInitialLoadEntries` property of the `SpaceDataSource` to `false`.

{% note %}
Make sure the routing field will be an Integer type.
{%endnote%}

After all initial load queries have been gathered, these are processed along with the initial load entries to compile a compound `DataIterator`. As described above, you can override all this logic by writing your own `initialLoad` method. Bear in mind that all `SpaceDataSource` objects are `ClusterInfoAware`, therefore you have access to the protected `ClusterInfo` field.

The following example XML snippet summarizes your options of controlling the initial load process.

{% highlight xml %}
<bean id="hibernateSpaceDataSource" class="org.openspaces.persistency.hibernate.DefaultHibernateSpaceDataSourceFactoryBean">
    <property name="sessionFactory" ref="sessionFactory"/>
    <property name="initialLoadEntries">
        <!-- If absent or empty, the system will search for all available entry metadata -->
        <list>
            <value>com.example.domain.MyEntry</value>
        </list>
    </property>
    <!-- switch for creating partition-specific queries for entries -->
    <property name="augmentInitialLoadEntries" value="false"/>
    <property name="initialLoadQueryScanningBasePackages">
        <!-- If absent or empty, the system will not search for initial load query methods -->
        <list>
            <value>com.example.domain</value>
        </list>
    </property>
</bean>
{% endhighlight %}

# Multi-Parallel Initial Load

The `ConcurrentMultiDataIterator` can be used for Multi-Parallel load. This will allow multiple threads to load data into each space primary partition. With the example below 4 threads will be used to load data into the space primary partition , each will handle a different `MyDataIterator`:

{% highlight java %}
public class MySpaceDataSource extends SpaceDataSource{

	public DataIterator<Object> initialDataLoad() {
		
		MyDataIterator dataIteratorArry[] = new MyDataIterator [4];
		dataIteratorArry[0] = new MyDataIterator(10,20);
		dataIteratorArry[1] = new MyDataIterator(30,40);
		dataIteratorArry[2] = new MyDataIterator(50,60);
		dataIteratorArry[3] = new MyDataIterator(70,80);
		
		int threadPoolSize = dataIteratorArry.length;
		ConcurrentMultiDataIterator  concurrentIterator = 
		new ConcurrentMultiDataIterator(dataIteratorArry, threadPoolSize);
		
		return concurrentIterator;
	}
}
{% endhighlight %}

