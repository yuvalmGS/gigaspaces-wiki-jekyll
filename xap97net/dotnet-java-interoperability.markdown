---
layout: xap97net
title:  .NET-Java Interoperability
categories: XAP97NET
page_id: 63799325
---

{summary}This page is focused on designing interoperable classes manually, and some related advanced features.{summary}

{refer}The [.Net-Java Example] demonstrates many .NET-Java interoperability features.{refer}

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
 (on) Since java packages use a different naming convention than .Net namespaces, it is recommended to use the `SpaceClass(AliasName="")` feature to map a .Net class to the respective java class.


- The properties/fields stored in the space in all platforms should be identical.
 {% info %} In Java, only properties are serialized into the space. In .NET, both fields and properties are serialized, so you can mix and match them.
 (on) Since java properties start with a lowercase letter, whereas .Net properties usually start with an uppercase letter, it is recommended to use the `SpaceProperty(AliasName="")` feature to map a property/field name from .Net to java.


- Only the types listed in the table below are supported. If one of your fields uses a different type, you can use the class only in a homogeneous environment.
 {% info %} Arrays of these types are supported as well.
 {% info %} You can also use .NET enumerations, which are treated as their underlying .NET type. Java enums are not supported.
 (on) If your class contains a field whose type is not in the table, you can use `SpaceExclude` to exclude it from the space.
 {% info %} Some of the types have different charactaristics in .NET and Java (signed\unsigned, nullable\not nullable, precision, etc.) This can lead to runtime exceptions (e.g. trying to store `null` in a .NET structure) or unexpected results (e.g. copying values between signed and unsigned fields).

# Supported Types for Matching and Interoperability

