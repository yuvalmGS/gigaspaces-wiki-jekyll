
{%anchor count%}

# The Count Operation


You can use `GigaSpace.count` to count objects in a space.


Examples:

{% highlight csharp %}
    ISpaceProxy spaceProxy = GigaSpacesFactory.FindSpace(url);

   // Count with Template
   Employee employee = new Employee("Last Name");
   int count = spaceProxy.Count(employee);

   // Count with SQLQuery
   String querystr	= "Age > 30";
   SqlQuery query = new SqlQuery<Employee>( querystr);
   int count = spaceProxy.Count(query);

   // Count with IdsQuery
   Integer[] ids = new Integer[] { 32, 33, 34 };
   IdsQuery<Employee> query = new IdsQuery<Employee>(ids);
   int count = spaceProxy.Count(query);

   // Count with Modifier
   SqlQuery<Employee> query = new SQLQuery<Employee>("FirstName='first name'");
    int count = spaceProxy.Count(query, CountModifiers.EXCLUSIVE_READ_LOCK);
{% endhighlight %}



{% togglecloak id=os-count %}**Method summary...**{% endtogglecloak %}
{% gcloak os-count %}

Count objects in space.{%javaapi%}http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/org/openspaces/core/GigaSpace.html#count(java.lang.Object){%endjavaapi%}

{%highlight java%}
int count(T entry) throws DataAccessException
int count(T entry, ClearModifiers modifiers) throws DataAccessException
int count(ISpaceQuery<T> query) throws DataAccessException
......

{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | default |
|:-----|:------------|:-------- |
|T          | POCO, SpaceDocument||
|query         | SqlQuery, IdQuery||
|[CountModifiers](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/gigaspaces/client/CountModifiers.html)|Provides modifiers to customize the behavior of the count operations | NONE  |
{% endgcloak  %}


