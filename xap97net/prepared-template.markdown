---
layout: xap97net
title:  Prepared Template
categories: XAP97NET
page_id: 63799305
---


{% summary %}Querying the space using a Prepared Template{% endsummary %}


# Overview

When executing a query operation on the space, there's an overhead incurred by translating the query to an internal representation (in object templates the properties values are extracted using reflection, in [SQLQuery](./sqlquery.html) the expression string is parsed to an expression tree). If the same query is executed over and over again without modification, that overhead can be removed by using **prepared templates**.

The `ISpaceProxy` interface provides a method called `Snapshot` which receives a template or query , translates it to an internal XAP query structure and returns a reference to that structure as `IPreparedTemplate<T>`. That reference can then be used with any of the proxy's query operations to execute queries on the space in a more efficient manner, since there's no need to translate or parse the query.

{% infosign %} In previous versions the `Snapshot()` method was also used as a workaround for using SQLQuery with blocking operations. Starting 8.0 SQLQuery supports blocking operations out of the box so that workaround is no longer required.

# Usage

Use `ISpaceProxy.Snapshot` to create a prepared template from an object template or a [SqlQuery](./sqlquery.html).

#### Creating a prepared template from an object


{% highlight java %}
Person template= new Person();
template.Age = 21;
IPreparedTemplate<Person> preparedTemplate = proxy.Snapshot(template);
{% endhighlight %}


#### Creating a prepared template from SqlQuery


{% highlight java %}
SqlQuery<Person> query = new SqlQuery<Person>(personTemplate, "Age >= ?");
query.SetParameter(1, 21);
IPreparedTemplate<Person> preparedTemplate = proxy.Snapshot(query);
{% endhighlight %}


{% exclamation %} Using the `ISpaceProxy.Snapshot` method with complex SQL queries is not supported. For more information see [simple SQL queries](./sqlquery.html#Simple SqlQuery).

After creating the prepared template, it can be passed as a template to the Read, Take, ReadMultiple, TakeMultiple, Count and Clear operations, as well as a template when registering for notification.

#### Taking an object from the space using the prepared template


{% highlight java %}
Person person = proxy.Take(preparedTemplate);
{% endhighlight %}

