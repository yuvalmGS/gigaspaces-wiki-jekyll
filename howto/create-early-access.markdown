---
layout: post
title:  Creating a new Version
parent: index.html
weight: 300
categories: HOWTO
---


# Creating Documentation for the New Version

In this example we will assume that the current version of XAP is 9.7, and the new version will be 10.0. We will use these release numbers for our example.

1. Creating a new wiki version
* Clone this repository
* Copy the `/xap97` folder and rename it to `xap100`
* Copy the `/xap97net` folder and rename it to `xap100net`


2. Release notes
* Create a new folder in the `/_includes/release_notes` directory called `xap100`
* Create a new file called `general_notes.markdown` in this newly created folder (no formatting). Change all relevant version numbers to reflect the new version
* Update XAP specific release notes in `/xap100/release_notes` and include the file you just created in step 5.
* Update .NET release notes in `/xap100net/release_notes` and include the file you just created in step 5.

3. Early access Page
* Change the links and text in /early_access/index.html to reflect the new version.

4. Create API Documentation Page
* Create a new file called `xap-100.markdown` in the `/api_documentation` folder
* Add the new page in the `/_includes/apidocnav.html` page `<li><a href="xap-100.html">XAP 10.0</a></li>`






