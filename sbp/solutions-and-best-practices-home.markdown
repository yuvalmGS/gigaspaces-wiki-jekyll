---
layout: sbp
title:  Solutions and Best Practices Home
categories: SBP
page_id: 48236956
---

{% section %}

{% column width=70% %}

This section contains GigaSpaces usage patterns, best practices and solutions. Each best practice is listed with the author/origin, and the GigaSpaces product version that it was tested against.

{% toc minLevel=1|maxLevel=1|type=flat|separator=pipe %}


# Data Access Patterns
|| Best Practice || Level || Description||
|depanlinkMoving from Hibernate to Spacetengahlink./moving-from-hibernate-to-space.htmlbelakanglink | Beginner | Moving from Database Centric into In-Memory Model. Can be used when moving from **J2EE Session Bean** into XAP.|
|depanlinkFinding Partition Loadtengahlink./finding-partition-load.htmlbelakanglink| Beginner | Monitoring Data Grid partitions in real time.|
|depanlinkEven Data Distributiontengahlink./even-data-distribution.htmlbelakanglink| Beginner | Technique to ensure even data load-balancing with partitioned IMDG.|
|depanlinkSpace Object Modelingtengahlink./space-object-modeling.htmlbelakanglink| Beginner | Migrating Relational Model into Object model.|
|depanlinkExcel that Scales Solutiontengahlink./excel-that-scales-solution.htmlbelakanglink| Beginner | Leveraging GigaSpaces .Net API to scale Excel applications.|
|depanlinkGlobal ID Generatortengahlink./global-id-generator.htmlbelakanglink| Beginner | Replacing Database sequencing with lightweight In-Memory ID Generator.|
|depanlinkWeb Service PUtengahlink./web-service-pu.htmlbelakanglink|Beginner | Web Service Processing Unit. Using the CXF Framework.|
|depanlinkODBC Drivertengahlink./odbc-driver.htmlbelakanglink| Beginner | Accessing GigaSpaces Data Grid via 3rd party ODBC Driver.|
|depanlinkIMDG with Large Backend Database Supporttengahlink./imdg-with-large-backend-database-support.htmlbelakanglink| Advanced | Leveraging IMDG running in LRU mode with large backend Database.|
|depanlinkDynamic Polling Container Templates using TriggerOperationHandlertengahlink./dynamic-polling-container-templates-using-triggeroperationhandler.htmlbelakanglink| Advanced | Polling Containers using TriggerOperationHandler |
|depanlinkCustom Matchingtengahlink./custom-matching.htmlbelakanglink| Advanced | Implementing complex customized queries for pattern matching.|
|depanlinkCustom Evictiontengahlink./custom-eviction.htmlbelakanglink| Advanced | Implementing used defined data eviction when using large backend Database.|
|depanlinkLowering the Space Object Footprinttengahlink./lowering-the-space-object-footprint.htmlbelakanglink| Advanced | Implementing compaction API to reduce the object footprint when storing objects with large numeric values.|
|depanlinkRapid Data Loadtengahlink./rapid-data-load.htmlbelakanglink| Advanced | Loading large amount of data into each partition using Map-Reduce technique.|
|depanlinkSchema Evolutiontengahlink./schema-evolution.htmlbelakanglink| Advanced | Leveraging different techniques to enhance the application data model without IMDG downtime.|
|depanlinkMongoDB External DataStoretengahlink./mongodb-external-datastore.htmlbelakanglink|Advanced| MongoDB External Data Source with Mirror Service implementation. |
|depanlinkScala Integrationtengahlink./scala-integration.htmlbelakanglink | Advanced| Common Scala integration scenarios on top of XAP. |

