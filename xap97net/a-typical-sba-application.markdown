---
layout: xap97net
title:  A Typical SBA Application
categories: XAP97NET
page_id: 63799429
---

{summary}A Typical Space-Based Application {summary}

# Overview

This section describes SBA from an application development perspective. It focuses on developing a high-throughput, event-driven, service-oriented application using GigaSpaces XAP and Space-Based Architecture.

# Application Description

Let's take a trading order management application as an example, to understand Space-Based Architecture and its application to GigaSpaces XAP. It is a classic case of an application with highly demanding scalability and latency requirements, in a stateful environment.

A trading application usually consists of a data feed i.e. trade requests, which flow into the system in a standard financial format (e.g. FIX). These feeds need to be matched, with very low latency, against other trades that exist in the market. The business logic typically includes the following steps:
1. Parsing and validation (transforming text format into domain objects, and validating that they conform to certain rules).
2. Matching (querying the data store to find a matching trade, and executing the deal).
3. Routing (routing details of the deal to interested parties).

The application needs to provide a 100% guarantee that once a transaction enters the system, it will not be lost. It also needs to keep end-to-end latency (latency from the time the system receives a trade, to the time the business process ends) to a fraction of a millisecond, and ensure that this low latency is not affected by future scaling.

# Application Design

The first step in building such an application with SBA, is to define its business logic components as independent services - Enrichment Service (parsing and validation), Order Book Service (matching and execution), and Reconciliation Service (routing): !GS6:Images^intro1a.jpg|align=center!

To reduce the latency overhead of communication between these services, they are all collocated in a single Virtual Machine (VM). To eliminate the network overhead of communication with the messaging and data tiers, Messaging Grid and Data Grid instances are both collocated in the same VM. All the interaction with all the services is done purely in-process, bringing I/O overhead to a minimum, in both the data and messaging layers.


This collocated unit of work (which includes business logic, messaging and data) is called a Processing Unit. Because the Processing Unit encompasses all application tiers, it represents the application's full latency path. And because everything occurs in-process, latency is reduced to an absolute minimum. !GS6:Images^intro2a.jpg|align=center!
Scaling is achieved simply by adding more Processing Units and spreading the load among them. Scaling does not affect latency, because the application's complexity does not increase. Each transaction is still routed to a single Processing Unit, which handles the entire business transaction in-process, with the same minimal level of latency. !GS6:Images^intro3a.jpg|align=center!
We can see that the trading application guarantees both minimal latency and linear scalability - something that would be impossible with a tier-based, best-of-breed approach (in other words, with separate products to manage business logic, data and messaging).


# Application Structure

{toc-zone:minLevel=3|maxLevel=3|type=flat|separator=pipe|location=top}

The following diagram outlines a typical architecture of an application built with OpenSpaces: !GS6:Images^intro4a.jpg|align=center!

### Processing Unit

At the heart of the application is the processing unit. A processing unit represents the unit of scale and failover of an application. It is built as a self-sufficient unit that can contain all the relevant components required to process a user's transaction within the same unit. This includes:
- a messaging component required to route transactions between processing units, as well as providing a means for communication between services that are collocated within the processing unit itself.
- business logic units, which are essentially POCOs that process events delivered from the messaging component.
- a data component, that holds the state required for the business logic implementation.

