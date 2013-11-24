---
layout: post
title:  Formating & Color
parent: plugin.html
weight: 100
categories: HOWTO
---




#### Align

{%panel%}
{%align center%} Aligning text in the center {%endalign%}
{%panel bgColor=white | title=Markdown%}
{% raw  %}
{%align center%} Aligning text in the center {%endalign%}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
left, center, right
{%endpanel%}
{%endpanel%}


#### Background Color

{%panel%}

This feature has been {%bgcolor orange %}introduced in Version 9.7{% endbgcolor %}

{%panel bgColor=white | title=Markdown%}

{% raw  %}

This feature has been {%bgcolor orange %}introduced in Version 9.7{% endbgcolor %}

{% endraw  %}

{%endpanel%}
{%panel bgColor=white | title=Parameters%}
color
{%endpanel%}
{%endpanel%}



#### Color
{%panel%}

{% color blue %}Blue text color{% endcolor %}

{%panel bgColor=white | title=Markdown%}
{% raw  %}
{% color blue %}Blue text color{% endcolor %}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
color
{%endpanel%}
{%endpanel%}


#### Font
{%panel%}

{% fontsize 10 %}This is font 10{% endfontsize %}
{% fontsize 20 %}This is font 20{% endfontsize %}
{% fontsize 30 %}This is font 30{% endfontsize %}

{%panel bgColor=white | title=Markdown%}
{% raw  %}
{% fontsize 10 %}This is font 10{% endfontsize %}

{% fontsize 20 %}This is font 20{% endfontsize %}

{% fontsize 30 %}This is font 30{% endfontsize %}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
size
{%endpanel%}
{%endpanel%}




#### Indent

{%panel%}
{%indent%} Indented text{%endindent%}
{%panel bgColor=white | title=Markdown%}
{% raw  %}
{%indent%} Indented text   {%endindent%}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
None
{%endpanel%}
{%endpanel%}





