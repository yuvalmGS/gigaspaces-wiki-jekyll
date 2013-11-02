---
layout: xap97net
title:  Terminology - Runtime Components
categories: XAP97NET
page_id: 63799418
---

**Summary** - GigaSpaces components from a functional perspective.
|[Basic Components|Terminology - Basic Components]|[Data Grid Topologies|Terminology - Data Grid Topologies]|[Space-Based Architecture|Terminology - Space-Based Architecture]||Runtime Components|

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

A container that hosts a [Processing Unit|Terminology - Basic Components#Processing Unit].

{% sub %}Key sentence: The Processing Unit can run only inside a hosting Processing Unit Container.{% endsub %}

{% endcolumn %}

{% column width=30% %}

{% align center %}!GS6:Images^term_puc.gif!

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

A container that runs the Processing Unit inside an IDE (e.g. Visual Studio, Eclipse).

{% sub %}Key sentence: The integrated processing unit container enables to run the Processing Unit inside your IDE for testing and debugging purposes.{% endsub %}

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_ipuc.gif!

{% sub %}**An Intgrated Processing Unit Container running a Processing Unit**{% endsub %}
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

A Processing Unit Container which runs within a [Grid Service Container|#GSC].
It enables running the processing unit within a [service grid|#Service Grid], which provides self-healing and SLA capabilities to components deployed on it.

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_gscnet.gif!

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


A set of [Grid Service Containers (GSC)|#GSC] managed by a [Grid Service Manager (GSM)|#GSM].
The containers host various deployments of [Processing Units|Terminology - Basic Components#Processing Unit], [Data Grid|Terminology - Data Grid Topologies].
Each container can be run on a separate physical machine.

{% sub %}Key sentence: A set of managed containers hosting Processing Unit Deployments{% endsub %}

{% endcolumn %}

{% column width=30% %}





{% align center %}!GS6:Images^term_empty_service_grid.gif!

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

#### Grid Service Container (GSC)

A [Service Grid|#Service Grid] component which hosts [Processing Unit|Terminology - Basic Components#Processing Unit] instances.
A machine can run one or more GSC processes. Each GSC communicates with a manager component ([GSM|#GSM]). The GSC receives requests to start/stop a processing unit instance, and sends information about the machine which runs it (OS, processor architecture, current memory and CPU stats), the software installed on it and the status of processing unit instances currently running on it.

{% sub %}Key sentence: A set of managed containers hosting different Processing Unit Instances{% endsub %}

{% endcolumn %}

{% column width=30% %}

{% align center %}!GS6:Images^term_gsc.jpg!

{% sub %}**Grid Service Container**{% endsub %}
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

#### Grid Service Manager (GSM)

A [Service Grid|#Service Grid] component which manages a set of [Grid Service Containers (GSC)|#GSC].
A GSM has an API for deploying/undeploying processing units. When a GSM is instructed to deploy a Processing Unit, it allocates an appropriate, available GSC and tells that GSC to run an instance of that processing unit. It then continues to monitor that the GSC is alive and the SLA is not breached.

{% sub %}Key sentence: A GSM manages all the running containers in the network and deploys processing units to them.{% endsub %}

{% endcolumn %}

{% column width=30% %}

{% align center %}!GS6:Images^term_gsm.gif!

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


{% align center %}!GS6:Images^term_management_ui.gif!

{% sub %}**Management UI Console**{% endsub %}
{% endalign %}

{% endcolumn %}

{% endsection %}



|[Basic Components|Terminology - Basic Components]|[Data Grid Topologies|Terminology - Data Grid Topologies]|[Space-Based Architecture|Terminology - Space-Based Architecture]||Runtime Components|