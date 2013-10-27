---
layout: post
title:  Wiring with Spring - XAP Tutorial
page_id: 61867404
---

{% compositionsetup %}

# Wiring with Spring (PU Configuration)

{% urhere %}{% sub %}[Overview](#1) - [The Application Workflow](#2) - [Implementation](#3) - [POJO Domain Model](#4) - [Writing POJO Services](#5) - ![sstar.gif](/attachment_files/sstar.gif) **[Wiring with Spring (PU Configuration)](#6)** - [Building and Packaging](#7) - [Deployment](#8) - [What's Next?](#9){% endsub %}{% endurhere %}

By now, the implementation of the domain model, DAO, and services is done, but you might have noticed that the picture is not yet complete. The configuration of a space, and types of events that the services should handle are some of the things that are not defined anywhere within the code. Instead, we define all of these in the configuration file (`pu.xml`) of each processing unit.

Each `pu.xml` appears below on a different tab.

{% anchor deck4 %}

{% inittab QSG_OS %}
{% tabcontent Feeder Processing Unit %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xmlns:os-events="http://www.openspaces.org/schema/events"
       xmlns:os-remoting="http://www.openspaces.org/schema/remoting"
       xmlns:os-sla="http://www.openspaces.org/schema/sla"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.openspaces.org/schema/core
       http://www.openspaces.org/schema/8.0/core/openspaces-core.xsd
       http://www.openspaces.org/schema/events
       http://www.openspaces.org/schema/8.0/events/openspaces-events.xsd
       http://www.openspaces.org/schema/remoting
	http://www.openspaces.org/schema/8.0/remoting/openspaces-remoting.xsd
       http://www.openspaces.org/schema/sla
       http://www.openspaces.org/schema/8.0/sla/openspaces-sla.xsd">

    <!-- Spring property configurer which allows us to use system properties (such as user.name).
    	 Here we define a common numberOfAccounts property to be injected to the AccountDataLoader
    	 and to the OrderEventFeeder beans -->
    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
    	<property name="properties">
    		<props>
    			<prop key="numberOfAccounts">100</prop>
    		</props>
    	</property>
    </bean>

	<!-- This component is the RequiredAnnotationBeanPostProcessor class.
	This is a special BeanPostProcessor implementation that is
	@Required-aware and actually provides the 'blow up if this
	required property has not been set' logic. It is very easy to
	configure; simply drop the following bean definition into your
	Spring XML configuration. -->
	<bean class="org.springframework.beans.factory.annotation.RequiredAnnotationBeanPostProcessor"/>

    <!-- Enables the usage of @GigaSpaceContext annotation based injection. -->
    <os-core:giga-space-context/>

	<!-- A bean representing AccountDataDAO using GigaSpaces (an IAccountDataDAO implementation) -->
	<bean id="accountDataDAO" class="org.openspaces.example.oms.common.AccountDataDAO"/>

    <!-- A bean representing a space (an IJSpace implementation).
         Note, we perform a lookup on the space since we are working against a remote space. -->
    <os-core:space id="space" url="jini://*/*/spaceOMS"/>

    <!-- OpenSpaces simplified space API built on top of IJSpace/JavaSpace. -->
    <os-core:giga-space id="gigaSpace" space="space"/>

	<!-- The AccountData loader bean, writing new 750 unique AccountData objects to the space. -->
    <bean id="accountDataLoader" class="org.openspaces.example.oms.feeder.AccountDataLoader">
		<property name="numberOfAccounts" value="${numberOfAccounts}" />
    	<property name="accountDataDAO" ref="accountDataDAO" />
    </bean>

    <!-- The Data feeder bean, writing new OrderEvents objects to the space in a constant interval.
    	 the depends-on attribute ensures the feeder will start only after the feeder bean is done -->
    <bean id="orderEventFeeder" class="org.openspaces.example.oms.feeder.OrderEventFeeder"

    	depends-on="accountDataLoader">
		<property name="numberOfAccounts" value="${numberOfAccounts}" />
    </bean>

</beans>
{% endhighlight %}

[Choose another tab](#deck4) (back to top)
{% endtabcontent %}
{% tabcontent Runtime Processing Unit %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xmlns:os-events="http://www.openspaces.org/schema/events"
       xmlns:os-remoting="http://www.openspaces.org/schema/remoting"
       xmlns:os-sla="http://www.openspaces.org/schema/sla"
       	xsi:schemaLocation="http://www.springframework.org/schema/beans
       	http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.openspaces.org/schema/core
       http://www.openspaces.org/schema/8.0/core/openspaces-core.xsd
       http://www.openspaces.org/schema/events
       http://www.openspaces.org/schema/8.0/events/openspaces-events.xsd
       http://www.openspaces.org/schema/remoting
	http://www.openspaces.org/schema/8.0/remoting/openspaces-remoting.xsd
       http://www.openspaces.org/schema/sla
       http://www.openspaces.org/schema/8.0/sla/openspaces-sla.xsd">

    <!-- Spring property configurer which allows us to use system properties (such as user.name). -->
    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"/>

	<!-- This component is the RequiredAnnotationBeanPostProcessor class.
	This is a special BeanPostProcessor implementation that is
	@Required-aware and actually provides the 'blow up if this
	required property has not been set' logic. It is very easy to
	configure; simply drop the following bean definition into your
	Spring XML configuration. -->
	<bean class="org.springframework.beans.factory.annotation.RequiredAnnotationBeanPostProcessor"/>

    <!-- Enables the usage of @GigaSpaceContext annotation based injection. -->
    <os-core:giga-space-context/>

	<!-- Loads a Spring application context (based on a separate Spring xml configuration file - here mode.xml)
		 only the if processing unit / space is in primary mode and unload it when the processing unit / space
		 is in backup mode. -->
	<os-core:context-loader id="spaceMode" location="classpath:/META-INF/spring/mode/mode.xml"/>

	<!-- A bean representing AccountDataDAO using GigaSpaces (an IAccountDataDAO implementation) -->
	<bean id="accountDataDAO" class="org.openspaces.example.oms.common.AccountDataDAO"/>

    <!-- A bean representing a space (an IJSpace implementation).
		 Note, we do not specify here the cluster topology of the space. It is declared outside of
         the processing unit or within the SLA bean. -->
    <os-core:space id="space" url="/./spaceOMS"/>

    <!-- OpenSpaces simplified space API built on top of IJSpace/JavaSpace. -->
    <os-core:giga-space id="gigaSpace" space="space" tx-manager="transactionManager"/>

    <!-- Defines a Jini transaction manager. -->
    <os-core:distributed-tx-manager id="transactionManager" />

	<!-- The orderEvent validator bean -->
    <bean id="orderEventValidator" class="org.openspaces.example.oms.runtime.OrderEventValidator">
    	<property name="accountDataDAO" ref="accountDataDAO" />
    </bean>

	<!-- A polling event container that performs (by default) polling take operations against
         the space using the provided template (in our case, the new orderEvents objects).
         Once a match is found, the orderEvent processor bean event listener is triggered using the
         annotation adapter. -->
    <os-events:polling-container id="orderEventValidatorPollingEventContainer" giga-space="gigaSpace">
        <os-events:tx-support tx-manager="transactionManager"/>
        <os-core:template>
            <bean class="org.openspaces.example.oms.common.OrderEvent">
                <property name="status" value="New"/>
            </bean>
        </os-core:template>
        <os-events:listener>
            <os-events:annotation-adapter>
                <os-events:delegate ref="orderEventValidator"/>
            </os-events:annotation-adapter>
        </os-events:listener>
    </os-events:polling-container>

    <!-- The orderEvent processor bean -->
    <bean id="orderEventProcessor" class="org.openspaces.example.oms.runtime.OrderEventProcessor">
    	<property name="accountDataDAO" ref="accountDataDAO" />
    </bean>

    <!-- A polling event container that performs (by default) polling take operations with txn
    	 support against the space using the provided template (in our case, the pending orderEvent objects).
         Once a match is found, the data processor bean event listener is triggered using the
         annotation adapter. -->
    <os-events:polling-container id="orderEventProcessorPollingEventContainer" giga-space="gigaSpace">
        <os-events:tx-support tx-manager="transactionManager"/>
        <os-core:template>
            <bean class="org.openspaces.example.oms.common.OrderEvent">
                <property name="status" value="Pending"/>
            </bean>
        </os-core:template>
        <os-events:listener>
            <os-events:annotation-adapter>
                <os-events:delegate ref="orderEventProcessor"/>
            </os-events:annotation-adapter>
        </os-events:listener>
    </os-events:polling-container>

</beans>
{% endhighlight %}

[Choose another tab](#deck4) (back to top)
{% endtabcontent %}
{% tabcontent Statistics Processing Unit %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xmlns:os-events="http://www.openspaces.org/schema/events"
       xmlns:os-remoting="http://www.openspaces.org/schema/remoting"
       xmlns:os-sla="http://www.openspaces.org/schema/sla"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.openspaces.org/schema/core
       http://www.openspaces.org/schema/8.0/core/openspaces-core.xsd
       http://www.openspaces.org/schema/events
       http://www.openspaces.org/schema/8.0/events/openspaces-events.xsd
       http://www.openspaces.org/schema/remoting
	http://www.openspaces.org/schema/8.0/remoting/openspaces-remoting.xsd
       http://www.openspaces.org/schema/sla
       http://www.openspaces.org/schema/8.0/sla/openspaces-sla.xsd">

    <!-- Simply use SLA to add 3 monitors that uses the outputOrderEvent bean to count the globaly
         processed and rejected due to matching account not found orderEvents objects
         and count the number of new orderEvents written. -->
    <os-sla:sla>
        <os-sla:monitors>
            <os-sla:bean-property-monitor name="Written OrderEvent"
            	bean-ref="outputOrderEvent" property-name="orderEventWrittenCounter" />
            <os-sla:bean-property-monitor name="Processed OrderEvent"
            	bean-ref="outputOrderEvent" property-name="orderEventProcessedCounter" />
            <os-sla:bean-property-monitor name="AccountNotFound OrderEvent"
            	bean-ref="outputOrderEvent" property-name="orderEventAccountNotFoundCounter" />
        </os-sla:monitors>
    </os-sla:sla>

    <!-- Spring property configurer which allows us to use system properties (such as user.name). -->
    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"/>

    <!-- Enables the usage of @GigaSpaceContext annotation based injection. -->
    <os-core:giga-space-context/>

    <!-- A bean representing a space (an IJSpace implementation).
         Note, we perform a lookup on the space since we are working against a remote space. -->
    <os-core:space id="space" url="jini://*/*/spaceOMS"/>

    <!-- OpenSpaces simplified space API built on top of IJSpace/JavaSpace. -->
    <os-core:giga-space id="gigaSpace" space="space"/>

	<!-- This bean outputs the userName and balance attributes of the AccountData object -->
    <bean id="outputAccountData" class="org.openspaces.example.oms.stats.OutputAccountData"/>

	<!-- The notification container, registers for notification on every AccountData write or update and
	invokes	the outputAccountData listner on a copy of the object that triggered the event -->
	<os-events:notify-container id="accountDataNotifyContainer" giga-space="gigaSpace" com-type="UNICAST">
		<!-- The notification will occur upon write or update -->
		<os-events:notify write="true" update="true"/>
		<os-core:template>
	        <bean class="org.openspaces.example.oms.common.AccountData">
	        <!-- using template without properties to get all accountData objects -->
	        </bean>
	    </os-core:template>
	    <os-events:listener>
	        <os-events:annotation-adapter>
	            <!-- The adapter activates the outputAccountData.<method annotated as @SpaceDataEvent> on
	            	 the accontData object -->
	            <os-events:delegate ref="outputAccountData"/>
	        </os-events:annotation-adapter>
	    </os-events:listener>
	</os-events:notify-container>

    <!-- This bean outputs the attributes of the orderEvent object -->
    <bean id="outputOrderEvent" class="org.openspaces.example.oms.stats.OutputOrderEventCounter"/>

    <!-- The notification container, registers for notification on every orderEvent write (notify
    on write is default), invokes the outputOrderEvent listner on a copy of the object that
    triggered the event -->
	<os-events:notify-container id="orderEventNotifyContainer" giga-space="gigaSpace">
		<os-core:template>
	        <bean class="org.openspaces.example.oms.common.OrderEvent">
	        </bean>
	    </os-core:template>
	    <os-events:listener>
	        <os-events:annotation-adapter>
	            <os-events:delegate ref="outputOrderEvent"/>
	        </os-events:annotation-adapter>
	    </os-events:listener>
	</os-events:notify-container>

</beans>
{% endhighlight %}

[Choose another tab](#deck4) (back to top)
{% endtabcontent %}
{% endinittab %}

{: .table .table-bordered}
|Full Element|Description|
|:-----------|:----------|
|{% wbr %}{% highlight java %}{% wbr %}<os-core:giga-space-context/>{% wbr %}<os-core:space id="space" url="jini://*/*/spaceOMS"/>{% wbr %}<os-core:giga-space id="gigaSpace" space="space"/>{% wbr %}{% endhighlight %}{% wbr %}|* The first element enables the usage of *`@GigaSpaceContext`* within the services in the same Processing Unit.{% wbr %}- The second element defines the space that is accessed by the services in that Processing Unit. The space can either be accessed embedded (as in the Runtime PU) using the url `/./spaceOMS`, or remote (as in the other two PUs) using the url `jini://\*/\*/spaceOMS`. The `spaceOMS` is just the name of the space, which can be any value but has to be consistent throughout the application.{% wbr %}- The third element defines an instance of the `GigaSpace` proxy object, connected to a specific space. |
|{% wbr %}{% highlight java %}{% wbr %}<!-- Defines a Jini transaction manager. -->{% wbr %}<os-core:distributed-tx-manager id="transactionManager" />{% wbr %}{% endhighlight %}{% wbr %}| This element defines a transaction manager instance that can be used by the services in that processing unit. |
|{% wbr %}{% highlight java %}{% wbr %}<bean id="accountDataDAO" class="org.openspaces.example.oms.common.AccountDataDAO"/>{% wbr %}<bean id="orderEventValidator" class="org.openspaces.example.oms.runtime.OrderEventValidator">{% wbr %}    <property name="accountDataDAO" ref="accountDataDAO" />{% wbr %}</bean>{% wbr %}{% endhighlight %}{% wbr %}| Every service or object can be defined as a Spring Bean within the `bean` element. The first line shows how we define our DAO object for later use. The second definition is of the `OrderEventValidator` that also includes as a property the reference to the DAO. That property is used for the injection of the DAO using the `setAccountDataDAO` method within the validator. |
|{% wbr %}{% highlight java %}{% wbr %}<os-events:polling-container id="orderEventValidatorPollingEventContainer" {% wbr %}		giga-space="gigaSpace">{% wbr %}    <os-events:tx-support tx-manager="transactionManager"/>{% wbr %}    <os-core:template>{% wbr %}        <bean class="org.openspaces.example.oms.common.OrderEvent">{% wbr %}            <property name="status" value="New"/>{% wbr %}        </bean>{% wbr %}    </os-core:template>{% wbr %}    <os-events:listener>{% wbr %}        <os-events:annotation-adapter>{% wbr %}            <os-events:delegate ref="orderEventValidator"/>{% wbr %}        </os-events:annotation-adapter>{% wbr %}    </os-events:listener>{% wbr %}</os-events:polling-container>{% wbr %}{% endhighlight %}{% wbr %}| A polling container defines a "pull" type of event-handling for a specific type of events. By default, the polling container performs a take operation every 5 seconds, but both the operation and interval can be changed.{% wbr %}- `tx-support` sets the transaction manager that is used by the polling container. {% wbr %}- The `template` sub-element defines the template for the take operation. In this example, the template is an `OrderEvent` object with the status attribute set to `New`. {% wbr %}- `listener` refers to the id of the service that is triggered by the event, while the method that handles that event is the one that was marked with the `@SpaceDataEvent` annotation. Note that behind the scenes, the container takes from the space one Entry that matches the template, and calls the relevant method in the relevant service, with that Entry as a parameter. |{% wbr %}|{% wbr %}{% highlight java %}{% wbr %}<os-events:notify-container id="orderEventNotifyContainer" giga-space="gigaSpace">{% wbr %}	<os-core:template>{% wbr %}        <bean class="org.openspaces.example.oms.common.OrderEvent">{% wbr %}        </bean>{% wbr %}    </os-core:template>{% wbr %}    <os-events:listener>{% wbr %}        <os-events:annotation-adapter>{% wbr %}            <os-events:delegate ref="outputOrderEvent"/>{% wbr %}        </os-events:annotation-adapter>{% wbr %}    </os-events:listener>{% wbr %}	</os-events:notify-container>{% wbr %}{% endhighlight %}{% wbr %}|Similar to the polling container, the Notify container receives events according to a defined template, but in a "push" mode. An event will occur every time an operation occurs on the space, by default, a `write` operation.|
|{% wbr %}{% highlight java %}{% wbr %}<os-sla:sla>{% wbr %}    <os-sla:monitors>{% wbr %}        <os-sla:bean-property-monitor {% wbr %}                name="Written OrderEvent" {% wbr %}                bean-ref="outputOrderEvent" {% wbr %}                property-name="orderEventWrittenCounter" />{% wbr %}        <os-sla:bean-property-monitor {% wbr %}                name="Processed OrderEvent" {% wbr %}                bean-ref="outputOrderEvent" {% wbr %}                property-name="orderEventProcessedCounter" />{% wbr %}        <os-sla:bean-property-monitor {% wbr %}                name="AccountNotFound OrderEvent" {% wbr %}                bean-ref="outputOrderEvent" {% wbr %}                property-name="orderEventAccountNotFoundCounter" />{% wbr %}    </os-sla:monitors> {% wbr %}</os-sla:sla>{% wbr %}{% endhighlight %}{% wbr %}| Under the SLA element we put the definitions of our SLA, that is the topology of a cluster and failover policies. This element can be defined within the `pu.xml` as shown here, or by overriding another XML file with the SLA element. We will show how to do this later, but here we show how to define monitors. Monitors are attributes from different services that we want to monitor in the GigaSpaces Management Center. |
