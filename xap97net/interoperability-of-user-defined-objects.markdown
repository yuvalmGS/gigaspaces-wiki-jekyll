---
layout: xap97net
title:  Interoperability of User-Defined Objects
categories: XAP97NET
page_id: 63799393
---

{summary}How to implement deep (complex) interoperable classes.{summary}

# Overview

A deep class is defined as a class in which, at least one of its fields is a user defined class.

{% info %} Creating a deep class to be interoperability ready, requires defining all its deep fields as fields that will be stored to the space, using its matching Java objects types. Use the property, `StorageType = StorageType.Object` on the `SpaceProperty()` attribute, defined to all the fields that are user defined objects.

{% info %} Class name mapping: when defining interoperability ready classes, class names of the corresponding .NET and Java classes have to match exactly. In order to keep the .NET and Java namespace style conventions, and still create matching classes, we use the `AliasName` property of the `SpaceClass()` attribute to map the .NET class name and namespace to the matching Java class name and namespace.

{% info %} Properties mapping: when defining interoperability of properties the names of the properties of the Java and .NET classes have to match exactly. In order to keep .NET and Java coding conventions and still create matching classes we use `AliasName` property of the `SpaceProperty()` attribute to map properties between .NET and Java.

# Designing Interoperable Classes

For the purpose of explaining the subject we'll look at a Person class (a deep class)

|| C# || Java ||
|
{% highlight java %}
using GigaSpaces.Core.Metadata;

namespace MyCompany.MyProject.Entities
{
    [SpaceClass(AliasName = "com.mycompany.myproject.entities.Person")]
    public class Person
    {
        private string _name;
        private Address _address;

        [SpaceProperty(AliasName = "name")]
        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        [SpaceProperty(AliasName = "address", StorageType = StorageType.Object)]
        public Address Address
        {
            get { return _address; }
            set { _address = value; }
        }
    }

    [SpaceClass(AliasName = "com.mycompany.myproject.entities.Address")]
    public class Address
    {
        [SpaceProperty(AliasName = "houseNumber")]
        public int HouseNumber;

        [SpaceProperty(AliasName = "street")]
        public string Street;

        [SpaceProperty(AliasName = "country")]
        public string Country;
    }
}
{% endhighlight %}
|
{% highlight java %}
package com.mycompany.myproject.entities;

public class Person
{
    private String _name;
    public String getName() { return _name; }
    public void setName(String value) { _name = value; }

    private Address _address;
    public Address getAddress() { return _address; }
    public void setAddress(Address value) { _address = value; }
}

package com.mycompany.myproject.entities;

public class Address
{
    public String HouseNumber;
    public String Street;
    public String Country;
}

{% endhighlight %}
|

