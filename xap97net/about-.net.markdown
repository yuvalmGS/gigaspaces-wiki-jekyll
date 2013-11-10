---
layout: xap97net
title:  About .NET
categories: XAP97NET
page_id: 63799335
---

# About GigaSpaces

GigaSpaces is a platform that is targeted for scaling out stateful applications in a high performance low latency environment. It is based on the GigaSpaces space-based runtime for delivering core middleware components. The primary model for ensuring the linear scalability of an application running on GigaSpaces relies on [Space Based Architecture](/product_overview/Concepts.html#Concepts-SpaceBasedArchitecture) as the primary design pattern.

The core of GigaSpaces is the _**space**_ -- a middleware infrastructure, collocated with the business process services. The space uses the [JavaSpaces API](/product_overview/Concepts.html#Concepts-TupleSpace) as its primary API, with four methods: [Read()](/product_overview/Concepts.html#Concepts-SpaceBasicConcepts), [Write()](/product_overview/Concepts.html#Concepts-SpaceBasicConcepts), [Take()](/product_overview/Concepts.html#Concepts-SpaceBasicConcepts), and [Notify()](/product_overview/Concepts.html#Concepts-SpaceBasicConcepts).

# Using JavaSpaces Through Native .NET API

Since version 5.0 of GigaSpaces, it is possible to use the JavaSpaces API through native .NET API. Furthermore, most of GigaSpaces' unique capabilities (batch operations, template construction, updating objects, subscribing to space events, and more) are also available with .NET.

## Interoperability and Performance

GigaSpaces provides the most efficient platform for interoperability between Java and .NET in the market today (compared to CORBA, WS, etc). For the enterprise, this means that the organization can have a common technology and product across different lines of business. This ensures that the product is developed in each platform, and can effectively interoperate at any given time. This also provides the flexibility to mix and match -- for example, to use Java on the server side and .NET on the client side.

Pure .NET applications can benefit from the richness and maturity of the architecture, and from the fact that they can have more flexibility when running some of their processes on more scalable Linux/Unix platforms.

Unmatched levels of high-throughput and low-latency are achieved through the solution's support for both in-process (embedded) and out-of-process optimization. Performance between Java and .NET is consistent -- there is very little overhead, even when handling the portability between the two platforms. Moreover, latency is kept low.

## Plain Old .Net Objects

The [Space-Based .NET API] is a .NET equivalent of the [POJO]({% currentjavaurl %}/POJO-Support.html) in the Java world. Using the PONO provides a consistent programming model across the two different languages. It is a declarative and non-intrusive way to map existing domain model objects into the space using .NET attributes. Finally, using PONOs is simple -- API appears in pure a .NET library, in a native format.

## PBS

Portable Binary Serialization (PBS) in GigaSpaces provides an extremely fast and efficient binary representation of .NET or Java objects, which is portable between the two domains even faster than in native serialization. Using PBS allows an implicit conversation between .NET and Java data types such as date format, representation of floating points, etc.
