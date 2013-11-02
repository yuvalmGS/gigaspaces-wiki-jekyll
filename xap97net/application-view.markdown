---
layout: xap97net
title:  Application View
categories: XAP97NET
page_id: 63799300
---

{% compositionsetup %}
{% summary %}Applications and Processing unit dependency view{% endsummary %}


# Overview

depanimagenew-in-805-ribbon.pngtengahimage/attachment_files/xap97net/new-in-805-ribbon.pngbelakangimage
The Applications Module allow users to manage and monitor XAP applications.
It offers a wide set of functionality from deployment to verification, monitoring and log tracing.

depanimageapps_explained.pngtengahimage/attachment_files/xap97net/apps_explained.pngbelakangimage

# The Application Map

The application map is a graphical representation of the deployment plan (processing units, their SLA and their dependencies)
It allow the user to compare the plan with the actual deployment in any given moment. the next sections give detailed explanation of the application map functionality

### Overview

depanimageapp_map_explained.pngtengahimage/attachment_files/xap97net/app_map_explained.pngbelakangimage

### Understanding the processing unit display

The application map depicts a shape per each processing unit
depanimagepu.jpgtengahimage/attachment_files/xap97net/pu.jpgbelakangimage

It shows the deployment and dependencies between each processing unit, belonging to the chosen "application" from the drop-down menu.
Processing units that were not deployed in the context of an application, will be shown under "Unassigned Services".

depanimageunassigned_selection.jpgtengahimage/attachment_files/xap97net/unassigned_selection.jpgbelakangimage

### Processing Unit dependencies

Dependencies between processing units are depicted by an arrow flowing in the direction of "depends on".
For example, in the screenshot below, the feeder depends on the Space to be alive.

{% info %}
For more information on processing unit dependencies, see [Application deployment and processing unit dependencies|Deploying onto the Service Grid#Application Deployment and Processing Unit Dependencies]
{% endinfo %}


depanimageapplication_dependency.pngtengahimage/attachment_files/xap97net/application_dependency.pngbelakangimage

|**Icon**|**Description**|
|depanimagesegment.pngtengahimage/attachment_files/xap97net/segment.pngbelakangimage|Space Partition|
|depanimagesegments.pngtengahimage/attachment_files/xap97net/segments.pngbelakangimage|Space Partition with backup|
|depanimagedata.pngtengahimage/attachment_files/xap97net/data.pngbelakangimage|Space Replica|
|depanimageprocess.pngtengahimage/attachment_files/xap97net/process.pngbelakangimage|Processing (Business Logic)|
|depanimagepipe.pngtengahimage/attachment_files/xap97net/pipe.pngbelakangimage|Event Container (Messaging)|
|depanimageworld.pngtengahimage/attachment_files/xap97net/world.pngbelakangimage|Web application|

### Contextual Actions

depanimageactions_explained.pngtengahimage/attachment_files/xap97net/actions_explained.pngbelakangimage

# The Monitoring view

The monitoring view, allows the user to monitor the performance of a the selected processing unit. The displayed statistics are at the cluster level.

### Understanding the widgets

depanimagemetrics_explained.pngtengahimage/attachment_files/xap97net/metrics_explained.pngbelakangimage

# The Infrastructure view

The infrastructure view allows the user to verify the application's topology. It maps the processing unit instances to hosts, providing some basic information about each host.
depanimageinfra_explained.pngtengahimage/attachment_files/xap97net/infra_explained.pngbelakangimage

# The Services view

The services view allows the user to get information at the processing unit instance level and to correlate performance of several selected instances.

### Comparing Instances

depanimageservices_explained.pngtengahimage/attachment_files/xap97net/services_explained.pngbelakangimage

### Service Instance Details

depanimagedetails_explained.pngtengahimage/attachment_files/xap97net/details_explained.pngbelakangimage

### Contextual Actions

# The Logs view

The logs view allows the user to browse the application logs, filter or search them.
depanimagelogs_explained.pngtengahimage/attachment_files/xap97net/logs_explained.pngbelakangimage

# Events time-line (per application)

The events time line is filtered per application chosen from the application drop-down menu.
The events time-line shows the deployment life cycle of all the processing units belonging to this application.

{% info %}
For more information on the events displayed, see [Events time-line tab in dashboard view|Dashboard View#Events time-line]
{% endinfo %}


depanimageevents_timeline_in_application.pngtengahimage/attachment_files/xap97net/events_timeline_in_application.pngbelakangimage
