---
layout: post
title:  Resolved Issues
categories: RELEASE_NOTES
parent: xap97.html
weight: 300
---

{%summary%} Issues that have been fixed in XAP 9.7.X release {%endsummary%}

## Overview

Below is a list of issues that have been fixed in GigaSpaces 9.7.X.



{: .table .table-bordered}
| Key | Summary | Fixed in Version | SalesForce ID | Platform/s |
|:----|:--------|:----------------|:---------------|:------------------|
| GS-11175 | ESM stops working when it cannot discover itself | 9.6.1,9.7.0 | | Java |
| GS-11186 | NPE is thrown when performing SQLQuery with template and projection on a primitive field and this filed is not part of the projection | 9.6.1,9.7.0 | | Java,.NET |
| GS-11191 | .Net ReadMultiple with bad query result in class cast exception | 9.6.1,9.7.0 | 8122 | .NET |
| GS-11207 | Exception is thrown when query projected result does not include primitive properties without null values | 9.6.1,9.7.0 | | Java,.NET |
| GS-11223 | Data replication throughput at Dashboard is not displayed as whole number | 9.6.1,9.7.0 | | All |
| GS-11226 | When adding a dynamic gateway target, the backup space will throw an exception in the logs rejecting this addition | 9.6.1,9.7.0 | | Java,.NET |
| GS-11227 | XAP.NET CLI Windows Service is broken - missing gs_cli.config file | 9_5_2_patch2,9.6.1,9.7.0 | | .NET |
| GS-11231 | Space mode change annotations are not working when a space proxy is created in the ContainerInitializing method | 9_6_0_patch1,9.6.1,9.7.0 | | .NET |
| GS-11233 | Projection on entry with auto generate id true doesn't work | 9.6.1,9.7.0 | | Java,.NET |
| GS-11239 | Eager Elastic PU does not self-heal when it is deployed right before second GSM starts | 9.6.1,9.7.0,9_6_1_patch3 | 8189 | Java |
| GS-11251 | ESM fails to start GSC when one out of two LUS is down | 9.6.1,9.7.0 | | Java |
| GS-11254 | On some scenarios, GSM may go down when GSC gets OutOfMemoryError | 9.7.0 | | All |
| GS-11260 | Durable notification and local view may receive notification which does not match its template of operations under distributed transaction | 9.6.1,9.7.0,9.5.1patch3 | 8159 | Java,.NET |
| GS-11266 | NHibernate practice binaries should not be packaged in the msi | 9.6.1,9.7.0 | | .NET |
| GS-11280 | Problem presenting log in ui and admin logging API, serialization error appears when log line is too long. | 9.6.1,9.7.0 | 8223 | All |
| GS-11303 | Projections is not working with a space iterator | 9.7.0 | 8247 | Java, .NET |
| GS-11305 | ArrayIndexOutOfBoundsException may be thrown when working with more than one class defining FIFO Group in rare condition | 9.7.0,9_5_0_patch2,9_6_2 | 8243 | Java,.NET |
| GS-11312 | Last replicated packet is kept on thread local cache which could hold up significant memory | 9.6.1,9.7.0 | 8237 | All |
| GS-11315 | FifoGroups is not working with inheritance when the fifo groups annotation is configured on the son class | 9.7.0 | | Java,.NET |
| GS-11317 | Typo in class name UniqueConstraintViolationExecption | 9.7.0 | | Java |
| GS-11331 | NPE is thrown when trying to performing admin operation with non secured admin on secured grid | 9.7.0 | | Java,.NET |
| GS-11339 | blocked update may throw wrong kind of execption or stay blocked in case of an internal error | 9.7.0 | | All |
| GS-11355 | "Insufficient Data In Class" might appear in log while starting local view after failovers | 9.7.0,9_6_1_patch1,9_6_2 | 8282 | All |
| GS-11357 | Increment by zero in Change operation causes to UnMarshallingException | 9.7.0,9_6_2 | | Java,.NET |
| GS-11365 | Updating entry twice under the same transaction when object was written with lease might cause to memory leak | 9.7.0,9_6_2 | 8294 | All |
| GS-11368 | Serialization error occurring when writing to swap replication redolog could cause deadlock in the space | 9.7.0 | 00008304 | All |
| GS-11374 | A space with EDS and mirror invokes a redundant call to the EDS iterator/enumerator with java.lang.Object/System.Object upon creation. | 9.7.0 | 8259 | Java,.NET |
| GS-11375 | High memory consumption when using large objects and light serialization | 9.7.0 | 8280 | Java |
| GS-11380 | @EventTemplate annotation not respected when using @Archive container annotation | 9.7.0 | | Java |
| GS-11382 | System parameter com.gs.security.fs.file-service.file-path ignored by ui | 9.7.0 | 8309 | All |
| GS-11383 | Upgrade Spring Security 3.1.4 | 9.7.0 | | Java |
| GS-11388 | NPE appears in logs when performing change operation with SQLQuery on local cache | 9.7.0 | | Java,.NET |
| GS-11391 | ESM service is missing an icon in gs-ui | 9.7.0,9_5_0_patch3,9_6_2 | | All |
| GS-11394 | creating of compound index allowed from SpaceTypeDescriptorBuilder with type=extended | 9.7.0 | | Java |
| GS-11395 | local view properties ignored | 9.7.0 | | All |
| GS-11402 | When a cancel/renew multiple leases operation fails, the exceptions are ignored | 9.7.0 | | All |
| GS-11411 | XSD 9.6 schemas are not provided -require internet | 9.7.0,9_6_2 | 8342 | All |
| GS-11414 | ESM may not start if failed communicating with management GSA | 9.7.0 | | Java |
| GS-11415 | Hide newsfeed button if not available | 9.7.0,9_6_2 | | All |
| GS-11419 | Cassandra Space Synchronization Endpoint - writing space documents with id autogenerate=true might cause data corruption | 9.7.0 | | Java |
| GS-11431 | NPE when overriding a setter method and no getter is available | 9.7.0,9_6_2 | 8349 | Java |
| GS-11433 | "useLocalCache" in url definition result in ClassCastException after reconnecting to master space | 8.0.7 patch3,9.7.0 | 8385 | All |
| GS-11435 | Add missing lrmi monitoring admin API in .NET | 9.7.0 | | .NET |
| GS-11440 | notify container leaseListener attribute of the @NotifyLease annotation causes compilation errors to users | 9.7.0 | | Java |
| GS-11442 | ClassCastException may occur in reliable async target if replication backlog is overflown | 9.7.0 | | All |
| GS-11445 | ESM failing to shutdown after the GSA has been stopped | 9.7.0 | 8406 | Java |
| GS-11451 | ESM mistakenly kills containers not registered with LUS, when it failed to start a container on that machine | 9.7.0 | | Java |
| GS-11452 | NPE replicating change operation in rare conditions | 9.7.0 | 8439 | Java, .NET |
| GS-11462 | Restart the ESM if it cannot detect any lookup service | 9.7.0 | 8448 | Java |
| GS-11469 | Change operation and central data base causes a problem when sending a durable notifications | 9.7.0 | | All |
| GS-11486 | Fix GigaMap id registration | 9.7.0 |  | Java |
| GS-11487 | Local View which fail to initialize due to MSE can cause replication backlog accumulation in the space | 9.7.0 | 8475 | All |
| GS-11487 | WLocal View which fail to initialize due to MSE can cause replication backlog accumulation in the space | 9.7.0 | 8475 | All |
| GS-11489 | Wrong display of Machine SLA Enforcment event | 9.7.0 |  | All |
| GS-11489 | Wrong display of Machine SLA Enforcment event | 9.7.0 | | All |
| GS-11490 | GSC failed to create a JMX server and listen on a port | 9.7.0 | 8496 | All |
| GS-11491 | Space shutdown may hang while closing Background fifo thread on rare scenarios | 9.7.0,9.6.2patch2 | 8451 | All |
| GS-11527 | DiscoveredMachineProvisioningConfigurer is missing the reservedMemoryCapacityPerManagementMachine method | 9.7.0 | | Java |
| GS-11522 | Durable notification do not arrive when there is a gateway configured | 9.7.0 | | Java,.NET |
| GS-11485 | Exceptions reading with OR queries objects with Date fields inserted by GS-UI | 9.7.0, 9.5.1patch3 | 8481 | All |

