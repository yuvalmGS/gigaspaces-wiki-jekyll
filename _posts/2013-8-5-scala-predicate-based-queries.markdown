---
layout: post
title:  Scala Predicate Based Queries
categories: XAP96
page_id: 63078413
---

{% compositionsetup %}
{% summary page|65 %}Predicate based `GigaSpace` query operations.{% endsummary %}

{% info %}
This feature makes use of Scala macros. As such, the minimum Scala version required in order to use it is 2.10
{% endinfo %}

# Overview

Support for predicate based queries on the `GigaSpace` proxy has been in added. This support is based on the new macros feature introduced in Scala 2.10.  Each predicate based query is transformed during compilation into an equivalent [SQLQuery](/xap96/2013/07/21/sqlquery.html).

# Usage

To use predicate based queries, import `import org.openspaces.scala.core.ScalaGigaSpacesImplicits._` into scope. Then call the `predicate` method on the `GigaSpace` instance as demonstrated:

{% highlight java %}
/* Import GigaSpace implicits into scope */
import org.openspaces.scala.core.ScalaGigaSpacesImplicits._

/* implicit conversion on gigaspace returns a wrapper class with predicate based query methods */
val predicateGigaSpace = gigaSpace.predicate
{% endhighlight %}

# Supported Queries

## Example data class

For the purpose of demonstration, we will use the following example data class

{% highlight java %}
case class Person @SpaceClassConstructor() (

  @BeanProperty
  @SpaceId
  id: String = null,

  @BeanProperty
  name: String = null,

  @BeanProperty
  @SpaceProperty(nullValue = "-1")
  @SpaceIndex(`type` = SpaceIndexType.EXTENDED)
  height: Int = -1,

  @BeanProperty
  birthday: Date = null,

  @BeanProperty
  son: Person = null
    
)
{% endhighlight %}

## Translations


{: .table .table-bordered}
|Predicate Query|Translated SQL Query|
|:--------------|:-------------------|
| `==` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr%}  person.name == "john"{% wbr%}}{% endhighlight %} | `=` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr%}  "name = ?", "john"{% wbr%}){% endhighlight %} |
| `!=` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr%}  person.name != "john"{% wbr%}}{% endhighlight %} | `<>` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr%}  "name <> ?", "john"{% wbr%}){% wbr%}{% endhighlight %} |
| `>` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr%}  person.height > 10{% wbr%}}{% wbr%}{% endhighlight %} | `>` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr%}  "height > ?", 10: Integer{% wbr%}){% wbr%}{% endhighlight %} |
| `>=` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}
  person.height >= 10{% wbr %}}{% wbr %}{% endhighlight %} | `>=` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "height >= ?", 10: Integer{% wbr %}){% wbr %}{% endhighlight %} |
| `<` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.height < 10{% wbr %}}{% wbr %}{% endhighlight %} | `<` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "height < ?", 10: Integer{% wbr %}){% wbr %}{% endhighlight %} |
| `<=` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.height <= 10{% wbr %}}{% wbr %}{% endhighlight %} | `<=` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "height <= ?", 10: Integer{% wbr %}){% wbr %}{% endhighlight %} |
| `&&` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.height > 10 && person.height < 100{% wbr %}}{% wbr %}{% endhighlight %} | `AND` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "( height > ? ) AND ( height < ? )", {% wbr %}  10: Integer, 100: Integer{% wbr %}){% wbr %}{% endhighlight %} |
| `\|\|` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.height < 10 \| person.height > 100{% wbr %}}{% endhighlight %} | `OR` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "( height < ? ) OR ( height > ? )", {% wbr %}  10: Integer, 100: Integer{% wbr %}){% endhighlight %} |
| `eq null` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.name eq null{% wbr %}}{% endhighlight %} | `is null` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "name is null", QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `ne null` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.name ne null{% wbr %}}{% endhighlight %} | `is NOT null` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "name is NOT null", QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `like` {% highlight java %}// Implicit conversion on java.lang.String{% wbr %}predicateGigaSpace read { person: Person =>{% wbr %}  person.name like "j%"{% wbr %}}{% endhighlight %} | `like` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "name like 'j%'", QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `notLike` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.name notLike "j%"{% wbr %}}{% endhighlight %} | `NOT like` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "name NOT like 'j%'", QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `rlike` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.name rlike "j.\*"{% wbr %}}{% endhighlight %} | `rlike` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "name rlike 'j.\*'", QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| Nested Queries {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.son.name == "dave"{% wbr %}}{% endhighlight %} |{% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "son.name = ?", "dave"{% wbr %}){% endhighlight %} |
| Date {% highlight java %}// implicit conversion on java.util.Date{% wbr %}predicateGigaSpace read { person: Person =>{% wbr %}  person.birthday < janesBirthday{% wbr %}}{% endhighlight %} |{% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "birthday < ?", janesBirthday{% wbr %}){% endhighlight %} |
| Date {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.birthday <= janesBirthday{% wbr %}}{% endhighlight %} |{% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "birthday <= ?", janesBirthday{% wbr %}){% endhighlight %} |
| Date {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.birthday > janesBirthday{% wbr %}}{% endhighlight %} |{% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "birthday > ?", janesBirthday{% wbr %}){% endhighlight %} |
| Date {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  person.birthday >= janesBirthday{% wbr %}}{% endhighlight %} |{% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "birthday >= ?", janesBirthday{% wbr %}){% endhighlight %} |
| `select` {% highlight java %}// select is imported into scope{% wbr %}predicateGigaSpace read { person: Person =>{% wbr %}  select(person.name, person.birthday){% wbr %}  person.id == someId{% wbr %}}{% endhighlight %} | `setProjections` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "id = ?", someId{% wbr %}).setProjections("name, birthday"){% endhighlight %} |
| `orderBy` {% highlight java %}// orderBy is imported into scope{% wbr %}predicateGigaSpace read { person: Person =>{% wbr %}  orderBy(person.birthday){% wbr %}  person.nickName eq null{% wbr %}}{% endhighlight %} | `ORDER BY` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "nickName is null ORDER BY birthday", {% wbr %}  QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `orderBy().ascending` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  orderBy(person.birthday).ascending{% wbr %}  person.nickName eq null{% wbr %}}{% endhighlight %} | `ORDER BY ... ASC` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "nickName is null ORDER BY birthday ASC", {% wbr %}  QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `orderBy().descending` {% highlight java %}predicateGigaSpace read { person: Person =>{% wbr %}  orderBy(person.birthday).descending{% wbr %}  person.nickName eq null{% wbr %}}{% endhighlight %} | `ORDER BY ... DESC` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "nickName is null ORDER BY birthday DESC", {% wbr %}  QueryResultType.OBJECT{% wbr %}){% endhighlight %} |
| `groupBy` {% highlight java %}// groupBy is imported into scope{% wbr %}predicateGigaSpace read { person: Person =>{% wbr %}  groupBy(person.birthday){% wbr %}  person.nickName eq null{% wbr %}}{% endhighlight %} | `GROUP BY` {% highlight java %}gigaSpace read new SQLQuery(classOf[Person], {% wbr %}  "nickName is null GROUP BY birthday", {% wbr %}  QueryResultType.OBJECT{% wbr %}){% endhighlight %} |