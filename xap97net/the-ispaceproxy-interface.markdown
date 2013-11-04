---
layout: xap97net
title:  The ISpaceProxy Interface
categories: XAP97NET
page_id: 63799326
---

{% compositionsetup %}

{% summary page|60 %}The `ISpaceProxy` interface provides access to the In-Memory Data Grid or the Space. The `ISpaceProxy` interface is used to read froom and write to the space. {% endsummary %}

# Overview

The `ISpaceProxy` interface is ideal for connecting to data stored in the Space. The `ISpaceProxy` interface is used to interact with the Space, allowing both read and write actions. An `ISpaceProxy` is initialized using the `GigaSpacesFactor` static class object.

{% indent %}
![space_basic_operations91.jpg](/attachment_files/xap97net/space_basic_operations91.jpg)
{% endindent %}

An `ISpaceProxy` can be initialized directly in the code or in the `pu.config` file in XML format. To define an `ISpaceProxy`:

{% inittab os_simple_space|top %}

{% tabcontent Namespace %}

{% highlight xml %}
 <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="GigaSpaces.XAP.ProcessingUnit.Containers.BasicContainer.BasicProcessingUnitContainer, GigaSpaces.Core"/>
      <BasicContainer>
//Defining the space proxy. These details are used to create the `ISpaceProxy` instance.
        <SpaceProxies>
          <add Name="MySpace" Url="/./mySpace" ClusterInfoAware="false"/>
          <add Name="MyClusteredSpace" Url="/./myClusteredProxy" Mode="Clustered"/>
        </SpaceProxies>
      </BasicContainer>
  </GigaSpaces.XAP>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Code %}

{% highlight java %}

ISpaceProxy mySpace = GigaSpacesFactory.FindSpace("/./spaceName")

