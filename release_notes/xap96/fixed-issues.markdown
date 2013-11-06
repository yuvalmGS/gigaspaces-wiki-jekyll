---
layout: post
title:  Resolved Issues
page_id: 61867183
---

{%summary%} Issues that have been fixed in XAP 9.6.X release {%endsummary%}

# Overview

Below is a list of issues that have been fixed in GigaSpaces 9.6.X.

# OpenSpaces

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11069 | Add the ability to set OpenSpacesMuleMessageReceiver max batch size on os-queue:connector | 9.6.2 | 7943 | ESB, OpenSpaces |
 | GS-11251 | ESM fails to start GSC when one out of two LUS is down | 9.6.1 | | Elastic PU,Service Grid |
 | GS-11239 | Eager Elastic PU does not self-heal when it is deployed right before second GSM starts | 9.6.1 | | Elastic PU,Service Grid |
 | GS-11175 | ESM stops working when it cannot discover itself | 9.6.1 | | Elastic PU,Service Grid |
 |GS-11168 | getPlannedNumberOfInstances() may return 0 due to event race condition | 9.6.0 RC | | Elastic PU, OpenSpaces, Service Grid|

# API, Proxy, Server

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11355 | "Insufficient Data In Class" might appear in log while starting local view after failovers | 9.6.2 | 8282 | Engine |
| GS-11365 | Updating entry twice under the same transaction when object was written with lease might cause to memory leak | 9.6.2 | 8294 | Engine |
| GS-11305 | ArrayIndexOutOfBoundsException may be thrown when working with more than one class defining FIFO Group in rare condition | 9.6.2 | 8243 | Engine |
| GS-11357 | Increment by zero in Change operation causes to UnMarshallingException | 9.6.2 | | |
| GS-11139 | GigaSpaces was holding file handlers to deleted files | 9.6.2 | 7944 | API |
| GS-11431 | NPE when overriding a setter method and no getter is available | 9.6.2 | 8349 | |
| GS-11280 | Problem presenting log in ui and admin logging API, serialization error appears when log line is too long. | 9.6.1 | | Replication |
| GS-11233 | Projection on entry with auto generate id true doesn't work | 9.6.1 | | Proxy | ||
| GS-11305 | ArrayIndexOutOfBoundsException may be thrown when working with more than one class defining FIFO Group in rare condition | 9.6.1 | | Engine |
| GS-11186 | NPE is thrown when performing SQLQuery with template and projection on a primitive field and this filed is not part of the projection | 9.6.1 | | API |
| GS-11312 | Last replicated packet is kept on thread local cache which could hold up significant memory | 9.6.1 | | Replication | ||
| GS-11260 | Durable notification and local view may receive notification which does not match its template of operations under distributed transaction | 9.6.1 | | Events,Replication |
| GS-11207 | Exception is thrown when query projected result does not include primitive properties without null values | 9.6.1 | | API |
| GS-11226 | When adding a dynamic gateway target, the backup space will throw an exception in the logs rejecting this addition | 9.6.1 | | Replication,WAN |
|GS-11163 | readById operation returns null when using parent class | 9.6.0 RC | 8064 | API |
|GS-11070 | JDBC update query increment field throws a java.lang.IllegalArgumentException for a valid query | 9.6.0 M2 | |SQL Query |
|GS-11081 | Remove potential deadlock on reflection byte code generation | 9.6.0 M2 | |Proxy |
|GS-11105 | Local view may return null for a read operation if that object is currently being modified by the replication. | 9.6.0 M2 | |Admin Tools Engine |
|GS-11137 | When using non native serialization mode, the resource pool at the client may hold large amount of memory on the heap without releasing it | 9.6.0 M4 | |Proxy |
|GS-11138 | If a recovery target has disconnected during a recovery process, it may hang the lease reaper thread in the space which was the source for recovery and hang following recovery requests | 9.6.0 M4 |8037 |Replication |
|GS-11161 | If replication ping operation is hanged forever due to unforeseen reason, no new replication connections can be established | 9.6.0 M4 |8063 |Replication |
|GS-11115 | Gateway replication may infinitely attempt to execute a batch if each attempt fails due to a different conflict | 9.6.0 M4 |7996 |WAN |
|GS-11149 | readByIds() operation of non exsiting object on an all-in-cache space configured with EDS will use eds methods insted of returning null immediately | 9.6.0 M4 |8040 |Engine |
|GS-11158 | Failure of auto renew durable notification listener after undeploy-deploy of the space | 9.6.0 M4 |8060 |Engine |
|GS-11122 | IPv6 addresses are parsed incorrectly in several locations throughout the system resulting in errors. | 9.6.0 M4 | |API |
|GS-11111 | Support for IP version 6 | 9.6.0 M4 | |Jini Service Grid |



# Service Grid

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|


# C++ Specifics

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|


# .NET Specifics

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11266 | NHibernate practice binaries should not be packaged in the msi | 9.6.1 | | .NET,Packages |
| GS-11191 | .Net ReadMultiple with bad query result in class cast exception | 9.6.1 | | .NET |
| GS-11227 | XAP.NET CLI Windows Service is broken - missing gs_cli.config file | 9.6.1 | | .NET |
| GS-11231 | Space mode change annotations are not working when a space proxy is created in the ContainerInitializing method | 9.6.1 | | .NET |
|GS-11082 | .NET/java interop nested path SQL query throws a SpaceMetadataException when queried java class is not in client classpath | 9.6.0 M2 | |.NET SQL Query |
|GS-11142 | ChangeException in .NET is not marked as serializable | 9.6.0 M4 |8046 |.NET |


# Configuration, UI, CLI & Admin tools

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11411 | XSD 9.6 schemas are not provided -require internet | 9.6.2 | 8342 | Configuration |
| GS-11415 | Hide newsfeed button if not available | 9.6.2 | | Web-UI |
| GS-11391 | ESM service is missing an icon in gs-ui | 9.6.2 | | GS-UI |
| GS-11108 | Error in startGroovy.bat file when trying to use Java 6 style wildcard for jars to be added to classpath | 9.6.1 | | Configuration |
| GS-11223 | Data replication throughput at Dashboard is not displayed as whole number | 9.6.1 | | Web-UI |
|GS-11109 | Web-UI doesn't show any available service after a user: logs in, closes the browser, waits until the session ends and logs in again with the same username. | 9.6.0 M2 | |Web-UI |
|GS-11125 | Fix typo in consistency level QUOROM should be QUORUM | 9.6.0 M4 | |Configuration |
|GS-11121 | Change Statistics throughput is not displayed properly in GS-UI | 9.6.0 M4 | |GS-UI |
|GS-11164 | Indexes table is flickering | 9.6.0 M4 | |GS-UI |
|GS-11134 | WebUI is coupled with Cloudify due to security feature. | 9.6.0 M4 | |Web-UI |
|GS-11155 | There is no option to select "Active Sessions" tomcat service metric in web ui | 9.6.0 M4 | |Web-UI |
|GS-11156 | Memcached metrics are not displayed in Metrics view of Applications | 9.6.0 M4 | |Web-UI |


