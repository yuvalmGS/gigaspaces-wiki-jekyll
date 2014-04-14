
{%anchor clear%}

# The Clear Operation

{%section%}
{%column width=60% %}
You can use `GigaSpace.clear` to remove objects from the space. When using the clear operation no object/objects are returned.
{%endcolumn%}
{%column width=35% %}
![POJO_clear.jpg](/attachment_files/POJO_clear.jpg)
{%endcolumn%}
{%endsection%}

Examples:

{% highlight csharp %}
   ISpaceProxy spaceProxy = GigaSpacesFactory.FindSpace(url);

   // Clear by Template
   Employee employee = new Employee("Last Name", new Integer(32));
   spaceProxy.Clear(employee);

   // Clear by SQLQuery
   String querystr	= "Age > 30";
   SqlQuery query = new S qlQuery<Employee>(querystr);
   spaceProxy.clear(query);

   // Clear by IdQuery
   IdQuery<Employee> query = new IdQuery<Employee>(new Integer(32));
   spaceProxy.Clear(query);

   // Clear with Modifier
   SqlQuery<Employee> query = new SqlQuery<Employee>("FirstName='first name'");
   spaceProxy.Clear(query, ClearModifiers.EVICT_ONLY);
{% endhighlight %}



{% togglecloak id=os-clear %}**Method summary...**{% endtogglecloak %}
{% gcloak os-clear %}

Clears objects from space.{%netapi%}{%dotnetdoc M_GigaSpaces_Core_ISpaceProxy_Clear%}{%endnetapi%}


http://www.gigaspaces.com/docs/dotnetdocs9.7/html/N_GigaSpaces_Core_Admin.htm
http://www.gigaspaces.com/docs/dotnetdocs9.7/html/T_GigaSpaces_Core_ISpaceProxy.htm


{%highlight csharp%}
void clear(T entry) throws DataAccessException
void clear(T entry, ClearModifiers modifiers) throws DataAccessException
void clear(ISpaceQuery<T> query) throws DataAccessException
......

{%endhighlight%}

{: .table .table-bordered}
| Modifier and Type | Description | default |
|:-----|:------------|:-------- |
|T          | POCO, SpaceDocument||
|query         | SqlQuery, IdQuery||
|[ClearModifiers]({%dotnetdoc /com/gigaspaces/client/ClearModifiers%}|Provides modifiers to customize the behavior of the clear operations | NONE  |
{% endgcloak  %}


