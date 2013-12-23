---
layout: post
title:  New Features and Improvements
categories: RELEASE_NOTES
parent: xap97.html
weight: 200
---

{%summary%} New features and improvements in the XAP 9.7.X release {%endsummary%}

## Overview

Below is a list of new features and improvements in GigaSpaces 9.7.X.


{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link| Platform/s
|:--|:------|:------------|:------------|:-----------------|:----------|
| GS-23    | LINQ Support - allow to query the space using Linq | 9.7.0 | | | .NET |
| GS-8601  | Identifying clients that are using an old version of a POJO class | 9.7.0 | 6424 | | All |
| GS-9362  | GCS/LUS/GSM inherits COMPONENT_OPTIONS from GSA -relay on order of parameter | 9.7.0 | 6777, 8011 | | All |
| GS-9785  | Add support for escaping reserved words when queried | 9.7.0 | 7141 | | All |
| GS-10590 | Protect from writing object to space without an ID | 9.7.0 | | | Java, .NET |
| GS-10888 | Enhance LRMI watchdog to close hanged connection when it can decide with high guarantee the response will never come | 9.7.0 | | | All |
| GS-11208 | Projection support for nested paths | 9.7.0 | | | Java,.NET |
| GS-11213 | Add GigaSpacesRuntime.shutdown() API which destroys GigaSpaces runtime while being hosted outside the service grid | 9.7.0 | 8151 | | Java |
| GS-11232 | Display used lookup group and locator in XAP web-ui after login | 9.7.0 | | | All |
| GS-11242 | Server execution aspect doesn't expose the invoked Method | 9.6.1,9.7.0 | 8102 | | Java |
| GS-11246 | GS-UI should resolve custom security paramters | 9.6.1,9.7.0 | 7904 | | All |
| GS-11250 | Seperate SpaceTask execution to a seperate thread pool from other operations | 9.7.0 | | | Java,.NET |
| GS-11252 | Improve XAP.NET configuration to support multiple GSA configurations | 9.6.1,9.7.0 | | | .NET |
| GS-11253 | unique index support | 9.7.0 | | | Java,.NET |
| GS-11262 | Upgrade Spring (not including security) to 3.2.4 | 9.7.0 | | | Java |
| GS-11270 | Allow to designate a zone for primary instances and zone for backup instances | 8_0_5_patch1,9.7.0 | | | All |
| GS-11271 | GSM to deploy primaries to designated zone | 9.7.0 | | | All |
| GS-11272 | Management Processing Unit which relocates primary instances to correct zone during runtime | 9.7.0 | | | All |
| GS-11277 | Mule: entries are written to the space without a write lease | 9.7.0,9_5_2_patch3,9_6_2 | 00007934 | | Java |
| GS-11293 | SpaceAddedEventManager interface should have options to add listener that does not include existing spaces | 9.7.0 | | | Java |
| GS-11297 | Add CREATE security privilege which allows only writing new objects to the space | 9.7.0 | | | All |
| GS-11298 | com.gigaspaces.license logger at level config will print where the license key was taken from. | 9.7.0 | | | All |
| GS-11299 | Multiplex event session management enhancements | 9.7.0 | | | All |
| GS-11302 | Block users deploying a Mirror using a cluster schema | 9.7.0 | | | All |
| GS-11308 | Add GigaSpace.newDataEventSession() to simplify data event session creation | 9.7.0 | | | Java |
| GS-11309 | Deprecation - EventSessionFactory (use GigaSpace.newDataEventSession() instead) | 9.7.0 | | | Java |
| GS-11311 | Expose PID and host in LRMIProxyMonitoringDetails | 9.7.0 | | | Java |
| GS-11324 | The ESM cannot start in secure mode | 9.7.0,9_5_0_patch3 | 8254 | | Java |
| GS-11338 | LrmiNoSuchObjectException is logged repeatedly after restart/rellocation | 9.7.0 | | | All |
| GS-11343 | Enhanced XAP.NET installer to include VC runtime files required by JDK7 | 9.6.1,9.7.0 | | | .NET |
| GS-11348 | ESM to disable GSA failure detection on demand | 9.7.0 | | | Java |
| GS-11350 | Add support for "<>" in the Cassandra space data source | 9.7.0,9_6_1_patch1,9_6_2 | 8298 | | Java |
| GS-11362 | Add support for Mule OpenSpaces queue connector attributes place holders | 9.7.0,9_5_2_patch3,9_6_2 | | | Java |
| GS-11363 | Simplify bin folder in XAP | 9.7.0 | | | Java |
| GS-11378 | Expose the change operation affect on ChangeResult if required | 9.7.0 | | | Java |
| GS-11403 | Change Extension - simplified addAndGet operation | 9.7.0 | | | Java,.NET |
| GS-11404 | Change data events default com type from unicast to multiplex | 9.7.0 | | | All |
| GS-11405 | Deprecation - Data events communication type | 9.7.0 | | | All |
| GS-11406 | Deprecation - custom lease for data event listeners | 9.7.0 | | | All |
| GS-11417 | Add 'version' command to CLI | 9.7.0 | | | All |
| GS-11427 | Update documentation in /lib/readme.txt to be same as in wiki | 9.7.0 | 8357 | | Java |
| GS-11428 | Expose IProcessingUnit.UndeployAndWait API in .NET | 9.7.0 | | | .NET |
| GS-11453 | Allow to configure web-ui client disconnection time | 9.7.0 | | | Java |
| GS-11471 | Update XAP.NET bundled JDK to Oracle 7 update 45 | 9.7.0 | | | .NET |
| GS-11474 | Add protective mode which prevents user error by querying with templates that has no null values | 9.7.0 | | | All |
| GS-11477 | Add protective mode which prevents user error by querying with templates that has no null values | 9.7.0 | | | All |
| GS-11480 | Add system property to determine whether DateTime values read from the space should be converted from UTC to local time | 9.7.0 | 8471 | | .NET |
| GS-11493 | Enhance EventTemplate attribute to support method with ISpaceProxy argument | 9.7.0 | | | .Net |
| GS-11494 | Add ISpaceProxy.GetServerAdmin().GetClusteredProxy() | 9.7.0 | | | .Net |
| GS-11495 | Deprecation - notify auto-renew with custom arguments | 9.7.0 | | | All |
| GS-11539 | Web-ui should expose reconnect option | 9.7.0 | | | Java |
| GS-11526 | Provide capability of automatic thread dump generation upon LRMI critical resource level warning | 9.7.0 | | | All |
| GS-11516 | Remove GSM and GSC windows service wrapper in XAP.NET | 9.7.0 | | | .NET |
| GS-11515 | Change XAP.NET setup wizard default from both .NET 2.0 and 4.0 to 4.0 only | 9.7.0 | | | .NET |
| GS-11514 | Add strongly typed API for creating local cache in XAP.NET | 9.7.0 | | | .NET |
