---
layout: sbp
title:  Solutions and Best Practices Home
categories: SBP
page_id: 48236956
---

{section}
{column:width=70%}
This section contains GigaSpaces usage patterns, best practices and solutions. Each best practice is listed with the author/origin, and the GigaSpaces product version that it was tested against.
{toc:minLevel=1|maxLevel=1|type=flat|separator=pipe}

# Data Access Patterns
|| Best Practice || Level || Description||
|[Moving from Hibernate to Space] | Beginner | Moving from Database Centric into In-Memory Model. Can be used when moving from *J2EE Session Bean* into XAP.|
|[Finding Partition Load]| Beginner | Monitoring Data Grid partitions in real time.|
|[Even Data Distribution]| Beginner | Technique to ensure even data load-balancing with partitioned IMDG.|
|[Space Object Modeling]| Beginner | Migrating Relational Model into Object model.|
|[Excel that Scales Solution]| Beginner | Leveraging GigaSpaces .Net API to scale Excel applications.|
|[Global ID Generator]| Beginner | Replacing Database sequencing with lightweight In-Memory ID Generator.|
|[Web Service PU]|Beginner | Web Service Processing Unit. Using the CXF Framework.|
|[ODBC Driver]| Beginner | Accessing GigaSpaces Data Grid via 3rd party ODBC Driver.|
|[IMDG with Large Backend Database Support]| Advanced | Leveraging IMDG running in LRU mode with large backend Database.|
|[Dynamic Polling Container Templates using TriggerOperationHandler]| Advanced | Polling Containers using TriggerOperationHandler |
|[Custom Matching]| Advanced | Implementing complex customized queries for pattern matching.|
|[Custom Eviction]| Advanced | Implementing used defined data eviction when using large backend Database.|
|[Lowering the Space Object Footprint]| Advanced | Implementing compaction API to reduce the object footprint when storing objects with large numeric values.|
|[Rapid Data Load]| Advanced | Loading large amount of data into each partition using Map-Reduce technique.|
|[Schema Evolution]| Advanced | Leveraging different techniques to enhance the application data model without IMDG downtime.|
|[MongoDB External DataStore]|Advanced| MongoDB External Data Source with Mirror Service implementation. |
|[Scala Integration] | Advanced| Common Scala integration scenarios on top of XAP. |

