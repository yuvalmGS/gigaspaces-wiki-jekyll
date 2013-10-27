---
layout: post
title:  XAP ESM on Rackspace
page_id: 61867047
---

{% compositionsetup %}
{% summary %}This page describes the GigaSpaces Elastic Data Grid deployment on Rackspace using the Elastic Service Manager{% endsummary %}

# Overview

The GigaSpaces [Elastic Service Manager](http://www.gigaspaces.com/wiki/display/XAP71/The+Elastic+Service+Manager) allows a user to deploy a data grid that can scale out and in to meet changing demands. A simple handler interface is used to request additional computing resources and to release ones that are no longer used.
![flow.gif](/attachment_files/flow.gif)
&nbsp;

This page describes the ESM integration with the Rackspace Cloud.

## Rackspace Cloud Hosting

Rackspace cloud hosting offers on-demand provisioning of virtual servers. As such, it is an ideal solution for scaling out data intensive applications to meet demand peaks.
For more information, please go to the [Rackspace](http://www.rackspacecloud.com/cloud_hosting_products/servers) web site.

# The GigaSpaces Cloud Enabled Platform

The following presentation was part of a joint GigaSpaces/Rackspace webinar showcasing the integration and included a live demonstration of a GigaSpaces data grid scaling out to new Rackspace servers on demand.
{% slideboomrackspacewebinar %}

# Prerequisites

- Download the GigaSpaces ESM package for Rackspace linked in this page, or get the most up to date version in the OpenSpaces source code repository at: [http://svn.openspaces.org/cvi/trunk/rackspace/](http://svn.openspaces.org/cvi/trunk/rackspace/)

- Set up your Rackspace account and create an API access key (see Rackspace documentation for more details)

- Update the 'rackspace.properties' file with your Rackspace user name and access key.

# Data Grid deployment control flow

{% indent %}
![GigaSpaces Rackace Integration.png](/attachment_files/GigaSpaces Rackace Integration.png)
{% endindent %}

Deployment of a data grid is initiated by connecting to a running instance of the ESM, and requesting a new data grid deployment. From this point on, the ESM controls the provisioning and removal of resources.

Here is the control flow of a typical deployment

1. Client looks up an existing ESM.
1. If an existing machine is not available, a new one is provisioned from the Rackspace cloud. An initialization script downloads all application files and starts a GigaSpaces Agent, Lookup Service, GSM and ESM.
1. Client connects to the ESM via the GigaSpaces [Admin API](http://www.gigaspaces.com/wiki/display/XAP7/Administration+and+Monitoring+API) and requests a new Data Grid deployment, specifying the [scaling handler](http://www.gigaspaces.com/wiki/display/XAP71/Custom+Elastic+Scale+Handler+Example) to use.
1. ESM provisions new servers from the Rackspace cloud as required to meet the grid requirements. If no longer required, the ESM will shut down these machines.

# How to Run the Demo

The project source code includes a demo application called _com.gigaspaces.rackspace.examples.ESMDemo_. This class will initialize a data grid and performs some basic operations on it. This is the best place to start. Here you can change the test grid's settings, like its capacity and availability, and see how they affect the grid deployment.

## The code

{% inittab demo|top %}
{% tabcontent Deploy %}

{% highlight java %}

final Admin admin = new AdminFactory().addLocator(locator).createAdmin();
final String gridName = "myElasticDataGrid";
// Use the Admin API to deploy an elastic grid
final ElasticServiceManager esm = admin.getElasticServiceManagers().waitForAtLeastOne();
final ProcessingUnit pu = esm.deploy(new ElasticDataGridDeployment(gridName)
.elasticScaleHandler(new ElasticScaleHandlerConfig("com.gigaspaces.rackspace.esm.RackspaceElasticHandler")
.addProperty("user", user)
.addProperty("apiKei", apiKey)
.addProperty("machineNamePrefix", "gs-esm-gsa")
.addProperty("gridName", gridName)
).capacity("1G", "2G").highlyAvailable(false).publicDeploymentIsolation()
.maximumJavaHeapSize("250m").initialJavaHeapSize("250m"));
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Handler Interface %}

{% highlight java %}

public interface ElasticScaleHandler {
    public void init(ElasticScaleHandlerConfig config);

    public boolean accept(Machine machine);

    public void scaleOut(ElasticScaleHandlerContext context);

    public void scaleIn(Machine machine);
}
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

## Seeing it in action

A video file attached to this page shows the demo code in action.

# Considerations

- Rackspace cloud servers are charged at an hourly rate, so it's a good idea to shut down all servers once you are done working with them.

- Rackspace does not currently support public machine images, so installation of the GigaSpaces libraries is performed after a new server has started. This is done by calling a script ('start-esm.sh') that downloads application files from the Rackspace [CloudFiles](http://www.rackspacecloud.com/cloud_hosting_products/files) storage system.
If you wish to make any changes to the deployment, you may want to modify these scripts to fit your needs.
