---
layout: post
title:  MongoDB External DataStore
categories: SBP
parent: data-access-patterns.html
weight: 1000
---

{% compositionsetup %}

{% tip %}
**Summary:** {% excerpt %}NoSQL Extended DataStore Implementation{% endexcerpt %}<br/>
**Author**: Joseph Ottinger, Uri Cohen, Shay Hassidim<br/>
**Recently tested with GigaSpaces version**: XAP 8.0.3<br/>
**Last Update:** September 2011<br/>
**Contents:**<br/>

{% toc minLevel=1|maxLevel=1|type=flat|separator=pipe %}

{% endtip %}

# Overview
One of the challenges in using an in-memory data grid is that it's an ideal representation of data that's often held in a non-relational database. GigaSpaces XAP has a [write-behind persistence mechanism]({%latestjavaurl%}/space-data-source-api.html) built-in that's designed for relational databases (so when you write a data item into the data grid, it gets replicated to the backend database automatically), but you might instead want to replicate to a different data storage mechanism altogether, such as [MongoDB](http://www.mongodb.org) or [Cassandra](http://cassandra.apache.org).

The mirror-parent project is meant to collect various external datastore implementations. As of September 2011, implementations include Cassandra and MongoDB, with slight feature differences between them (which will be discussed); however, the implementations work for the general case and illustrate a pattern that can be customized as needed.

# Getting the project
The mirror project is held on github in the [best practices](https://github.com/Gigaspaces/bestpractices) project. This is an umbrella repository; the specific project is in the mirror-parent directory under the root directory.

# How the NoSQL EDS implementations work?
The GigaSpaces XAP external datastore is used by two kinds of processing units: a stateful processing unit (which represents the data grid) and a mirror processing unit (whose sole purpose is to use an external datastore via write-through to persist data.)

![noSQL-EDS.jpg](/attachment_files/sbp/noSQL-EDS.jpg)
There are two phases of an EDS: writethrough persistence and initial load. The writethrough phase is what writes the data from the data grid to the backend data store; the initial load phase is run on datagrid startup, to load the data from the external data store into the data grid.

## Configuring the Mirror
To use a custom EDS with the mirror space, all you have to do is declare the EDS via Spring, and configure the mirror space to use the EDS, as shown in the MongoDB EDS configuration from the tests:

{% highlight java %}
    <!-- BEGIN mongo config -->
    <mongo:mongo id="mongo" host="localhost" port="27017">
        <mongo:options connections-per-host="10"
                       threads-allowed-to-block-for-connection-multiplier="5"
                       max-wait-time="12000"
                       connect-timeout="1000"
                       socket-timeout="0"
                       auto-connect-retry="0"/>
    </mongo:mongo>

    <bean id="mongoEDS" class="org.openspaces.bestpractices.mirror.mongodb.common.MongoEDS">
        <property name="databaseName" value="test"/>
        <property name="mongo" ref="mongo"/>
    </bean>
    <!-- END cassandra config -->

    <!--
        The mirror space. Uses the Hibernate external data source. Persists changes done on the Space that
        connects to this mirror space into the database using Hibernate.
    -->
    <os-core:mirror id="mirror" url="/./mirror-service" external-data-source="mongoEDS">
        <os-core:source-space name="space" partitions="1" backups="1"/>
        <os-core:properties>
            <props>
                <prop key="space-config.external-data-source.data-class">com.j_spaces.core.IGSEntry</prop>
            </props>
        </os-core:properties>
    </os-core:mirror>
{% endhighlight %}

The important facets here are the `mongoEDS` bean declaration, and the `external-data-source` attribute of the space. Assuming you have a MongoDB instance running on localhost (as the MongoDB configuration above shows), this would instantiate a mirror space, prepared for all write-through activity.

## Configuring the Data-Grid

The data grid uses the EDS for reads. If no initial load is desired, configuring the data grid for mirroring is enough; otherwise, you'll replicate the EDS declaration for the data grid declaration as well, which yields the following configuration:

{% highlight java %}
<!-- BEGIN mongo config -->
    <mongo:mongo id="mongo" host="localhost" port="27017">
        <mongo:options connections-per-host="10"
                       threads-allowed-to-block-for-connection-multiplier="5"
                       max-wait-time="12000"
                       connect-timeout="1000"
                       socket-timeout="0"
                       auto-connect-retry="0"/>
    </mongo:mongo>

    <bean id="mongoEDS" class="org.openspaces.bestpractices.mirror.mongodb.common.MongoEDS">
        <property name="databaseName" value="test"/>
        <property name="mongo" ref="mongo"/>
    </bean>
    <!-- END mongo config -->

    <os-core:space id="space" url="/./space" mirror="true" external-data-source="mongoEDS">
        <os-core:properties>
            <props>
                <prop key="space-config.external-data-source.data-class">com.j_spaces.core.IGSEntry</prop>
                <prop key="space-config.external-data-source.usage">read-only</prop>
            </props>
        </os-core:properties>
        <os-core:space-type type-name="Product">
            <os-core:id property="CatalogNumber"/>
            <os-core:routing property="Category"/>
            <os-core:basic-index path="Name"/>
            <os-core:extended-index path="Price"/>
        </os-core:space-type>
    </os-core:space>
{% endhighlight %}

This configuration is almost an exact analog to the mirror declaration. However, this will read the data from the EDS on startup, such that any data held in the right format and collection in the MongoDB datastore will be loaded into the data grid, ready for read and update. Any writes will naturally be persisted through the mirror back to Mongo.

# MongoDB Specifics

The example configuration as described shows the MongoDB configuration. One aspect of the MongoEDS is that it allows manipulation and persistence of POJOs and SpaceDocuments, interchangeably (and in fact it relies on the the SpaceDocument API to perform the initial load, with XAP converting to POJOs as needed.)

# Cassandra Specifics

Cassandra configuration can be seen in the [test project resources](https://github.com/Gigaspaces/bestpractices/tree/master/mirror-parent/cassandra/cassandra-common/src/test/resources).

Cassandra has some issues with the SpaceDocument loading mechanism, primarily because a key attribute is difficult to determine in the EDS (we're looking for a clean API workaround for this.) However, POJO support is fully operational.
