---
layout: post100
title:  Aggregators
categories: XAP100
parent: querying-the-space.html
weight: 900
---

{% summary  %}  {% endsummary %}

{%section%}
{%column width=60% %}
With many systems such as pricing systems, risk management, trading and other analytic and business intelligence applications you may need to perform an aggregation activity across data stored within the data grid when generating reports or when running some business process. Such activity can leverage data stored in memory and will be much faster than performing it with a database.
{%endcolumn%}
{%column width=40% %}
![aggreg.jpg](/attachment_files/built-in-aggregators.jpg)
{%endcolumn%}
{%endsection%}

XAP provides the common functionality to perform aggregations across the space. There is no need to retrieve the entire data set from the space to the client side , iterate the result set and perform the aggregation. This would be an expensive activity as it might return large amount of data into the client application. The Aggregators allow you to perform the entire aggregation activity at the space side avoiding any data retrieval back to the client side. Only the result of each aggregation activity performed with each partition is returned back to the client side where all the results are reduced and returned to the client application. Such aggregation activity utilize the partitioned nature of the data-grid allowing each partition to execute the aggregation with its local data in parallel, where all the partitions intermediate results are fully aggregated at the client side using the relevant reducer implementation.

# Usage

{% inittab %}
{% tabcontent Application %}
{% highlight java %}
import static org.openspaces.extensions.QueryExtension.*;
...
SQLQuery<Person> personSQLQuery = new SQLQuery<Person>();
// retrieve the maximum value stored in the field "age"
Number maxAgeInSpace = maxValue(space, personSQLQuery, "age");
/// retrieve the minimum value stored in the field "age"
Number minAgeInSpace = minValue(space, personSQLQuery, "age");
// Sum the "age" field on all space objects.
Number combinedAgeInSpace = sum(space, personSQLQuery, "age");
// Sum's the "age" field on all space objects then divides by the number of space objects.
Double averageAge = average(space, personSQLQuery, "age");
// Retrieve the space object with the highest value for the field "age".
Person oldestPersonInSpace = maxEntry(space, personSQLQuery, "age");
/// Retrieve the space object with the lowest value for the field "age".
Person youngestPersonInSpace = minEntry(space, personSQLQuery, "age");
{% endhighlight %}
{% endtabcontent%}
{% tabcontent Space Class %}
{% highlight java %}
@SpaceClass
public class Person {
    private Long id;
    private Long age;
    private String country;

    @SpaceId(autoGenerate=false)
    public Long getId() {
        return id;
    }

    public Person setId(Long id) {
        this.id = id;
        return this;
    }

    public Long getAge() {
        return age;
    }

    public Person setAge(Long age) {
        this.age = age;
        return this;
    }

    public String getCountry() {
        return country;
    }

    public Person setCountry(String country) {
        this.country = country;
        return this;
    }
}
{% endhighlight %}
{% endtabcontent%}
{%endinittab%}

# Compound Aggregation

{%section%}
{%column width=60% %}
Compound aggregation will execute multiple aggregation operations across the space returning all of the result sets at once. When multiple aggregates are needed the compound aggregation API is significantly faster than calling each individual aggregate.

{%endcolumn%}
{%column width=40% %}
![aggreg.jpg](/attachment_files/built-in-Compound-aggregators.jpg)
{%endcolumn%}
{%endsection%}


{% highlight java %}
import static org.openspaces.extensions.QueryExtension.*;
...
SQLQuery<Person> query = new SQLQuery<Person>(Person.class,
		"country=? OR country=? ", "UK", "U.S.A");

AggregationResult aggregationResult = space.aggregate(query,
		new AggregationSet().maxEntry("age").minEntry("age").sum("age")
			.average("age").minValue("age").maxValue("age"));

Person oldest = (Person) aggregationResult.get(0);
Person youngest = (Person) aggregationResult.get(1);
Number sum = (Number) aggregationResult.get(2);
Double average = (Double) aggregationResult.get(3);
Number min = (Number) aggregationResult.get(4);
Number max = (Number) aggregationResult.get(5);
{% endhighlight %}

# Aggregate Embedded Fields
Aggregation against the members of embedded space classes is supported by supplying the field path while invoking the desired aggregate function.

{% inittab %}
{% tabcontent Application %}
{% highlight java %}
import static org.openspaces.extensions.QueryExtension.*;
...
SQLQuery<Person> personSQLQuery = new SQLQuery<Person>();
// retrieve the maximum value stored in the field "age"
Number maxAgeInSpace = maxValue(space, personSQLQuery, "demographics.age");
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Person Space Class %}
{% highlight java %}
@SpaceClass
public class Person {
    private String id;
    private String name;
    private String state;
    private Demographics demographics;

    @SpaceId(autoGenerate = true)
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Demographics getDemographics() {
        return demographics;
    }

    public void setDemographics(Demographics demographics) {
        this.demographics = demographics;
    }
}
{% endhighlight %}
{% endtabcontent %}
{% tabcontent Demographic Space Class %}
{% highlight java %}
public class Demographics     {
    private Integer age;
    private char gender;

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public char getGender() {
        return gender;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }
}
{% endhighlight %}
{% endtabcontent %}
{% endinittab %}