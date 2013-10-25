---
layout: sbp
title:  GigaSpaces-Excel Integration FAQ
categories: SBP
page_id: 47219033
---

{summary:page|65}Frequently asked questions about the GigaSpaces-Excel integration.{summary}
{rate}
# Overview
The following FAQs deal with the GigaSpaces Excel Integration solutions.

# General FAQs

- [What are the *Prerequisites*?|#Prerequisites]
- [Why does the Space Viewer toolbar not show up in Excel?|#The Space Viewer toolbar does not show up in Excel]

{include:Prerequisites - GigaSpaces-Excel Integration}

# The Space Viewer toolbar does not show up in Excel

h3. Problem
The Excel Space Viewer is installed on a laptop PC. It is working OK but after a few days, the Space Viewer toolbar does not appear in Excel.
Running the installation file (`GigaSpacesViewerSetup.msi`) and selecting *Add*/*Remove*/*Repair* works fine, but the toolbar still doesn't show up in Excel.
- *Operating system* -- Microsoft Windows XP Professional
- *Office version* -- Microsoft Office Small Business Edition 2003

h3. Solution

- Open Excel
- Click *Help* > *About Excel* > *Disabled Items*
- Highlight the *mscorlib.dll* item and click *Enable*
