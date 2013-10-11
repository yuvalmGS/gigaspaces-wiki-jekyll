---
layout: post
title:  Elastic Processing Unit - take 2
page_id: 61867412
---

{% compositionsetup %}
{% summary page %}Explains how to deploy and manage an Elastic Processing Unit (EPU){% endsummary %}

# Introduction

An Elastic Processing Unit (EPU) is a [Processing Unit](/xap96/the-processing-unit-structure-and-configuration.html) with additional capabilities that simplify its deployment across multiple machines. Containers and machine resources such as Memory and CPU are automatically provisioned based on Memory and CPU requirements. When a machine failure occurs, or when scale requirements change, new machines are provisioned and the Processing Unit deployment distribution is balanced automatically. The PU scale is triggered by modifying the requirements through an API call. From that point in time the EPU is continuously maintained to satisfy the specified capacity (indefinitely, or until the next scale trigger). When a processing unit is undeployed, machines and resources which were provisioned and are no longer needed will scale-in.

##### Prerequisites

The Elastic Processing Unit is managed by a separate service called an Elastic Service Manager (ESM). This manager exists to enforce the elastic requirements. In future versions, the Elastic Service Manager will be merged with the Grid Service Manager (GSM). In current release (including 8.0.1), the [Grid Service Agent](/xap96/the-grid-service-agent.html) should maintain one global instance of an ESM.

# Overview

An Elastic Processing Unit is currently deployed using the [Admin API](/xap96/administration-and-monitoring-api.html). The deployment is done similar to deployment of a Processing Unit, but with additional capabilities exposed. The API defines elasticity from a resource perspective and not from Processing Unit Instance perspective. The resources - Memory and CPU - describe the scaling requirements.

##### Elasticity

Elasticity is supported for **[Space](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/space/ElasticSpaceDeployment.html)** ![linkext7.gif](/attachment_files/linkext7.gif) data-grid deployments, **[Stateful](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/pu/elastic/ElasticStatefulProcessingUnitDeployment.html)** ![linkext7.gif](/attachment_files/linkext7.gif) and **[Stateless](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/pu/elastic/ElasticStatelessProcessingUnitDeployment.html)** ![linkext7.gif](/attachment_files/linkext7.gif) data-grid deployments, **[Stateful](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/pu/elastic/ElasticStatefulProcessingUnitDeployment.html)** ![linkext7.gif](/attachment_files/linkext7.gif) and **[Stateless](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/pu/elastic/ElasticStatelessProcessingUnitDeployment.html)** ![linkext7.gif](/attachment_files/linkext7.gif) Processing Unit deployments. Elasticity is achieved by calling a scale trigger for scaling up/down (adding or removing containers) or out/in (adding or removing machines) based on the Memory/CPU scaling requirements.

##### Machine Provisioning

An **[Elastic Machine Provisioning](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/grid/gsm/machines/plugins/ElasticMachineProvisioning.html)** ![linkext7.gif](/attachment_files/linkext7.gif) implementation can be plugged-in to enable `starting`, `stopping` and `discovering` of virtual machines. One such open-source plugin is the [Citrix Xen Server](http://svn.openspaces.org/cvi/trunk/xenserver) ![linkext7.gif](/attachment_files/linkext7.gif) - _a virtualization software technology that enables multiple virtual machines to run on a single physical server_. We have been using it internally for testing. Another alternative, is [RackSpace](http://svn.openspaces.org/cvi/trunk/rackspace) ![linkext7.gif](/attachment_files/linkext7.gif) - _a cloud provider offering a set of pooled computing resources, enabling an application to scale dynamically and increase its share of resources on-the-fly_. &nbsp; To get you started on a simple "pool" of machines, the [default plugin](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/pu/elastic/config/DiscoveredMachineProvisioningConfig) ![linkext7.gif](/attachment_files/linkext7.gif) implementation can be plugged-in to enable `starting`, `stopping` and `discovering` of virtual machines. One such open-source plugin is the [Citrix Xen Server](http://svn.openspaces.org/cvi/trunk/xenserver) ![linkext7.gif](/attachment_files/linkext7.gif) - _a virtualization software technology that enables multiple virtual machines to run on a single physical server_. We have been using it internally for testing. Another alternative, is [RackSpace](http://svn.openspaces.org/cvi/trunk/rackspace) ![linkext7.gif](/attachment_files/linkext7.gif) - _a cloud provider offering a set of pooled computing resources, enabling an application to scale dynamically and increase its share of resources on-the-fly_. &nbsp; To get you started on a simple "pool" of machines, the [default plugin](http://www.gigaspaces.com/docs/JavaDoc8.0/org/openspaces/admin/pu/elastic/config/DiscoveredMachineProvisioningConfig) ![linkext7.gif](/attachment_files/linkext7.gif) scales based on machines discovered by the Lookup Service. A machine can be added to the "pool" by simply starting a Grid Service Agent on it.

##### Scaling

Scaling is either done manually or eagerly. A manual scale is achieved by calling the `scale` API on a Processing Unit, and supplying the Memory/CPU requirements to satisfy. For example scaling from 2GB to 4GB, or scaling from 2 cores to 8 cores, or both. The scaling is enforced by first scaling up/down and only if requirements can't be met with the current set of resources, scaling out/in by requesting more/less machine resources. On the other hand, eager scaling will automatically use up any discovered resource - scaling the processing unit to consume as many resources as it can. For example, by starting up a new machine (with a Grid Service Agent), the processing unit will eagerly scale by starting containers occupying relocated/incremented instances.

##### Rebalancing

Balancing a system is done in respect to the number of Memory and CPU cores used per machine. An unbalanced system can be caused by new scaling requirements or even machine failure. The Processing Unit instances would need to be relocated, incremented or decremented to fit the new system capacity. For Stateful and Space data-grid deployments, balancing is more complex - and is done with minimal or no disruption to the client application.

##### Life-cycle management

A Processing Unit's instances are maintained until it is undeployed. Throughout the life-cycle of the processing unit, containers and machines can come and go, but the instances are always maintained. If a container suddenly terminates, a new container will be started. If a Machine is suddenly shutdown, a new machine will be provisioned.

# 1-2-3 Getting Started

To get you started on a single machine, the following example shows how to deploy an Elastic Space Processing Unit and how it scales.

##### 1 - Setting up the environment

The Grid Service Agent should start and manage a global instance of an ESM, GSM and LUS. There should be only one global ESM instance.
By default, the GSA starts two Grid Service Containers. Since the ESM will be the one requesting containers to meet memory capacity requirements, the GSA should initially start with **zero** containers.

{% inittab deckName1|top %}
{% tabcontent Windows %}

{% highlight java %}
set LOOKUPGROUPS=myGroup
set JSHOMEDIR=d:\gigaspaces
start cmd /c "%JSHOMEDIR%\bin\gs-agent.bat gsa.global.esm 1 gsa.gsc 0 gsa.global.gsm 1 gsa.global.lus 1"
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Linux %}

