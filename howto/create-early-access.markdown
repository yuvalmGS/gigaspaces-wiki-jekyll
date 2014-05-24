---
layout: post
title:  Creating a new Version
parent: none
weight: 300
categories: HOWTO
---

{%summary%}{%endsummary%}


In this example we will assume that the current version of XAP is 9.7, and the new version will be 10.0. We will use these release numbers for our example.


# Create navbars

In the directory `/_includes`

####  Copy `navbar97.html` and rename it to `navbar100.html`

In the newly created file search for : `<a href="/xap97/index.html">Admin</a>`{%wbr%}
Replace it with the following context: `<a href="/xap100/index.html">Admin</a>`

####  Copy `navbar97adm.html` and rename it to `navbar100adm.html`

In the newly created file search for : `<a href="/xap97adm/index.html">Admin</a>`{%wbr%}
Replace it with the following context: `<a href="/xap100adm/index.html">Admin</a>`

# Create new post templates

In the directory `/_layouts`

#### Copy `post97.html` and rename it to `post100.html`

In the newly created file search for : {%raw%}{% include navbar97.html %}{%endraw%} {%wbr%}
Replace it with the following context: {%raw%}{% include navbar100.html %}{%endraw%}

In the newly created file search for : {%raw%}{% include footer.html %}{%endraw%}{%wbr%}
Replace it with the following context: {%raw%}{% include early-access-footer.html %}{%endraw%}

#### Copy `post97adm.html` and rename it to `post100adm.html`

In the newly created file search for : {%raw%}{% include navbar97adm.html %}{%endraw%}{%wbr%}
Replace it with the following context: {%raw%}{% include navbar100adm.html %}{%endraw%}

In the newly created file search for : {%raw%}{% include footer.html %}{%endraw%}{%wbr%}
Replace it with the following context: {%raw%}{% include early-access-footer.html %}{%endraw%}


# Early access footer:

In the `/_includes/early-access-footer.html` file search for `Early Access XAP 9.7 Documentation. The current official release is <a href="/xap97">9.7</a></p>`
and replace the text to  `Early Access XAP 10.0 Documentation`.

# Create Pages

####  Copy the `/xap97` folder and rename it to `xap100`

In this new directory `/xap100` replace in all files the  yaml front matter `post` and `categories` tags with `100`.

Example:

{%section%}
{%column%}
{%highlight java%}
---
layout: post97
title:  Administration Tools
categories: XAP97
weight: 760
parent: none
---
{%endhighlight%}
{%endcolumn%}
{%column%}
{%wbr%}{%wbr%}{%wbr%}
====>>>
{%endcolumn%}
{%column%}
{%highlight java%}
---
layout: post100
title:  Administration Tools
categories: XAP100
weight: 760
parent: none
---
{%endhighlight%}
{%endcolumn%}
{%endsection%}


####  Copy the `/xap97adm` folder and rename it to `xap100adm`

In this new directory `/xap100adm` replace in all files the  yaml front matter `post` and `categories` tags with `100`.

Example:

{%section%}
{%column%}
{%highlight java%}
---
layout: post97adm
title:  Administration Tools
categories: XAP97ADM
weight: 760
parent: none
---
{%endhighlight%}
{%endcolumn%}
{%column%}
{%wbr%}{%wbr%}{%wbr%}
====>>>
{%endcolumn%}
{%column%}
{%highlight java%}
---
layout: post100adm
title:  Administration Tools
categories: XAP100ADM
weight: 760
parent: none
---
{%endhighlight%}
{%endcolumn%}
{%endsection%}


#### Copy the `/xap97net` folder and rename it to `xap100net`

 In this new directory `/xap100net` replace in all files the  yaml front matter tags `post` and `categories` with `100`.

 Example:

 {%section%}
 {%column%}
 {%highlight java%}
 ---
 layout: post97
 title:  Administration Tools
 categories: XAP97NET
 weight: 760
 parent: none
 ---
 {%endhighlight%}
 {%endcolumn%}
 {%column%}
 {%wbr%}{%wbr%}{%wbr%}
 ====>>>
 {%endcolumn%}
 {%column%}
 {%highlight java%}
 ---
 layout: post100
 title:  Administration Tools
 categories: XAP100NET
 weight: 760
 parent: none
 ---
 {%endhighlight%}
 {%endcolumn%}
 {%endsection%}


# Create new Categories

In the file `/_config.yml` add the following new categories:

categories-list: [.....,"XAP100", "XAP100NET", "XAP100ADM"]


# Update Landing Pages

In the file  `/xap100/index.html`:

- search for  `<h1>XAP 9.7 for Java Documentation</h1>` and replace it with `<h1>XAP 10.0 for Java Documentation</h1>`{%wbr%}
- search for  `Welcome to the Java documentation portal` and replace it with `Welcome to the <b>Early Access</b> Java documentation portal`

In the file  `/xap100net/index.html`:

- search for  `<h1>XAP.NET 9.7 Documentation</h1>` and replace it with `<h1>XAP.NET 10.0 Documentation</h1>`{%wbr%}
- search for  `Welcome to the Java documentation portal` and replace it with `Welcome to the <b>Early Access</b> .NET documentation portal`


# Updating Main Menu

In the file `/_includes/navbar.html`

Search for  `<li><a href="/xap97">9.7</a></li>` and add right above it the following line : `<li><a href="/xap100">10.0 Early Access</a></li>`

There are two links in this file, one for Java and one for .NET, add in both places the menu item.