# Parallel Processing & Messaging Patterns
|| Best Practice || Level || Description||
|depanlinkMap-Reduce Pattern - Executors Exampletengahlink./map-reduce-pattern---executors-example.htmlbelakanglink| Beginner | Implementing Task Executors and Service Executors to perform parallel queries or parallel processing across multiple IMDG partitions. Can be used when moving from **J2EE EJB**/RMI/IIOP into XAP.|
|depanlinkMaster-Worker Patterntengahlink./master-worker-pattern.htmlbelakanglink| Beginner | Grid computing pattern. Implementing distributed processing across multiple workers deployed into the Grid. |
|depanlinkEvent Driven Remoting Exampletengahlink./event-driven-remoting-example.htmlbelakanglink| Beginner | Request-Response pattern. Implementing asynchronous remove service invocation. Can be used when moving from **J2EE MDB** into XAP.|
|depanlinkMule ESB Exampletengahlink./mule-esb-example.htmlbelakanglink| Advanced | Scaling ESB based application. Using the IMDG as the ESB state repository. Deploying the ESB into the GigaSpaces grid allowing it to scale in an elastic manner.|
|depanlinkPriority Based Queuetengahlink./priority-based-queue.htmlbelakanglink| Advanced | Messaging based pattern. Can be used when moving from **J2EE JMS** Quality of Service into XAP.|
|depanlinkParallel Queue Patterntengahlink./parallel-queue-pattern.htmlbelakanglink| Advanced |Messaging based pattern. Can be used when moving from **J2EE JMS Service Activator Aggregator Strategy/MDB** into XAP.|
|depanlinkUnit Of Worktengahlink./unit-of-work.htmlbelakanglink| Advanced |Messaging based pattern. Can be used when moving from **J2EE JMS** Unit of Order into XAP.|
|depanlinkDrools Rule Engine Integrationtengahlink./drools-rule-engine-integration.htmlbelakanglink| Advanced | Scaling business rule management system based application.|
|depanlinkSpring Batch PUtengahlink./spring-batch-pu.htmlbelakanglink| Advanced | Complex Batch Processing using depanlinkSpring Batchtengahlinkhttp://static.springsource.org/spring-batchbelakanglink.|
|depanlinkJTA-XA Exampletengahlink./jta-xa-example.htmlbelakanglink | Advanced | Integrating GigaSpaces with an external JMS Server using XA. Atomikos is used as the JTA Transaction provider. Apache ActiveMQ is used as a the JMS provider.|

# Setup Production Environment
|| Best Practice || Level ||Description||
|depanlinkEmbedding XAP for OEMstengahlink./embedding-xap-for-oems.htmlbelakanglink| Beginner | A quick and simple example of how an OEM might embed GigaSpaces XAP for customer use.|
|depanlinkUniversal Deployertengahlink./universal-deployer.htmlbelakanglink |Beginner | Allows deploying composite applications. Support multiple processing unit dependency based deployment.|
|depanlinkData-Collocation Deployment Topologytengahlink./data-collocation-deployment-topology.htmlbelakanglink| Beginner | Considerations which topology to choose when deploying both business logic and data into the Grid.|
|depanlinkMirror Monitortengahlink./mirror-monitor.htmlbelakanglink| Beginner | Monitoring asynchronous persistency behavior in real time using JMX.|
|depanlinkSafe Grid Shutdowntengahlink./safe-grid-shutdown.htmlbelakanglink| Beginner | Cleanly shutting down the grid after all async replication operations are committed.|
|depanlinkHyperic integrationtengahlink./hyperic-integration.htmlbelakanglink| Beginner | Hyperic monitoring integration example.|
|depanlinkClusters Over WANtengahlink./wan-replication-gateway.htmlbelakanglink| Beginner | Example for WAN replication implementation.|
|depanlinkWAN Gateway Pass Through Replicationtengahlink./wan-gateway-pass-through-replication.htmlbelakanglink| Beginner | Example for implementing a pass through WAN replication topology.|
|depanlinkWAN Gateway Master Slave Replicationtengahlink./wan-gateway-master-slave-replication.htmlbelakanglink| Beginner | Example for implementing a single-master/multi-slave replication topology.|
|depanlinkPrimary-Backup Zone Controllertengahlink./primary-backup-zone-controller.htmlbelakanglink|Beginner | Using Zones to control Data-Grid primary/backup instances location.|
|depanlinkRESTful Admin APItengahlinkhttp://www.openspaces.org/display/RES/Project+Documentationbelakanglink| Beginner | Using web services to monitor and administrate GigaSpaces.|
|depanlinkJMX Space Statisticstengahlink./jmx-space-statistics.htmlbelakanglink| Beginner | Using JMX to expose space statistics.|
|depanlinkSpace Dump and Reloadtengahlink./space-dump-and-reload.htmlbelakanglink| Beginner | Using the administration API to dump the space data into a file and reload it back.|
|depanlinkScaling Agenttengahlink./scaling-agent.htmlbelakanglink| Beginner | Using the administration API to scale web applications. Can be used when moving **J2EE Web applications** into XAP elastic Web Container.|
|depanlinkWeb Load Balancer Agent PUtengahlink./web-load-balancer-agent-pu.htmlbelakanglink| Advanced | Using the administration API to build customized HTTP load-balancer agent. Can be used when moving **J2EE Web applications** into XAP elastic Web Container.|
|depanlinkMoving into Production Checklisttengahlink./moving-into-production-checklist.htmlbelakanglink| Advanced | All what you need to review before moving your system into production.|
|depanlinkCapacity Planningtengahlink./capacity-planning.htmlbelakanglink| Advanced | Considerations for sizing your system before moving into production.|
|depanlinkRefreshable Business Logic Exampletengahlink./refreshable-business-logic-example.htmlbelakanglink| Advanced | Using the administration API to reload new application code (hot deploy) while the application is running.|