{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

Several `ISpaceProxy` instances can be defined within a single Processing Unit, each with its own properties.

{% infosign %} `ISpaceProxy` simplifies most operations used with the space, but some operations still require access to `IJSpace`, which can be accessed through the `ISpaceProxy` API.

{% note %}

- The `ISpaceProxy` variable represents a remote or embedded space proxy (for a single space or clustered) and **should be constructed only** once throughout the lifetime of the application process.
- You should treat the `ISpaceProxy` variable as a singleton to be shared across multiple different threads.
- The `ISpaceProxy` interface is a thread safe and there is no need to create an `ISpaceProxy` variable per application thread.
- In case the space has been fully terminated (no backup or primary instances running any more) the client space proxy will try to reconnect to the space up to a predefined timeout based on the [Proxy Connectivity](/xap97/proxy-connectivity.html) settings. If it fails to reconnect, an error will be displayed.
{% endnote %}

# Operations

The [ISpaceProxy](http://www.gigaspaces.com/docs/JavaDocOS//docs/dotnetdocs9.5/) interface includes the following main operations:
||[Id Based operations](./id-queries.html)||[Batch operations](#Batch Operations)||[Asynchronous operations](#Asynchronous Operations)||Data Count operations||
|[ReadById](./id-queries.html#Reading an Object using its ID)
TakeById
[ReadByIds](./id-queries.html#Reading Multiple Objects using their IDs)
TakeByIds
ReadIfExistsById
TakeIfExistsById|ReadMultiple
TakeMultiple
WriteMultiple
ReadByIds
TakeByIds|BeginExecute
BeginTake
EndExecute
EndTake|Count

||[Data Query operations](./sqlquery.html)||Data Insert and Update operations||[Business logic execution operations](./task-execution-over-the-space.html)||Data removal operations||
|Read
ReadMultiple
[GetSpaceIterator](/xap97/paging-support-with-space-iterator.html)|Write
WriteMultiple [change](./change-api.html) |Execute
executorBuilder|Clean
Clear
Take
TakeMultiple|

{% include ispaceproxy-code-snippets.markdown %}

{% tip %}
The `Clear` and `Clean` operations do not remove the Space class definition from the Space. You should restart the Space to allow it to drop the class definitions.
{% endtip %}

# Clustered Flag

When starting an embedded space with a cluster topology, or when looking up a remote space started with a cluster topology, a clustered proxy is returned. A clustered proxy is a smart proxy that performs operations against the whole cluster.

Many times, especially when working with a Processing Unit that starts an embedded space, operations against the space should be performed directly on the cluster member. This is a core concept of SBA and Processing Unit, where most, if not all operations should be performed in-memory without leaving the processing unit boundaries when a Processing Unit starts an embedded space.

The decision of working directly with a cluster member or against the whole cluster is done in the `ISpaceProxy` level. The `GigaSpacesFactory` provides a clustered flag with the following logic as the default value: If the space is started in embedded mode (for example, `/./space`), the clustered flag is set to `false`. When the space is looked up in a remote protocol (Jini or RMI), the clustered flag is set to `true`. In addition to automatically setting the flag, the flag can be set explicitly. To configure a clustered proxy:

{% inittab os_simple_space|top %}

{% tabcontent Namespace %}

{% highlight xml %}
  <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="GigaSpaces.XAP.ProcessingUnit.Containers.BasicContainer.BasicProcessingUnitContainer, GigaSpaces.Core"/>
      <BasicContainer>
        <SpaceProxies>
          <add Name="MySpace" Url="/./mySpace" ClusterInfoAware="false"/>
          <add Name="MyClusteredSpace" Url="/./myClusteredProxy" Mode="Clustered"/>
        </SpaceProxies>
      </BasicContainer>
  </GigaSpaces.XAP>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Code %}

{% highlight java %}
//define the space configuration object
SpaceConfig mySettings = new SpaceConfig();
//set the clustered property to true
mySettings.ClusterInfo = true;

//use the FindSpace method in the GigaSpacesFactory static class to create the ISpaceProxy object. Include the SpaceConfig object to set the ISpaceProxy as clustered.
ISpaceProxy proxy = GigaSpacesFactory.FindSpace("/./embSpace", mySettings);

{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

The above example shows a typical scenario where the clustered flag is used. Within a Processing Unit, an application might need to access both the cluster member and the whole cluster directly.

# Using Generics and Default Values in the ISpaceProxy object

The `ISpaceProxy` interface is implemented to provide a wide variety of options for reading data. By receiving and returning a generic parameter, the function provides the capability to read all types of objects in the Space. By implementing many overriding functions, you can take advantage of the in-built default values, or choose to specify your own values according to your own needs. In the Take function below, you can choose to override the timeout value, or use the default value of `0` and not specify a timeout value at all.

{% highlight java %}
public interface ISpaceProxy{

    // ....

    <T> T Take(T template) throws DataAccessException;

    <T> T Take(T template, long timeout) throws DataAccessException;

}
{% endhighlight %}

In a similar manner, the read timeout and write lease can be specified.

{% inittab os_simple_space|top %}

{% tabcontent Namespace %}

{% highlight xml %}
 <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="GigaSpaces.XAP.ProcessingUnit.Containers.BasicContainer.BasicProcessingUnitContainer, GigaSpaces.Core"/>
      <BasicContainer>
//Defining the space proxy. These details are used to create the `ISpaceProxy` instance.
        <SpaceProxies>
          <add Name="MySpace" Url="/./mySpace" ClusterInfoAware="false"/>
          <add Name="MyClusteredSpace" Url="/./myClusteredProxy" Mode="Clustered" Default-Timeout="1000"/>
        </SpaceProxies>
      </BasicContainer>
  </GigaSpaces.XAP>

{% endhighlight %}

{% endtabcontent %}

{% tabcontent Code %}

{% highlight java %}

 ISpaceProxy myProxy = GigaFactory.FindSpace("spacePath");

//call Take function using the default timeout value
    myProxy.Take(myTemplate);

//call Take function overriding the default timeout value
    myProxy.Take(myTemplate, 10000);

{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

{% tip %}
See more examples for the `ISpaceProxy` interface usage with the [POJO Support](/xap97/pojo-support.html) section.
{% endtip %}

# Saving Data to the Space

The `ISpaceProxy.Write()` operation saves a copy of an object into the Space. The actual object passed as a parameter to the Write function is not affected by the operation. As with the Read operation, the Write operation supports default values and generic parameters. When the object to be saved already exists in the Space (objects are identified with their `ID`), the default behavior is to perform an **update operation**.  To change the default update operation scenario, change the update mode in the `WriteModifiers` enum settings to `WriteModifiers.WRITE_ONLY` mode.

When updating an object with many fields use the `PARTIAL_UPDATE` mode.

When performing a Write operation you may provide a lease (time to live) duration (in milliseconds time unit) for the object. The Write invocation returns a [Lease](/xap97/leases---automatic-expiration.html) object allowing you to cancel or renew the object lease. When the lease expires, the object is removed from the Space. The default lease duration is `FOREVER`. An `IllegalArgumentException` is thrown if the lease time requested is negative.

If a Write returns without throwing an exception, that object is committed to the Space, possibly within a transaction. When the Write operation throws an exception, the exception type and message must be considered in order to know whether the object was successfully committed to the Space or not. For example, the `EntryAlreadyInSpaceException` when using write with a `WriteOnly` modifier means the object was not committed, as it already exists in the Space.

Writing an object into a space might generate [notifications](/xap97/notify-container.html) to registered objects.

## Returning Previous Value

When updating an existing object in the space, you may need the object's value before it was updated. The previous value is returned as an `ILeaseContext` Object. The default behavior is to return a null value. To change the setting, set the `WriteModifiers.RETURN_PREV_ON_UPDATE` to true.

# Performing a Delta Update

You may update selected Space object fields (delta) using the [WriteModifiers.PARTIAL_UPDATE](http://www.gigaspaces.com/docs/JavaDoc9.6/com/gigaspaces/client/WriteModifiers.html) modifier. This option is useful when having objects with large number of fields where you would like to update only few of the space object fields. This optimizes the network utilization and avoids serializing/de-serializing the entire object fields when interacting with a remote space.

## How to Perform a Delta Update?

When using the `PARTIAL_UPDATE` modifier, only enter values into the fields that **should** be updated. All other fields **should be assigned a `null` value**. This means that only fields which are set are sent from the client to the Space to replace the existing field's value. In case of a backup (replica) space, the primary space only replicates the updated fields (delta).

Make sure the updated object include its ID when using this option.

{% exclamation %} To use Delta updates you don't have to implement any special interface or have special serialization code. You can use a regular Object.

When updating an object, you can specify 0 (ZERO) as the lease time. This instructs the space to use the original lease time used when the object was written to the Space.

`PARTIAL_UPDATE` Example:

{% highlight java %}

ISpaceProxy mySpace = GigaSpaceFactory.FindSpace("spaceURL");

// initial insert with full update.
MyClass obj = new MyClass();
obj.setId("1");
obj.setField1("A");
obj.setField2("B");
obj.setField3("C");
mySpace.Write(obj);

// reading object back from the space
MyClass obj2 = Space.ReadById(MyClass.class , "1");

// updating only field2
obj2.setField1(null);
obj2.setField2("BBBB");
obj2.setField3(null);
try
{
	mySpace.Write(obj2,0,0,WriteModifiers.PARTIAL_UPDATE);
}
catch (EntryNotInSpaceException enise)
{
	// Object not in space - unsuccessful update
}
{% endhighlight %}

Alternatively, you can use the [change](./change-api.html) operation and update specific fields or even nested fields or modify collections and maps without having to supply the entire collection or map upon such update. The following `change` operation example is equivalent to the previous partial update operation.

{% highlight java %}
IdQuery<MyClass> idQuery = new IdQuery<MyClass>(MyClass.class, "1")
ChangeResult<MyClass> changeResult = space.change(idQuery, new ChangeSet().set("field2", "BBBB"));
if (changeResult.getNumberOfChangedEntries() == 0)
{
  // Object not in space - no change applied
}
{% endhighlight %}

# Data Access

There are various mechanisms offered by GigaSpaces XAP to access the data within the space:

## ID Based

Each space object includes an ID. You may read or remove objects from the space using their ID via the `ReadByID`,`TakeByID`,`ReadIfExistsById`,`TakeIfExistsById`, `ReadByIDs` or the `TakeByIDs` operations.

{% tip %}
The `ReadByID` and `ReadByIDs` have a special performance optimization when running a [Local Cache](./local-cache.html) or [Local View](./local-view.html).
{% endtip %}

See the [Id Queries](./id-queries.html) for details.

## Template Based

The template is an object of the desired entry type, and the properties which are set on the template (i.e. not null) are matched against the respective properties of entries of the same type in the space. Properties with null values are ignored (not matched).

See the [Template Matching](./template-matching.html) for details.

## SQL Based

The [SQLQuery](./sqlquery.html) class is used to query the space using SQL-like syntax. The query statement includes only the `WHERE` clause. The selection aspect of a SQL statement is embedded in other parameters for a SQL query.

See the [SQLQuery](./sqlquery.html) for details.

## Space Iterator

The [IteratorBuilder](http://www.gigaspaces.com/docs/JavaDoc9.6/org/openspaces/core/IteratorBuilder.html) with the [GSIterator](http://www.gigaspaces.com/docs/JavaDoc9.6/com/j_spaces/core/client/GSIterator.html) allows you to iterate over large amount of space objects in a **paging approach**. It avoids the need to retrieve the entire result set in one batch as the `readMultiple` since it is fetching the result set in batches. This optimizes the resource utilization (memory and CPU) involved when executing the query both at the client and server side.

See the [Paging Support with Space Iterator](/xap97/paging-support-with-space-iterator.html) for details.

# ReadIfExists and Read Operations

The two forms of the `Read` operations query the space for an object that matches the template/[SQLQuery](./sqlquery.html) provided. If a match is found, a copy of the matching object is returned. If no match is found, `null` is returned. Passing a `null` reference as the template will match any object.

Any matching object can be returned. Successive Read requests with the same template may or may not return equivalent objects, even if no intervening modifications have been made to the Space. Each invocation of `Read` may return a new object even if the same object is matched in the space. If you would like to Read objects in the same order they have been written into the space you should perform the read objects in a [FIFO mode](./fifo-support.html).

A `ReadIfExists` operation will return a matching object, or a `null` if there is currently no matching object in the space. If the only possible matches for the template have **conflicting locks** from one or more other transactions, the `timeout` value specifies how long the client is willing to wait for interfering transactions to settle before returning a value. If at the end of that time no value can be returned that would not interfere with transactional state, `null` is returned. Note that, due to the remote nature of the space, `Read` and `ReadIfExists` may throw a `RemoteException` if the network or server fails prior to the `timeout` expiration.

A `Read` operation acts like a `ReadIfExists` except that it will wait until a matching object is found or until transactions settle, whichever is longer, up to the timeout period.

In both read methods, a timeout of `JavaSpace.NO_WAIT` means to return immediately, with no waiting, which is equivalent to using a zero timeout. An `IllegalArgumentException` will be thrown if a negative timeout value is used.

{% tip %}
The `Read` operation default timeout is `JavaSpace.NO_WAIT`.
{% endtip %}

# takeIfExists and take Operations

The `take` operations perform exactly like the corresponding `read` operations, except that the matching object is **removed** from the space on one atomic operation. Two `take` operations will **never return** copies of the same object, although if two equivalent objects were in the space the two `take` operations could return equivalent objects.

If a `take` returns a non-null value, the object has been removed from the space, possibly within a transaction. This modifies the claims to once-only retrieval: A take is considered to be successful only if all enclosing transactions commit successfully. If a `RemoteException` is thrown, the take may or may not have been successful. If an `UnusableEntryException` is thrown, the take `removed` the unusable object from the space. If any other exception is thrown, the take did not occur, and no object was removed from the space.

With a `RemoteException`, an object can be removed from a space and yet never returned to the client that performed the take, thus losing the object in between. In circumstances in which this is unacceptable, the take can be wrapped inside a transaction that is committed by the client when it has the requested object in hand.

If you would like to take objects from the space in the same order they have been written into the space you should perform the take objects in a [FIFO mode](./fifo-support.html).

Taking an object from the space might generate [notifications](/xap97/notify-container.html) to registered objects/queries.

{% tip %}
The `take` operation default timeout is `JavaSpace.NO_WAIT`.
{% endtip %}

# Batch Operations

The GigaSpace interface provides simple way to perform bulk operations. You may read or write large amount of objects in one call. The batch operations can be called using the following:

- GigaSpace.readMultiple - Bulk read.
- GigaSpace.takeMultiple - Bulk take (read+remove). Returns the removed objects back to the client.
- GigaSpace.writeMultiple - Bulk write and update.

{% exclamation %} To remove batch of objects without returning these back into the client use `GigaSpace.clear(SQLQuery)`;

Here are few important considerations when using the batch operations:

- The `readMultiple` and `takeMultiple` operations boost the performance, since they perform multiple operations using one call. These methods returns the matching results in one result object back to the client. This allows the client and server to utilize the network bandwidth in an efficient manner. In some cases, these batch operations can be up to 10 times faster than multiple single based operations.
- The `readMultiple` and `takeMultiple` operations should be handled with care, since they can return a large data set (potentially all the space data). This might cause an out of memory error in the space and client process. You should use the [GSIterator](#Space Iterator) to return the result in batches (paging) in such cases.
- Destructive batch operations (`takeMultiple` , `writeMultiple` , `updateMultiple`) should be performed with transactions - this allows the client to roll back the space to its initial state prior the operation was started, in case of a failure.
- When calling `writeMultiple` or `updateMultiple`, make sure `null` values are not part of the passed array.
- When using `writeMultiple`, you should verify that duplicated entries (with the same ID) do not appear as part of the passed array, since the identity of the object is determined based on its `ID` and not based on its reference. This is extremely important with an embedded space, since `writeMultiple` injects the ID value into the object after the write operation (when autogenerate=false).
- The `readMultiple` and `takeMultiple` operations **do not support timeout** operations. The simple way to achieve this is by calling the `read` operation first with the proper timeout, and if non-null values are returned, perform the batch operation.
- Exception handling - batch operations many throw the following Exceptions. Make sure you catch these and act appropriately:
    - [org.openspaces.core.WriteMultiplePartialFailureException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/WriteMultiplePartialFailureException)
    - [org.openspaces.core.WriteMultipleException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/WriteMultipleException)
    - [org.openspaces.core.ReadMultipleException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/ReadMultipleException)
    - [org.openspaces.core.TakeMultipleException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/TakeMultipleException)
    - [org.openspaces.core.ClearException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/ClearException)

# Asynchronous Operations

The GigaSpace interface supports asynchronous (non-blocking) read and asynchronous take operations through the GigaSpace interface. Both return a [Future<T>](http://download.oracle.com/javase/6/docs/api/java/util/concurrent/Future.html) object, where T is the type of the object the request returns. Future<T>.get() can be used to query the object to see if a result has been returned or not.

Alternatively, asyncRead and asyncTake also accept an implementation of [AsyncFutureListener<T>](http://www.gigaspaces.com/docs/JavaDoc7.1/com/gigaspaces/async/AsyncFutureListener.html), which will have its [onResult(AsyncFuture<T>)](http://www.gigaspaces.com/docs/JavaDoc7.1/com/gigaspaces/async/AsyncFutureListener.html#onResult(com.gigaspaces.async.AsyncResult)) method called when the result has been populated. This does not affect the return type of the Future<T>, but provides an additional mechanism for handling the asynchronous response.

![async_operations.jpg](/attachment_files/xap97net/async_operations.jpg)

Asynchronous `write` operation can be implemented using a [Task](./task-execution-over-the-space.html), where the `Task` implementation include a write operation. With this approach the `Task` is sent to the space and executed in an asynchronous manner. The write operation itself will be completed once both the primary and the backup will acknowledge the operation. This activity will be performed as a background activity from the client perspective.

{% inittab async_operations|top %}

{% tabcontent Space Class %}

{% highlight java %}
public class MyClass implements Serializable{
	String data;
	Integer id;
	public MyClass(){}
	public MyClass(int id , String data){
		this.id = id;
		this.data = data;
	}
	public MyClass(int id){this.id = id;}
	public String getData() {return data;}
	public void setData(String data) {this.data = data;}
	@SpaceId (autoGenerate = false)
	@SpaceRouting
	public Integer getId() {return id;}
	public void setId(Integer id) {this.id = id;}
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent AsyncFutureListener %}

{% highlight java %}
public class AsyncListener implements AsyncFutureListener<MyClass>{
	String operation;
	public AsyncListener(String operation)
	{
		this.operation=operation;
	}
	public void onResult(AsyncResult<MyClass> result) {
		System.out.println("Async " + operation+
			" Operation Listener - Found matching object:"+
				result.getResult());
	}
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Async Read %}

{% highlight java %}
GigaSpace space = new GigaSpaceConfigurer (new UrlSpaceConfigurer("jini://*/*/space")).gigaSpace();
AsyncFuture<MyClass> futureRead =  space.asyncRead(new MyClass(1), 10000, new AsyncListener("Read"));
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Async Take %}

{% highlight java %}
GigaSpace space = new GigaSpaceConfigurer (new UrlSpaceConfigurer("jini://*/*/space")).gigaSpace();
AsyncFuture<MyClass> futureTake =  space.asyncTake(new MyClass(1), 10000, new AsyncListener("Take"));
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Async Write %}

{% highlight java %}
GigaSpace space = new GigaSpaceConfigurer (new UrlSpaceConfigurer("jini://*/*/space")).gigaSpace();
MyClass obj = new MyClass(1,"AAA");
space.execute(new AsyncWriteTask(obj));
{% endhighlight %}

{% highlight java %}
public class AsyncWriteTask implements Task<Integer>{
	MyClass obj;
	public AsyncWriteTask (MyClass obj)
	{
		this.obj=obj;
	}
	@TaskGigaSpace
	transient GigaSpace space;
	public Integer execute() throws Exception {
		space.write (obj);
		return 1;
	}
}
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

# Declarative Transactions

As seen in the take API above, there is no need to provide a Jini transaction object for the different space operations. `GigaSpace` with the different OpenSpaces [transaction managers](/xap97/transaction-management.html) and Spring allow simple declarative definition of transactions. This boils down to the fact that if there is an ongoing transaction running, any operation performed using the `GigaSpace` interface joins it, using Spring's rich transaction support.

{% exclamation %} In order to have GigaSpace transactional, the transaction manager must be provided as a reference when constructing the GigaSpace bean. For example (using the distributed transaction manager):

{% inittab os_simple_space|top %}

{% tabcontent Namespace %}

{% highlight xml %}
<os-core:space id="space" url="/./space" />

<os-core:distributed-tx-manager id="transactionManager"/>

<os-core:giga-space id="gigaSpace" space="space" tx-manager="transactionManager"/>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Plain XML %}

{% highlight xml %}
<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="/./space" />
</bean>

<bean id="transactionManager" class="org.openspaces.core.transaction.manager.DistributedJiniTransactionManager">
	<property name="space" ref="space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
    <property name="space" ref="space" />
	<property name="transactionManager" ref="transactionManager" />
</bean>
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

{% lampon %} It is highly recommended to read the [transaction management chapter](http://static.springframework.org/spring/docs/3.0.x/reference/transaction.html) in the Spring reference documentation.

## Transaction Provider

OpenSpaces provides a pluggable transaction provider using the following interface:

{% highlight java %}
public interface TransactionProvider {

    Transaction getCurrentTransaction(Object transactionalContext, IJSpace space);

    int getCurrentTransactionIsolationLevel(Object transactionalContext);
}
{% endhighlight %}

OpenSpaces comes with a default transaction provider implementation, which uses Spring and its transaction manager in order to obtain the currently running transactions and automatically use them under transactional operations.

`GigaSpace` allows access to the current running transaction using the transaction provider. The following code example shows how the take operation can be performed using `IJspace` (users normally won't be required to do so):

{% highlight java %}
gigaSpace.getSpace().take(obj, gigaSpace.getCurrentTransaction(), 1000);
{% endhighlight %}

# Transaction Isolation Level

GigaSpaces supports three isolation levels: `READ_UNCOMMITTED`, `READ_COMMITTED` and `REPEATABLE_READ` (default). When using `GigaSpace`, the default isolation level that it will perform under can be defined in the following manner:

{% inittab os_simple_space|top %}

{% tabcontent Namespace %}

{% highlight xml %}
<os-core:space id="space" url="/./space" />

<os-core:giga-space id="gigaSpace" space="space" default-isolation="READ_COMMITTED"/>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Plain XML %}

{% highlight xml %}
<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="/./space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
    <property name="defaultIsolationLevelName" value="READ_COMMITTED" />
</bean>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Code %}

{% highlight java %}
IJSpace space = // get Space either by injection or code creation

GigaSpace gigaSpace = new GigaSpaceConfigurer(space)
                          .defaultIsolationLevel(TransactionDefinition.ISOLATION_READ_COMMITTED)
                          .gigaSpace();
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

In addition, Spring allows you to define the isolation level on the transaction definition itself:

{% highlight java %}
@Transactional(readOnly = true)
public class DefaultFooService implements FooService {

    private GigaSpace gigaSpace;

    public void setGigaSpace(GigaSpace gigaSpace) {
    	this.gigaSpace = gigaSpace;
    }

    public Foo getFoo(String fooName) {
        // do something
    }

    // these settings have precedence for this method
    @Transactional(readOnly = false,
                   propagation = Propagation.REQUIRES_NEW,
                   isolation  = Isolation.READ_COMMITTED)
    public void updateFoo(Foo foo) {
        // do something
    }
}
{% endhighlight %}

In the above example, any operation performed using `GigaSpace` in the `updateFoo` method automatically works under the `READ_COMMITTED` isolation level.

# Exception Hierarchy

OpenSpaces is built on top of the Spring [consistent exception hierarchy](http://static.springframework.org/spring/docs/2.0.x/reference/dao.html#dao-exceptions) by translating all of the different JavaSpaces exceptions and GigaSpaces exceptions into runtime exceptions, consistent with the Spring exception hierarchy. All the different exceptions exist in the `org.openspaces.core` package.

OpenSpaces provides a pluggable exception translator using the following interface:

{% highlight java %}
public interface ExceptionTranslator {

    DataAccessException translate(Throwable e);
}
{% endhighlight %}

A default implementation of the exception translator is automatically used, which translates most of the relevant exceptions into either Spring data access exceptions, or concrete OpenSpaces runtime exceptions (in the `org.openspaces.core` package).

## Exception handling for Batch Operations

Batch operations many throw the following Exceptions. Make sure you catch these and act appropriately:
    - [org.openspaces.core.WriteMultiplePartialFailureException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/WriteMultiplePartialFailureException)
    - [org.openspaces.core.WriteMultipleException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/WriteMultipleException)
    - [org.openspaces.core.ReadMultipleException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/ReadMultipleException)
    - [org.openspaces.core.TakeMultipleException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/TakeMultipleException)
    - [org.openspaces.core.ClearException](http://www.gigaspaces.com/docs/JavaDocOS/org/openspaces/core/ClearException)