The following types are supported by the space for matching and interoperability:
|| CLS || C# || VB.Net || Java || Description ||
| [System.Byte|http://msdn2.microsoft.com/en-us/library/system.byte.aspx] | `byte` | `Byte` | [byte|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html] | 8-bit integer.**<sup>1</sup>** |
| [Nullable<Byte>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `byte?`| `Nullable(Of Byte)` | {sunjavadoc:java/lang/Byte|java.lang.Byte} | Nullable wrapper for byte.^**1**^ |
| [System.Int16|http://msdn2.microsoft.com/en-us/library/system.int16.aspx] | `short` | `Short` | [short|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html] | 16-bit integer. |
| [Nullable<Int16>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `short?` | `Nullable(Of Short)` | {sunjavadoc:java/lang/Short|java.lang.Short} | Nullable wrapper for short. |
| [System.Int32|http://msdn2.microsoft.com/en-us/library/system.int32.aspx] | `int` | `Integer` | [int|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html] | 32-bit integer. |
| [Nullable<Int32>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `int?` | `Nullable(Of Integer)` | {sunjavadoc:java/lang/Integer|java.lang.Integer} | Nullable wrapper for int. |
| [System.Int64|http://msdn2.microsoft.com/en-us/library/system.int64.aspx] | `long` | `Long` | [long|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html] | 64-bit integer. |
| [Nullable<Int64>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `long?` | `Nullable(Of Long)` | {sunjavadoc:java/lang/Long|java.lang.Long} | Nullable wrapper for long. |
| [System.Single|http://msdn2.microsoft.com/en-us/library/system.single.aspx] | `float` | `Single` | [float|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html] |  Single-precision floating-point number (32 bits). |
| [Nullable<Single>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `float?` | `Nullable(Of Single)` | {sunjavadoc:java/lang/Float|java.lang.Float} | Nullable wrapper for float. |
| [System.Double|http://msdn2.microsoft.com/en-us/library/system.double.aspx] | `double` | `Double` | [double|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html] |  Double-precision floating-point number (64 bits). |
| [Nullable<Double>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `double?` | `Nullable(Of Double)` | {sunjavadoc:java/lang/Double|java.lang.Double} | Nullable wrapper for double. |
| [System.Boolean|http://msdn2.microsoft.com/en-us/library/system.boolean.aspx] | `bool` | `Boolean` | [boolean|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html]   | Boolean value (true/false). |
| [Nullable<Boolean>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `bool?` | `Nullable(Of Boolean)` | {sunjavadoc:java/lang/Boolean|java.lang.Boolean} | Nullable wrapper for boolean. |
| [System.Char|http://msdn2.microsoft.com/en-us/library/system.char.aspx] | `char` | `Char` | [char|http://java.sun.com/docs/books/tutorial/java/nutsandbolts/datatypes.html]   | A Unicode  character (16 bits). |
| [Nullable<Char>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `char?` | `Nullable(Of Char)` | {sunjavadoc:java/lang/Character|java.lang.Character} | Nullable wrapper for char. |
| [System.String|http://msdn2.microsoft.com/en-us/library/system.string.aspx] | `string` | `String` | {sunjavadoc:java/lang/String|java.lang.String} | An immutable, fixed-length string of Unicode characters. |

| [System.DateTime|http://msdn2.microsoft.com/en-us/library/system.datetime.aspx] [Nullable<DateTime>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `DateTime` `DateTime?` | `DateTime` `Nullable(Of DateTime)`| {sunjavadoc:java/util/Date|java.util.Date} | An instant in time, typically expressed as a date and time of day.^**2,3**^ |
| [System.Decimal|http://msdn2.microsoft.com/en-us/library/system.decimal.aspx] [Nullable<Decimal>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `decimal` `decimal?` | `Decimal` `Nullable(Of Decimal)` | {sunjavadoc:java/math/BigDecimal|java.math.BigDecimal} | A decimal number, used for high-precision calculations.^**2,4**^ |
| [System.Guid|http://msdn2.microsoft.com/en-us/library/system.guid.aspx] [Nullable<Guid>|http://msdn.microsoft.com/en-us/library/b3h38hb0.aspx] | `Guid` `Guid?` | `Guid` `Nullable(Of Guid)` | {sunjavadoc:java/util/UUID|java.util.UUID} | A 128-bit integer representing a unique identifier.^**2**^ |
| [System.Object|http://msdn2.microsoft.com/en-us/library/system.object.aspx] | `object` | `Object` | {sunjavadoc:java/lang/Object|java.lang.Object} | Any object |
1. In .Net a `byte` is unsigned, whereas in java a `byte` is signed.
2. These types can be either nullable or not nullable in .Net, whereas in java they are always nullable.
3. In .Net a `DateTime` is measured in ticks (=100 nanoseconds) since 1/1/0001, whereas in java a `Date` is a measured in milliseconds since 1/1/1970.
4. The types `Decimal` (.Net) and `BigDecimal` (java) have different precision and range (see .Net and java documentation for more details). In addition, be aware that serialization/deserialization of these types is relatively slow, compared to other numeric types. As a rule of thumb these types should not be used, unless the other numeric types presicion/range is not satisfactory.

# Arrays and Collections support

The following collections are mapped for interoperability:
|| .Net || Java || Description ||
| `T\[\]` | `E\[\]` | Fixed-size arrays of elements. |
| [System.Collections.Generic.List<T>|http://msdn.microsoft.com/en-us/library/6sh2ey19.aspx]  [System.Collections.ArrayList|http://msdn2.microsoft.com/en-us/library/system.collections.arraylist.aspx]  [System.Collections.Specialized.StringCollection|http://msdn2.microsoft.com/en-us/library/system.collections.specialized.stringcollection.aspx] | {sunjavadoc:java/util/ArrayList|java.util.ArrayList } | Ordered list of elements. |
| [System.Collections.Generic.Dictionary<K,V>|http://msdn.microsoft.com/en-us/library/xfhwa508.aspx]  [System.Collections.HashTable|http://msdn2.microsoft.com/en-us/library/system.collections.hashtable.aspx]  [System.Collections.Specialized.HybridDictionary|http://msdn2.microsoft.com/en-us/library/system.collections.specialized.hybriddictionary.aspx]  [System.Collections.Specialized.ListDictionary|http://msdn2.microsoft.com/en-us/library/system.collections.specialized.listdictionary.aspx] | {sunjavadoc:java/util/HashMap|java.util.HashMap} | Collection of key-value pairs. |
| [System.Collections.Specialized.OrderedDictionary|http://msdn2.microsoft.com/en-us/library/system.collections.specialized.ordereddictionary.aspx] | {sunjavadoc:java/util/LinkedHashMap|java.util.LinkedHashMap} | Ordered collection of key-value pairs. |
| [System.Collections.Generic.SortedDictionary<K,V>|http://msdn.microsoft.com/en-us/library/f7fta44c.aspx] | {sunjavadoc:java/util/TreeMap|java.util.TreeMap} | Sorted collection of key-value pairs. |
| [System.Collections.Specialized.NameValueCollection|http://msdn2.microsoft.com/en-us/library/system.collections.specialized.namevaluecollection.aspx] [System.Collections.Specialized.StringDictionary|http://msdn2.microsoft.com/en-us/library/system.collections.specialized.stringdictionary.aspx] | {sunjavadoc:java/util/Properties|java.util.Properties} | Collection of key-value string pairs.**<sup>1</sup>** |
1. In java, the `Properties` type allows the user to store keys and values which are not strings.

