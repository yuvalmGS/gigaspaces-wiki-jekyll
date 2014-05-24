---
layout: post
title:  Directory Structure
categories: HOWTO
weight:  100
parent:  none
---


The documentation portal has the following directory structure :

##  `/attachment_files`

This directory contains all images and icons that are used throughout the wiki.
At the present time all images from the old wiki have been saved in this directory. As we keep improving
the portal we will restructure the images by logically grouping them in sub folders. This will make it easier
to reuse the images in the future. We started the re grouping with the folder `space_operations`.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| `gs`    |contains GigaSpaces logos and trademarks|
| `logos` |framework and product logos |
| `navigation` | navigation icons and images |
| `qsg` | images for Quick Start guide |
| `sbp` | images for Solutions and Patterns |
| `dotnet` | images for the .NET wiki |
| `space_operations` | space operation related images and icons|

## `/api_documentation`

This folder contains the page that has all the reference links to the API documentation (Java, C++, .NET and Scala).

## `/download_files`

All downloadable artifacts like examples and presentations are placed in this directory.

* Sub directories

{: .table .table-bordered}
|Subfolder name |Description|
|:------|:---------------------------------------|
| `sbp` |contains artifacts for the Solutions and Patterns |
| `dotnet` |.NET related documents |




## `/release_notes`

In this folder pages for each XAP release will be created. These pages contain information that are related to Java, C# and CPP.



## `/product_overview`

This directory contains the product overview pages including architecture, concepts and terminology.
All other sections of the wiki are referencing these pages.

## `/sbp`

This is the directory that contains the Solutions and Patterns documentation pages. 


## `/xap97`

This is the directory that contains all documentation pages for the XAP 9.7 Java release.




## `xap97adm`

This is the directory that holds all documentation pages for the XAP Admin 9.7 release.



{%note%}
Each new XAP version will have its own subfolders, e.g `xap100`, `xap101` etc.
{%endnote%}