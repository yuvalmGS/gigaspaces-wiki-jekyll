---
layout: post
title:  Client Side Caching
categories: XAP97NET
parent: programmers-guide.html
weight: 2600
---

XAP supports client side caching of space data within the client application's memory. Client-side caching implements a two-layer cache architecture where the first layer is stored locally, within the client's memory, and the second layer is stored within the remote master space. The remote master space may be used with any of the supported deployment topologies.

For a detailed description of the different caching scenarios please consult the [Product Overview](/product_overview/caching-scenarios.html)



- [Local Cache](./local-cache.html){%wbr%}
A local cache allows the client application to cache recently used data at the client memory address and have it updated automatically by the space when that data changes.

- [Local View](./local-view.html){%wbr%}
A Local View allows the client application to cache specific data based on client’s criteria at the client memory address and have it updated automatically by the space when that data changes.

{%comment%}
- [Client caching over the WAN](./client-side-caching-over-the-wan.html){%wbr%}
Client caching over the WAN.

- [Monitoring client side cache](./monitoring-the-client-side-cache.html){%wbr%}
Monitoring the Local View/Cache.
{%endcomment%}



