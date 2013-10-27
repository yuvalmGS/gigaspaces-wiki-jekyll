---
layout: post
title:  The Runtime Environment
page_id: 61867113
---

{% summary %}This section gives a detailed description of the GigaSpaces deployment & runtime environment.{% endsummary %}

{% anchor GSRuntimeEnv %}

# The GigaSpaces Runtime Environment

The basic unit of deployment in the GigaSpaces XAP platform is the [Processing Unit](/xap96/packaging-and-deployment.html).

Once packaged, a processing unit is deployed onto the GigaSpaces runtime environment, which is called the **Service Grid**. It is responsible for materializing the processing unit's configuration, provisioning its instances to the runtime infrastructure and making sure they continue to run properly over time.
![archi_deployenv.jpg](/attachment_files/archi_deployenv.jpg)

{% info %}
When developing your processing unit, you can [run and debug the processing unit within your IDE](/xap96/running-and-debugging-within-your-ide.html). You will typically deploy it to the GigaSpaces runtime environment when it's ready for production or when you want to run it in the real-life runtime environment
{% endinfo %}

The service grid is composed of a number of components:
![gs_runtime.jpg](/attachment_files/gs_runtime.jpg)

# The Grid Service Agent (GSA)

[The Grid Service Agent](/xap96/the-grid-service-agent.html) (GSA) has been introduced with GigaSpaces XAP 7.0. You can think of it as a daemon or a background service, which can start and stop any of the other runtime components (at the process/JVM level).

Typically, the GSA is started with the hosting machine's startup. Using the agent, you can bootstrap the entire cluster very easily, and start and stop additional GSCs, GSMs and lookup services at will.

All of the above components are fully manageable from the GigaSpaces management interfaces such as the [GUI](/xap96/graphical-user-interface.html) and the [administration and monitoring API](/xap96/administration-and-monitoring-api.html).

# The Grid Service Container (GSC)

When a processing unit is deployed, its instances are provisioned to the running GigaSpaces containers. The Grid Service Container provides an isolated runtime for the processing unit instance, and exposes its state to [The Grid Service Manager](/xap96/the-grid-service-manager.html).

# The Grid Service Manager (GSM)

[The Grid Service Manager](/xap96/the-grid-service-manager.html) is the component which manages the deployment and life cycle of the processing unit.

Using one of GigaSpaces deployment tools (e.g. the GUI), you upload the processing unit jar to the GSM. The GSM analyzes the deployment descriptor and determines how many instances of the processing unit should be created, and which GSCs should run them.

It then ships the processing unit code the running GSCs and orders them to instantiate the processing unit instances. This phase in the deployment process is called provisioning.

Once provisioned, the GSM constantly monitors the processing unit instances to determine if they're functioning properly or not.

When a certain instance fails, the GSM identifies that and re-provisions the failed instance on to another GSC, thus enforcing the processing unit's SLA.

In a typical deployment you would have two or three GSMs so that if one of them fails, another takes over. At any given point in time, each deployed processing unit is managed by a certain GSM, and the other running GSMs serve as its hot standby. If it fails for some reason, one of the standbys takes over and start managing and monitoring the processing units that the failed GSM managed.

# The Lookup Service (LUS)

[The lookup service](/xap96/the-lookup-service.html) is the component responsible for listing all the available runtime components on the network, namely GSCs and GSMs.

Whenever a certain component starts, the first thing it does is connecting to the lookup service and registering itself with it. Using the lookup service, the GSM can know for example about all the running GSCs in the network. Typically, you would have 2 lookup services running in your environment to maintain high availability. Note that the lookup service can run within a GSM, or in standalone mode using its own JVM.

By default, other components find the lookup services using the jini protocol over multicast. If multicast is not enabled in the network, this can be overridden and the explicit address of the lookup service can be specified. Please refer to [this page](/xap96/how-to-configure-unicast-discovery.html#HowtoConfigureUnicastDiscovery-Configuringthelookuplocatorsproperty) for more details.

Another important attribute in that context is the **lookup group**. The lookup group is a logical grouping of all the components that belong to the same runtime cluster. Using lookup groups, you can run multiple deployment of the same processing unit on the same physical infrastructure, without them interfering with one another. For more details please refer to [this page](/xap96/lookup-service-configuration.html)

# The Elastic Service Manager (ESM)

The Elastic Service Manager (ESM) manages the [Elastic Processing Unit](/xap96/elastic-processing-unit.html) together with the GSM.

# The Apache Loader-Balancer Agent (LBA)

The [Apache Load Balancer Agent](/xap96/apache-load-balancer-agent.html) is an optional component used when deploying web applications.

# The Transaction Manager (TXM)

This is an optional component. When executing transactions that spans multiple space partitions you should use the Jini Transaction Manager or the Distributed Transaction Manager. See the [Transaction Management](/xap96/transaction-management.html) section for details.

{% children %}
