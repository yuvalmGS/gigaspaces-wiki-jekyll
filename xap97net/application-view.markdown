---
layout: xap97net
title:  Application View
categories: XAP97NET
page_id: 63799300
---

{% compositionsetup %}
{% summary %}Applications and Processing unit dependency view{% endsummary %}


# Overview

![new-in-805-ribbon.png](/attachment_files/xap97net/new-in-805-ribbon.png)
The Applications Module allow users to manage and monitor XAP applications.
It offers a wide set of functionality from deployment to verification, monitoring and log tracing.

![apps_explained.png](/attachment_files/xap97net/apps_explained.png)

# The Application Map

The application map is a graphical representation of the deployment plan (processing units, their SLA and their dependencies)
It allow the user to compare the plan with the actual deployment in any given moment. the next sections give detailed explanation of the application map functionality

### Overview

![app_map_explained.png](/attachment_files/xap97net/app_map_explained.png)

### Understanding the processing unit display

The application map depicts a shape per each processing unit
![pu.jpg](/attachment_files/xap97net/pu.jpg)

It shows the deployment and dependencies between each processing unit, belonging to the chosen "application" from the drop-down menu.
Processing units that were not deployed in the context of an application, will be shown under "Unassigned Services".

![unassigned_selection.jpg](/attachment_files/xap97net/unassigned_selection.jpg)

### Processing Unit dependencies

Dependencies between processing units are depicted by an arrow flowing in the direction of "depends on".
For example, in the screenshot below, the feeder depends on the Space to be alive.

{% info %}
For more information on processing unit dependencies, see [Application deployment and processing unit dependencies](/xap97/deploying-onto-the-service-grid.html#Application Deployment and Processing Unit Dependencies)
{% endinfo %}


![application_dependency.png](/attachment_files/xap97net/application_dependency.png)

|**Icon**|**Description**|
|![segment.png](/attachment_files/xap97net/segment.png)|Space Partition|
|![segments.png](/attachment_files/xap97net/segments.png)|Space Partition with backup|
|![data.png](/attachment_files/xap97net/data.png)|Space Replica|
|![process.png](/attachment_files/xap97net/process.png)|Processing (Business Logic)|
|![pipe.png](/attachment_files/xap97net/pipe.png)|Event Container (Messaging)|
|![world.png](/attachment_files/xap97net/world.png)|Web application|

### Contextual Actions

![actions_explained.png](/attachment_files/xap97net/actions_explained.png)

# The Monitoring view

The monitoring view, allows the user to monitor the performance of a the selected processing unit. The displayed statistics are at the cluster level.

### Understanding the widgets

![metrics_explained.png](/attachment_files/xap97net/metrics_explained.png)

# The Infrastructure view

The infrastructure view allows the user to verify the application's topology. It maps the processing unit instances to hosts, providing some basic information about each host.
![infra_explained.png](/attachment_files/xap97net/infra_explained.png)

# The Services view

The services view allows the user to get information at the processing unit instance level and to correlate performance of several selected instances.

### Comparing Instances

![services_explained.png](/attachment_files/xap97net/services_explained.png)

### Service Instance Details

![details_explained.png](/attachment_files/xap97net/details_explained.png)

### Contextual Actions

# The Logs view

The logs view allows the user to browse the application logs, filter or search them.
![logs_explained.png](/attachment_files/xap97net/logs_explained.png)

# Events time-line (per application)

The events time line is filtered per application chosen from the application drop-down menu.
The events time-line shows the deployment life cycle of all the processing units belonging to this application.

{% info %}
For more information on the events displayed, see [Events time-line tab in dashboard view](./dashboard-view.html#Events time-line)
{% endinfo %}


![events_timeline_in_application.png](/attachment_files/xap97net/events_timeline_in_application.png)
