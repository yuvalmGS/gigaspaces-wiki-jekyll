---
layout: post
title:  External Data Source API
categories: XAP97
---

{% compositionsetup %}
{% summary page|66 %}External Data Source API. This page explains how to implement custom external data source.{% endsummary %}

# Overview

{% info title=Built in External Data Source Implementation %}
GigaSpaces XAP also ships with an [out-of-the-box implementation](./hibernate-space-persistency.html) based on Hibernate
{% endinfo %}

The External Data Source API provide three major functionalities, each is defined by a specific interface:

- [Data Retrieval](#Data Retrieval) - Determines how data is retrieved from the data source, when it is needed by the space.
- [Data Persistency](#Data Persistency) - Determines how data is updated in the data source, when it is changed in the space.
- [Initialization and Shutdown](#Initialization and Shutdown) - Determines:
    - How the data source is configured - database name,location.
    - Which data is loaded into the space at startup.
    - How to close the data source.

{% tip %}
`SQLDataProvider` and `DataProvider` `read` and `iterator` methods are called when running in LRU cache policy mode and when running with `read-only` EDS usage mode.
{% endtip %}

# External Data Source Components

Based on your application persistency requirements - you may need to implement all EDS interfaces or only few of them.
For example - when your application should load data from the database without writing data into back into the database (using EDS `read-only` usage mode), you should implement only the `SQLDataProvider` interface. In such a case you may write data into the database via the Mirror Service by implementing the `BulkDataPersister`.

## Data Retrieval

There are two options to implement Data retrieval:

- [SQL-based API](#SQL-based API)
- [Object-based API](#Object-based API)

####  SQL-based API

The [SQLDataProvider](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/SQLDataProvider.html) allows you to implement a full-featured EDS with databases that support SQL queries.
When the EDS implements the `SQLDataProvider` interface, all space data retrieval operations are translated to SQLQuery and passed to `DataIterator iterator(SQLQuery query)`. The result is an iterator of the fetched data, that is iterated by the space, and the data is inserted into the space memory. See Default implementation of SQLDataProvider.iterator().

#### Object-based API

The **[DataProvider](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/DataProvider.html)** should be used for databases that don't support SQL queries.

- `DataIterator iterator(userObjectTemplate)`: This method is called when read is performed with a template. The original template is passed as the parameter to iterator(). The result is an iterator of the fetched data that is iterated by the space, and the data is inserted into the space memory.
- `Object read(Object userObjectTemplate)`: This method is used to optimize queries that always return a single object - reads with UID. The data is the user object template that has a non-null UID. The result should be a matching object found in the EDS with the same ID.

## Data Persistency

Data Persistency can be implemented as Synchronous or Asynchronous. In Synchronous approach, DataPersister logic is running in the same space instance, in Asynchronous approach DataPersister logic runs in a Mirror Service (see [Asynchronous Persistency with the Mirror](./asynchronous-persistency-with-the-mirror.html))

In either approach, DataPersistor interface is implemented and configured appropriately. There are two options to implement Data Persistency:

- [Persistency Transactional Mode](#Persistency Transactional Mode)
- [Persistency Non-Transactional Mode](#Persistency Non-Transactional Mode)

{% tip %}
In case you would like to avoid specific classes or space objects from being persistent (invoking the Data Persistency EDS methods), you should use the `@SpaceClass (persist=false)` class level decoration or the `@SpacePersist` method level decoration. See the [POJO Metadata](./pojo-metadata.html) for details.
{% endtip %}

### Persistency Transactional Mode

If the EDS implements the **[BulkDataPersister](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/BulkDataPersister.html)** interface, data persistency operations that fall under a transaction are translated to a list of **BulkItem**(operation+data), and passed to `executeBulk(List<BulkItem>` items).
The [BulkItem](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/BulkItem.html) is an object that has two components - the data that was changed and the operation that was executed - WRITE/UPDATE/REMOVE. See Default implementation of BulkDataPersister.executeBulk()

### Persistency Non-Transactional Mode

In the EDS does not implement  **[BulkDataPersister](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/BulkDataPersister.html)** interface, or space operations are not wrapped under a transaction, persistence operations are invoked on a per space operation basis.

The **[DataPersister](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/DataPersister.html)** interface has three methods for each space operation:

- `write(Object userObject)` - Invoked when a new object is inserted to the space.
- `update(Object userObject)` - Invoked when an object is updated in the space.
- `remove(Object userObject)` - Invoked when an object is removed from the space.

{% tip %}
`userObject` is always the original user object unless stated otherwise. See the `space-config.external-data-source.data-class` at the [External Data Source Properties](./space-persistency-advanced-topics.html#Properties) section.
{% endtip %}

##Initialization and Shutdown
Initialization and Shutdown done via the **[ManagedDataSource](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/ManagedDataSource.html)** interface:

- `init(Properties customProperties)` is called on space startup, so all the EDS initialization is done in this method. All the configuration is passed in the _customProperties_ parameter. This is the content of a properties file that is completely implementation dependant, and can be configured in the following way: see EDS Configuration and Default implementation of ManagedDataSource.init()
- `DataIterator initialLoad()` is called just after the init(). It returns an iterator to the data that should be inserted into the space on startup. This can be all of the data, or only a subset. This depends on the implementation - see Default implementation of ManagedDataSource.initialLoad()
- `shutdown()`  is called before the space is closed. This is the place to close all the database connections, or any other resources that EDS was using - see Default implementation of ManagedDataSource.shutdown()

# Multi Space class EDS implementation

You should have a single EDS implementation per space (or space cluster). This implementation should handle all the different space classes the space handling. In such a case, your EDS classes (DataProvider, etc) should not use generics. This how you could load/persist any type of object. As part of the executeBulk, initialLoad , etc methods you should check the data type (`instance of`) and have the specific code to handle the specific class object (if needed).

# API Matrix

## EDS Implements:SQLDataProvider, DataPersister

{: .table .table-bordered}
|Client Call |EDS Call|Cache Policy Mode|EDS Usage Mode|
|:-----------|:-------|:----------------|:-------------|
|write|iterator SQLQuery,write|ALL\_IN\_CACHE, LRU|read-write|
|take|remove|ALL\_IN\_CACHE, LRU|read-write|
|readById|iterator SQLQuery|ALL\_IN\_CACHE, LRU|read-write,read-only|
|readByIds|iterator SQLQuery|ALL\_IN\_CACHE, LRU|read-write,read-only|
|read|iterator SQLQuery|LRU|read-write,read-only|
|readMultiple|iterator SQLQuery|LRU|read-write,read-only|
|takeMultiple|iterator SQLQuery, remove|ALL\_IN\_CACHE, LRU|read-write|
|readMultiple SQLQuery|iterator SQLQuery|LRU|read-write,read-only|
|takeMultiple SQLQuery|iterator SQLQuery ,remove|ALL\_IN\_CACHE, LRU|read-write|

## EDS Implements:DataProvider, DataPersister

{: .table .table-bordered}
|Client Call |EDS Call|Cache Policy Mode|EDS Usage Mode|
|:-----------|:-------|:----------------|:-------------|
|write|read(LRU),write|ALL\_IN\_CACHE, LRU|read-write|
|take|remove|ALL\_IN\_CACHE, LRU|read-write|
|readById - **autoGenerate=true**|read|LRU|read-write,read-only|
|readById - **autoGenerate=false**|iterator|LRU|read-write,read-only|
|readByIds - **autoGenerate=true**|read|LRU|read-write,read-only|
|readByIds - **autoGenerate=false**|iterator|LRU|read-write,read-only|
|read|iterator|LRU|read-write,read-only|
|readMultiple|iterator |LRU|read-write,read-only|
|takeMultiple|iterator , remove|ALL\_IN\_CACHE, LRU|read-write|
|readMultiple SQLQuery| | | |
|takeMultiple SQLQuery| | | |

## EDS Implements:DataProvider,SQLDataProvider,DataPersister

{: .table .table-bordered}
|Client Call |EDS Call|Cache Policy Mode|EDS Usage Mode|
|:-----------|:-------|:----------------|:-------------|
|write|iterator SQLQuery,write,read(LRU)|ALL\_IN\_CACHE, LRU|read-write|
|take|remove|ALL\_IN\_CACHE, LRU|read-write|
|readById|iterator SQLQuery|LRU|read-write,read-only|
|readByIds|iterator SQLQuery|LRU|read-write,read-only|
|read|iterator SQLQuery|LRU|read-write,read-only|
|readMultiple|iterator SQLQuery|LRU|read-write,read-only|
|takeMultiple|iterator SQLQuery, remove|ALL\_IN\_CACHE, LRU|read-write|
|readMultiple SQLQuery|iterator SQLQuery|LRU|read-write,read-only|
|takeMultiple SQLQuery|iterator SQLQuery ,remove|ALL\_IN\_CACHE, LRU|read-write|

Custom EDS implementations looking for transactional behavior on persisting data should implement BulkDataPersister Interface and invoke the space operations with appropriate transaction boundaries. All update operations (write, writeMultiple, take, takeMultiple) that fall under a space transaction will be invoked as one executeBulk call.

If a Custom EDS implements BulkDataPersister but the space operations are not invoked under transaction, above mapping still holds true.

{% tip %}
**The `space-config.external-data-source.supports-inheritance` space property behavior**

- When having the `supports-inheritance=true` - GigaSpaces will call the read/iterator method once (according the autoGenerate mode of the class).
- When having `supports-inheritance=false` - GigaSpaces will call the read/iterator method for the relevant class and every class that extends this class (according the autoGenerate mode of the class).
{% endtip %}

# All External Data Source APIs

- **[ManagedDataSource](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/ManagedDataSource.html)** -- handles data source life cycle -- configuration,initialization, shutdown, and initial load.
- **[SQLDataProvider](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/SQLDataProvider.html)** -- handles all space read operations.
- **[DataProvider](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/DataProvider.html)** -- handles simple data source queries -- read operations.
    - [DataIterator](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/DataIterator.html)
- **[BulkDataPersister](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/BulkDataPersister.html)** -- handles the persistency of all write/update/take operations. Supports transactional operations.
    - [BulkItem](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/BulkItem.html)
- **[DataPersister](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?com/gigaspaces/datasource/DataPersister.html)** -- handles single data updates -- write/update/remove operations.
- **[SQLDataProviderSplitter](http://www.gigaspaces.com/docs/JavaDoc9.6/index.html?org/openspaces/persistency/patterns/SQLDataProviderSplitter.html)** --  A sql data provider that redirects the sql based operations to the given data source that
  can handle the given type.

# Example

See below a simple EDS implementation example. The space with this example running in a partitioned mode (2 nodes) using LRU Caching policy mode.

{% inittab example|top %}
{% tabcontent The EDS implementation class %}
This class includes a simple main method that will allow you to test it when running within your IDE debugger:

{% highlight java %}
package com.test.eds;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;
import com.gigaspaces.datasource.DataIterator;
import com.gigaspaces.datasource.DataProvider;
import com.gigaspaces.datasource.DataSourceException;
import com.gigaspaces.datasource.ManagedDataSource;

public class MyEDS implements DataProvider<MyData> {
	static Logger logger = Logger.getLogger("MyEDS");

	public static void main(String[] args) {
		try {

			GigaSpace spaceNode1 = startClusterNode(1);
			GigaSpace spaceNode2 = startClusterNode(2);
			logger.info("Partition 1 has " + spaceNode1.count(null)
					+ " objects");
			logger.info("Partition 2 has " + spaceNode2.count(null)
					+ " objects");

			GigaSpace gigaspace = new GigaSpaceConfigurer(
					new UrlSpaceConfigurer("jini://*/*/space")).gigaSpace();

			MyData obj = new MyData();
			obj.setId("a");
			obj.setData("aaaaa");
			obj.setRouting(1);
			logger.info("APP-write");
			gigaspace.write(obj);

			MyData templ1 = new MyData();
			templ1.setId("1");
			templ1.setRouting(1);

			MyData templ2 = new MyData();
			templ2.setId("a");
			templ2.setRouting(1);

			MyData templ3 = new MyData();
			templ3.setId("b");
			templ3.setRouting(1);

			logger.info("APP-read Loaded object from EDS");
			MyData ret = gigaspace.read(templ1);
			if (ret == null)
				logger.info("Could not read loaded object");
			else
				logger.info("read loaded object - OK!");

			logger.info("APP-read");
			ret = gigaspace.read(templ2);
			if (ret == null)
				logger.info("Could not read object");
			else
				logger.info("read object - OK!");

			logger.info("APP-read unloaded object");
			ret = gigaspace.read(templ3);
			if (ret == null)
				logger.info("Can't find the object - OK");
			else
				logger.info("read loaded object - OK!");

			logger.info("APP-readMultiple");
			MyData retArray[] = gigaspace.readMultiple(new MyData(),
					Integer.MAX_VALUE);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public DataIterator<MyData> iterator(MyData query)
			throws DataSourceException {
		logger.info(">> Partition ID:" + partitionID + " EDS-iterator");
		return new MyDataIterator(query);
	}

	public MyData read(MyData query) throws DataSourceException {
		logger.info(">> Partition ID:" + partitionID + " EDS-read ID:"
				+ query.getId());
		return null;
	}

	int partitionID;

	public void init(Properties props) throws DataSourceException {
		logger.info(props.toString());
		partitionID = Integer
				.valueOf(
						props.get(ManagedDataSource.STATIC_PARTITION_NUMBER)
								.toString()).intValue();
		logger.info(">> Partition ID:" + partitionID + " EDS-init");
	}

	public DataIterator<MyData> initialLoad() throws DataSourceException {
		logger.info(">> Partition ID:" + partitionID + " EDS-initialLoad");
		List<MyData> initData = new ArrayList<MyData>();

		// load the space with some data
		MyData obj = new MyData();
		obj.setId("1");
		obj.setData("1111111");
		obj.setRouting(1);

		initData.add(obj);
		logger.info(">> Partition ID:" + partitionID + " trying to load "
				+ initData.size() + " objects into the space");
		return new MyDataIterator(initData);
	}

	public void shutdown() throws DataSourceException {
	}

	static GigaSpace startClusterNode(int id) {
		GigaSpace space = new GigaSpaceConfigurer(new UrlSpaceConfigurer(
				"/./space?cluster_schema=partitioned-sync2backup&total_members=2,0&id="
						+ id)
				.addProperty("space-config.persistent.enabled", "true")
				.addProperty("space-config.engine.cache_policy", "0")
				// LRU
				.addProperty("space-config.external-data-source.usage",
						"read-only")
				.addProperty("space-config.persistent.StorageAdapterClass",
						"com.j_spaces.sadapter.datasource.DataAdapter")
				.addProperty(
						"space-config.external-data-source.data-source-class",
						MyEDS.class.getName())).gigaSpace();
		return space;
	}

}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent The DataIterator %}

{% highlight java %}
package com.test.eds;

import java.util.Iterator;
import java.util.List;

import com.gigaspaces.datasource.DataIterator;
import com.j_spaces.core.client.SQLQuery;

public class MyDataIterator implements DataIterator<MyData>{

	List<MyData> data;
	Iterator<MyData> dataIter;
	public MyDataIterator(List<MyData> initData)
	{
		data=initData;
		dataIter = data.iterator();
	}

	public MyDataIterator(SQLQuery<MyData> query)
	{

	}
	public MyDataIterator(MyData query)
	{

	}
	public void close() {

	}

	public boolean hasNext() {
		if (dataIter!=null )
			return dataIter.hasNext();
		return false;
	}

	public MyData next() {
		if (dataIter!=null )
			return dataIter.next();
		else
			return null;
	}

	public void remove() {
		if (dataIter!=null )
			dataIter.remove();
	}

}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent The Space Class %}

{% highlight java %}
package com.test.eds;

import com.gigaspaces.annotation.pojo.*;
import com.gigaspaces.metadata.index.SpaceIndexType;

@SpaceClass (persist=true)
public class MyData {

	String id;
	String data;
	Integer routing;

	@SpaceId (autoGenerate=true)
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@SpaceIndex(type=SpaceIndexType.BASIC)
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}

	@SpaceRouting
	public Integer getRouting() {
		return routing;
	}
	public void setRouting(Integer routing) {
		this.routing = routing;
	}
}
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

