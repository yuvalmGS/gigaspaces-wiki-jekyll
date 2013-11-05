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

{% align center %}\|![wiki_icon_folder.gif](/attachment_files/xap97net/wiki_icon_folder.gif)\|Example Root\|`<GigaSpaces Root>\dotnet\examples\DotNetJava` \|
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
The `\[SpaceClass(AliasName="")\]` attribute is used to map the .NET names to the respective Java names.

- The .NET class **GigaSpaces.Examples.DotnetJava.Person** is mapped to the Java class **com.gigaspaces.examples.dotnetjava.Person**.

- The .NET fields/properties **SomeByte, SomeString** are mapped to the Java properties **someByte, someString**.

{: .table .table-bordered}
| C# | Java |
|:---|:-----|
|`Using GigaSpaces.Core.Metadata;`<br/><br/>`namespace GigaSpaces.Examples.DotnetJava`<br/>`{`<br/>`    [SpaceClass(AliasName = "com.gigaspaces.examples.dotnetjava.Person")]`<br/>`    public class Person`<br/>`    {`<br/>`    [SpaceProperty(AliasName="someByte")]`<br/>`    public Nullable<byte> SomeByte;`<br/>`    [SpaceProperty(AliasName = "someString")]`<br/>`    public string SomeString;`<br/>`...`<br/>`    }`<br/>`}`|`package com.gigaspaces.examples.dotnetjava;`<br/><br/>`public class Person`<br/>`{`<br/>`    private Byte _someByte;`<br/>`    public Byte getSomeByte()`<br/>`    { return _someByte; }`<br/>`    public void setSomeByte(Byte value)`<br/>`    { _someByte = value; }`<br/><br/>`    private String _someString;`<br/>`    public String getSomeString()`<br/>`    { return _someString; }`<br/>`    public void setSomeString(String value)`<br/>`    { _someString = value; }`<br/>`...`<br/>`}`|

For more details about .NET-Java Interoperability and designing the interoperable classes, refer to [.NET-Java Interoperability](http://www.gigaspaces.com/wiki/display/XAP66/.NET-Java+Interoperability)

# Building and Running the Example

1. Build the .NET application, using compileC#.bat (You can also build the DotNetJavaDemo.sln from Visual Studio).
2. Build the Java application, using compileJava.bat.
3. Start a remote space, using startAll.bat. The .NET and Java applications use this space to communicate.
4. Start the .NET listener, using startDOTNETClient_Notify.bat.
5. Start the Java listener, using startJavaClient_Write.bat.
6. Start the .NET writer, using startDOTNETClient_Write.bat. Both the .NET and Java listener consoles now show the written .NET object.
7. Start the Java writer, using startJavaClient_Write.bat. Both the .NET and Java listener consoles now show the written Java object.