{% highlight java %}
export LOOKUPGROUPS=myGroup
export JSHOMEDIR=~/gigaspaces
nohup ${JSHOMEDIR}/bin/gs-agent.sh gsa.global.esm 1 gsa.gsc 0 gsa.global.gsm 1 gsa.global.lus 1 > /dev/null 2>&1 &
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

**Screenshot:**
![gettingStarted1.png](/attachment_files/gettingStarted1.png)

##### 2 - Deploying an Elastic Space data-grid

Using the Admin API we can discover the running services. Since discovery is asynchronous, we need to wait for at least one instance to be discovered.
Below, we specify 1 GB as the maximum memory capacity of the whole data-grid, 128MB as the memory capacity of each container (i.e. -Xms and -Xmx JVM heap size), and (optionally) define an initial scale of 512MB - half of the maximum memory capacity.

{% infosign %} Notice the `.singleMachineDeployment()` which is used to disable the high-availability constraint of a partition (i.e. primary and backup won't co-exist on the same machine). Of course, you would **not** be using this in production. This will do the trick to get you started on a single machine.

{% highlight java %}
// Wait for the discovery of the managers and at least one agent
Admin admin = new AdminFactory().addGroup("myGroup").create();
admin.getGridServiceAgents().waitForAtLeastOne();
admin.getElasticServiceManagers().waitForAtLeastOne();
GridServiceManager gsm = admin.getGridServiceManagers().waitForAtLeastOne();

//deploy a Space - total memory 1GB, each container 128MB
//initially start with a total of 512MB (i.e. 4 containers = 128MB x4 = 512MB)
ProcessingUnit pu = gsm.deploy(
		new ElasticSpaceDeployment("mySpace")
		.maxMemoryCapacity(1,MemoryUnit.GIGABYTES)
		.memoryCapacityPerContainer(128,MemoryUnit.MEGABYTES)
		//initial scale
		.scale(
				new ManualCapacityScaleConfigurer()
				.memoryCapacity(512,MemoryUnit.MEGABYTES)
				.create())
		//deploy on a single machine
		.singleMachineDeployment()
);

//wait for all instances to be discovered
pu.waitForSpace().waitFor(pu.getTotalNumberOfInstances());
...
{% endhighlight %}

**Screenshot:**
![gettingStarted2.png](/attachment_files/gettingStarted2.png)

##### 3 - Scale up by memory capacity

The initial scale is optional, and can be also invoked after the processing unit has been deployed. Containers won't be started until it is invoked.
At any time a processing unit can be requested to scale. For example, the following request will scale the processing unit from 512 MB (which it currently has) to 768 MB.

{% infosign %} Notice: Rebalancing will take place moving backup partition instances to the newly started containers.

{% highlight java %}
...
//manually trigger a scaling requirement
//scale to a total of 768MB (i.e. 6 containers = 128MB x6 = 768MB)
pu.scale(
		new ManualCapacityScaleConfigurer()
		.memoryCapacity(768,MemoryUnit.MEGABYTES)
		.create());
{% endhighlight %}

**Screenshot:**
![gettingStarted3.png](/attachment_files/gettingStarted3.png)

The same API can be used as a request to scale down/in - by specifying less memory.

{% highlight java %}
pu.scale(
		new ManualCapacityScaleConfigurer()
		.memoryCapacity(256,MemoryUnit.MEGABYTES)
		.create());
{% endhighlight %}

**Screenshot:**
![gettingStarted4.png](/attachment_files/gettingStarted4.png)

{% infosign %} When you undeploy an elastic processing unit, this will also terminate all the GSCs hosting the processing unit.

# Tutorial Slides

Elastic Processing Unit tutorial:

<div style="width:425px" id="__ss_7017690"><strong style="display:block;margin:12px 0 4px"><a href="http://www.slideshare.net/shayhassidim/the-elastic-pu" title="The Elastic PU">The Elastic PU</a></strong><object id="__sse7017690" width="425" height="355"><param name="movie" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=elasticpu-110222110302-phpapp02&stripped_title=the-elastic-pu&userName=shayhassidim" /><param name="allowFullScreen" value="true"/><param name="allowScriptAccess" value="always"/><embed name="__sse7017690" src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=elasticpu-110222110302-phpapp02&stripped_title=the-elastic-pu&userName=shayhassidim" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="355"></embed></object></div>

{% children %}
