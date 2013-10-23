---
layout: post
title:  Quick Start Guide Part I
page_id: 61867355
---


{%summary%}This tutorial will introduce you to the basic features of GigaSpace's XAP platform.{%endsummary%}

# Overview
{%section%}
{%column width=70% %}
This Tutorial provides a high-level overview of the GigaSpaces XAP platform. Hands on examples are provided to demonstrate the core concepts and API's. The primary people who can benefit from this tutorial, are architects and developers who wish to build scaled-out applications with GigaSpaces XAP.
{%endcolumn%}
{%column width=20% %}
<img src="/attachment_files/gs/gs.png" width="100" height="100">
{%endcolumn%}
{%endsection%}

# Class Model
Throughout this tutorial we will create and use a simple internet payment service application to demonstrate the basic XAP features. The basic concept of our application;
- Merchants enter into a contract to handle financial transactions using the application.
- The Merchant will receive a percentage for each transaction.
- Users will make payments with the online system.

Here is the simplified Class Model:

{%indent %}
<img src="/attachment_files/qsg/class_diagram.png" width="500" height="400">
{%endindent%}
 

{%comment%}
| witdh=300px, height=300px!
{%endcomment%}

You can download all examples presented here from [GitHub](https://github.com/Gigaspaces/xap-tutorial). Feel free to clown, fork and contribute to the tutorial code.

# Let's get started

{%panel%}
- Download and unzip the latest XAP release* from the [downloads page](http://www.gigaspaces.com/xap-download)
- Unzip the distribution into a working directory; GS_HOME
- Set the JAVA_HOME environment variable to point to the JDK root directory
- Start your favorite Java IDE
- Create a new project
- Include all files from the GS_HOME/lib/required in the classpath
{%endpanel%}


# Tutorial Trail


{%comment%} ==============================================================Part I  {%endcomment%}

{% panel borderStyle=solid|borderColor=#3c78b5|bgColor=white %}
{%section%}
{%column width=8% %}
[Part I](./tutorial-part-I.html)
{%endcolumn%}

{%column width=60% %}

This part of the tutorial will introduce you to the space as a data store.
You will learn how to:
- create a space
- write objects to the space
- querying the space
- indexing objects in space
{%endcolumn%}

{%column width=20% %}
Learn more [![Learn more](/attachment_files/navigation/l-more.png)](./tutorial.html){:target="_blank"}
{%endcolumn%}
{%endsection%}
{%endpanel%}




{%comment%}
{linkinnew:Tutorial Part I}Learn  !GRA:Images3^l-more.png!{linkinnew}
 !data.png|width=100px,height=100px!
{%endcomment%}



{%comment%} ==========================Part II ====================================
Part II
{%endcomment%}

{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part II|Tutorial  Part II]{indent}
!grid.gif|width=100px,height=100px!
{column}

{column:width=60%}
### The Data Grid
In this part of the tutorial we will show you how you can deploy an In Memory Data Grid (IMDG) that provides scalability and failover.

You will learn how to:
* start a data grid
* deploy a data grid
* interact with the data grid
* how to use the administration UI

{column}

{column:width=10%}
###

{linkinnew:Tutorial  Part II}Learn  !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
============================ Part III ===================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part III|Tutorial Part III]{indent}
!processing.png|width=100px,height=100px!
{column}

{column:width=60%}
### Processing Services
In this part of the tutorial we will introduce you to the different processing services you can run on top of the space.

You will learn how to use:
* Executor service
* Remoting service


{column}

{column:width=10%}
###

{linkinnew:Tutorial Part III}Learn  !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
============================ Part IV ===================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part IV|Tutorial Part IV]{indent}
!Events-Message.png|width=100px,height=100px!
{column}

{column:width=60%}
### Events and Messaging
In this part of the tutorial we will introduce you to events and messaging on top of the space.

You will learn how to use:
* Notify container
* Polling container
{column}

{column:width=10%}
###
{linkinnew:Tutorial Part IV}Learn  !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
============================== Part V =====================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part V|Tutorial Part V]{indent}
!PU.gif|width=100px,height=100px!
{column}

