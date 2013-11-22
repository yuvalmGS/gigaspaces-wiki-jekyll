---
layout: post
title:  Space Filter Demo
categories: XAP97NET
parent: space-filters.html
weight: 200
---

# Overview

The Space Filter Demo demonstrates the different ways to [implement](./implementing-and-using-a-space-filter.html) a [space filter](./space-filters.html) and how to integrate it in a space.

The example can be found at `<GigaSpaces root>\Examples\SpaceFilter`

This demo shows three equivalent space filter implementations, and a console application that runs the same demo sequence three times, once per filter implementation:

- [MessageCensorshipAttributeFilter](#1).
- [MessageCensorshipMethodNamesFilter](#2).
- [MessageCensorshipSpaceFilter](#3).

# Censorship Filters

This demo data object is the `Message` class. This class contains one string property `Content` that holds the content of the message. The purpose of each filter, is to log certain `Message` related operations (Take, Write), and to censor messages that contain illegal words, before entering the space. All filters extend the `MessageCensorship` class, which implements the `CensorMessage` method that contains the censorship logic. The `MessageCensorship` receives an array of illegal words, and uses that to censor a message when `CensorMessage` is called.

# Demo Sequence

The demo sequence consists of: creating the relevant Space Filter, creating a [SpaceFilterConfig](./spacefilterconfig-class.html) to configure the filter, starting a space with the filter integrated in it, and executing a short sequence of writing and taking Message objects into and from the space.

{% highlight java %}
// Write a simple hello message to the space - the filter will log this message to the console.
space.Write(new Message("Hello"));

// Take and print the hello message from the space - the filter will log this operation to the console.
Console.WriteLine("Took message from space: " + space.Take(new Message()).Content);

// Write a message that contains an illegal word to the space - the filter will censor this message before it reaches the space, and log this to the console.
space.Write(new Message("Hello badword"));

// Take and print the censored message from the space - the filter will log this operation to the console.
Console.WriteLine("Took message from space: " + space.Take(new Message()).Content);

Console.WriteLine("Writing an object instance (Not Message), no monitor message should appear after this line");
// This object can not be assigned into Message - the filter will not operate on this object.
space.Write(new object());
{% endhighlight %}

{% anchor 1 %}

# Message Censorship Attribute Filter

This filter is implemented, using an attribute to mark the filter operation methods. This filter is based on the [Attribute-based SpaceFilterOperationDelegate](./spacefilteroperationdelegate.html#Attribute based implementation)

{% highlight java %}
public class MessageCensorshipAttributeFilter : MessageCensorship, IDisposable
{
  [...]

  [OnFilterInit]
  public void Initialize()
  {
    Reporter.Log("--------------------------------------------");
    Reporter.Log("MessageCensorshipAttributeFilter initialized.");
    Reporter.Log("--------------------------------------------");
  }

  public void Dispose()
  {
    //If implementing IDisposable, the Dispose method will be called when the space shuts down
    Reporter.Log("--------------------------------------------");
    Reporter.Log("MessageCensorshipAttributeFilter closed.");
    Reporter.Log("--------------------------------------------");
  }

  [BeforeTake]
  //Only filter objects that can be assigned to Message
  public void LogTake(Message message)
  {
    Reporter.Log("Taking message from space.");
  }

  [BeforeWrite]
  public void LogAndCensorizeWrite(ISpaceFilterEntry entry)
  {
    //Only operate if the filter entry type is Message, use ObjectType to filter the relevant object types for better performance.
	if (typeof(Message).IsAssignableFrom(entry.ObjectType))
    {
      //Gets the actual message inside the entry, when calling this method only then the object is actually being evaluated.
      Message message = (Message)entry.GetObject();
      if (CensorMessage(message))
      {
        //Updates the actual message inside the filter entry, this method must be used if the value needs
        //to be updated inside the filter entry, this is done in a lazy manner.
        //
        //When it is needed to update the entry value the paramter that should be used is ISpaceFilterEntry, otherwise the value
        //will only be updated locally.
        entry.UpdateObject(message);
        Reporter.Log("Message being written to space contains bad words.");
      }
      else
        Reporter.Log("Writing message to space: " + message.Content);
    }
  }
}
{% endhighlight %}

The different attributes are used to mark which method needs to be invoked, according to the different filter operations. The parameters that the method signature contains, must be of a specific [structure](./spacefilteroperationdelegate.html#How does it work).

Each space filter needs a [SpaceFilterConfig](./spacefilterconfig-class.html) that defines it in order to integrate in a space. The attribute-based filter uses the [AttributeSpaceFilterConfigFactory](./spacefilteroperationdelegate.html#Attribute based implementation).

{% highlight java %}
//Create an attribute based space filter delegate configurer
AttributeSpaceFilterConfigFactory attributeSpaceFilterConfigFactory = new AttributeSpaceFilterConfigFactory();
attributeSpaceFilterConfigFactory.Filter = new MessageCensorshipAttributeFilter(IllegalWords);

spaceConfig.SpaceFiltersConfig = new SpaceFilterConfig[]{attributeSpaceFilterConfigFactory.CreateSpaceFilterConfig()};

//Start a space with the configured filter
space = GigaSpacesFactory.FindSpace("/./spaceAttributeFilterDemo", spaceConfig);
{% endhighlight %}

In this example, we can see that the `LogAndCensorizeWrite` method receives an [ISpaceFilterEntry](./ispacefilterentry-interface.html) as its single parameter, and not the `Message` object like the `LogTake` method. That's because this method might need to update the value of the message when it needs to be censored. This can only be done using the `entry.UpdateObject` method.

Another important thing to notice is that the `LogAndCensorizeWrite` method first checks if the Message type  from the `entry.ObjectType`, can be assigned into Message, and only then gets the actual Message object. This is done to decrease the performance impact of the filter, because the evaluation of `GetObject` and `UpdateObject` is done in a lazy fashion.

This filter class implements `IDisposable`, to demonstrate that when a filter class implements the `IDisposable` interface, it is disposed of when the space shuts down.

{% anchor 2 %}

# Message Censorship Method Names Filter

This filter is implemented using method names to mark the filter operation methods. This filter is based on the [Method name-based SpaceFilterOperationDelegate](./spacefilteroperationdelegate.html#Method name based implementation).

{% highlight java %}
public class MessageCensorshipMethodNamesFilter : MessageCensorship, IDisposable
{
  [...]

  public void Initialize()
  {
    Reporter.Log("--------------------------------------------");
    Reporter.Log("MessageCensorshipAttributeFilter initialized.");
    Reporter.Log("--------------------------------------------");
  }

  public void Dispose()
  {
    //If implementing IDisposable, the Dispose method will be called when the space shutdown
    Reporter.Log("--------------------------------------------");
    Reporter.Log("MessageCensorshipAttributeFilter closed.");
    Reporter.Log("--------------------------------------------");
  }

  //Only filter objects that can be assigned to Message
  public void LogTake(Message message)
  {
    Reporter.Log("Taking message from space.");
  }

  public void LogAndCensorizeWrite(ISpaceFilterEntry entry)
  {
    //Only operate if the filter entry type is Message, use ObjectType to filter the relevant object types for better performance.
	if (typeof(Message).IsAssignableFrom(entry.ObjectType))
    {
      //Gets the actual message inside the entry, when calling this method only then the object is actually being evaluated.
      Message message = (Message)entry.GetObject();
      if (CensorMessage(message))
      {
        //Updates the actual message inside the filter entry, this method must be used if the value needs
        //to be updated inside the filter entry, this is done in a lazy manner.
        //
        //When it is needed to update the entry value the paramter that should be used is ISpaceFilterEntry, otherwise the value
        //will only be updated locally.
        entry.UpdateObject(message);
        Reporter.Log("Message being written to space contains bad words.");
      }
      else
        Reporter.Log("Writing message to space: " + message.Content);
    }
  }
}
{% endhighlight %}

This filter implementation is very similiar to the [attribute-based one](#Message Censorship Attribute Filter), except that there are no marker attributes. The method that needs to be invoked according to the filter operation, is specified by name when creating the [MethodNameSpaceFilterConfigFactory](./spacefilteroperationdelegate.html#Method name based implementation) that creates the [SpaceFilterConfig](./spacefilterconfig-class.html) for this filter.

{% highlight java %}
//Create a method based space filter delegate configurer
MethodNameSpaceFilterConfigFactory methodNameSpaceFilterConfigFactory = new MethodNameSpaceFilterConfigFactory();
methodNameSpaceFilterConfigFactory.Filter = new MessageCensorshipMethodNamesFilter(IllegalWords);
methodNameSpaceFilterConfigFactory.BeforeWrite = "LogAndCensorizeWrite";
methodNameSpaceFilterConfigFactory.BeforeTake = "LogTake";
methodNameSpaceFilterConfigFactory.OnFilterInit = "Initialize";

spaceConfig.SpaceFiltersConfig = new SpaceFilterConfig[] { methodNameSpaceFilterConfigFactory.CreateSpaceFilterConfig() };

//Start a space with the configured filter
space = GigaSpacesFactory.FindSpace("/./spaceMethodFilterDemo", spaceConfig);
{% endhighlight %}

The same structure for the filter operation method applies here as well.

{% anchor 3 %}

# Message Censorship Space Filter

This filter implements the [`ISpaceFilter`](./ispacefilter-interface.html) interface directly.

{% highlight java %}
public class MessageCensorshipSpaceFilter : MessageCensorship, ISpaceFilter
{
  [..]
  public void Dispose()
  {
    Reporter.Log("--------------------------------------------");
    Reporter.Log("MessageCensorshipSpaceFilter closed.");
    Reporter.Log("--------------------------------------------");
  }

  public void Init(ISpaceProxy proxy, string filterId, IDictionary<string, string> customProperties, FilterPriority priority)
  {
    Reporter.Log("--------------------------------------------");
    Reporter.Log("MessageCensorshipSpaceFilter initialized.");
    Reporter.Log("--------------------------------------------");
  }

  public void Process(SecurityContext securityContext, ISpaceFilterEntry entry, FilterOperation operation)
  {
    //Only operate if the filter entry type is Message, use ObjectType to filter the relevant object types for better performance.
    if (typeof(Message).IsAssignableFrom(entry.ObjectType))
    {
      switch (operation)
      {
        case FilterOperation.BeforeTake:
          Reporter.Log("Taking message from space.");
          break;
        case FilterOperation.BeforeWrite:
          //Gets the actual message inside the entry, when calling this method only then the object is actually being evaluated.
          Message message = (Message) entry.GetObject();
          if (CensorMessage(message))
          {
            //Updates the actual message inside the filter entry, this method must be used if the value needs
            //to be updated inside the filter entry, this is done in a lazy manner.
            entry.UpdateObject(message);
            Reporter.Log("Message being written to space contains bad words.");
          }
          else
            Reporter.Log("Writing message to space: " + message.Content);
          break;
      }
    }
  }

  public void Process(SecurityContext securityContext, ISpaceFilterEntry firstEntry, ISpaceFilterEntry secondEntry, FilterOperation operation)
  {
  }
}
{% endhighlight %}

All the filter operations are represented by the operation parameter in the Process method. A switch on the operation, delegates the operation to the corresponding filtering action.

When implementing [ISpaceFilter](./ispacefilter-interface.html), a [SpaceFilterConfig](./spacefilterconfig-class.html) needs to be created, and each filter operation that should be filtered, needs to be specified in it.

{% highlight java %}
//Create configuration for space filter
SpaceFilterConfig spaceFilterConfig = new SpaceFilterConfig();

spaceFilterConfig.Filter = new MessageCensorshipSpaceFilter(IllegalWords);
spaceFilterConfig.FilterOperations = new FilterOperation[]{FilterOperation.BeforeWrite, FilterOperation.BeforeTake};

SpaceConfig spaceConfig = new SpaceConfig();
spaceConfig.SpaceFiltersConfig = new SpaceFilterConfig[]{spaceFilterConfig};

//Start a space with the configured filter
ISpaceProxy space = GigaSpacesFactory.FindSpace("/./spaceFilterDemo", spaceConfig);
{% endhighlight %}
