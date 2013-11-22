---
layout: post
title:  Authoring Guidelines
categories: HOWTO
parent: none
---


* We use [Markdown](http://daringfireball.net/projects/markdown) as markup language for all the documentation pages. Please refer to [the markdown syntax guide](http://daringfireball.net/projects/markdown/syntax) for more details. That also means that all files should have the `.markdown` extension.

* All pages should start with a [yaml front matter](http://jekyllrb.com/docs/frontmatter/), which basically looks like this (See one of the existing pages under xap97 or xap97net for a full example):

{%raw%}
\---
layout: post
title:  About Jini
weight: 100
categories: XAP97
\---
{%endraw%}

 * `layout` refers to the page layout, which essentially determins the HTML elemenets that wrap the page content. The appropriate layout for every documentation page is `post`.
 * `title` is the page title, as will appear in the page itself and the table of contents.
 You don't need to refer to other elements if such exist.


{%comment%}
* XAP versions: each XAP version is placed under its own directory. For example, XAP 9.7 is placed under `xap97` and XAP.NET 9.7 is placed under `xap97net`.

* Images and other attached files: all images should placed under the directory `attachement_files`. Images and files that are shared between version should be placed at the root of this folder, images specific to a certain version (that you don't expect to be relevant to future versions) should be placed under a directory that has the same name (e.g. `xap97`).

* Special markup helpers (summary section, documentation links, code blocks, tabbed views, tips, info box, warning box, etc.) are described [below](#available-markup-helpers-jekyll-plugins).

* Tables can be created using the following syntax:

```
{: .table .table-bordered}
|Header1|Header2|Header3|
|:------|:------|:------|
|value1 |value2 |very long value in my table|
```
* HTML snippets: Markdown supports direct HTML injection, so you can always embed a complete html snippet to the page in case there's some formatting, markup or element that is not supported (e.g. embedding a slideshare deck).

## Available Markup Helpers (Jekyll Plugins)

The following table contains a list of available plugins and simple example for how to use each within markdown files. This is not an exhaustive list and contains only the main and most commonly used plugins, the entire set of plugins can be found in the [`_plugins`](_plugins) directory, and usage samples for all plugins can be found within the documentation pages.

* `align`

* `anchor`

* `bgcolor`

* `children`

* `cloack`

* `color`

* `comment`

* `currentversion`

* `dotnetdoc`

* `exclamation`

* `fontsize`

* `indent`

* `info`

* `infosign`

* `javadoc`

* `lampoff`

* `latestxaprelease`

* `lampon`

* `learn`

* `lozenge`

* `minus`

* `next`

* `note`

* `oksign`

* `panel`

* `plus`

* `question`

* `quote`

* `redirect`

* `refer`

* `remove`

* `scaladoc`

* `section`

* `star`

* `summary`
Creates a summary section at the top of the page. The section will include the text in the markup help, and shotcut links to all h1 titles in the page (every title which is prefixed by a single `#` sign).

 * __Usage__:
```
{% summary %}This is a page summary.{% endsummary %}
```
 * __Parameters__: None

* `tabs`

* `tip`

* `warning`

* `wbr`

* `whr`

{%endcomment%}


## Chapters in this Guide

{% children %}



