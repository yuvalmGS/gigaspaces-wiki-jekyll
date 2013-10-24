---
layout: xap96
title:  Your First Web Application
page_id: 61867190
---

{% trainingbox %}
{% compositionsetup %}{% compositionsetup %}

{% comment %}
=============================================================
         Summary
=============================================================
{% endcomment %}

**Summary:** {% excerpt %}This tutorial explains how your web application can be deployed into the GigaSpaces XAP platform and what are the benefits that can be obtained by doing so{% endexcerpt %}

{% comment %}
=============================================================
         Set Up Your Environment
=============================================================
{% endcomment %}

{% section %}

## Before You Begin - Set Up Your Environment

If you would like to build and run the tutorial sample application, [download GigaSpaces and set up your Eclipse development environment](/xap96/setting-up-your-ide-to-work-with-gigaspaces.html).
If you also wish to utilize the GigaSpaces XAP load balancing agent, you should [download](http://httpd.apache.org/download.cgi) and install the [Apache 2.2 Http Server](http://httpd.apache.org/).

{% comment %}
=============================================================
         Quick Start Guide Steps
=============================================================
{% endcomment %}

## Deploying Your Web Application on GigaSpaces XAP - Step by Step

This tutorial explains how your existing web JEE web application can benefit from the GigaSpaces platform, showing you how to deploy a simple standard web application into the GigaSpaces environment to achieve high availability and self healing capabilities, how to achieve failover capabilities for your HTTP session and how to access the GigaSpaces data grid from within the web application.
This tutorial will also contain in the near future more advanced examples and patterns for web applications which are based on the [GigaSpaces Spring PetClinic port](http://www.openspaces.org/display/DAE/GigaSpaces+PetClinic)
{% endsection %}

{% panel borderStyle=solid|borderColor=#3c78b5|bgColor=white %}

{% section %}

{% comment %}
---------------------------------------------------------------
         Deploying an existing web application on to GigaSpaces XAP
---------------------------------------------------------------
{% endcomment %}

{% column width=7 %}
{% align center %}

![Step1.jpg](/attachment_files/Step1.jpg)
{% endalign %}

{% endcolumn %}
{% column width=35% %}
[**Adding Self-Healing and Automatic Scaling to Your Existing Web Application**](/xap96/step-1---deploying-your-web-application-to-the-gigaspaces-environment.html)
{% color grey %}~15 minutes{% endcolor %}
Shows how to take an existing web application (in our case a very simple servlet and JSP example) and deploy it to the GigaSpaces environment to achieve high availability and dynamic load balancer configuration
{% endcolumn %}
{% column width=40% %}
{% align right %}

![web-deploy.jpg](/attachment_files/web-deploy.jpg)
![web-deploy-large.jpg](/attachment_files/web-deploy-large.jpg)
{% endalign %}

{% endcolumn %}
{% endsection %}

{% togglecloak id=1 %}  **In this step you will learn...**{% endtogglecloak %}
{% gcloak 1 %}

- How to deploy a standard web application to the GigaSpaces XAP environment
- How to define SLA attributes for your web application (minimum and maximum number of instances to maintain)
- How to configure Apache 2.2 to automatically discover and route traffic to running web container instances using the GigaSpaces load balancing agent

{% endgcloak %}

{% endpanel %}
{% panel borderStyle=solid|borderColor=#3c78b5|bgColor=white %}

{% section %}

{% comment %}
---------------------------------------------------------------
         Http Session Replication
---------------------------------------------------------------
{% endcomment %}

{% column width=7 %}
{% align center %}

![Step2.jpg](/attachment_files/Step2.jpg)
{% endalign %}

{% endcolumn %}
{% column width=35% %}
[**Enabling HTTP Session Failover & Fault Tolerance**](/xap96/step-2---enabling-http-session-failover-and-fault-tolerance.html)
{% color grey %}~15 minutes{% endcolor %}
Shows how to back your application's HTTP session store with the Space to achieve high availability and fault-tolerance
{% endcolumn %}
{% column width=40% %}
{% align right %}

![http-session.jpg](/attachment_files/http-session.jpg)
![http-session-large.jpg](/attachment_files/http-session-large.jpg)
{% endalign %}

{% endcolumn %}
{% endsection %}

{% togglecloak id=2 %}  **In this step you will learn...**{% endtogglecloak %}
{% gcloak 2 %}

- How to back the web container's HTTP session store with the space
- What are the preferred space topologies for backing the HTTP session

{% endgcloak %}
{% endpanel %}

{% panel borderStyle=solid|borderColor=#3c78b5|bgColor=white %}

{% section %}

{% comment %}
---------------------------------------------------------------
         Accessing the Space
---------------------------------------------------------------
{% endcomment %}

{% column width=7 %}
{% align center %}

![Step3.jpg](/attachment_files/Step3.jpg)
{% endalign %}

{% endcolumn %}
{% column width=35% %}

[**Removing the Database Bottleneck**](/xap96/step-3---scaling-the-data-access-layer.html)
{% color grey %}~15 minutes{% endcolor %}
Shows how to access the GigaSpaces XAP in memory data grid from within your web application to achieve unparalleled scalability and performance compared to a relational database.

{% endcolumn %}
{% column width=40% %}
{% align right %}

![space-access.jpg](/attachment_files/space-access.jpg)
![space-access-large.jpg](/attachment_files/space-access-large.jpg)
{% endalign %}

{% endcolumn %}
{% endsection %}

{% togglecloak id=3 %}  **In this step you will learn...**{% endtogglecloak %}
{% gcloak 3 %}

- Various techniques to connect to the space from the web application
- How to read from and write to the Space in your web application

{% endgcloak %}
{% endpanel %}

