---
layout: post
title:  Page Cross-reference
parent: markdown.html
weight: 500
categories: HOWTO
---


#### Latest XAP release

When you need to referece a page in the latest XAP release in your documentation you use the `latestjavaurl` plugin.

{%panel%}

[Grid Service Agent]({%latestjavaurl%}/service-grid.html)

Markdown:

{%panel bgColor=white%}
{%raw%}
\[Grid Service Agent]({%latestjavaurl%}/service-grid.html)
{%endraw%}
{% endpanel %}

You should use this plugin in the following sections of the documentation:

* Services and Best Practices
* Java Tutorial
* Product Overview

{% endpanel %}


#### Latest XAP release number

When you need to referece the latest XAP release number in your documentation you use the `latestxaprelease` plugin.

{%panel%}

In version {%latestxaprelease%} of XAP the ...

Markdown:

{%panel bgColor=white%}
{%raw%}
In version {%latestxaprelease%} of XAP the ...
{%endraw%}
{% endpanel %}

You must use this plugin for the following scenarios:

* Services and Best Practices
* Java Tutorial
* Product Overview

{% endpanel %}


#### Current Java Release

When you need to referece a page in the current XAP release in the documentation you use the `currentjavaurl` plugin.

{%panel%}

[Administration Guide]({% currentjavaurl %}/graphical-user-interface.html)

Markdown:

{%panel bgColor=white%}
 {%raw%}
\[Administration UI Interfaces]({% currentjavaurl %}/graphical-user-interface.html)
{%endraw%}
{% endpanel %}

You must use this plugin in the following scenarios:

* To make a reference link from a .NET document to a document in XAP

{% endpanel %}









