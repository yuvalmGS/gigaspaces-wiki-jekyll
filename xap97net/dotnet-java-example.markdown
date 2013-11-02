---
layout: xap97net
title:  .Net-Java Example
categories: XAP97NET
page_id: 63799316
---

{% compositionsetup %}

{% summary %}The .NET-Java  Example illustrates basic interoperability operations between Java and .NET space proxies.{% endsummary %}


{% section %}

{% column width=7% %}

{% endcolumn %}

{% column width=86% %}

{% align center %}||depanimagewiki_icon_folder.giftengahimage/attachment_files/xap97net/wiki_icon_folder.gifbelakangimage||Example Root|`<GigaSpaces Root>\dotnet\examples\DotNetJava` |
{% endalign %}

{% endcolumn %}

{% column width=7% %}

{% endcolumn %}

{% endsection %}

# Overview

The .NET-Java  Example illustrates basic interoperability operations between Java and .NET space proxies.

There are two applications in the example: a .NET application and a Java application.

Both applications:
- Connect to an existing remote space
- Define a Person class (**Person.cs** in .NET, **src\Person.java** in Java)
- Have two modes:
    - Write mode. The application connects to a remote space, writes one Person instance to the space, and exits
    - Listener mode. The application:
        - Connects to a remote space
        - Subscribes for notifications about all changes in Person objects (a new Person will also trigger a notification)
        - Writes the data of the Person objects whenever they arrive

## The Person Interoperable Class

- The .NET naming convention is different than the Java naming convention.
The `\[XAP66:SpaceClass(AliasName="")\]` attribute is used to map the .NET names to the respective Java names.

- The .NET class **GigaSpaces.Examples.DotnetJava.Person** is mapped to the Java class **com.gigaspaces.examples.dotnetjava.Person**.

- The .NET fields/properties **SomeByte, SomeString** are mapped to the Java properties **someByte, someString**.

|| C# || Java ||
|
{% highlight java %}
Using GigaSpaces.Core.Metadata;

namespace GigaSpaces.Examples.DotnetJava
{
    [SpaceClass(AliasName = "com.gigaspaces.examples.dotnetjava.Person")]
    public class Person
    {
    [SpaceProperty(AliasName="someByte")]
    public Nullable<byte> SomeByte;
    [SpaceProperty(AliasName = "someString")]
    public string SomeString;
...
    }
}
{% endhighlight %}
|
{% highlight java %}
package com.gigaspaces.examples.dotnetjava;

public class Person
{
    private Byte _someByte;
    public Byte getSomeByte()
    { return _someByte; }
    public void setSomeByte(Byte value)
    { _someByte = value; }

    private String _someString;
    public String getSomeString()
    { return _someString; }
    public void setSomeString(String value)
    { _someString = value; }
...
}
{% endhighlight %}
|
For more details about .NET-Java Interoperability and designing the interoperable classes, refer to depanlink.NET-Java Interoperabilitytengahlinkhttp://www.gigaspaces.com/wiki/display/XAP66/.NET-Java+Interoperabilitybelakanglink

# Building and Running the Example

1. Build the .NET application, using compileC#.bat (You can also build the DotNetJavaDemo.sln from Visual Studio).
2. Build the Java application, using compileJava.bat.
3. Start a remote space, using startAll.bat. The .NET and Java applications use this space to communicate.
4. Start the .NET listener, using startDOTNETClient_Notify.bat.
5. Start the Java listener, using startJavaClient_Write.bat.
6. Start the .NET writer, using startDOTNETClient_Write.bat. Both the .NET and Java listener consoles now show the written .NET object.
7. Start the Java writer, using startJavaClient_Write.bat. Both the .NET and Java listener consoles now show the written Java object.