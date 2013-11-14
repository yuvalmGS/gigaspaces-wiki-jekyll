---
layout: post
title:  Wiki Directory Structure
page_id: 61867355
---



The wiki has the following directory structure :


##  attachment_files

This directory contains all images and icons that are used throughout the wiki.
At the presnet time all images from the old wiki have been saved in this directory. As we keep improving
the wiki we will restructure the images by logically grouping them in sub folders. This will make it easier
to reuse the images in the future. We started the re grouping with the folder space_operations.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| gs    |contains GigaSpaces logos and trademarks|
|logos |framework and product logos |
|navigation | navigation icons and images |
|qsg | images for Quick Start guide |
| sbp | images for Services and Best Practices |
|dotnet| images for the .NET wiki |
|space_operations| space operation related images and icons|

## api_documentation

This folder conatins the wiki page that has all the reference links to the API documentation (Java, C++, .NET and Scala)

## download_files

All downloadable artifacts like examples and presentations are placed in this directory.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| sbp   |contains artifacts for the Services and Best Practices |
|dotnet |.NET related documents |


## java_tutorial

This directory contains the Java Tutorial.


## release_notes

In this folder a page for each XAP release will be created. The page contains information that is common to XAP and XAPNET.
This page then will be included in the actual release notes that are located within each XAP release.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| xap97   |contains a common description for this release |
| xap98   |contains a common description for this release |
| xap..   | ........ |

## presentation_files

This directory contains presentation and white paper documents that are downloadable from wiki pages.


## product_overview

This directory contains the product overview wiki pages including architecture, concepts and terminology.
All other sections of the wiki are refrencing thes pages.

## sbp

This is the directory that contains the Services and Best Practices wiki pages


## xap97

This is the directory that holds all wiki pages for the xap97 release.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| release_notes | contains all information about this release |

## xap97net

This is the directory that holds all wiki pages for the xap97 .NET release.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| release_notes | contains all information about this release |


Each new XAP version will have its own subfolders, e.g XAP98, XAP99 etc.
