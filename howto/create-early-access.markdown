---
layout: howto
title:  Creating an early access wiki
page_id: 61867355
---


In this example we will assume that the current version of XAP is 9.7, and the new version will be 9.8. We will use these release numbers for our  example

1. Creating a new wiki version
* Clown the wiki repository
* Copy the /xap97 folder and rename it to xap98
* Copy the /xap97net folder and rename it to xap98net


2. Release notes
* Create a new folder in the /_includes/release_notes directory called xap98
* Create a new file called general_notes.markdown in this newly created folder (no formatting).Change all relevant version numbers to reflect the new version
* Update xap specific release notes in /xap98/release_notes and include the file you just created in step 5.
* Update .NET release notes in /xap98net/release_notes and include the file you just created in step 5.

3. Early Access Link
* Change the link for the early access page  (where is it located ?)


4. Updating landing pages
* XAP Main landing page. Update the file /xap98/index.html, change all version numbers to reflect the new release and add Early Access in the text.
* XAPNET Main landing page. Update the file /xap98net/index.html, change all version numbers to reflect the new release and add Early Access in the text.


5. Create API Documentation Page
* Create a new file called xap-98.markdown in the /api_documentation folder
* Add the new page in the /_includes/apidocnav.html page `<li><a href="xap-98.html">XAP 9.8</a></li>`






