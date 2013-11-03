---
layout: xap97net
title:  .NET-Java Interoperability
categories: XAP97NET
page_id: 63799325
---


{% summary %}This page is focused on designing interoperable classes manually, and some related advanced features.{% endsummary %}


{% refer %}The depanlink.Net-Java Exampletengahlink./dotnet-java-example.htmlbelakanglink demonstrates many .NET-Java interoperability features.{% endrefer %}

# Designing Interoperable Classes

|| C# || Java ||
|
{% highlight java %}
using GigaSpaces.Core.Metadata;

namespace MyCompany.MyProject.Entities
{
    [SpaceClass(AliasName="com.mycompany.myproject.entities.Person")]
    public class Person
    {
        private string _name;
        [SpaceProperty(AliasName="name")]
        public string Name
        {
            get { return this._name; }
            set { this._name = value; }
        }
    }
}
{% endhighlight %}
|
{% highlight java %}
package com.mycompany.myproject.entities;

public class Person
{
    private String name;
    public String getName()
    {
        return this.name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
}
{% endhighlight %}
|

### Guidelines and Restrictions

The following guidelines and restrictions should be followed in order to enable platform interoperability:
- The full class name (including package\namespace) in all platforms should be identical.
 {% lampon %} Since java packages use a different naming convention than .Net namespaces, it is recommended to use the `SpaceClass(AliasName="")` feature to map a .Net class to the respective java class.


- The properties/fields stored in the space in all platforms should be identical.
 {% infosign %} In Java, only properties are serialized into the space. In .NET, both fields and properties are serialized, so you can mix and match them.
 {% lampon %} Since java properties start with a lowercase letter, whereas .Net properties usually start with an uppercase letter, it is recommended to use the `SpaceProperty(AliasName="")` feature to map a property/field name from .Net to java.


- Only the types listed in the table below are supported. If one of your fields uses a different type, you can use the class only in a homogeneous environment.
 {% infosign %} Arrays of these types are supported as well.
 {% infosign %} You can also use .NET enumerations, which are treated as their underlying .NET type. Java enums are not supported.
 {% lampon %} If your class contains a field whose type is not in the table, you can use `SpaceExclude` to exclude it from the space.
 {% infosign %} Some of the types have different charactaristics in .NET and Java (signed\unsigned, nullable\not nullable, precision, etc.) This can lead to runtime exceptions (e.g. trying to store `null` in a .NET structure) or unexpected results (e.g. copying values between signed and unsigned fields).

# Supported Types for Matching and Interoperability

The following types are supported by the space for matching and interoperability:
|| CLS || C# || VB.Net || Java || Description ||
| depanlinkSystem.Bytetengahlinkhttp://msdn2.microsoft.com/en-us/library/system.byte.aspxbelakanglink | `byte` | `Byte` | depanlinkbytetengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink | 8-bit integer.**<sup>1</sup>** |
| depanlinkNullable<Byte>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `byte?`| `Nullable(Of Byte)` | {sunjavadoc:java/lang/Byte|java.lang.Byte} | Nullable wrapper for byte.**<sup>1</sup>** |
| depanlinkSystem.Int16tengahlinkhttp://msdn2.microsoft.com/en-us/library/system.int16.aspxbelakanglink | `short` | `Short` | depanlinkshorttengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink | 16-bit integer. |
| depanlinkNullable<Int16>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `short?` | `Nullable(Of Short)` | {sunjavadoc:java/lang/Short|java.lang.Short} | Nullable wrapper for short. |
| depanlinkSystem.Int32tengahlinkhttp://msdn2.microsoft.com/en-us/library/system.int32.aspxbelakanglink | `int` | `Integer` | depanlinkinttengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink | 32-bit integer. |
| depanlinkNullable<Int32>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `int?` | `Nullable(Of Integer)` | {sunjavadoc:java/lang/Integer|java.lang.Integer} | Nullable wrapper for int. |
| depanlinkSystem.Int64tengahlinkhttp://msdn2.microsoft.com/en-us/library/system.int64.aspxbelakanglink | `long` | `Long` | depanlinklongtengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink | 64-bit integer. |
| depanlinkNullable<Int64>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `long?` | `Nullable(Of Long)` | {sunjavadoc:java/lang/Long|java.lang.Long} | Nullable wrapper for long. |
| depanlinkSystem.Singletengahlinkhttp://msdn2.microsoft.com/en-us/library/system.single.aspxbelakanglink | `float` | `Single` | depanlinkfloattengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink |  Single-precision floating-point number (32 bits). |
| depanlinkNullable<Single>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `float?` | `Nullable(Of Single)` | {sunjavadoc:java/lang/Float|java.lang.Float} | Nullable wrapper for float. |
| depanlinkSystem.Doubletengahlinkhttp://msdn2.microsoft.com/en-us/library/system.double.aspxbelakanglink | `double` | `Double` | depanlinkdoubletengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink |  Double-precision floating-point number (64 bits). |
| depanlinkNullable<Double>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `double?` | `Nullable(Of Double)` | {sunjavadoc:java/lang/Double|java.lang.Double} | Nullable wrapper for double. |
| depanlinkSystem.Booleantengahlinkhttp://msdn2.microsoft.com/en-us/library/system.boolean.aspxbelakanglink | `bool` | `Boolean` | depanlinkbooleantengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink   | Boolean value (true/false). |
| depanlinkNullable<Boolean>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `bool?` | `Nullable(Of Boolean)` | {sunjavadoc:java/lang/Boolean|java.lang.Boolean} | Nullable wrapper for boolean. |
| depanlinkSystem.Chartengahlinkhttp://msdn2.microsoft.com/en-us/library/system.char.aspxbelakanglink | `char` | `Char` | depanlinkchartengahlinkhttp://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.htmlbelakanglink   | A Unicode  character (16 bits). |
| depanlinkNullable<Char>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `char?` | `Nullable(Of Char)` | {sunjavadoc:java/lang/Character|java.lang.Character} | Nullable wrapper for char. |
| depanlinkSystem.Stringtengahlinkhttp://msdn2.microsoft.com/en-us/library/system.string.aspxbelakanglink | `string` | `String` | {sunjavadoc:java/lang/String|java.lang.String} | An immutable, fixed-length string of Unicode characters. |

| depanlinkSystem.DateTimetengahlinkhttp://msdn2.microsoft.com/en-us/library/system.datetime.aspxbelakanglink depanlinkNullable<DateTime>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `DateTime` `DateTime?` | `DateTime` `Nullable(Of DateTime)`| {sunjavadoc:java/util/Date|java.util.Date} | An instant in time, typically expressed as a date and time of day.**<sup>2,3</sup>** |
| depanlinkSystem.Decimaltengahlinkhttp://msdn2.microsoft.com/en-us/library/system.decimal.aspxbelakanglink depanlinkNullable<Decimal>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `decimal` `decimal?` | `Decimal` `Nullable(Of Decimal)` | {sunjavadoc:java/math/BigDecimal|java.math.BigDecimal} | A decimal number, used for high-precision calculations.**<sup>2,4</sup>** |
| depanlinkSystem.Guidtengahlinkhttp://msdn2.microsoft.com/en-us/library/system.guid.aspxbelakanglink depanlinkNullable<Guid>tengahlinkhttp://msdn.microsoft.com/en-us/library/b3h38hb0.aspxbelakanglink | `Guid` `Guid?` | `Guid` `Nullable(Of Guid)` | {sunjavadoc:java/util/UUID|java.util.UUID} | A 128-bit integer representing a unique identifier.**<sup>2</sup>** |
| depanlinkSystem.Objecttengahlinkhttp://msdn2.microsoft.com/en-us/library/system.object.aspxbelakanglink | `object` | `Object` | {sunjavadoc:java/lang/Object|java.lang.Object} | Any object |
1. In .Net a `byte` is unsigned, whereas in java a `byte` is signed.
2. These types can be either nullable or not nullable in .Net, whereas in java they are always nullable.
3. In .Net a `DateTime` is measured in ticks (=100 nanoseconds) since 1/1/0001, whereas in java a `Date` is a measured in milliseconds since 1/1/1970.
4. The types `Decimal` (.Net) and `BigDecimal` (java) have different precision and range (see .Net and java documentation for more details). In addition, be aware that serialization/deserialization of these types is relatively slow, compared to other numeric types. As a rule of thumb these types should not be used, unless the other numeric types presicion/range is not satisfactory.

# Arrays and Collections support

The following collections are mapped for interoperability:
|| .Net || Java || Description ||
| `T\ajepaaa\ajepbbb` | `E\ajepaaa\ajepbbb` | Fixed-size arrays of elements. |
| depanlinkSystem.Collections.Generic.List<T>tengahlinkhttp://msdn.microsoft.com/en-us/library/6sh2ey19.aspxbelakanglink  depanlinkSystem.Collections.ArrayListtengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.arraylist.aspxbelakanglink  depanlinkSystem.Collections.Specialized.StringCollectiontengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.specialized.stringcollection.aspxbelakanglink | {sunjavadoc:java/util/ArrayList|java.util.ArrayList } | Ordered list of elements. |
| depanlinkSystem.Collections.Generic.Dictionary<K,V>tengahlinkhttp://msdn.microsoft.com/en-us/library/xfhwa508.aspxbelakanglink  depanlinkSystem.Collections.HashTabletengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.hashtable.aspxbelakanglink  depanlinkSystem.Collections.Specialized.HybridDictionarytengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.specialized.hybriddictionary.aspxbelakanglink  depanlinkSystem.Collections.Specialized.ListDictionarytengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.specialized.listdictionary.aspxbelakanglink | {sunjavadoc:java/util/HashMap|java.util.HashMap} | Collection of key-value pairs. |
| depanlinkSystem.Collections.Specialized.OrderedDictionarytengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.specialized.ordereddictionary.aspxbelakanglink | {sunjavadoc:java/util/LinkedHashMap|java.util.LinkedHashMap} | Ordered collection of key-value pairs. |
| depanlinkSystem.Collections.Generic.SortedDictionary<K,V>tengahlinkhttp://msdn.microsoft.com/en-us/library/f7fta44c.aspxbelakanglink | {sunjavadoc:java/util/TreeMap|java.util.TreeMap} | Sorted collection of key-value pairs. |
| depanlinkSystem.Collections.Specialized.NameValueCollectiontengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.specialized.namevaluecollection.aspxbelakanglink depanlinkSystem.Collections.Specialized.StringDictionarytengahlinkhttp://msdn2.microsoft.com/en-us/library/system.collections.specialized.stringdictionary.aspxbelakanglink | {sunjavadoc:java/util/Properties|java.util.Properties} | Collection of key-value string pairs.**<sup>1</sup>** |
1. In java, the `Properties` type allows the user to store keys and values which are not strings.

