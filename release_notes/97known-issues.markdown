---
layout: post
title:  Known Issues and Limitations
categories: RELEASE_NOTES
parent: xap97.html
weight: 400
---

{%summary%} Known Issues and Limitations in XAP 9.7.X release {%endsummary%}

## Overview

Below is a list of new features and improvements in GigaSpaces 9.7.X.


{: .table .table-bordered}
| Key | Summary | SalesForce ID | Since version | Workaround | Platform/s
|:----|:--------|:----------------|:---------------|:------------------|:----------|
| GS-11325 | Widget - remove redundant configuration keys | | 9.7.0 | | All |
| GS-11329 | finish automation_tools project and use it in widget and hp demo page | | 9.7.0 | | All |
| GS-11345 | XAP 9.6 pu.xml should use 9.6 xml schema and not 9.1 | | 9.7.0 | | |
| GS-11346 | Web-ui doesn't show the correct running/planned instances of a deployed application. | | 9.7.0 | | All |
| GS-11351 | Webui shows double fake application when deploying a pu (in .NET build) | | 9.7.0 | | .Net |
| GS-11354 | webUI: Under Applications, Toolbox button disabled for the first ~5 seconds | | 9.7.0 | | All |
| GS-11356 | Initial load of Cassandra EDS working with LRU space might cause ClassNotFoundException | 8269 | 9.7.0 | | Java |
| GS-11361 | Deployment of an application with dependencies on elastic pu could be slower than sequential pu deployment | | 9.7.0 | | |
| GS-11370 | Generate dump throws NPE | | 9.7.0 | | |
| GS-11372 | cloudify widget - refactor pool mechanism | | 9.7.0 | | All |
| GS-11376 | NumberFormatException is thrown when installing service | | 9.7.0 | | All |
| GS-11377 | cloudify-repository sub-project of webui-libs is not installed properly in maven repository | | 9.7.0 | | All |
| GS-11381 | ESM caught in a re-balancing loop after addition of new machine | | 9.7.0 | | All |
| GS-11384 | single click to hide layover and play widget | | 9.7.0 | | All |
| GS-11385 | Widget - separate API urls from page urls | | 9.7.0 | | All |
| GS-11396 | Enable multi widgets on same page | | 9.7.0 | | All |
| GS-11396 | NIC_ADDR , LOOKUPLOCATORS and LOOKUPGROUPS should be read also by GigaSpaces client | | 9.7.0 | | All |
| GS-11398 | Web UI alignments | | 9.7.0 | | All |
| GS-11408 | Web - UI - Mirror stats should track change operations | | 9.7.0 | | All |
| GS-11418 | UI - space remote view (local view) shows only portion of the data and not all | | 9.7.0 | | All |
| GS-11420 | Cassandra Synchronization Endpoint - Concurrent column family creation, sporadic failures | | 9.7.0 | | Java |
| GS-11432 | @SpaceLeaseExpiration support for SpaceDocument | | 9.7.0 | | Java,.NET |
| GS-11434 | WAN Gateway- pass through site won't show on Web UI | | 9.7.0 | | All |
| GS-11443 | Discovery group selection doesn't filter out WAN Gateway Lookup Groups | | 9.7.0 | | All |
| GS-11446 | Using deprecated admin.restart() admin.stop() against secured grid without supplying credentials succeed | | 9.7.0 | | All |
| GS-11447 | Without credentials client is able to get RuntimeDetails of secured space | | 9.7.0 | | All |
| GS-11449 | ESM log is cluttered when admin API cannot get statistics | | 9.7.0 | | Java |
| GS-11450 | ESM log is cluttered by failed attempt to kill containers | | 9.7.0 | | Java |
| GS-11463 | Restart the ESM if it cannot detect any lookup service during initialization | | 9.7.0 | | Java |
| GS-11466 | Fix failure issue in success build process | | 9.7.0 | | All |
| GS-11484 | Space name can not contain the word "localview" | | 9.7.0 | | All |
| GS-11485 | Exceptions reading with OR queries objects with Date fields inserted by GS-UI | | 9.7.0 | | All |
| GS-11492 | SpaceDocument Id cannot be set to Integer via namespace declaration | | 9.7.0 | | Java |
| GS-11496 | webui security - a viewer can uninstall applications | | 9.7.0 | | All |
| GS-11500 | Installing services in the app catalog prompts for authorization groups | | 9.7.0 | | All |

