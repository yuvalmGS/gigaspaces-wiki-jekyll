---
layout: post
title:  Building and Packaging - XAP Tutorial
page_id: 61867381
---

# Building and Packaging

{% urhere %}{% sub %}[Overview](#1) - [The Application Workflow](#2) - [Implementation](#3) - [POJO Domain Model](#4) - [Writing POJO Services](#5) - [Wiring with Spring (PU Configuration)](#6) - ![sstar.gif](/attachment_files/sstar.gif) **[Building and Packaging](#7)** - [Deployment](#8) - [What's Next?](#9){% endsub %}{% endurhere %}

Once everything is ready, we need to build, package and deploy the application.

All the `jar` files under the `<GigaSpaces Root>/lib/required` directory should be included in your classpath. These include:

- `gs-runtime.jar`
- `gs-openspaces.jar`
- `commons-logging.jar`
- Spring framework jars (all start with `com.spring*`)

In order to deploy the application, we need to deploy each of the three processing units separately. To do this, every processing unit must be deployed to the GSM. Every processing unit is actually a folder or a jar file (whose name is the name of the processing unit later used for deployment) with several subfolders. A typical processing unit directory structure is as follows:

{% highlight java %}
my-pu
-- lib
---- mylib1.jar
---- mylib2.jar
-- org
---- mypackage
------- MyClass.class
---- META-INF
------ spring
-------- pu.xml
{% endhighlight %}

As shown above, the processing unit is composed of a lib directory under which all the libraries that the processing unit depends on are located. Under `META-INF\spring` we can find the `pu.xml` file, which is a spring XML files that describes the components of the processing unit . Also, directly under the root of the processing unit is our compiled code, with its appropriate package structure.
