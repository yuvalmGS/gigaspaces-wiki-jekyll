---
layout: post
title:  The Space
categories:
parent: getting-started.html
weight: 50
---


{% summary %}A Space is a logical in-memory service, which can store entries of information.{% endsummary %}


# Overview
A Space is a logical in-memory service, which can store entries of information. An entry is a domain object; In Java, an entry can be as simple a Java POJO or a SpaceDocument.

The space is accessed via a programmatic interface which supports the following main functions:

- Write – the semantics of writing a new entry of information into the space.
- Read – read the contents of a stored entry into the client side.
- Take – get the value from the space and delete its content.
- Notify – alert when the contents of an entry of interest have registered changes.



# Embedded Space

{%section%}
{%column width=60% %}
A client communicating with a an embedded space performs all its operation via local connection. There is no network overhead when using this approach.
{%endcolumn%}
{%column width=35% %}
![embedded-space.jpg](/attachment_files/embedded-space.jpg)
{%endcolumn%}
{%endsection%}

To create a `GigaSpace` for a colocated (embedded) space the space URL should use embedded space URL format:

{% inittab os_space_emb|top %}
{% tabcontent Namespace %}

{% highlight xml %}

<os-core:space id="space" url="/./space" />
<os-core:giga-space id="gigaSpace" space="space"/>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}

<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="/./space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}

GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer("/./space")).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

The Embedded space can be used in a distributed architecture such as the replicated or partitioned clustered space:

{% indent %}
![replicated-space1.jpg](/attachment_files/replicated-space1.jpg)
{% endindent %}

A simple way to use the embedded space in a clustered architecture would be by deploying a [clustered space](./deploying-and-interacting-with-the-space.html) or packaging your application as a [Processing Unit](./packaging-and-deployment.html) and deploy it using the relevant SLA.



# Remote Space

A client communicating with a remote space performs all its operation via a remote connection. The remote space can be partitioned (with or without backups) or replicated (sync or async replication based).

{% indent %}
![remote-space.jpg](/attachment_files/remote-space.jpg)
{% endindent %}

Here is an example how a client application can create a `GigaSpace` interface interacting with a remote space:

{% inittab os_space_remote|top %}
{% tabcontent Namespace %}

{% highlight xml %}

<os-core:space id="space" url="jini://*/*/space" />
<os-core:giga-space id="gigaSpace" space="space"/>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}

<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="jini://*/*/space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
</bean>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}

GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer("jini://*/*/space")).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

{%info%}
A full description of the Space URL Properties can be found [here.](./the-space-url.html)
{%endinfo%}


# Reconnection
When working with a **remote space**, the space may become unavailable (network problems, processing unit relocation, etc.). For information on how such disruptions are handled and configured refer to [Proxy Connectivity](./proxy-connectivity.html).




{% children %}
