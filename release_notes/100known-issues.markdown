---
layout: post
title:  Known Issues and Limitations
categories: RELEASE_NOTES
parent: xap100.html
weight: 400
---


Below is a list of known issues in GigaSpaces 10.0.X.


{: .table .table-bordered}
| Key | Summary | SalesForce ID | Since version | Workaround | Platform/s
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11589 | Not all threads are terminated when destroying UrlSapceContainer | | 10.0.0 | | All |
| GS-11595 | Running Web-ui for long period can cause in certain conditions OOM due to too many threads | 8600 | 10.0.0 | | Java |
| GS-11622 | Web-ui shows wrong instance count with replic | | 10.0.0 | | All |
| GS-11626 | Failed to deploy data example using secured space | | 10.0.0 | | Java |
| GS-11629 | sla.xml has side effect on spring import | 8597 | 10.0.0 | | Java |
| GS-11632 | NPE using DefaultSpaceInstance.runGc() when discoverUnmanagedSpaces used | 8587 | 10.0.0 | | All |
| GS-11634 | Redundant apostrophes in the GS_JARS variable in setenv.bat | | 10.0.0 | | Java |
| GS-11635 | Gigaspaces's jars missing from the classpath in startGroovy and startGroovy.bat | | 10.0.0 | | Java |
| GS-11636 | problem deploying JPA pet clinic example petclinic-web | | 10.0.0 | | Java |
| GS-11646 | Running a query with nested projection from Web-ui fails | | 10.0.0 | | All |
| GS-11647 | "Create" Permission wasn't added in GS-ui | 8758 | 10.0.0 | | All |
| GS-11654 | .Net localCache freeze on a clear operation in rare condition | 8740 | 10.0.0 | | .NET |
| GS-11660 | Bug in Linq - Parameters are valid only on the right side of the expression | | 10.0.0 | | .NET |
| GS-11670 | .Net- Enum does not work in change api | 8739 | 10.0.0 | | .NET |
| GS-11675 | Setting spaceDataSource should not move the space to LRU cache policy | | 10.0.0 | | All |
| GS-11679 | Admin statistics history size overridden with default value | | 10.0.0 | | Java |
| GS-11682 | Web-UI: After running and terminating gs-agent, gsa is displayed for about one minute under Hosts | | 10.0.0 | | .NET |
| GS-11695 | MongoDB SynchronizationEndpoint- NPE when storing a map that contains a null value for a non null key | | 10.0.0 | | Java |
| GS-11697 | MongoDB-Incorrect return value in DataSyncOperation.getDataAsDocument() for duble | | 10.0.0 | | All |
| GS-11698 | Cannot override java.security.policy system property | | 10.0.0 | | Java |
| GS-11701 | RESTData cannot handle Array | | 10.0.0 | | All |
| GS-11703 | .NET code is not CLS-Compliant | | 10.0.0 | | .NET |
| GS-11707 | Remove option to select persistent schema from the deploy dialog | | 10.0.0 | | All |
| GS-11708 | Web UI missing features | | 10.0.0 | | All |
| GS-11709 | Cache miss stats when running in LRU | | 10.0.0 | | All |
| GS-11711 | NPE in ESM destroy in rare condition | | 10.0.0 | | ALL |
| GS-11712 | ESM is stuck in a processing loop although the applications have been uninstalled due to unexpected exception | | 10.0.0 | | All |
| GS-11714 | XAP.NET Default.config max/min heap size | | 10.0.0 | | .NET |
| GS-11715 | Change GS UI Query default limit to 100 | | 10.0.0 | | All |
| GS-11716 | Rename XAP.NET GigaSpaces.NetToJava.dll and GigaSpaces.Jav | | 10.0.0 | | .NET |