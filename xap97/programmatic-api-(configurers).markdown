---
layout: post
title:  Programmatic API (Configurers)
categories: XAP97
parent: deploying-and-interacting-with-the-space.html
weight: 300
---

{% summary %}This section describes how you can use OpenSpaces components in a non-Spring environment. The constructs which are used to create and configure GigaSpaces components are called **Configurers** .{% endsummary %}

# Overview

{% infosign %} In many cases, you don't want to use Spring only to interact with GigaSpaces components, or even do not use Spring at all in your organization.

You can always "imitate" Spring, and call the OpenSpaces Spring FactoryBeans from your own code, but that's not very clean, and requires you to dig through the OpenSpaces code to understand how Spring and OpenSpaces work.

# OpenSpaces for Non-Spring Users

Since version 6.0.2, you have the option of programmatically creating GigaSpaces components, as opposed to creating them declaratively in your Spring XML configuration.

This is also very useful if you're using code-based configuration frameworks to configure your application such as [Google Guice](http://code.google.com/p/google-guice) or [Spring JavaConfig](http://www.springframework.org/javaconfig).

## Some History

Up until version 6.0, the preferred API to use GigaSpaces was JavaSpaces with some proprietary extensions. In 6.0 we introduced OpenSpaces framework, which greatly simplified things and made the user experience much more positive by abstracting away a lot of the API problems and inconsistencies.

From day one, OpenSpaces has been tightly coupled with Spring. It uses Spring for configuration, and utilizes a lot of goodies that Spring provides, such as Spring's transaction management framework, namespace-based configuration, AOP and more.

However, since OpenSpaces' goal is become the preferred Java API for the product, the fact that you could only use it through Spring was a bit limiting to some of our users.

# Introducing Configurers

Below are a number of code snippets to show you how this is done. Let's first show the **Spring equivalent** of creating a space instance, and then wiring your listener on top of it, using a polling container:

{% highlight xml %}
<os-core:space id="space" url="/./space" />
<os-core:giga-space id="gigaSpace" space="space"/>
<bean id="simpleListener" class="SimpleListener" />
<os-events:polling-container id="eventContainer" giga-space="gigaSpace">
<os-core:template>
        <bean class="org.openspaces.example.data.common.Data">
            <property name="processed" value="false"/>
        </bean>
    </os-core:template>
<os-events:listener>
        <os-events:annotation-adapter>
            <os-events:delegate ref="simpleListener"/>
        </os-events:annotation-adapter>
    </os-events:listener>
</os-events:polling-container>
{% endhighlight %}

{% infosign %} The above XML snippet creates a space, and registers to get notified on all objects of type Data, whose processed field equals false.

Here's how this is done in Java code, via configurers:

{% highlight java %}
//creating a space
IJSpace space = new UrlSpaceConfigurer("/./space").space();
//wrapping it with a GigaSpace
GigaSpace gigaSpace = new GigaSpaceConfigurer(space).gigaSpace();
//creating polling container
Data template = new Data();
template.setProcessed(false);
SimplePollingEventListenerContainer pollingEventListenerContainer = new SimplePollingContainerConfigurer(gigaSpace)
.template(template)
.eventListenerAnnotation(new SimpleListener())
.pollingContainer();
{% endhighlight %}

{% infosign %} That's it - as you can see, it's even simpler than the XML equivalent.

## Additional Notes

- All of the configurers use **method chaining**, which makes them very intuitive to use. It's about as close as you can get to domain specific languages in pure Java.
- There are configurers for all of the OpenSpaces constructs, specifically: Space, GigaSpace, Event containers, Remoting Proxies and Scripting Proxies.

## Where is this Documented?

Every OpenSpaces [documentation page](./the-space-component.html) includes code snippets that show how to configure it.

The configuration is displayed in a tabbed pane, which typically includes the following tabs:

- Namespace - shows how to configure the component using Spring's namespaces support and the OpenSpaces-specific elements
- Plain XML - shows how to configure the component via pure Spring, without GigaSpaces-specific elements
- Annotation (if relevant) - shows how to configure the component via Spring and OpenSpaces' annotation support annotations
- **Code - shows how to configure the component programmatically, using configurers**

