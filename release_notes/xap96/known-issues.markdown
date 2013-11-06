---
layout: post
title:  Known Issues and Limitations
page_id: 61867183
---

{%summary%} Known Issues and Limitations in XAP 9.6.X release {%endsummary%}

# Overview

Below is a list of new features and improvements in GigaSpaces 9.6.X.

# OpenSpaces

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
|GS-11087 | Cannot deploy the archive application servlet.war (located in "repository\com\gigaspaces\quality\sgtest\apps\archives") in cloudify-iTests esm tests. | |9.6.0 M2 | | |Elastic PU |


# API, Proxy, Server

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11433 | "useLocalCache" in url definition result in ClassCastException after reconnecting to master space | 8385 | 8.0.5 GA | 9.7.0 | | Client |
| GS-11226 | When adding a dynamic gateway target, the backup space will throw an exception in the logs rejecting this addition | | 9.5.0 GA | | | Replication, WAN |
|GS-11122 | IPv6 addresses are parsed incorrectly in several locations throughout the system resulting in errors. | |9.6.0 M2 |9.6.0 M4 | |API |
|GS-11173 | Read operation might return null in LRU space + EDS when objects are written with limited lease | 8039 |9.6.0 RC | | |Engine |
|GS-11188 | Wrong results are returned from SQL Query and order/group by with template and projection while the group/order by filed is not part of the projection | |9.6.0 RC | | |API |
|GS-11186 | NPE is thrown when performing SQLQuery with template and projection on a primitive field and this filed is not part of the projection | |9.6.0 RC | | |API |
|GS-11203 | Client validation is missing when performing Read Multiple with SQL Query and missing parameter | |9.6.0 RC | | |API |
|GS-11204 | Replicating an extension of lease of notify template under rare circumstances may cause repetitive replication exception | |9.6.0 RC | | |Replication |
|GS-11207 | Exception is thrown when query projected result does not include primitive properties without null values | |9.6.0 RC | | |API |
|GS-11213 | Threads remaining after closing GigaSpace application | 8151 |9.6.0 RC | | |API |



# Service Grid

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
|GS-11111 | Support for IP version 6 | |9.6.0 M2 |9.6.0 M4 | |Jini Service Grid |

# C++ Specifics

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|


# .NET Specifics

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
|GS-11088 | Exception thrown when loading XAP.NET configuration in web application | |9.6.0 M2 | | |.NET |
|GS-11190 | Generate dump of a deployed application fetches empty pu.xml files in dot net builds | |9.6.0 RC | | |.NET |
|GS-11191 | .Net ReadMultiple with bad query result in class cast exception | 8122 |9.6.0 RC | | |.NET |
|GS-11194 | Using NHibernateExternalDataSource practice requires .NET 3.5 | |9.6.0 RC | | |.NET |


# Configuration, UI, CLI & Admin tools

{: .table .table-bordered}
|Key|Summary|Since Version|SalesForce ID|Documentation Link|Component/s|
|:----|:--------|:----------------|:---------------|:------------------|:----------|
 | GS-11283 | recipes repository should sort recipe alphabetically | | 9.6.1 | | | Web-UI | ||
 | GS-11285 | refactor gs-webui-test-beans | | 9.6.1 | | | Web-UI | ||
 | GS-11257 | New cloudify templates | | 9.6.1 | | | Web-UI | ||
 | GS-11256 | Widget feedback | | 9.6.1 | | | Web-UI | ||
 | GS-11282 | "uninstall" should not appear for "management" application. | | 9.6.1 | | | Web-UI | ||
 |GS-11108 | Error in startGroovy.bat file when trying to use Java 6 style wildcard for jars to be added to classpath | 8007 |9.6.0 M2 | | |Configuration |
 |GS-11121 | Change Statistics throughput is not displayed properly in GS-UI | |9.6.0 M2 | | |GS-UI |
 |GS-11113 | missing PUs from UI | |9.6.0 M2 | | |Web-UI |
 |GS-11116 | Data Replication and External Data Source is XAP only data, but displayed in Cloudify | |9.6.0 M2 | | |Web-UI |
 |GS-11189 | Openning logs window from Hosts tab of WebUI throws an exception | |9.6.0 RC | | |Web-UI |
 |GS-11184 | WebUI: The "Log Level" is not "ANDed" to search query while querying logs | |9.6.0 RC | | | Web-UI |
 |GS-11193 | Running query from GS_UI with custom security enabled throws SQLException | 7904 |9.6.0 RC | | |GS-UI |
 |GS-11200 | In XAP webui the icon of pu instance actions in applications->services disappears when moving the mouse on it and then moving it away. | |9.6.0 RC | | |Web-UI |