# Parallel Processing & Messaging Patterns
|| Best Practice || Level || Description||
|[Map-Reduce Pattern - Executors Example]| Beginner | Implementing Task Executors and Service Executors to perform parallel queries or parallel processing across multiple IMDG partitions. Can be used when moving from *J2EE EJB*/RMI/IIOP into XAP.|
|[Master-Worker Pattern]| Beginner | Grid computing pattern. Implementing distributed processing across multiple workers deployed into the Grid. |
|[Event Driven Remoting Example]| Beginner | Request-Response pattern. Implementing asynchronous remove service invocation. Can be used when moving from *J2EE MDB* into XAP.|
|[Mule ESB Example]| Advanced | Scaling ESB based application. Using the IMDG as the ESB state repository. Deploying the ESB into the GigaSpaces grid allowing it to scale in an elastic manner.|
|[Priority Based Queue]| Advanced | Messaging based pattern. Can be used when moving from *J2EE JMS* Quality of Service into XAP.|
|[Parallel Queue Pattern]| Advanced |Messaging based pattern. Can be used when moving from *J2EE JMS Service Activator Aggregator Strategy/MDB* into XAP.|
|[Unit Of Work]| Advanced |Messaging based pattern. Can be used when moving from *J2EE JMS* Unit of Order into XAP.|
|[Drools Rule Engine Integration]| Advanced | Scaling business rule management system based application.|
|[Spring Batch PU]| Advanced | Complex Batch Processing using [Spring Batch|http://static.springsource.org/spring-batch].|
|[JTA-XA Example] | Advanced | Integrating GigaSpaces with an external JMS Server using XA. Atomikos is used as the JTA Transaction provider. Apache ActiveMQ is used as a the JMS provider.|

# Setup Production Environment
|| Best Practice || Level ||Description||
|[Embedding XAP for OEMs]| Beginner | A quick and simple example of how an OEM might embed GigaSpaces XAP for customer use.|
|[Universal Deployer] |Beginner | Allows deploying composite applications. Support multiple processing unit dependency based deployment.|
|[Data-Collocation Deployment Topology]| Beginner | Considerations which topology to choose when deploying both business logic and data into the Grid.|
|[Mirror Monitor]| Beginner | Monitoring asynchronous persistency behavior in real time using JMX.|
|[Safe Grid Shutdown|Safe Grid Shutdown]| Beginner | Cleanly shutting down the grid after all async replication operations are committed.|
|[Hyperic integration]| Beginner | Hyperic monitoring integration example.|
|[Clusters Over WAN|WAN Replication Gateway]| Beginner | Example for WAN replication implementation.|
|[WAN Gateway Pass Through Replication]| Beginner | Example for implementing a pass through WAN replication topology.|
|[WAN Gateway Master Slave Replication]| Beginner | Example for implementing a single-master/multi-slave replication topology.|
|[Primary-Backup Zone Controller]|Beginner | Using Zones to control Data-Grid primary/backup instances location.|
|[RESTful Admin API|http://www.openspaces.org/display/RES/Project+Documentation]| Beginner | Using web services to monitor and administrate GigaSpaces.|
|[JMX Space Statistics]| Beginner | Using JMX to expose space statistics.|
|[Space Dump and Reload]| Beginner | Using the administration API to dump the space data into a file and reload it back.|
|[Scaling Agent]| Beginner | Using the administration API to scale web applications. Can be used when moving *J2EE Web applications* into XAP elastic Web Container.|
|[Web Load Balancer Agent PU]| Advanced | Using the administration API to build customized HTTP load-balancer agent. Can be used when moving *J2EE Web applications* into XAP elastic Web Container.|
|[Moving into Production Checklist]| Advanced | All what you need to review before moving your system into production.|
|[Capacity Planning]| Advanced | Considerations for sizing your system before moving into production.|
|[Refreshable Business Logic Example]| Advanced | Using the administration API to reload new application code (hot deploy) while the application is running.|

# Solutions
|| Best Practice || Level ||Description||
|[Elastic Distributed Calculation Engine]|Advanced| Elastic Distributed Calculation Engine implementation using Map-Reduce approach.|
|[Trading Settlement] |Advanced| A trading settlement system where the entire tier-based architecture is built on GigaSpaces.|
|[Mainframe Integration] |Advanced| GigaSpaces XAP can simplify the migration effort from mainframe based systems and reduce the cost of the legacy applications. GigaSpaces XAP act as a front-end layer for mainframe based systems may boost the system performance and improve the overall system response time on peak load.|
|[Global Http Session Sharing]|Advanced| Global HTTP Session Sharing allows transparent session replication between remote sites and sharing between different application servers in real-time.|
|[Observable WAN]|Advanced|Monitor and measure the replication performance of a multi-site deployment.|
{column}
{column}


h4. Quick Links


h5. • [9.6.X Release Notes|RN:GigaSpaces XAP 9.6.X Release Notes]


h5. • [What's new in XAP 9.6.X|RN:What's New in GigaSpaces 9.6.X]


h5. • [API Documentation|API:API Documentation Portal]


h5. • [Solutions and Best Practices|SBP:Solutions and Best Practices Home]


h5. • [Forum|http://ask.gigaspaces.org/]


h5. • [Downloads|http://www.gigaspaces.com/LatestProductVersion]


h5. • [Blog|http://blog.gigaspaces.com/]


h5. • [White Papers|http://www.gigaspaces.com/os_papers.html]


h5. • Looking for *[*XAP.NET*|XAP96NET:XAP.NET 9.6 Documentation Home]* or *[*other versions*|ALL:Choose a GigaSpaces Version]*?

{column}
{section}