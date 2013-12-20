---
layout: post
title:  Runtime Components
categories: PRODUCT_OVERVIEW
weight: 300
parent: terminology.html
---

{% summary %}GigaSpaces runtime components {% endsummary %}


# GigaSpaces Runtime and Administration Components

# Processing Unit Container

{% comment %}
=====================================

        Runtime and Administration Components

======================================
{% endcomment %}

{% comment %}
-------------------------------------------------
          Processing Unit Container
-------------------------------------------------
{% endcomment %}

{% anchor Processing Unit Container %}

{% section %}
{% column width=50% %}

A container that hosts a [Processing Unit](./terminology---basic-components.html#Processing Unit).

{% sub %}Key sentence: The Processing Unit can run only inside a hosting Processing Unit Container.{% endsub %}
{% endcolumn %}
{% column width=30% %}
{% align center %}
![term_puc.gif](/attachment_files/term_puc.gif)

{% sub %}**A Processing Unit Container**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

# Types of Processing Unit Containers

{% comment %}
----------------------------
          IPUC
----------------------------
{% endcomment %}

{% section %}
{% column width=50% %}

#### Integrated Processing Unit Container

A container that runs the Processing Unit inside an IDE (e.g. IntelliJ IDEA, Eclipse).

{% sub %}Key sentence: The integrated processing unit container enables to run the Processing Unit inside your IDE for testing and debugging purposes.{% endsub %}

{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_ipuc.gif](/attachment_files/term_ipuc.gif)

{% sub %}**An Integrated Processing Unit Container running a Processing Unit**{% endsub %}
{% sub %}**inside an IDE**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
----------------------------
          GSC
----------------------------
{% endcomment %}

{% anchor SGPUC %}

{% section %}
{% column width=50% %}

#### Service Grid Processing Unit Container (AKA SLA Driven Container)

A Processing Unit Container which runs within a [Grid Service Container](#GSC).
It enables running the processing unit within a [service grid](#Service Grid), which provides self-healing and SLA capabilities to components deployed on it.
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_gscnet.gif](/attachment_files/term_gscnet.gif)

{% sub %}**A Service Grid Processing Unit Container running a Processing Unit**{% endsub %}
{% sub %}**inside an IDE**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% whr %}

{% comment %}
-------------------------------------------------
          Service Grid
-------------------------------------------------
{% endcomment %}

{% anchor Service Grid %}

{% section %}
{% column width=50% %}

# Service Grid

A set of [GigaSpaces Containers (GSC)](#gsc) managed by a [GigaSpaces Manager](#gsm).
The containers host various deployments of [Processing Units](./terminology---basic-components.html#Processing Unit) and [Data Grids](./terminology---data-grid-topologies.html).
Each container can be run on a separate physical machine.

{% sub %}Key sentence: A set of managed containers hosting Processing Unit Deployments{% endsub %}
{% endcolumn %}
{% column width=30% %}

{% align center %}
![term_empty_service_grid.gif](/attachment_files/term_empty_service_grid.gif)

{% sub %}**A Service Grid composed of a Grid Service Manager which manages 3 Grid Service Containers**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
----------------------------
          GSC
----------------------------
{% endcomment %}

{% anchor GSC %}

{% section %}
{% column width=50% %}

#### GigaSpaces Container (GSC)

A [Service Grid](#Service Grid) component which hosts [Processing Unit](./terminology---basic-components.html#Processing Unit) instances.
A machine can run one or more [GSC](#gsc) processes. Each GSC communicates with a manager component [GSM](#gsm). The GSC receives requests to start/stop a processing unit instance, and sends information about the machine which runs it (OS, processor architecture, current memory and CPU stats), the software installed on it and the status of processing unit instances currently running on it.

{% sub %}Key sentence: A set of managed containers hosting different Processing Unit Instances{% endsub %}
{% endcolumn %}
{% column width=30% %}
{% align center %}
![term_gsc.jpg](/attachment_files/term_gsc.jpg)

{% sub %}**GigaSpaces Container**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
-------------------------------------------------
          Grid Service Manager
-------------------------------------------------
{% endcomment %}

{% anchor GSM %}

{% section %}
{% column width=50% %}

#### GigaSpaces Manager (GSM)

The [GSM](#gsm) is a [Service Grid](#Service Grid) component which manages a set of [GigaSpaces Containers (GSC)](#gsc).
A GSM has an API for deploying/undeploying processing units. When a GSM is instructed to deploy a Processing Unit, it allocates an appropriate, available GSC and tells that GSC to run an instance of that processing unit. It then continues to monitor that the GSC is alive and the SLA is not breached.

{% sub %}Key sentence: A GSM manages all the running containers in the network and deploys processing units to them.{% endsub %}
{% endcolumn %}
{% column width=30% %}
{% align center %}
![term_gsm.gif](/attachment_files/term_gsm.gif)

{% sub %}**Grid Service Manager**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
-------------------------------------------------
          Management UI
-------------------------------------------------
{% endcomment %}

{% anchor Management UI %}

{% section %}
{% column width=50% %}

#### Management UI

The GigaSpaces Management Center, also known as the GigaSpaces UI or GS-UI.
A monitoring, management and deployment console.

Enables the user to view and interact with the runtime components running in the network.

{% endcolumn %}
{% column width=30% %}
{% align center %}
![term_management_ui.gif](/attachment_files/term_management_ui.gif)

{% sub %}**Management UI Console**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

