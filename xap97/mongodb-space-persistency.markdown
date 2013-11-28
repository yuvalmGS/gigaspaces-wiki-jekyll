---
layout: post
title:  MongoDB Space Persistency
categories: XAP97
parent: space-persistency.html
weight: 100
---

{% compositionsetup %}

{% summary %} A MongoDB Space Persistency Solution {% endsummary %}

# Overview

[MongoDB?~D?](http://www.mongodb.org/) is a simple and popular open-source document-oriented NoSQL database.


# MongoDB Space Data Source and Space Synchronization Endpoint

GigaSpaces comes with built in implementations of [Space Data Source](./space-data-source-api.html) and [Space Synchronization Endpoint](./space-synchronization-endpoint-api.html)
 for MongoDB, called `MongoSpaceDataSource` and `MongoSpaceSynchronizationEndpoint`, respectively.
{% indent %}
![mongodbPersistence.jpg.jpg](/attachment_files/mongodbPersistence.jpg)
{% endindent %}

{% comment %}
For information about the two see: [MongoDB Space Data Source](./mongodb-space-data-source.html) and [MongoDB Space Synchronization Endpoint](./mongodb-space-synchronization-endpoint.html).
{% endcomment %}

For further details about the persistency APIs used see [Space Persistency](./space-persistency.html).

# MongoDB Space Data Source

{% include xap97/mongodb-space-data-source.markdown %}

# MongoDB Space Synchronization Endpoint

{% include xap97/mongodb-space-synchronization-endpoint.markdown %}
