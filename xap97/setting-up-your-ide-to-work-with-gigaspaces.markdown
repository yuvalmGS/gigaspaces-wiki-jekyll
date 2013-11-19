---
layout: post
title:  Setting Up your IDE to work with GigaSpaces
categories: XAP97
weight: 100
parent: your-first-xtp-application.html
---

{% compositionsetup %}{% compositionsetup %}
**Summary:** Setting up your IDE to Work With GigaSpaces

{% anchor 0 %}
Follow these steps to prepare your development environment:

{% comment %}
------------------------------------------------
Ensure you have JDK installed
------------------------------------------------
{% endcomment %}

- **Ensure you have a JDK installed** - you will need version 1.5 or higher, latest Java 1.6 is recommended.

{% panel bgColor=white|borderStyle=solid %}

#### Checking your JDK version

To check your installed Java version:

1. Open a command line window.
1. Run **`set JAVA_HOME`**
1. A response similar to this suggests you have a JDK installed:

{% highlight java %}
JAVA_HOME=C:\jdk1.6
{% endhighlight %}

1. To check the JDK version, run **`%JAVA_HOME%\bin\java \-version`**
A response like this from Java indicates you have a good JDK installed:

{% highlight java %}
java version "1.6.0_23"
Java(TM) SE Runtime Environment (build 1.6.0_23-b05)
Java HotSpot(TM) Client VM (build 11.0-b16, mixed mode, sharing)
{% endhighlight %}

If your installed JDK version is lower then 1.5 or none is installed, see below on how to install one.

#### Installing a proper JDK (Java Development Kit)

- To install JDK 1.6, download and install [**JDK 6 Update X**](http://java.sun.com/javase/downloads/index.jsp)

{% comment %}
- The `JAVA_HOME` environment variable points to the correct JDK (not JRE) directory before running GigaSpaces. For example, `D:\Java\jdk1.6`.
- The `JAVA_HOME` environment variable should be added to the beginning of the `Path` environment variable. For example, `%JAVA_HOME%;SystemRoot%\system32;%SystemRoot%;%SystemRoot%`
- Your network and machines running GigaSpaces are configured to have multicast enabled. See the [Multicast Configuration](Multicast Configuration) section for details on how to enable multicast.
{% endcomment %}

{% endpanel %}

{% anchor 1 %}

{% comment %}
------------------------------------------------
Download and install GigaSpaces zip
------------------------------------------------
{% endcomment %}

- **Download and unzip the latest XAP release** from the [downloads page](http://www.gigaspaces.com/LatestProductVersion).
{% anchor 2 %}

{% comment %}
------------------------------------------------
Download and install Eclipse zip
------------------------------------------------
{% endcomment %}

- **Install a Java IDE**: If you don't have an IDE installed, you can [download and unzip the Eclipse IDE for Java Developers](http://www.eclipse.org/downloads), or the [IntelliJ IDEA](http://www.jetbrains.com/idea/download/index.html) IDE (we recommend the Ultimate Edition because of its excellent Spring framework support).
If you're using Eclipse, it is also recommended to install the [Spring Tool Suite plugin for Eclipse](http://www.springsource.com/developer/sts).

### What's Next?

**Write your first GigaSpaces Application: [Writing your first Application](./your-first-xtp-application.html).**
