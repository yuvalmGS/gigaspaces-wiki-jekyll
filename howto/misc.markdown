---
layout: post
title:  Miscellaneous
parent: plugin.html
weight: 150
categories: HOWTO
---




#### Comment

{%panel%}
{%comment%}
This is a comment and will not display on the final page
{%endcomment%}
{%panel bgColor=white | title=Markdown%}
{% raw  %}
{%comment%}
This is a comment and will not display on the final page
{%endcomment%}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
{%endpanel%}
{%endpanel%}



#### Cloak

{%panel%}
{% togglecloak id=1 %}  **In this step you will learn...**{% endtogglecloak %}
{% gcloak 1 %}

- How to deploy a standard web application to the GigaSpaces XAP environment
- How to define SLA attributes for your web application (minimum and maximum number of instances to maintain)
- How to configure Apache 2.2 to automatically discover and route traffic to running web container instances using the GigaSpaces load balancing agent

{% endgcloak %}
{%panel bgColor=white | title=Markdown%}
{% raw  %}
{% togglecloak id=1 %}  **In this step you will learn...**{% endtogglecloak %}
{% gcloak 1 %}

- How to deploy a standard web application to the GigaSpaces XAP environment
- How to define SLA attributes for your web application (minimum and maximum number of instances to maintain)
- How to configure Apache 2.2 to automatically discover and route traffic to running web container instances using the GigaSpaces load balancing agent

{% endgcloak %}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
{%endpanel%}
{%endpanel%}







