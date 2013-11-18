---
layout: post
title:  The GigaSpaceContext Annotation
categories: XAP97
---

{% compositionsetup %}
{% summary page|60 %}Allows you to inject a predefined `GigaSpace` instance using annotations.{% endsummary %}

# GigaSpace Context

{% info title=Annotation Based Injection with Spring %}
In previous Spring releases, Spring only allowed you to inject the [GigaSpace](./the-gigaspace-interface.html) instace using setter injection or constructor injection. OpenSpaces extended this injection mechanism by allowing you to use annotations to inject a `GigaSpace` instance.
**As of Spring 2.5, this is no longer required** since Spring support annotation based injection using the [`@Resource`](http://download.oracle.com/javaee/6/api/javax/annotation/Resource.html) or [`@Autowired`](http://static.springsource.org/spring/docs/3.0.x/api/org/springframework/beans/factory/annotation/Autowired.html) annotations.
{% endinfo %}

The following code uses the annotation-based injection:

{% highlight java %}
public class MyService {

    @GigaSpaceContext
    private GigaSpace gigaSpace;

}
{% endhighlight %}

In the above case, there is no need to have a setter for the `GigaSpace` instance, and by annotating it with `GigaSpaceContext`, a `GigaSpace` instance is automatically injected. In order to enable this feature, the following element needs to be configured in the Spring application context:

{% inittab os_simple_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}

<os-core:giga-space-context/>

<os-core:space id="space" url="/./space" />

<os-core:giga-space id="gigaSpace" space="space"/>

<bean id="myService" class="eg.MyService" />
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}

<bean id="gigaSpaceContext" class="org.openspaces.core.context.GigaSpaceContextBeanPostProcessor" />

<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="/./space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
</bean>

<bean id="myService" class="eg.MyService" />
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# GigaSpace Late Context

OpenSpaces allows you to define beans (such as filters), that are later injected to the actual space. If such beans require access to the `GigaSpace` instance, a cyclic dependency occurs (`GigaSpace` requires the `Space`, but the `Space` requires the filter injection). OpenSpaces allows you to use the same annotation-based injection mechanism in order to inject the `GigaSpace` instance at a different lifecycle stage.

The following code uses the annotation-based injection:

{% highlight java %}
public class MyService {

    @GigaSpaceLateContext
    private GigaSpace gigaSpace;

}
{% endhighlight %}

In the above case, there is no need to have a setter for the `GigaSpace` instance, and by annotating it with `GigaSpaceLateContext`, a `GigaSpace` instance is automatically injected. In order to enable this feature, the following element needs to be configured in the Spring application context:

{% inittab os_simple_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}

<os-core:giga-space-late-context/>

<os-core:space id="space" url="/./space" />

<os-core:giga-space id="gigaSpace" space="space"/>

<bean id="myService" class="eg.MyService" />
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}

<bean id="gigaSpaceContext" class="org.openspaces.core.context.GigaSpaceLateContextBeanPostProcessor" />

<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="/./space" />
</bean>

<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
</bean>

<bean id="myService" class="eg.MyService" />
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# Multiple GigaSpace Instances

There can be more than one `GigaSpace` instance defined within the same Spring application context. In such cases, the annotation-based injection requires the ID of the `GigaSpace` instance it should inject. You should use the **name** property to identify it.

The following code uses the annotation-based injection (note the **name** property usage):

{% highlight java %}
public class MyService {

    @GigaSpaceContext(name="directGigaSpace")
    private GigaSpace directGigaSpace;

    @GigaSpaceContext(name="clusteredGigaSpace")
    private GigaSpace clusteredGigaSpace;
}
{% endhighlight %}

In the above case, there is no need to have a setter for the `GigaSpace` instance, and by annotating it with `GigaSpaceContext`, a `GigaSpace` instance is automatically injected. In order to enable this feature, the following element needs to be configured in the Spring application context:

{% inittab os_simple_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}

<os-core:giga-space-context/>

<os-core:space id="space" url="/./space" />

<os-core:giga-space id="directGigaSpace" space="space"/>

<os-core:giga-space id="clusteredGigaSpace" space="space" clustered="true"/>

<bean id="myService" class="eg.MyService" />
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}

<bean id="gigaSpaceContext" class="org.openspaces.core.context.GigaSpaceContextBeanPostProcessor" />

<bean id="space" class="org.openspaces.core.space.UrlSpaceFactoryBean">
    <property name="url" value="/./space" />
</bean>

<bean id="directGigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
</bean>

<bean id="clusteredGigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
	<property name="space" ref="space" />
	<proeprty name="clustered" value="true" />
</bean>

<bean id="myService" class="eg.MyService" />
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

