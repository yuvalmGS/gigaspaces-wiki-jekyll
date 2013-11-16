---
layout: product
title:  Terminology - Basic Components
page_id: 61867004
---

{% summary page|65 %}GigaSpaces basic components.{% endsummary %}

|Basic Components|[Data Grid Topologies](./terminology---data-grid-topologies.html)|[Space-Based Architecture](./terminology---space-based-architecture.html)|[Runtime Components](./terminology---runtime-components.html)|

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

{% section %}
{% column width=50% %}

#### Space

The GigaSpaces cache instance that holds data objects in memory.

{% sub %}Key sentence: The space holds your data objects.{% endsub %}
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_space.gif](/attachment_files/term_space.gif)

{% sub %}**A space holding objects**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% whr %}

{% comment %}
----------------------------
          4 Verbs
----------------------------
{% endcomment %}

{% anchor Execute, Read, Write, Take and Notify %}

{% section %}
{% column width=50% %}

#### Execute, Read, Write, Take and Notify

A set of methods used to read, write, take, and register for notification on objects that are stored in the space. Execute allows sending Tasks to be executed within the space. Read and Take critera can be specified via a query or a template (an example object).

{% sub %}Key sentence: Interaction with the space is done using the read, write, update, take and notify methods.{% endsub %}
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_verbs.jpg](/attachment_files/term_verbs.jpg)

{% sub %}**A client application uses the read, write, take, update and notify methods to exchange objects and receive notifications from the space**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% whr %}

{% comment %}
**Local Cache** - a space embedded within a client application to enable ...
{% endcomment %}

{% comment %}
----------------------------
          Service Bean
----------------------------
{% endcomment %}

{% anchor Service Bean %}

{% section %}
{% column width=50% %}

#### Service Bean

An application component that interacts with the space (using the read, write, take and notify operations), and implements a certain functionality.

{% sub %}Key sentence: The service bean interacts with the space to implement your application's logic.{% endsub %}
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_service_bean.gif](/attachment_files/term_service_bean.gif)

{% sub %}**A Service Bean**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% whr %}

{% comment %}
----------------------------
          Processing Unit
----------------------------
{% endcomment %}

{% anchor Processing Unit %}

{% section %}
{% column width=50% %}

#### Processing Unit

A combination of service beans and/or an embedded space instance. This is the fundamental unit of deployment in GigaSpaces XAP. The Processing Unit itself runs within a [Processing Unit Container](./terminology---runtime-components.html#Processing Unit Container), and is typically deployed onto the [Service Grid](./terminology---runtime-components.html#Service Grid). Once a Processing Unit is deployed, a **Processing Unit instance** is the actual runtime entity.

{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_empty_pu.gif](/attachment_files/term_empty_pu.gif)

{% sub %}**A Processing Unit instance**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

# Different Processing Unit Configurations

{% comment %}
----------------------------
          PU with an embedded space
----------------------------
{% endcomment %}

{% section %}
{% column width=50% %}

#### Processing Unit configured with an embedded space

A deployable package which instantiates an embedded space instance, also called a data grid instance. A set of embedded space instances that run within the processing units typically form a [Data Grid](./terminology---data-grid-topologies.html).
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_pu_with_space.gif](/attachment_files/term_pu_with_space.gif)

{% sub %}**A Processing Unit instance with an embedded space**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
----------------------------
          PU with services
----------------------------
{% endcomment %}

{% section %}
{% column width=50% %}

#### Processing Unit configured with one of more services

A deployable package containing one or more services. In the GigaSpaces context, it usually acts as a client that interacts with other Processing Units by utilizing the messaging capabilities of the space.
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_pu_with_bean.gif](/attachment_files/term_pu_with_bean.gif)

{% sub %}**A Processing Unit instance containing a Service bean that interacts with a space embedded in another Processing Unit**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

{% comment %}
----------------------------
          SBA PU
----------------------------
{% endcomment %}

{% section %}
{% column width=50% %}

#### Processing Unit configured with embedded space and embedded services

A deployable, independent, scalable unit, which is the building block of [Space-Based Architecture](./terminology---space-based-architecture.html).
Client application (which can also be other processing units) write objects to the space, and the processing unit which contains this space consumes these objects or is notified about them and triggeres a related services.
{% endcolumn %}
{% column width=30% %}
{% align center %}

![term_pu_with_space_and_bean.gif](/attachment_files/term_pu_with_space_and_bean.gif)

{% sub %}**A Processing Unit instance with an embedded service that interacts with an embedded space**{% endsub %}
{% endalign %}

{% endcolumn %}
{% endsection %}

|Basic Components|[Data Grid Topologies](./terminology---data-grid-topologies.html)|[Space-Based Architecture](./terminology---space-based-architecture.html)|[Runtime Components](./terminology---runtime-components.html)|
