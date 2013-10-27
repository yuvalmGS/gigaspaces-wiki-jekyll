---
layout: xap97net
title:  Terminology - Basic Components
categories: XAP97NET
page_id: 63799398
---

**Summary** - GigaSpaces components from a functional perspective.
||Basic Components|[Data Grid Topologies|Terminology - Data Grid Topologies]|[Space-Based Architecture|Terminology - Space-Based Architecture]|[Runtime Components|Terminology - Runtime Components]|

# Basic Components


{% comment %}
=========================================

         Basic Components

=========================================
{% endcomment %}


{% comment %}
----------------------------
          Space
----------------------------
{% endcomment %}

{% anchor Space %}
{section}

{% column width=50% %}

#### Space

The GigaSpaces cache instance that holds data objects in memory.

~Key sentence: The space holds your data objects.~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_space.gif!

~**A space holding objects**~
{% endalign %}

{% endcolumn %}

{section}
{whr}

{% comment %}
----------------------------
          4 Verbs
----------------------------
{% endcomment %}

{% anchor Execute, Read, Write, Take and Notify %}
{section}

{% column width=50% %}

#### Execute, Read, Write, Take and Notify

A set of methods used to read, write, take, and register for notification on objects that are stored in the space. Execute allows sending Tasks to be executed within the space. Read and Take critera can be specified via a query or a template (an example object).

~Key sentence: Interaction with the space is done using the read, write, update, take and notify methods.~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_verbs.jpg!

~**A client application uses the read, write, take, update and notify methods to exchange objects and receive notifications from the space**~
{% endalign %}

{% endcolumn %}

{section}
{whr}

{% comment %}
**Local Cache** - a space embedded within a client application to enable ...
{% endcomment %}


{% comment %}
----------------------------
          Service Component
----------------------------
{% endcomment %}

{% anchor Service Component %}
{section}

{% column width=50% %}

#### Service Component

An application component that interacts with the space (using read, write, take, etc.), and implements a certain functionality.
Java people sometimes refer to it as a Service Bean, but it does not have to be a [Java Bean|http://en.wikipedia.org/wiki/JavaBean].
~Key sentence: The service component interacts with the space to implement your application's logic.~

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_service_bean.gif!

~**A Service Component**~
{% endalign %}

{% endcolumn %}

{section}
{whr}

{% comment %}
----------------------------
          Processing Unit
----------------------------
{% endcomment %}

{% anchor Processing Unit %}
{section}

{% column width=50% %}

#### Processing Unit

A combination of service components and/or an embedded space instance. This is the fundamental unit of deployment in GigaSpaces XAP. The Processing Unit itself runs within a [Processing Unit Container|Terminology - Runtime Components#Processing Unit Container], and is typically deployed onto the [Service Grid|Terminology - Runtime Components#Service Grid].

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_empty_pu.gif!

~**A Processing Unit**~
{% endalign %}

{% endcolumn %}

{section}

# Common Processing Unit Configurations


{% comment %}
----------------------------
          PU with an embedded space
----------------------------
{% endcomment %}

{section}

{% column width=50% %}

#### Processing Unit configured with an embedded space

A deployable package which instantiates an embedded space instance, also called a data grid instance. A set of embedded space instances that run within the processing units typically form a [Data Grid|Terminology - Data Grid Topologies].

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_pu_with_space.gif!

~**A Processing Unit with an embedded space**~
{% endalign %}

{% endcolumn %}

{section}

{% comment %}
----------------------------
          PU with services
----------------------------
{% endcomment %}

{section}

{% column width=50% %}

#### Processing Unit configured with one of more services

A deployable package containing one or more services. In the GigaSpaces context, it usually acts as a client that interacts with other Processing Units by utilizing the messaging capabilities of the space.

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_pu_with_bean.gif!

~**A Processing Unit containing a Service component that interacts with a space embedded in another Processing Unit**~
{% endalign %}

{% endcolumn %}

{section}

{% comment %}
----------------------------
          SBA PU
----------------------------
{% endcomment %}

{section}

{% column width=50% %}

#### Processing Unit configured with embedded space and embedded services

A deployable, independent, scalable unit, which is the building block of [Space-Based Architecture|Terminology - Space-Based Architecture].
Client application (which can also be other processing units) write objects to the space, and the procesing unit which contains this space consumes these objects or is notified about them and triggeres a related services.

{% endcolumn %}

{% column width=30% %}

{% align center %}
!GS6:Images^term_pu_with_space_and_bean.gif!

~**A Processing Unit with an embedded service that interacts with an embedded space**~
{% endalign %}

{% endcolumn %}

{section}


||Basic Components|[Data Grid Topologies|Terminology - Data Grid Topologies]|[Space-Based Architecture|Terminology - Space-Based Architecture]|[Runtime Components|Terminology - Runtime Components]|