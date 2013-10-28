---
layout: xap97net
title:  Application View
categories: XAP97NET
page_id: 63799300
---

{% compositionsetup %}{summary}Applications and Processing unit dependency view{summary}

# Overview

!GRA:Images2^new-in-805-ribbon.png|align=right!
The Applications Module allow users to manage and monitor XAP applications.
It offers a wide set of functionality from deployment to verification, monitoring and log tracing.

!GRA:Images2^apps_explained.png!

# The Application Map

The application map is a graphical representation of the deployment plan (processing units, their SLA and their dependencies)
It allow the user to compare the plan with the actual deployment in any given moment. the next sections give detailed explanation of the application map functionality

### Overview

!GRA:Images2^app_map_explained.png!

### Understanding the processing unit display

The application map depicts a shape per each processing unit
!GRA:Images2^pu.jpg!

It shows the deployment and dependencies between each processing unit, belonging to the chosen "application" from the drop-down menu.
Processing units that were not deployed in the context of an application, will be shown under "Unassigned Services".

!GRA:Images^unassigned_selection.jpg|border=1!

### Processing Unit dependencies

Dependencies between processing units are depicted by an arrow flowing in the direction of "depends on".
For example, in the screenshot below, the feeder depends on the Space to be alive.

{% info %}
For more information on processing unit dependencies, see [Application deployment and processing unit dependencies|Deploying onto the Service Grid#Application Deployment and Processing Unit Dependencies]
{% endinfo %}


!GRA:Images^application_dependency.png|border=1!

|**Icon**|**Description**|
|!GRA:Images2^segment.png!|Space Partition|
|!GRA:Images2^segments.png!|Space Partition with backup|
|!GRA:Images2^data.png!|Space Replica|
|!GRA:Images2^process.png!|Processing (Business Logic)|
|!GRA:Images2^pipe.png!|Event Container (Messaging)|
|!GRA:Images2^world.png!|Web application|

### Contextual Actions

!GRA:Images2^actions_explained.png!

# The Monitoring view

The monitoring view, allows the user to monitor the performance of a the selected processing unit. The displayed statistics are at the cluster level.

### Understanding the widgets

!GRA:Images2^metrics_explained.png!

# The Infrastructure view

The infrastructure view allows the user to verify the application's topology. It maps the processing unit instances to hosts, providing some basic information about each host.
!GRA:Images2^infra_explained.png!

# The Services view

The services view allows the user to get information at the processing unit instance level and to correlate performance of several selected instances.

### Comparing Instances

!GRA:Images2^services_explained.png!

### Service Instance Details

!GRA:Images2^details_explained.png!

### Contextual Actions

# The Logs view

The logs view allows the user to browse the application logs, filter or search them.
!GRA:Images2^logs_explained.png!

# Events time-line (per application)

The events time line is filtered per application chosen from the application drop-down menu.
The events time-line shows the deployment life cycle of all the processing units belonging to this application.

{% info %}
For more information on the events displayed, see [Events time-line tab in dashboard view|Dashboard View#Events time-line]
{% endinfo %}


!GRA:Images^events_timeline_in_application.png|border=1!
