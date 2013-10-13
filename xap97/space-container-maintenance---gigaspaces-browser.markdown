---
layout: post
title:  Space Container Maintenance - GigaSpaces Browser
page_id: 61867051
---

{% summary %}Restarting, shutting down and refreshing containers; viewing a runtime configuration report.{% endsummary %}

# Runtime Configuration Report

It is often useful to know the current configuration of a running container. 

**To view a runtime configuration report for a container:**

1. In the GigaSpaces Browser, right-click the container node 
![IMG501.jpg](/attachment_files/IMG501.jpg).
The container context menu is displayed:

{% indent %}
![IMG962.gif](/attachment_files/IMG962.gif)
{% endindent %}

1. From the menu, select **Runtime Configuration Report**. 
The report is displayed in a new window:

{% indent %}
![IMG963.gif](/attachment_files/IMG963.gif)
{% endindent %}

{% tip %}
You can also view the GigaSpaces runtime configuration settings by setting the system property 
`-Dcom.gs.env.report=true` in the Java command line. Refer to the [GigaSpaces Properties List](./system-properties-list.html) for more details.
{% endtip %}

The information displayed includes: 

- Space configuration 
- Container configuration 
- Cluster configuration 
- System properties 
- System environment and variables 
- Java properties 
- Network interfaces 
- GigaSpaces build or version etc.
