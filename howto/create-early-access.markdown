---
layout: post
title:  Creating a new Version
parent: index.html
weight: 300
categories: HOWTO
---


In this example we will assume that the current version of XAP is 9.7, and the new version will be 10.0. We will use these release numbers for our example.

1. Creating a new wiki version
* Clone this repository
* Copy the `/xap97` folder and rename it to `xap100`
* Copy the `/xap97net` folder and rename it to `xap100net`

2. Release notes
* Copy the folder `/release_notes97` and rename it to `/release_notes100`
* Update all pages in this folder to reflect the new version

3. Create API Documentation Page
* Copy the file `xap-97.markdown` and rename the new copy it to `xap-100.markdown`
* Modify `xap-100.markdown`, change the yaml front matter on this page:

{%panel%}
layout: post

`title:  XAP 10.0`

categories: API_DOCUMENTATION

`weight: 900`

parent: none
{%endpanel%}
* change the title to reflect the new version
* weight should be the current release weight - 100

4.Early access page
* Change the links and text in /early_access/index.html to reflect the new version.




