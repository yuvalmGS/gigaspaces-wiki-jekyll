---
layout: post
title:  space copy - GigaSpaces CLI
categories: XAP96
page_id: 61867317
---

{% summary %}Copies all objects from the specified source space to the specified destination space.{% endsummary %}

# Syntax

    gs> space copy [source-space-url] [destination-space-url] [options]

# Description

Copies all objects from the specified source space to the specified destination space. Specify the source and destination space URL by simply typing these after the `copy` command -- first the source space, and then the destination space.

The `space copy` command is relevant only for spaces that are in a started mode.

# Options


{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `-move` | clears the source space after copy | `-move` |
| `help` \ `h` | Prints help -- the command's usage and options. | |

# Example

Copies all objects from a source space named `spaceSource` to a destination space named `spaceDest`:

    space copy jini://localhost/*/spaceSource jini://localhost/*/spaceDest

Copies all objects from a source secured space named `spaceSource` to a destination secured space named `spaceDest`:

    space copy jini://localhost/*/spaceSource jini://localhost/*/spaceDest

If copying from and to a secured space, the logged in user permissions are used (needs read permissions from the source space and write permissions to the destination space). For more information on security, see the [Command Line Interface (CLI) Security](/xap96/2011/05/03/command-line-interface-(cli)-security.html) page.
