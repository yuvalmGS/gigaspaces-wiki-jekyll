---
layout: xap97net
title:  Your First Data Grid Application
categories: XAP97NET
---

{% summary %}Writing your first XAP.NET application {% endsummary %}

# Overview

This page explains how to create a simple Hello World application using XAP.NET API. The application is very simple: connect to a space, store an entry and retrieve it. The application shown here is also available in the examples distributed with the product (from the Windows Start menu, select **Programs > GigaSpaces XAP.NET > Examples** and review the **HelloWorld** example).

{% infosign %} All the instructions and code shown in this page are for C# developers. Naturally all other .NET languages (VB.NET, C++/CLI, J#, etc.) are supported as well.

# Prerequisites

If you haven't done so yet, please [download](http://www.gigaspaces.com/LatestProductVersion) and [install](./installing-xap.net.html) GigaSpaces XAP.NET.

# Setting Up the Project

This section shows how to create a C# Console Application named **HelloWorld** with a reference to the **GigaSpaces.Core** assembly.

## Create a Console Application Project

1. Open Microsoft Visual Studio. From the **File** menu select **New > Project**. The **New Project** dialog appears.
2. In the **Project types** tree, select **Visual C#**, then select **Console Application** in the **Templates** list.
3. In the **Name** test box, type **HelloWorld**. If you wish, change the default location to a path you prefer.
4. Select **OK** to continue. Visual Studio creates the project and opens the automatically generated `program.cs` file.

## Add a Reference to the GigaSpaces Core Assembly

1. From the **Project** menu, select **Add Reference**. The **Add Reference** dialog appears.
2. Select the **Browse** tab, navigate to the XAP.NET installation folder (e.g. **C:\GigaSpaces\XAP.NET 8.0.0 x86\NET v4.0.30319**). Go into the **Bin** folder, select **GigaSpaces.Core.dll**, and click **OK**.
    1. Since running .NET 4.0 side-by-side with .NET 2.0 [has limitations](http://msdn.microsoft.com/en-us/magazine/ee819091.aspx), GigaSpaces XAP.NET comes with a separate set of assemblies for .NET 2.0 and .NET 4.0. Make sure you use the one relevant for you.

3. In the **Solution Explorer**, make sure you see **GigaSpaces.Core** in the project references. There's no need to reference any other assembly.

# Writing the Code

This section shows how to write a simple program that connects to the space, stores a `Message` object with some text, and retrieves it.

## Creating the Message Class

We want to demonstrate storing some object to the space. To do this, let's create a simple `Message` class with a `Text` property of type `String`.

1. In **Solution Explorer**, right-click the **HelloWorld** project and select **Add > Class**. The **Add New Item** dialog appears.
2. In the **Templates** list, make sure **Class** is selected. Type **Message** in the class name text box, and click **Add**. The class is added to the project and the editor displays its content.
3. Add the following code to the `Message` class:

{% highlight java %}
public class Message
{
    private String _text;

    public Message()
    {
    }
    public Message(String text)
    {
        this._text = text;
    }

    public String Text
    {
        get { return this._text; }
        set { this._text = value; }
    }
}
{% endhighlight %}

## Getting Started

The XAP.NET API used in this example is located in the `GigaSpaces.Core` namespace.
Switch to the **Program.cs** editor, and add a `using` statement to include `GigaSpaces.Core`:

{% highlight java %}
using GigaSpaces.Core;
{% endhighlight %}

## Connecting to the Space

We need to establish a connection to a space which stores the object. To do this, we use the `FindSpace` method from a factory class called `GigaSpacesFactory`. This takes a URL of the requested space, and returns a space proxy of type `ISpaceProxy`. Since we don't have any spaces running yet, we use a special URL prefix to indicate that we want the space lookup to occur in-process, and that the searched space should be created in-process if it doesn't exist yet. The space name is **myEmbeddedSpace** (when the space and the proxy reside in the same process, the space is called an **embedded space**).

Edit the `Main` method and add the following code:

{% highlight java %}
String spaceUrl = "/./myEmbeddedSpace";

// Connect to space:
Console.WriteLine("*** Connecting to space using \"" + spaceUrl + "\"...");
ISpaceProxy proxy = GigaSpacesFactory.FindSpace(spaceUrl);
Console.WriteLine("*** Connected to space.");
{% endhighlight %}

## Storing a Message Object

The next step is to create a `Message` object, and store it in the space. To do this, we use the `Write` method in the `ISpaceProxy` we've just created, and simply pass the object we want to store as an argument:

Add the following code to the `Main` method, after the previous code:

{% highlight java %}
// Write a message to the space:
Message outgoingMessage = new Message("Hello World");
Console.WriteLine("Writing Message [" + outgoingMessage.Text + "]");
proxy.Write(outgoingMessage);
{% endhighlight %}

## Retrieving the Stored Message

Finally, we want to retrieve the object from the space. To do this, we use the `Take` method in `ISpaceProxy`, which takes a template argument and searches for a matching entry in the space. If a match is found, it is removed from the space, and returned to the caller, otherwise null is returned.

A template is an object of the type we wish to query, where the null properties are ignored and the non-null properties are matched. For example, creating a `Message`, and setting the `Text` to "Goodbye" returns null, because the space does not contain such an object. We use a new `Message`, without setting the `Text` property, which matches all possible entries of type `Message` (of course, we know there's currently only one in the space).

Add the following code to the `Main` method, after the previous code:

{% highlight java %}
// Take a message from the space:
Message incomingMessage = proxy.Take(new Message());
Console.WriteLine("Took Message [" + incomingMessage.Text + "]");

Console.WriteLine("Press ENTER to exit.");
Console.ReadLine();
{% endhighlight %}

# Running the Program

To run the program, from the **Debug** menu, select **Start Debugging**.

The following shows the complete program code, with some minor modifications:

{% highlight java %}
using System;
using System.Collections.Generic;
using System.Text;

using GigaSpaces.Core;

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Welcome to GigaSpaces.NET Hello World Example!" + Environment.NewLine);

            try
            {
                // Get space URL from command argument, (use default if none):
                string spaceUrl = (args.Length > 0 ? args[0] : "/./myEmbeddedSpace");

                // Connect to space:
                Console.WriteLine("*** Connecting to space using \"" + spaceUrl + "\"...");
                ISpaceProxy proxy = GigaSpacesFactory.FindSpace(spaceUrl);
                Console.WriteLine("*** Connected to space.");
                Console.WriteLine();

                // Write a message to the space:
                Random random = new Random();
                Message outgoingMessage = new Message("Hello World " + random.Next(1, 1001));
                Console.WriteLine("Writing Message [" + outgoingMessage.Text + "]");
                proxy.Write(outgoingMessage);

                // Take a message from the space:
                Message incomingMessage = proxy.Take(new Message());
                Console.WriteLine("Took Message [" + incomingMessage.Text + "]");

                proxy.Dispose();

                Console.WriteLine(Environment.NewLine + "Hello World Example finished successfully!" + Environment.NewLine);
            }
            catch (Exception ex)
            {
                Console.WriteLine(Environment.NewLine + "Hello World Example failed: " + ex.ToString());
            }

            Console.WriteLine("Press ENTER to exit.");
            Console.ReadLine();
        }
    }
}
{% endhighlight %}

