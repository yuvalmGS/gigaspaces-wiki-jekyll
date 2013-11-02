---
layout: sbp
title:  Excel that Scales Solution
categories: SBP
page_id: 47219144
---


{% tip %}
**Summary:** {% excerpt %}Available functionality, how to develop the integration components and how to configure, deploy and run the GigaSpaces-Excel solution.{% endexcerpt %}
**Author**: Pini Cohen, GigaSpaces
**Recently tested with GigaSpaces version**: XAP.NET 6.6
**Contents:**

{% toc minLevel=1|maxLevel=1|type=flat|separator=pipe %}

{% endtip %}

{rate}

# Overview

This section gets you started with the Excel integration by understanding its available functionality, how to develop the integration components and how to configure, deploy and run the solution.

Along with several examples that can be used as starting points for development, it includes supported platforms and a short description of testing that was performed to validate the proposed patterns.

# GigaSpaces-Excel Integration Patterns

There are two main problems that the GigaSpaces-Excel solution is relevant for:

| ** You are working with a **very large amount of data**, which **causes Excel to slow down or freeze*
- However, **you need only a portion of your data to be displayed** in Excel at a time
- You need the spreadsheet to be **updated constantly** | depanimageblue_arrow2.jpgtengahimage/attachment_files/sbp/blue_arrow2.jpgbelakangimage | **[Data offload|Data Offload - GigaSpaces-Excel Integration]** |
| ** You are **performing very complex calculations**, or a **large amount of calculations* in Excel
- These calculations are **costly** -- they **cause Excel to slow down or freeze**; or **slow down other applications** | depanimageblue_arrow2.jpgtengahimage/attachment_files/sbp/blue_arrow2.jpgbelakangimage | **[Calculation offload|Calculation Offload - GigaSpaces-Excel Integration]** |