{column:width=60%}
### Processing Unit
In this part of the tutorial we will introduce you the Processing Unit (PU). The PU is the fundamental unit of deployment in GigaSpaces XAP

You will learn how to:
* create a PU
* configure the PU
* deploy a PU
* how to scale and provide failover

{column}

{column:width=10%}
###
{linkinnew:Tutorial Part V}Learn  !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
================================= Part VI =========================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part VI|Tutorial Part VI]{indent}
!transaction.png|width=100px,height=100px!
{column}

{column:width=60%}
### Space Transactions
In this part of the tutorial we will introduce you to the transaction processing capabilities of XAP.


You will learn about:
* Transaction managers
* Transaction processing
* Concurrency
* Locking



{column}

{column:width=20%}
###
{linkinnew:Tutorial Part VI}Learn  !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
================================= Part VII =========================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part VII|Tutorial Part VII]{indent}
!persistence.png|width=100px,height=100px!
{column}

{column:width=60%}
### Space Persistence
In this part of the tutorial we will introduce you to space persistency.


You will learn about:
* Synchronous persistence
* Asynchronos persistence
* Persistence Adapters



{column}

{column:width=20%}
###
{linkinnew:Tutorial Part VII}Learn !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}


{%comment%}
================================= Part VIII =========================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}###[Part VIII|Tutorial Part VIII]{indent}
!web.png|width=100px,height=100px!
{column}

{column:width=60%}
### Web
In this part of the tutorial we will introduce you to web deployment on top of the grid.


You will learn:
* how to deploy a standard WAR file
* how to share global HTTP Sessions
* how to integrate with Apache load balancer
{column}

{column:width=20%}
###
{linkinnew:Tutorial Part VIII}Learn !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}


{%comment%}
================================= Part IX =========================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part IX|Tutorial Part IX]{indent}
!BData.png|width=100px,height=100px!
{column}

{column:width=60%}
### Big Data
In this part of the tutorial we will show how XAP integrates with Big Data.


You will learn about:
* Archive container
* Space persistency
{column}

{column:width=20%}
###
{linkinnew:Tutorial Part IX}Learn !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
================================= Part X =========================
{%endcomment%}
{panel:borderStyle=solid|borderColor=#3c78b5|bgColor=white}
{section}
{column:width=30%}
{indent}### [Part X|Tutorial Part X]{indent}
!security.png|width=100px,height=100px!
{column}

{column:width=60%}
### Security
In this part of the tutorial we will demonstrated how to secure XAP components.


You will learn how to:
* create Roles
* create Users
* secure XAP components
{column}

{column:width=20%}
###
{linkinnew:Tutorial Part X}Learn !GRA:Images3^l-more.png!{linkinnew}
{column}
{section}
{panel}

{%comment%}
# Class Model
Throughout this tutorial we will create and use a simple internet payment service application to demonstrate the basic XAP features. The basic concept of our application;
* Merchants enter into a contract to handle financial transactions using the application.
* The Merchant will receive a percentage for each transaction.
* Users will make payments with the online system.

Here is the simplified Class Model:

{indent:5}!classd.png| witdh=300px, height=300px!{indent}


You can download all examples presented here from [GitHub|https://github.com/Gigaspaces/xap-tutorial]. Feel free to clown, fork and contribute to the tutorial code.

# Let's get started

{%panel%}
- Download and unzip the latest XAP release* from the [downloads page|http://www.gigaspaces.com/xap-download]
- Unzip the distribution into a working directory; GS_HOME
- Set the JAVA_HOME environment variable to point to the JDK root directory
- Start your favorite Java IDE
- Create a new project
- Include all files from the GS_HOME/lib/required in the classpath
{%endpanel%}
{%endcomment%}

{section-page:na}