---
layout: post
title:  Scala Predicate Based Queries
categories: XAP97
---

{% compositionsetup %}
{% summary page|65 %}Predicate based `GigaSpace` query operations.{% endsummary %}

{% info %}
This feature makes use of Scala macros. As such, the minimum Scala version required in order to use it is 2.10
{% endinfo %}

# Overview

Support for predicate based queries on the `GigaSpace` proxy has been in added. This support is based on the new macros feature introduced in Scala 2.10.  Each predicate based query is transformed during compilation into an equivalent [SQLQuery](./sqlquery.html).

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
| `== predicateGigaSpace read { person: Person =>`<br/>`  person.name == "john"`<br/>`}` | `= gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name = ?", "john"`<br/>`)` |
| `!= predicateGigaSpace read { person: Person =>`<br/>`  person.name != "john"`<br/>`}` | `<> gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name <> ?", "john"`<br/>`)`<br/> |
| `> predicateGigaSpace read { person: Person =>`<br/>`  person.height > 10`<br/>`}`<br/> | `> gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "height > ?", 10: Integer`<br/>`)`<br/> |
| `>= predicateGigaSpace read { person: Person =>`<br/>`  person.height >= 10`<br/>`}`<br/> | `>=gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "height >= ?", 10: Integer`<br/>`)`<br/> |
| `< predicateGigaSpace read { person: Person =>`<br/>`  person.height < 10`<br/>`}`<br/> | `< gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "height < ?", 10: Integer`<br/>`)`<br/> |
| `<= predicateGigaSpace read { person: Person =>`<br/>`  person.height <= 10`<br/>`}`<br/> | `<= gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "height <= ?", 10: Integer`<br/>`)`<br/> |
| `&& predicateGigaSpace read { person: Person =>`<br/>`  person.height > 10 && person.height < 100`<br/>`}`<br/> | `AND gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "( height > ? ) AND ( height < ? )", `<br/>`  10: Integer, 100: Integer`<br/>`)`<br/> |
| `|| predicateGigaSpace read { person: Person =>`<br/>`  person.height < 10 \| person.height > 100`<br/>`}` | `OR gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "( height < ? ) OR ( height > ? )", `<br/>`  10: Integer, 100: Integer`<br/>`)` |
| `eq null predicateGigaSpace read { person: Person =>`<br/>`  person.name eq null`<br/>`}` | `is null gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name is null", QueryResultType.OBJECT`<br/>`)` |
| `ne null predicateGigaSpace read { person: Person =>`<br/>`  person.name ne null`<br/>`}` | `is NOT null gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name is NOT null", QueryResultType.OBJECT`<br/>`)` |
| `like // Implicit conversion on java.lang.String`<br/>`predicateGigaSpace read { person: Person =>`<br/>`  person.name like "j%"`<br/>`}` | `like gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name like 'j%'", QueryResultType.OBJECT`<br/>`)` |
| `notLike predicateGigaSpace read { person: Person =>`<br/>`  person.name notLike "j%"`<br/>`}` | `NOT like gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name NOT like 'j%'", QueryResultType.OBJECT`<br/>`)` |
| `rlike predicateGigaSpace read { person: Person =>`<br/>`  person.name rlike "j.\*"`<br/>`}` | `rlike gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "name rlike 'j.\*'", QueryResultType.OBJECT`<br/>`)` |
| Nested Queries `predicateGigaSpace read { person: Person =>`<br/>`  person.son.name == "dave"`<br/>`}` |`gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "son.name = ?", "dave"`<br/>`)` |
| Date `// implicit conversion on java.util.Date`<br/>`predicateGigaSpace read { person: Person =>`<br/>`  person.birthday < janesBirthday`<br/>`}` |`gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "birthday < ?", janesBirthday`<br/>`)` |
| Date `predicateGigaSpace read { person: Person =>`<br/>`  person.birthday <= janesBirthday`<br/>`}` |`gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "birthday <= ?", janesBirthday`<br/>`)` |
| Date `predicateGigaSpace read { person: Person =>`<br/>`  person.birthday > janesBirthday`<br/>`}` |`gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "birthday > ?", janesBirthday`<br/>`)` |
| Date `predicateGigaSpace read { person: Person =>`<br/>`  person.birthday >= janesBirthday`<br/>`}` |`gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "birthday >= ?", janesBirthday`<br/>`)` |
| `select // select is imported into scope`<br/>`predicateGigaSpace read { person: Person =>`<br/>`  select(person.name, person.birthday)`<br/>`  person.id == someId`<br/>`}` | `setProjections gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "id = ?", someId`<br/>`).setProjections("name, birthday")` |
| `orderBy // orderBy is imported into scope`<br/>`predicateGigaSpace read { person: Person =>`<br/>`  orderBy(person.birthday)`<br/>`  person.nickName eq null`<br/>`}` | `ORDER BY gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "nickName is null ORDER BY birthday", `<br/>`  QueryResultType.OBJECT`<br/>`)` |
| `orderBy().ascending predicateGigaSpace read { person: Person =>`<br/>`  orderBy(person.birthday)==.ascending`<br/>`  person.nickName eq null`<br/>`}` | `ORDER BY ... ASC gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "nickName is null ORDER BY birthday ASC", `<br/>`  QueryResultType.OBJECT`<br/>`)` |
| `orderBy().descending predicateGigaSpace read { person: Person =>`<br/>`  orderBy(person.birthday).descending`<br/>`  person.nickName eq null`<br/>`}` | `ORDER BY ... DESC gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "nickName is null ORDER BY birthday DESC", `<br/>`  QueryResultType.OBJECT`<br/>`)` |
| `groupBy // groupBy is imported into scope`<br/>`predicateGigaSpace read { person: Person =>`<br/>`  groupBy(person.birthday)`<br/>`  person.nickName eq null`<br/>`}` | `GROUP BY gigaSpace read new SQLQuery(classOf[Person], `<br/>`  "nickName is null GROUP BY birthday", `<br/>`  QueryResultType.OBJECT`<br/>`)` |
