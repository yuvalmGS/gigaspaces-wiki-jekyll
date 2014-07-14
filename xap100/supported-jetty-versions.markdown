---
layout: post100
title:  Global HTTP Session Sharing
categories: XAP100
parent: web-application-overview.html
weight: 600
---

{%summary%}{%endsummary%}

XAP 10.0 support multiple version of jetty:
Jetty 8.1.8.v20121106
Jetty 9.1.3.v20140225

{% note %}
Currently XAP 10.0 comes with Jetty 8.1.8 settings out of the box, however it is very easy to change it to use Jetty 9.1.3
{% endnote %}

# Using jetty 9.1.1 with XAP 10.0.
1. Rename the jar lib/platform/openspaces/gs-openspaces-jetty-9.jar to lib/platform/openspaces/gs-openspaces-jetty.jar
2. Replace the files in directory lib/platform/jetty with Jetty 9.1.3.v20140225 files 
