---
layout: sbp
title:  Data Offload - GigaSpaces-Excel Integration
categories: SBP
page_id: 47219052
---

{% summary page|65 %}Using the data offload pattern.{% endsummary %}

{rate}

# Overview

In this pattern, all data is stored in the space (on the server side). Excel in turn loads only the relevant data each time and displays it in the spreadsheet. This removes the load from Excel, which is sometimes unable to cope with such large amounts of data, and, if required, updates the displayed data without delay.

Using this pattern is divided into 4 main steps:
1. depanlinkLoading all your data to the spacetengahlink#1 -- Loading Data to Spacebelakanglink.
2. depanlinkLoading a subset of your data to the Excel spreadsheettengahlink#2 -- Loading Data Subset to Excelbelakanglink.
3. If required: depanlinkDefining a refresh policytengahlink#3 -- Defining Refresh Policybelakanglink.

## 1 -- Loading Data to Space

As a first step, you need to load all your data from its current source to the space.

GigaSpaces provides [OpenSpaces|XAP66:Product Architecture#ProductArchitecture-OpenSpacesAPIandComponents] as its main API. However, it is also possible to load data from different types of applications transparently, using different connectors implemented by GigaSpaces:
- For messaging-based applications, refer to the [XAP66:JMS] section.
- If your application is an external data source (like a database), refer to the [XAP66:External Data Source] section.

## 2 -- Loading Data Subset to Excel

After you've loaded your data to the space, you need to load the portion you want to work with into your Excel spreadsheet. A SQL query is performed on the space, thus separating the specified data from all the data and loading it into the spreadsheet.

This can be done using the **depanlinkExcel Space Viewertengahlink./excel-space-viewer.htmlbelakanglink**, which allows you to perform queries on the space and display the data in the spreadsheet.

## 3 -- Defining Refresh Policy

If you need the data displayed in your spreadsheet to be constantly updated, you can do this using the depanlinkExcel Space Viewertengahlink./excel-space-viewer.htmlbelakanglink. Simply define the required refresh rate in milliseconds in the [New View|Excel Space Viewer#Creating New View] or [Configure View|Excel Space Viewer#Changing Existing View] window. Excel in turn loads the updated data from the space according to the specified refresh rate.

# What's Next?

{% refer %}[Try another pattern|Excel that Scales Solution]{% endrefer %}
