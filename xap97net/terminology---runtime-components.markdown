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

{comment}=====================================

        Runtime and Administration Components

======================================{comment}
{comment}-------------------------------------------------
          Processing Unit Container
-------------------------------------------------{comment}
{anchor:Processing Unit Container}
{section}

{% column width=50% %}

A container that hosts a [Processing Unit|Terminology - Basic Components#Processing Unit].

~Key sentence: The Processing Unit can run only inside a hosting Processing Unit Container.~

{% endcolumn %}

{% column width=30% %}

{% align center %}!GS6:Images^term_puc.gif!

~**A Processing Unit Container**~
{% endalign %}

{% endcolumn %}

{section}

# Types of Processing Unit Containers

{comment}----------------------------
          IPUC
----------------------------{comment}
{section}

{% column width=50% %}

#### Integrated Processing Unit Container

A container that runs the Processing Unit inside an IDE (e.g. Visual Studio, Eclipse).

~Key sentence: The integrated processing unit container enables to run the Processing Unit inside your IDE for testing and debugging purposes.~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_ipuc.gif!

~**An Intgrated Processing Unit Container running a Processing Unit**~
~**inside an IDE**~
{% endalign %}

{% endcolumn %}

{section}
{comment}----------------------------
          GSC
----------------------------{comment}
{anchor:SGPUC}
{section}

{% column width=50% %}

#### Service Grid Processing Unit Container (AKA SLA Driven Container)

A Processing Unit Container which runs within a [Grid Service Container|#GSC].
It enables running the processing unit within a [service grid|#Service Grid], which provides self-healing and SLA capabilities to components deployed on it.

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_gscnet.gif!

~**A Service Grid Processing Unit Container running a Processing Unit**~
~**inside an IDE**~
{% endalign %}

{% endcolumn %}

{section}
{whr}
{comment}-------------------------------------------------
          Service Grid
-------------------------------------------------{comment}
{anchor:Service Grid}
{section}

{% column width=50% %}

# Service Grid


A set of [Grid Service Containers (GSC)|#GSC] managed by a [Grid Service Manager (GSM)|#GSM].
The containers host various deployments of [Processing Units|Terminology - Basic Components#Processing Unit], [Data Grid|Terminology - Data Grid Topologies].
Each container can be run on a separate physical machine.

~Key sentence: A set of managed containers hosting Processing Unit Deployments~

{% endcolumn %}

{% column width=30% %}





{% align center %}!GS6:Images^term_empty_service_grid.gif!

~**A Service Grid composed of a Grid Service Manager which manages 3 Grid Service Containers**~
{% endalign %}

{% endcolumn %}

{section}
{comment}----------------------------
          GSC
----------------------------{comment}
{anchor:GSC}
{section}

{% column width=50% %}

#### Grid Service Container (GSC)

A [Service Grid|#Service Grid] component which hosts [Processing Unit|Terminology - Basic Components#Processing Unit] instances.
A machine can run one or more GSC processes. Each GSC communicates with a manager component ([GSM|#GSM]). The GSC receives requests to start/stop a processing unit instance, and sends information about the machine which runs it (OS, processor architecture, current memory and CPU stats), the software installed on it and the status of processing unit instances currently running on it.

~Key sentence: A set of managed containers hosting different Processing Unit Instances~

{% endcolumn %}

{% column width=30% %}

{% align center %}!GS6:Images^term_gsc.jpg!

~**Grid Service Container**~
{% endalign %}

{% endcolumn %}

{section}
{comment}-------------------------------------------------
          Grid Service Manager
-------------------------------------------------{comment}
{anchor:GSM}
{section}

{% column width=50% %}

#### Grid Service Manager (GSM)

A [Service Grid|#Service Grid] component which manages a set of [Grid Service Containers (GSC)|#GSC].
A GSM has an API for deploying/undeploying processing units. When a GSM is instructed to deploy a Processing Unit, it allocates an appropriate, available GSC and tells that GSC to run an instance of that processing unit. It then continues to monitor that the GSC is alive and the SLA is not breached.

~Key sentence: A GSM manages all the running containers in the network and deploys processing units to them.~

{% endcolumn %}

{% column width=30% %}

{% align center %}!GS6:Images^term_gsm.gif!

~**Grid Service Manager**~
{% endalign %}

{% endcolumn %}

{section}
{comment}-------------------------------------------------
          Management UI
-------------------------------------------------{comment}
{anchor:Management UI}
{section}

{% column width=50% %}

#### Management UI

The GigaSpaces Management Center, also known as the GigaSpaces UI or GS-UI.
A monitoring, management and deployment console.

Enables the user to view and interact with the runtime components running in the network.

{% endcolumn %}

{% column width=30% %}


{% align center %}!GS6:Images^term_management_ui.gif!

~**Management UI Console**~
{% endalign %}

{% endcolumn %}

{section}



|[Basic Components|Terminology - Basic Components]|[Data Grid Topologies|Terminology - Data Grid Topologies]|[Space-Based Architecture|Terminology - Space-Based Architecture]||Runtime Components|