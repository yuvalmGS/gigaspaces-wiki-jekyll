---
layout: post
title:  Deployment - XAP Tutorial
categories: XAP97
---

# Deployment

{% urhere %}{% sub %}[Overview](#1) - [The Application Workflow](#2) - [Implementation](#3) - [POJO Domain Model](#4) - [Writing POJO Services](#5) - [Wiring with Spring (PU Configuration)](#6) - [Building and Packaging](#7) - ![sstar.gif](/attachment_files/sstar.gif) **[Deployment](#8)** - [What's Next?](#9){% endsub %}{% endurhere %}

You are now ready to deploy your application, but first, a short recap:

Our Order Management System application has 3 processing units: Feeder, Runtime and Statistics. The domain model includes an order object and an account object, as well as a data access object to encapsulate account-related operations on the space.

There are several ways to deploy the application and to run a processing unit. A PU can either run in standalone mode within your IDE (for development and testing purposes), or on top of the Service Grid, within SLA driven containers that we like to call GSC (Grid Service Container). In this tutorial, we'll show the latter approach, which is used in production environments.

We will do this is two phases. First, we'll show how to deploy the application with a single space (the one that runs embedded within the runtime processing unit, as shown in the first image above). Second, we'll show how to deploy that same application in a clustered environment, where we partition the data and workload to several spaces, meaning we'll run multiple runtime PUs.

## Deployment of a Single Space

1. Because we want to deploy to the Service Grid, we first need to start it. Running the grid is as easy as running the [GS-Agent](./the-grid-service-agent.html)  from the `<GigaSpaces Root\bin` directory, which will start up an agent (which will itself start a Grid Service Manager and two Grid Service Containers) on top of which we run our processing units. The deployed application will then look like this:
![XAP Open OMS tutorial SLA Single PUsmall-layout2.jpg](/attachment_files/XAP Open OMS tutorial SLA Single PUsmall-layout2.jpg)

{% infosign %} Even though the image shows one container per processing unit, we can run several processing units on each container.

1. To start the Grid Agent , execute:

{% highlight java %}
<GigaSpaces Root>\bin\gs-agent.(sh/bat)
{% endhighlight %}

1. Start the GigaSpaces Management Center:

{% highlight java %}
<GigaSpaces Root>\bin\gs-ui.(sh/bat)
{% endhighlight %}

The Management Center is displayed:

![spacebrowser011.jpg](/attachment_files/spacebrowser011.jpg)

1. Click the **Deployments, Details** tab at the left.
The Deployments, Details tab is displayed:

![2-deployment_details1.jpg](/attachment_files/2-deployment_details1.jpg)

1. The two running GSCs are displayed at the bottom of the tab. Both of them are still empty, because no processing units have been deployed.
1. To deploy a processing unit, click the deploy button (![newpackfolder.gif](/attachment_files/newpackfolder.gif)).
The deployment wizard is displayed:

![deployment_wizard1.jpg](/attachment_files/deployment_wizard1.jpg)

1. In the first page of the wizard, click the **SBA Application - Processing Unit** radio button, and click **Next**.
The deployment options page is displayed:

![pu_deploy_wizard2.jpg](/attachment_files/pu_deploy_wizard2.jpg)

1. In the **Processing Unit name** field, type the name of the Processing Unit. This name should be the same as the name of the processing unit directory, located under the `<GigaSpaces Root>\deploy` directory.
For example, if you copied the runtime PU folder under the `deploy` directory with the name `oms-runtime`, type `oms-runtime` in the **Processing Unit Name** field.

{% infosign %} You can specify an alternative name for the processing unit, which will be displayed in the Management Center interface, using the **Override PU Name** field (the **Processing Unit Name** field must still match the name of your PU directory). For example, if your **Processing Unit Name** is `oms-runtime`, your override name might be something like `Order Management Runtime Module`.

1. Click **Deploy**.
The deployment status page is displayed:

![deployment_status_screen1.jpg](/attachment_files/deployment_status_screen1.jpg)

1. Wait until the Processing Unit successfully finishes deploying, then click **Close**.
1. Now, have another look at the lower side of the **Deployment, Details** tab. You should see that one of the GSCs contains the Processing Unit you just deployed.
1. Repeat the deployment process twice more for the other Processing Units (remember, you are deploying the runtime, feeder and statistics processing units).
At the bottom of the **Deployments, Details** tab, you should now see three Processing Units deployed in the two running containers:

![deployment_details_with_pu1.jpg](/attachment_files/deployment_details_with_pu1.jpg)

# Remember the `os-sla:monitors` elements we mentioned? They were defined in the `pu.xml` of the statistics processing unit. Locate the statistics PU in the containers at the bottom, and double-click its name.

A visual representation of the monitors is displayed:

![9-stats_monitor1.jpg](/attachment_files/9-stats_monitor1.jpg)

{% infosign %} For each processing unit in which you define a monitor, you can easily access that monitor's view by double-clicking the relevant PU's name.

1. Click the **Space Browser** tab on the left. In the **Grid Tree** on the left, click **Spaces**.
The Service View on the right updates to show your running spaces:

![spacebrowser021.jpg](/attachment_files/spacebrowser021.jpg)

(Currently, you should only have one space running in the runtime PU.)

1. In the **Grid Tree** on the left, click the **Statistics** node.
The Service View on the right updates to show statistics for your running space -- how many times different operations were performed on the space:

![oms-statistics_new.jpg](/attachment_files/oms-statistics_new.jpg)

{% infosign %} The write and take operations shown in the statistics are the events and accounts written to the space and taken from it. The notify operations are notifications sent to the statistics PU.

## Partitioned with Synchronized Backup Deployment

![XAP Open OMS tutorial SLAfullsmall-layout2.jpg](/attachment_files/XAP Open OMS tutorial SLAfullsmall-layout2.jpg)

As you could see, developing and deploying our application on the grid wasn't too difficult. Following the 4 steps makes the process clear and easy, and with Open Spaces we achieve a lot of abstraction from the code.

So now the application sends events and processes them while using an embedded space to keep the states of the accounts, as well as to deliver events between services, thus using the space as both the data and the messaging layer, and the entire platform is running a full application without the need to integrate any other product.

But how does it scale? Let's say there are more feeders of order events, those events might be coming from many different directions. Eventually, our runtime processing unit that holds the space will become a bottleneck, it will either run out of memory (as all the objects in the space consume memory), or just fully utilize the CPU. So how do we solve this?

We simply scale out, we add more instances of the runtime processing unit on other SLA containers (GSCs) that run on other machines. There are several possible topologies to achieve this scaling, but the most common one is the partitioned-with-backup topology. This means that there are several spaces running, each with a different partition of the entire data, so sticking with our example, imagine two partitions, each with another half of all the user accounts. This way, when an order event comes in, it is automatically routed to the relevant partition according to the username of that order (remember the `@SpaceRouting` annotation in the `OrderEvent` class? That's what it is used for).

In order to achieve better reliability and failover capabilities, each partition also has one backup space, to which it replicates its entire contents in a synchronous manner. In case the primary partition goes down, the backup of that partition automatically takes over, continuing from where the failing primary stopped.

It all must seem quite complicated, but it isn't. Once we've accomplished the previous step of implementation and wiring with Spring, it is just a matter of a small difference in the deployment process. Here's how:

Restart the GSM and two GSC as earlier (to keep things clean just shut down whatever you had running earlier).

Now, within the GigaSpaces Management Center (`<GigaSpaces Root>\bin\gs-ui.bat/sh`), click on the Deployment, Details tab and on the deploy button. Choose again the first option **SBA Application - Processing Unit**. On the next screen, put the name of the processing unit you want to scale out (because the runtime processing unit is the only one with an embedded space, it makes sense to partition it) as before. But now, choose the cluster schema **partitioned**, put `2` in **Number of Instances** and `1` in the **Backups** fields. Note that the backups value is per partition, meaning in this case we'll have two partitions, **each** one with a backup. This is how the screen should look:

![pu_deploy_wizard_partitions.jpg](/attachment_files/pu_deploy_wizard_partitions.jpg)

Note that the deployment will take a few seconds longer as it now deploys 4 spaces (two primaries and two backups). Now deploy the feeder and statistics processing units as before.

Back in the Deployments, Details tab you'll now see 4 instances of the runtime processing unit. Note that each primary is on a different container than its backup:

![deployment_details_with_partitions.jpg](/attachment_files/deployment_details_with_partitions.jpg)

Finally, click on the Space Browser tab to see the four spaces you've just deployed:

![spacebrowser_partitions_new.jpg](/attachment_files/spacebrowser_partitions_new.jpg)

That's it! You've just scaled out your application and can scale it even further by deploying it to as many machines as you want.
