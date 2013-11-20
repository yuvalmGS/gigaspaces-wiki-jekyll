---
layout: post
title:  Layout
parent: markdown.html
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

Markdown:

{%panel bgColor=white%}
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
{%endpanel%}


#### Panel

{%panel%}

{% panel title=This is a panel title| borderStyle=solid|borderColor=#3c78b5|bgColor=#FFFFCE %}
This is some panel content
{%endpanel%}
Markdown:

{%panel bgColor=white%}
{% raw  %}
{% panel title=This is a panel title| borderStyle=solid|borderColor=#3c78b5|bgColor=#FFFFCE %}
This is some panel content
{%endpanel%}
{% endraw  %}
{%endpanel%}
{%endpanel%}


#### Table

{%panel%}

{: .table .table-bordered}
| Header1 | Header2 | Header3
|:-----|:-------|:-----------|
| column1 | column2 | column3|

Markdown:

{%panel bgColor=white%}
{% raw  %}
\{: .table .table-bordered}
 | Header1 | Header2 | Header3
 |:-----|:-------|:-----------|
 | column1 | column2 | column3|
{% endraw  %}
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

Markdown:

{%panel bgColor=white%}
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
{%endpanel%}


#### Code Block

{%panel%}

{% highlight java %}
 public class Test()
 {

 }
{%endhighlight%}

Markdown:

{%panel bgColor=white%}
{% raw  %}

{% highlight java %}
 public class Test()
 {

 }
{%endhighlight%}

{% endraw  %}
{%endpanel%}
{%endpanel%}












{%comment%}
#### Note

{%panel%}
This is a box that displays text

{%note%}this is an note {%endnote%}

Markdown:

{%panel bgColor=white%}
{% raw  %}
{%note%}this is an note {%endnote%}
{% endraw  %}
{%endpanel%}
{%endpanel%}




{%note%}this is an note {%endnote%}

{%tip%}This is a tip {%endtip%}

{%quote%}This is a quote{%endquote%}

{%warning%}This is a warning{%endwarning%}



{%exclamation%} This is an exclamation mark !

{%remove%} This is a remove

{%plus%}This is a plus sign

{%question%}This is a question

{%lampon%}Lamp on

{%lampoff%}Lamp off

{%infosign%} This is an info sign

{%star%} This is a star

{%oksign%} This is an OK sign

{%sub%} This is a sub  {%endsub%}

```
{%refer%} This is refer   {%endrefer%}
```

# Anchor

[Layouts](#layout)

{%highlight xml%}
{%comment%} Make sure that there is an empty line below the anchor tag !!!!!!{%endcomment%}
{%endhighlight%}


# Layouts

{%anchor layout%}

## Section

{%section%}
{%column width=20% %}
Hello there this is a column 1
{%endcolumn%}
{%column width=70% %}
Hello there this is another column  2
{%endcolumn%}
{%endsection%}


## Panel
{% panel title=This is a panel title| borderStyle=solid|borderColor=#3c78b5|bgColor=#FFFFCE %}
Panel content
{%endpanel%}


## Table

{: .table .table-bordered}
| Hello | Title |   Column
|:-----|:-------|:-----------|
| test | test 1 | test2|


## Tabbed pane

{% inittab Java |top %}
{% tabcontent Java %}
Some code
{% endtabcontent %}
{% tabcontent XML %}
Some code
{% endtabcontent %}
{% endinittab %}

# Bookmarks

{%bookmarks%}


# Code

{%highlight java%}
public void getIt()
{
    System.out.println();
}
{%endhighlight%}


# Link

[SpaceDocument](./about-jini.html)

# Image

![archi_overview.jpg](/attachment_files/archi_overview.jpg)

# Image Gallery

{% gallery %}

[![ide-0.jpg](/attachment_files/ide-0.jpg)](/attachment_files/ide-0.jpg)
IMG101.jpg

[![ide-1.jpg](/attachment_files/ide-1.jpg)](/attachment_files/ide-1.jpg)
IMG103.jpg

[![ide-2.jpg](/attachment_files/ide-2.jpg)](/attachment_files/ide-2.jpg)
IMG200.png


{% endgallery %}


# Gist
{% gist 1027674 %}

{%endcomment%}

 