---
layout: post
title:  Resolved Issues
categories: RELEASE_NOTES
parent: xap100.html
weight: 300
---


Below is a list of issues that have been fixed in GigaSpaces 10.0.X.



{: .table .table-bordered .table-condensed}
| Key | Summary | Version | Sales Force ID | Platform/s |
|:---------|:--------|:----------------|:---------------|:------------------|
| <nobr>GS-11505</nobr> | StandaloneProcessingUnitContainerProvider#close() raise Interruption that cause problems in unit tests | 10.0.0 | 8518 | Java |
| GS-11536 | LRMI threads cause JVM-wide slowdown with parallel reads | 10.0.0 | 8527 | Java |
| GS-11561 | Reading a POJO which contains a document using mongo EDS fails | 9.7.1, <br>10.0.0 |  | Java |
| GS-11587 | Concurrency bug in LRU/Off-heap - unpin is called when entry not locked when ifExists waiting templates removed | 10.0.0 | | All |
| GS-11606 | Deterministic Deployment is not working on secured grid | 10.0.0 | 8642 | All |
| GS-11615 | SpaceDataSourceSplitter#initialMetadataLoad might causes NPE | 9.7.1, <br>10.0.0 | 8655 | All |
| GS-11616 | ReadModifiers missing default constructor | 9.7.1,<br> 10.0.0 | 8657 | Java |
| GS-11619 | Fix installmavenrep.bat script in windows | 9.7.1,<br> 10.0.0 |  | All |
| GS-11631 | PrimaryZoneController.afterPropertiesSet() throws NullPointerException | 10.0.0 | | Java |
| GS-11633 | Add Multi thread support to XAResourceImpl | 10.0.0 | 8698 | Java |
| GS-11640 | Installmavenrep.bat fails because POMGenerator doesn't generate mongo-datasource pom | 9.7.1,<br> 10.0.0 |  | Java |
| GS-11641 | Default Notifications may not consume all concurrent resources when it could have | 9.7.0 patch3, 10.0.0 | 8635 | All |
| GS-11651 | Web-ui: NumberFormatException thrown while parsing cpu values for specific Local values | 9.7.1,<br> 10.0.0 |  | Java |
| GS-11652 | Calendar instance is not formatted nicely in GS-ui query results | 9.7.1,<br> 10.0.0 | | Java |
| GS-11661 | Using enums with Linq throws an exception | 9.7.1, <br>10.0.0 | | .NET |
| GS-11664 | AccessDeniedException in write only operation - when using role including WRITE permission | 9.7.1, <br>10.0.0, <br>9.7.0 patch2 | 8757 | All |
| GS-11667 | Storing http-sessions in the space is broken | 10.0.0 |  | Java |
| GS-11668 | Jetty shared mode doesn't work | 10.0.0 | | Java |
| GS-11670 | Change does not support enums in XAP.NET | 10.0.0 | 8739 | .NET |
| GS-11681 | Ping cli command does not work | 9.7.1,<br> 10.0.0 | | Java |
| GS-11686 | CLI don't alert when a wrong parameters is used | 10.0.0 | | All |
| GS-11689 | Protective mode primitiveWithoutNullValue is thrown from replication | 9.7.1,<br> 10.0.0 | 8808 | All |
| GS-11690 | Linq expressions without where clause throw exception | 9.7.1,<br> 10.0.0 | | .NET |
| GS-11704 | Queries with empty ranges IndexOutOfBoundsException | 9.7.1,<br> 10.0.0 | 8894 | All |
| GS-11717 | XAP benchmark fails on primitiveWithoutNullValue protective mode | 9.7.1,<br> 10.0.0 |  | All |
| GS-11732 | Disributed transaction over multiple clusters might cause consolidations problems | 10.0.0 | 8935 | All |
| GS-11736 | Can't see space in gs-ui when running XAP 9.7.1 gsInstance.bat when using jdk 7u55 | 10.0.0, <br>9.7.2 |  | Java |
| GS-11739 | Benchmark Write using batches writes actually only part of expected objects | 9.7.1,<br> 10.0.0 |  | Java |
| GS-11740 | Duplicate lease renewal in MapCache | 8_0_5_patch1, 10.0.0 | 8815 | Java |
| GS-11748 | LRU space with no EDS partitioned-sync2backup might face version conflict that will lead to replication error and increase redolog | 9.1.0 patch3,<br> 10.0.0 | 8962 | All |
| GS-11761 | Expose query execution time in web-ui | 10.0.0 | 8962 | Java |
| GS-11826 | Management tools do not display properly blob store setting immediately after deployment | 10.0.0 |  | Java |
| GS-11837 | NPE thrown in gs-ui when clicked on empty space in Inspector dialog tree | 10.0.0 |  | Java |
| GS-11840 | GS-UI throws LRMINoSuchObjectException when undeploying PlainWebAppExample | 10.0.0 |  | Java |
| GS-11841 | Undeploy application option should not be exposed in XAP for "Unassigned Services" | 10.0.0 |  | Java |
| GS-11856 | XAP 10 blobstore RPM hangs when installing | 10.1.0, 10.0.1  |  | All |
| GS-11936 | Backwards compatibility issue: NPE is thrown when the client version is less then 10.0 and the server version is 10.0 | 10.1.0, 10.0.1 | 9182  | All |
| GS-11950 | Blobstore.rpm install hang | 10.1.0, 10.0.1 |  | All |
| GS-11962 | In .NET when BasicContainer element is missing from pu.config we got System.NullReferenceException | 10.1.0, 10.0.1 | 9201  | .NET |