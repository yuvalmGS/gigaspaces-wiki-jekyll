---
layout: post
title:  Known Issues and Limitations
categories: RELEASE_NOTES
parent: xap100.html
weight: 400
---


Below is a list of known issues in GigaSpaces 10.0.X.


{: .table .table-bordered .table-condensed}
| Key | Summary | SalesForce ID | Since version | Workaround | Platform/s
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11589 | Not all threads are terminated when destroying UrlSapceContainer | | 10.0.0 | | All |
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
| GS-11675 | Setting spaceDataSource should not move the space to LRU cache policy | | 10.0.0 | | All |
| GS-11679 | Admin statistics history size overridden with default value | | 10.0.0 | | Java |
| GS-11682 | Web-UI: After running and terminating gs-agent, gsa is displayed for about one minute under Hosts | | 10.0.0 | | .NET |
| GS-11695 | MongoDB SynchronizationEndpoint- NPE when storing a map that contains a null value for a non null key | | 10.0.0 | | Java |
| GS-11697 | MongoDB-Incorrect return value in DataSyncOperation.getDataAsDocument() for duble | | 10.0.0 | | All |
| GS-11698 | Cannot override java.security.policy system property | | 10.0.0 | | Java |
| GS-11701 | RESTData cannot handle Array | | 10.0.0 | | All |
| GS-11711 | NPE in ESM destroy in rare condition | | 10.0.0 | | ALL |
| GS-11712 | ESM is stuck in a processing loop although the applications have been uninstalled due to unexpected exception | | 10.0.0 | | All |
| GS-11719 | gigaspace.getTypeManager().getTypeDescriptor(type) returns the outdated type descriptor from the server | | 10.0.0 | | Java |
| GS-11720 | GS-UI: Hidden progressbar in relocation window | | 10.0.0 | | Java |
| GS-11727 | com.gigaspaces.management.space.SpaceQueryDetails JavaDoc missing | | 10.0.0 | | Java |
| GS-11728 | Syntax error message in DotNetException.java class | 8927 | 10.0.0 | | Java, .NET |
| GS-11732 | Disributed transaction over multiple clusters might cause consolidations problems | 8935 | 10.0.0 | | All |
| GS-11736 | Can't see space in gs-ui when running gsInstance.bat when using jdk 7u55 | | 10.0.0 | | Java |
| GS-11744 | Decreasing the height of the EDG window hides content and does not show scroll-bar | | 10.0.0 | | All |
| GS-11767 | Opening the Types tab under Data Grids throws an exception that is not catched in the webui | | 10.0.0 | | All |
| GS-11768 | Warning message as a result of using deprecated setAutoRenew(boolean , LeaseListener , long , long, long) method | | 10.0.0 | | Java |
| GS-11773 | ClassCastException thrown during deployment |  | 10.0.0 | | Java |
| GS-11774 | Got SQLQueryException when using rownum < ? | 8992 | 10.0.0 | | .NET |
| GS-11775 | NPE - when trying to resolve certain split brain scenario | 9032 | 10.0.0 | | All |
| GS-11776 | Fix Shutdown API to close custom thread pool and client connection | 9052 | 10.0.0 | | All |
| GS-11777 | Watchdog should stop monitoring once the server returned a result | 9031 | 10.0.0 | | All |
| GS-11780 | Severe message in the log after killing GSA in some scenarios | 9056 | 10.0.0 | | All |
| GS-11793 | jboss should have the dependency in test scope only | 9089 | 10.0.0 | | Java |
| GS-11820 | Fix pom.xml & WIKI to work with 9.7 RELEASE instead of SNAPSHOT | 9094 | 10.0.0 | | Java |
| GS-11822 | NPE in replicating change in rare condition | 9097 | 10.0.0 | | All |
| GS-11824 | Fail to shutdown GSC due to recovery thread that hang on socket trying to load class | 9081 | 10.0.0 | | All |
| GS-11825 | Got never ended SpaceMetadataException in the logs when adding index to an unregistered type | 9044 | 10.0.0 | | java |
| GS-11826 | Management tools do not display properly blob store setting immediately after deployment |  | 10.0.0 | | Java |