# Solutions
|| Best Practice || Level ||Description||
|depanlinkElastic Distributed Calculation Enginetengahlink./elastic-distributed-calculation-engine.htmlbelakanglink|Advanced| Elastic Distributed Calculation Engine implementation using Map-Reduce approach.|
|depanlinkTrading Settlementtengahlink./trading-settlement.htmlbelakanglink |Advanced| A trading settlement system where the entire tier-based architecture is built on GigaSpaces.|
|depanlinkMainframe Integrationtengahlink./mainframe-integration.htmlbelakanglink |Advanced| GigaSpaces XAP can simplify the migration effort from mainframe based systems and reduce the cost of the legacy applications. GigaSpaces XAP act as a front-end layer for mainframe based systems may boost the system performance and improve the overall system response time on peak load.|
|depanlinkGlobal Http Session Sharingtengahlink./global-http-session-sharing.htmlbelakanglink|Advanced| Global HTTP Session Sharing allows transparent session replication between remote sites and sharing between different application servers in real-time.|
|depanlinkObservable WANtengahlink./observable-wan.htmlbelakanglink|Advanced|Monitor and measure the replication performance of a multi-site deployment.|

{% endcolumn %}


{% column %}


#### Quick Links

##### • depanlink9.6.X Release Notestengahlinkhttp://wiki.gigaspaces.com/wiki/display/RN/GigaSpaces+XAP+9.6.X+Release+Notesbelakanglink

##### • depanlinkWhat's new in XAP 9.6.Xtengahlinkhttp://wiki.gigaspaces.com/wiki/display/RN/What's+New+in+GigaSpaces+9.6.Xbelakanglink

##### • depanlinkAPI Documentationtengahlinkhttp://wiki.gigaspaces.com/wiki/display/API/API+Documentation+Portalbelakanglink

##### • depanlinkSolutions and Best Practices Hometengahlink/sbp/index.htmlbelakanglink

##### • depanlinkForumtengahlinkhttp://ask.gigaspaces.org/belakanglink

##### • depanlinkDownloadstengahlinkhttp://www.gigaspaces.com/LatestProductVersionbelakanglink

##### • depanlinkBlogtengahlinkhttp://blog.gigaspaces.com/belakanglink

##### • depanlinkWhite Paperstengahlinkhttp://www.gigaspaces.com/os_papers.htmlbelakanglink

##### • Looking for **depanlinkXAP.NETtengahlinkhttp://wiki.gigaspaces.com/wiki/display/XAP96NET/XAP.NET+9.6+Documentation+Homebelakanglink** or **[other versions|ALL:Choose a GigaSpaces Version]**?


{% endcolumn %}

{% endsection %}
