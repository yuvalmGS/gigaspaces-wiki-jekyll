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
| GS-11615 | SpaceDataSourceSplitter#initialMetadataLoad might causes NPE | 8655 | 10.0.0 | | All |
| GS-11619 | Fix instalation scripts in windows | | 10.0.0 | | All |
| GS-11622 | web UI shows wrong instance count with replicated cluster | | 10.0.0 | | All |
| GS-11625 | XAP fail to run on IBM jdk6.0.0.435 | 8639 | 10.0.0 | | Java |
| GS-11626 | Failed to deploy data example using secured space | | 10.0.0 | | Java |
| GS-11629 | sla.xml has side effect on spring import | 8597 | 10.0.0 | | Java |
| GS-11632 | NPE using DefaultSpaceInstance.runGc() when discoverUnmanagedSpaces used | 8587 | 10.0.0 | | All |
| GS-11633 | Add Multi thread support to XAResourceImpl | 8698 | 10.0.0 | | All |
| GS-11634 | Redundant apostrophes in the GS_JARS variable in setenv.bat | | 10.0.0 | | Java |
| GS-11635 | Gigaspaces's jars missing from the classpath in startGroovy and startGroovy.bat | | 10.0.0 | | Java |
| GS-11635 | Gigaspaces's jars missing from the classpath in startGroovy and startGroovy.bat | | 10.0.0 | | Java |
| GS-11636 | problem deploying JPA pet clinic example petclinic-web | | 10.0.0 | | Java |
| GS-11640 | Installmavenrep.bat fails because POMGenerator doesn't generate mongo-datasource pom | | 9.7.0 | | Java |
| GS-11646 | Running a query with nested projection from web-ui fails | | 10.0.0 | | All |
| GS-11647 | "Create" Permission wasn't added in GS_UI | | 10.0.0 | | All |