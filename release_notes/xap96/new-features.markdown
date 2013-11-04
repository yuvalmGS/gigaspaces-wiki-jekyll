---
layout: post
title:  New Features and Improvements
page_id: 61867183
---

{%summary%} New features and improvements in the XAP 9.6.X release {%endsummary%}

# Overview

Below is a list of new features and improvements in GigaSpaces 9.6.X.

# OpenSpaces

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
|GS-11362  | Add support for Mule OpenSpacesqueue connector attributes place holders          | 9.6.2   |      | | ESB, OpenSpaces |
|GS-11277 | Mule: entries are written to the space without a write lease                       | 9.6.2   | 7934 | | ESB |
|GS-11130  | Expose Space, SpaceInstance and ProcessingUnitInstance statistics within timeline | 9.6.0 M4|      | |OpenSpaces |


# API, Proxy, Server

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
|GS-11421 | Cassandra Persistency - Simplify extending implementation | 9.6.2 | | | EDS |
| GS-11350 | Add support for "<>" in the Cassandra space data source | 9.6.2 | 8298 | | EDS |
| GS-11242 | Server execution aspect doesn't expose the invoked Method | 9.6.1 | | | API |
|GS-11100 | Deprecate - Notify Container communication type | 9.6.0 M2 | | |API Events |
|GS-11092 | Allowing user to configure a space to reject replicated operation it the required consistency level cannot be maintained. | 9.6.0 M2 | | |API Replication |
|GS-11107 | provide timeout for writeMultiple (in the same sense as for single write) | | | |Engine |
|GS-11093 | Configurable property to disable explicit gc call before throwing memory shortage exception | 9.6.0 M2 | | |Engine |
|GS-11104 | Deprecate - NOTIFY_ALL modifier | 9.6.0 M2 |7999 | |Events |
|GS-11055 | Allow to configure LRMI filters (SSL, ZIP) to be used on specific addresses only | 9.6.0 M2 | | |LRMI |
|GS-11086 | Query engine optimizations for OR \ AND queries | 9.6.0 M2 |7978 | |SQL Query |
|GS-11129 | allow multiple selections (ands) on the same collection item | 9.6.0 M4 | | |Engine |
|GS-11107 | provide timeout for writeMultiple (in the same sense as for single write) | 9.6.0 M4 | | |Engine |


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


