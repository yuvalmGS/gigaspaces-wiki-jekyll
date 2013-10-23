---
layout: post
title:  Test Page
page_id: 61867355
---



{%next ur=/xapqsg/java-tutorial-part2.html|text=Next step in the tutorial is  %}

{%endnext%}

{%try%}http://www.google.com{%endtry%}

{%learn%}/xap97/qsg-part-9.html{%endlearn%}


{%gist /croffler/c6acf31bc9f23dc921eb %}

# Indent

{%indent 30 %}I ma indented {%endindent%}

{%summary%}This is a test page {%endsummary%}

# Notes and tips

{%exclamation%} This is an exclamation mark !

{%info%}this is an information {%endinfo%}

{%note%}this is an note {%endnote%}

{%tip%}This is a tip {%endtip%}

{%quote%}This is a quote{%endquote%}

{%warning%}This is a warning{%endwarning%}

{%remove%} This is a remove

{%plus%}This is a plus sign

{%question%}This is a question

{%lampon%}Lamp on

{%lampoff%}Lamp off

{%infosign%} This is an info sign

{%star%} This is a star

{%oksign%} This is an OK sign

{%sub%} This is a sub  {%endsub%}

{%refer%} This is refer   {%endrefer%}


# Anchor

[Layouts](#layout)

{%comment%} Make sure that there is an empty line below the anchor tag !!!!!!{%endcomment%}

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

 