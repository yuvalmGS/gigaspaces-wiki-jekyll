---
layout: post
title:  Layout
parent: plugin.html
weight: 200
categories: HOWTO
---




#### Section and Columns

{%panel%}

{%section%}
{%column%}
This is the first column
{%endcolumn%}
{%column%}
This is the second column
{%endcolumn%}
{%endsection%}

{%panel bgColor=white | title=Markdown%}
{% raw  %}
{%section%}
{%column%}
This is the first column
{%endcolumn%}
{%column%}
This is the second column
{%endcolumn%}
{%endsection%}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
TODO
{%endpanel%}
{%endpanel%}


#### Panel

{%panel%}

{% panel title=This is a panel title| borderStyle=solid|borderColor=#3c78b5|bgColor=#FFFFCE %}
This is some panel content
{%endpanel%}

{%panel bgColor=white | title=Markdown%}
{% raw  %}
{% panel title=This is a panel title| borderStyle=solid|borderColor=#3c78b5|bgColor=#FFFFCE %}
This is some panel content
{%endpanel%}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
title
bgcolor
borderStyle
{%endpanel%}
{%endpanel%}


#### Table

{%panel%}

{: .table .table-bordered}
| Header1 | Header2 | Header3
|:-----|:-------|:-----------|
| column1 | column2 | column3|

{: .table }
| Header1 | Header2 | Header3
|:-----|:-------|:-----------|
| column1 | column2 | column3|

{%panel bgColor=white | title=Markdown%}
{% raw  %}
\{: .table .table-bordered}
 | Header1 | Header2 | Header3
 |:-----|:-------|:-----------|
 | column1 | column2 | column3|
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
None
{%endpanel%}
{%endpanel%}


#### Tabbed Pane

{%panel%}

{% inittab Java |top %}
{% tabcontent Java %}
Tab one display
{% endtabcontent %}
{% tabcontent XML %}
Tab two display
{% endtabcontent %}
{% endinittab %}

{%panel bgColor=white | title=Markdown%}
{% raw  %}
{% inittab Java |top %}
{% tabcontent Java %}
Tab one display
{% endtabcontent %}
{% tabcontent XML %}
Tab two display
{% endtabcontent %}
{% endinittab %}
{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
TODO
{%endpanel%}
{%endpanel%}


#### Code Block

{%panel%}

{% highlight java %}
 public class Test()
 {

 }
{%endhighlight%}

{%panel bgColor=white | title=Markdown%}
{% raw  %}

{% highlight java %}
 public class Test()
 {

 }
{%endhighlight%}

{% endraw  %}
{%endpanel%}
{%panel bgColor=white | title=Parameters%}
java
xml
{%endpanel%}
{%endpanel%}






