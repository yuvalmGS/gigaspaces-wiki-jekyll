---
layout: post
title:  New Features and Improvements
categories: RELEASE_NOTES
parent: xap100.html
weight: 200
---

{%comment%}
{%summary%} New features and improvements in the XAP 10.0.X release {%endsummary%}

## Overview
{%endcomment%}

Below is a list of new features and improvements in GigaSpaces 10.0.X.


{: .table .table-bordered}
| Key | Summary | Fixed in Version | SalesForce ID | Documentation Link | Platform/s
|:--|:------|:------------|:------------|:-----------------|:----------|
| GS-11446 | End of life IRemoteJSpaceAdmin.start/stop/restart() operations | 10.0.0 | 8407 | | All |
| GS-11549 | Remove standalone service grid launchers (GSM, GSC, LUS) from XAP.NET | 10.0.0 |  | | .NET |
| GS-11558 | Remove space container registration from lookup service | 10.0.0 | | | All |
| GS-11568 | Support user-defined change operations | 10.0.0 | | | Java |
| GS-11575 | Log Index and query statistics and status | 10.0.0 | | | All |
| GS-11593 | Web-UI: use new ProcessingUnit's method getPlannedNumberOfInstances() for proper displaying planned instances | 10.0.0 | | | Java |
| GS-11596 | Log severe messages when warning persists | 10.0.0 | 8622 | | All |
| GS-11607 | End of life - Clean .NET | 10.0.0 | | | .NET |
| GS-11609 | Log on warning level when LRMI class loading failed because it cannot create a connection to the source | 10.0.0 | | | Java |
| GS-11610 | End of life - shutting down a space from a remote proxy | 10.0.0 | | | All |
| GS-11612 | Deploy process optimization | 9.7.1, 10.0.0 | | | Java, .NET |
| GS-11620 | Simplify view-query definition in openspaces-core.xsd | 10.0.0 | | | Java |
| GS-11645 | Configure CHMAP segments for entries, default | 10.0.0 | | | Java |
| GS-11656 | Notification event triggering is moved to a custom LRMI thread pool (together with space tasks) | 10.0.0 | | | All |
| GS-11657 | Change lrmi.space-task threadpool system properties to lrmi.custom | 10.0.0 | | | All |
| GS-11666 | Pojo to Document Conversion should not convert Class,URI,Locale types | 9.7.1, 10.0.0 | | | Java |
| GS-11659 | .Net add documentation regarding types of local cache | 10.0.0 | 8740 | | .NET |
| GS-11693 | Enhance nHibernate EDS to support overriding initial load | 10.0.0 | | | .NET |
| GS-11702 | Added support for configuring a persistent space without custom code in XAP.NET | 9.7.1, 10.0.0 | | | .NET |
| GS-11706 | Added static ProcessingUnitContainer.Current to provide cluster info to any pu component | 9.7.1, 10.0.0 | | | .NET |
| GS-11710 | Simplify processing unit configuration in XAP.NET | 9.7.1, 10.0.0 | | | .NET |