In XAP.NET, a processing unit can be implemented imperatively (extending an abstract class) or declaratively (XML describes the processing unit components and their relations). It is also possible to extend the abstract processing unit provided in XAP.NET to create a processing unit container using your favorite IoC framework (In Java XAP a [Spring|http://www.springframework.org/] Processing Unit container is available).

{% anchor event_containers %}

### Event Containers

Event containers are used to abstract the event processing from the event source. This abstraction enables users to build their business logic with minimal binding to the underlying event source, whether it is a space-based event source or not.

Two types of event containers are available in the product:
- [Polling|Polling Container Component] - Polls the space for entries matching the specified template.
- [Notify|Notify Container Component] - Subscribes for notifications from the space on entries matching the specified template.
(+) The event container object model is designed to be customizable and extensible, so users can customize the behavior of those 2 containers or even create their own containers.

An event container is simply a class which defines:
- A template which will be used to match events.
- A Method which will be used to process matching events.

For example:


{% highlight java %}
[NotifyEventDriven(Name="MyDataProcessor")]
public class DataProcessor
{
    [EventTemplate]
    public Data UnprocessedData
    {
        get
        {
            Data template = new Data();
            template.Processed = false;
            return template;
        }
    }

    [DataEventHandler]
    public Data ProcessData(Data data)
    {
        data.Processed = true;
        return data;
    }
}
{% endhighlight %}


Activating the container can be done via code:

{% highlight java %}
ISpaceProxy spaceProxy = ...; // Reference to a space proxy.
IEventListenerContainer container = EventListenerContainerFactory.CreateContainer(spaceProxy, new DataProcessor());
container.Start();
{% endhighlight %}


Or XML:

{% highlight xml %}
<EventContainers>
    <add Name="MyDataProcessor" SpaceProxyName="..."/>
</EventContainers>
{% endhighlight %}


### The ISpaceProxy Core Middleware Component

The `ISpaceProxy` component is a .NET POCO driven abstraction of the JavaSpaces specification. JavaSpaces is a service specification. It provides a distributed object exchange/coordination mechanism (which might or might not be persistent) for objects. It can be used to store the system state and implement distributed algorithms. In a space, all communication partners (peers) communicate by sharing states. It is an implementation of the [Tuple spaces idea|Concepts#tuple].

Space is used when users want to achieve scalability and availability, while reducing the complexity of the overall system. Processes perform simple operations to write new objects into a space, take objects from a space, or read (make a copy of) objects from a space.

The `ISpaceProxy` abstraction was designed with the following principles in mind:

- **POCO Entries** - the data model in JavaSpaces is an Entry. An Entry has to inherit from a specific interface (`Entry`). All public, non-transient fields are stored in the space. This model is quite different from modern data caching and persistence frameworks (NHibernate, ADO.NET Entity Framework, etc.), which are POCO-oriented. The POCO data model is basically a simple class with annotations that extend that model with specific meta-information such as indexes definition, persistency model, etc. The
- **Generics support** - users can use generics to avoid unnecessary casting and make their interaction with the space more type-safe.

- **Overloaded methods** - the `ISpaceProxy` interface uses overloaded methods, that can use defaults to reduce the amount of arguments passed in read/take/write methods.

### Using the GigaSpace Component in the Context of EDA/SOA Applications

The space serves several purposes in an EDA/SOA type of application:
- **Messaging Grid** - in this case, the space is used as a distributed transport that enables remote and local services to send and receive objects based on their content. In a typical Space-Based Architecture, the space is used to route requests/orders from the data source to the processing unit, based on a predefined affinity-key. The affinity-key is used to route the request/order to the appropriate processing unit. Since it is optimized to run in-memory, it is used also as a means to enable the workflow between the embedded POCO services.
- **In Memory Data Grid (IMDG)** - in this case, the space is used as a distributed object repository, that provides in-memory access to distributed data. Data can be distributed in various topologies - partitioned and replicated are the main ones. In a typical Space-Based Architecture, the space instances are collocated within each processing unit and therefore provide local access to distributed data required by POCO services running under that processing unit. The domain model is also POCO-driven. Data objects are basically objects with annotations, (which add specific metadata required by the Data Grid to mark indexed fields), the affinity-key, and whether the object should be persisted or not, as can be seen in the code snippet below:

{% highlight java %}
[SpaceClass]
public class Data
{
    [SpaceId]
    public long Id { get; set; }

    [SpaceRouting]
    public String Type { get; set; }
}
{% endhighlight %}


- **Processing Grid** - a processing grid represents a particular and common use of the space for parallel transaction processing, using a master/worker pattern. In Space-Based architecture, the processing grid is implemented through a set of POCO services that serve as the workers and event containers, that trigger events from the space into and from these services. Requests/orders are processed in parallel between the different processing units, as well as within these processing units, in case there is a pool of services handling the event.

### Space-Based Remoting

[Space-Based Remoting|Space Based Remoting] allows for POCO services that are collocated within a specific processing unit to be exposed to remote clients, like any other RMI or RPC service.

The client uses the `ExecutorRemotingProxyBuilder<T>` to create a space-based dynamic proxy for the service T. The client uses the proxy to invoke methods on the appropriate service instance. The proxy captures the invocation, extracts information on the service-instance, the method-name, and arguments, and invokes a service request on the space using that information. It then blocks for a response, which can be either a successful result or an exception thrown by the remote service.

A processing unit that needs to be export a service uses the `DomainServiceHost`. The `DomainServiceHost` creates a service-delegator listener that registers for invocations. The invocation context contains information about the instance that needs to be invoked, the method and the arguments. The delegator uses this information to invoke the appropriate method on the POCO service. If the method returns a value, it captures the value and uses the space to return response Entry.

**Benefits compared to RMI**:
- **Efficiency** - unlike RMI, space-based remoting leverages the fact that the space is the network gateway, and therefore doesn't require any additional sockets or I/O resources beyond the ones that have already been allocated to the space.
- **Scalability** - the client stub can point to a cluster of processing units, each containing different instances of the same service for scalability. The proxy utilizes the space clustered proxy for load-balancing of the requests between processing units.
- **Continuous high availability** - since the client proxy doesn't point directly to a specific server but to a space proxy, it remains valid during failover or relocation of a service, i.e. - if a service fails, the command is automatically routed to the backup processing unit. The POCO service contained in this unit immediately picks up the request and responds instead of the failed service, thus enabling smooth continuation of the request during a service failure.
- **Loosely coupled** - a single proxy can point to a set of service instances. This provides the flexibility of invoking methods on a single service, and performing broadcast operations, i.e. invoking multiple services at the same time, or only a single service regardless of its physical location.
- **Synchronous/Asynchronous invocation** - a client can choose to invoke a method and wait for a result (synchronous invocation). It can also invoke a method and pick up the result at a later stage.

### SLA-Driven Container

{comment}TODO_NIV - Change to internal link when available.{comment}
An [OpenSpaces SLA Driven Container|XAP97NET:Basic Processing Unit Container] that allows you to deploy a processing unit over a dynamic pool of machines, is available through an SLA-driven container, formerly known as the Grid Service Containers - GSCs. The SLA-driven containers are .NET processes that provide a hosting environment for a running processing unit. The Grid Service Manager (GSM) is used to manage the deployment of the processing unit, based on SLA. The SLA definition is part of the processing unit configuration, and is normally named `sla.xml`. The SLA definition defines: the number of PU instances that need to be running at a given point of time, the scaling policy, the failover policy based on CPU, and memory or application-specific measurement. !GS6:Images^intro6a.jpg|align=center!
The following is a snippet taken from the example SLA definition section of the processing unit Spring configuration:


{% highlight xml %}
<os-sla:sla cluster-schema="partitioned-sync2backup" number-of-instances="2" number-of-backups="1" max-instances-per-vm="1">
    <os-sla:monitors>
        <os-sla:bean-property-monitor name="Processed Data" bean-ref="dataProcessedCounter" property-name="processedDataCount" />
    </os-sla:monitors>
</os-sla:sla>
{% endhighlight %}

{toc-zone}
{whr}
{refer}**Next Chapter:** [Database Integration]{refer}
