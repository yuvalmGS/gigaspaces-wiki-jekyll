---
layout: post
title:  Test Page
categories: HOWTO
---



<div class="panel-group" id="accordion1">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion1" href="#collapseOne">
          Collapsible Group Item #1
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse ">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion1" href="#collapseTwo">
          Collapsible Group Item #2
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion1" href="#collapseThree">
          Collapsible Group Item #3
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">
        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
      </div>
    </div>
  </div>
</div>





# Tab in Tab

{% accordion id=chrisroffler%}
{% accord Java  %}
dfdsfdnfndfnnd,sf
 dsfdfdkfkldkfkd;lf
 fkdskfldkflkdlf
{% endaccord%}
{% accord C#  %}
hggjgjgjgjgj
{% endaccord%}
{% accord c++ %}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% accord Scala %}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% endaccordion %}


# Tab in Tab2

{% accordion id=chrisroffler1%}
{% accord Java %}
dfdsfdnfndfnnd,sf
 dsfdfdkfkldkfkd;lf
 fkdskfldkflkdlf
{% endaccord%}
{% accord C#  %}
{% endaccord%}
{% accord c++ %}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% accord Scala %}
fdskfkdsfkjdksjfjdf
kfdlkflkdl;fkl;dsf
kfdskflkdlfkldklfd
{% endaccord%}
{% endaccordion %}





{%next ur=/xapqsg/java-tutorial-part2.html|text=Next step in the tutorial is  %}

{%endnext%}

{%try%}http://www.google.com{%endtry%}

{%learn%}/xap97/qsg-part-9.html{%endlearn%}


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



{%comment%}
### Platform Configuration

You will find the platform specific configuration under GS_HOME\NET v....\Config\Settings.xml.


{%include /xap97source/dotnet/Settings-xml.markdown %}

{%endcomment%}




