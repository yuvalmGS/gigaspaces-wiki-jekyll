---
layout: xap97net
title:  Space Events
categories: XAP97NET
page_id: 63799367
---

{summary}Registering to Space events{summary}

# Overview

It is possible to subscribe to different space events and be notified of changes inside the space that match the event subscription. These notifications are pushed from the space to the proxy, unlike the opposite way, where the proxy executes queries on the space.

This page demonstrates a basic event usage scenario.

# Event Registration

Subscribing to an event is done using an {{IDataEventSession}} with a [template|Query Template Types], an event type and a callback method. {{ISpaceProxy}} has a default data event session that can be used for subscription.

The following example demonstrates simple events usage:
{code:java}
public class Person
{
  private String _userId;

  public String UserId
  {
    get { return _userId; }
    set { _userId = value; }
  }

  ...

  public Person()
  {
  }
}

...

//Callback method that is triggered when the event fires
void Space_PersonChanged(object sender, SpaceDataEventArgs<Person> e)
{
  Console.WriteLine("Person with UserId: " + e.Object.UserId + " was written to the space);
}

//Event subscription
IEventRegistration registration = proxy.DefaultDataEventSession.AddListener(new Person(),
                                                                            Space_PersonChanged,
                                                                            DataEventType.Write);
{code}

Any new person entries that are written to the space, trigger the event and execute the {{Space_PersonChanged}} callback method at the client side.
The DataEventType dictates which type of events to listen for. It's a flag enum that can have more than one value -- for example, listening to {{Write}} and {{Update}} events looks like this:
{code:java}
IEventRegistration registration = proxy.DefaultDataEventSession.AddListener(new Person(),
                                                                            Space_PersonChanged,
                                                                            DataEventType.Write | DataEventType.Update);
{code}

When the events are no longer relevant, the registration for the events should be removed, to reduce the load on the space.
{code:java}
proxy.DefaultDataEventSession.RemoveListener(registration);
{code}

{refer}In most cases, using the {{DefaultDataEventSession}} is enough, however, in some scenarios the {{DataEventSession}} needs to be customized. This topic is covered in [Advance Events Scenarios|Advance Events Scenarios]{refer}