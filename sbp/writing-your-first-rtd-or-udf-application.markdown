---
layout: sbp
title:  Writing Your First RTD or UDF Application
categories: SBP
page_id: 47219379
---

{summary:page|65}Writing your first RTD/UDF application using the GigaSpaces-Excel integration.{summary}
{rate}
h1. Overview

This section shows you how to write your first RTD or UDF application using the GigaSpaces-Excel integration.

{refer}See some basic and advanced code examples for [working with UDF and RTD|RTD and UDF Examples - GigaSpaces-Excel Integration].{refer}

{include: Prerequisites - GigaSpaces-Excel Integration}

h1. Writing Your First RTD/UDF Application

# In Visual Studio, create 2 new *Class Library* projects, one for UDF and one for RTD.
# Add the {{<GigaSpaces Root>\Bin\GigaSpaces.Core.dll}} reference.
# In the *COM* tab, select *Microsoft Excel 11.0 Object Library*.
# In the *.NET* tab, select *System.configuration*.
# Office runtime:
#* For Excel 2003 - in the *COM* tab, add the *Microsoft Office 11.0 Object Library*.
#* For Excel 2007 - in the *COM* tab, add the *Microsoft Office 12.0 Object Library*.
\\
# Build the projects.
# Make sure {{GigaSpaces.Core.dll}} and {{GigaSpaces.NetToJava.dll}} exist in your {{Release}} folder.
# Run the following command from the {{Release}} folder:
{noformat}
%WinDir%\Microsoft.NET\Framework\v2.0.50727\RegAsm.exe \[MY_RTD_CLASSNAME\].dll /Codebase
{noformat}
# Save the [^excel.exe.config] file in your Excel runtime folder. For example: {{C:\Program Files\Microsoft Office\OFFICE11}}
# Open Excel.
# To add the UDF function:
## In Excel, go to *Tools* > *add ins* > *automation*.
## Scroll down to *\[MY_UDF_CLASSNAME\]*, select it and click *OK*. You might get a dialog at this point about mscoree.dll. Click No to this dialog (Yes will delete the add-in from the list).
# Start a space: {{<GigaSpaces Root>\Bin\Gs-ui.exe}}.
# To call a UDF, click the *Function* icon, and look for the *\[MY_UDF_CLASSNAME\]* functions.
# To call a RTD, write in any Excel cell:
{noformat}
=RTD("[MY PROG ID]",,[MY PARAMETERS])
{noformat}

h1. What's Next?

{refer}See the [GigaSpaces-Excel Market-Data Example].{refer}
{refer}Back to The [Excel that Scales Solution] section.{refer}