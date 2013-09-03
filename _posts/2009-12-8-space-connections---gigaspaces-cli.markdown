---
layout: post
title:  space connections - GigaSpaces CLI
categories: XAP96
page_id: 61867230
---

{% summary page|60 %}Displays all live connections to the specified space.{% endsummary %}

# Syntax

    gs> space connections [variable [value]]

# Description

Displays all live connections to the specified space. 

{% lampon %} It is also possible to retrieve space connections using the GigaSpaces UI **[Connections view](/xap96/2011/04/12/connections-view---gigaspaces-browser.html)**.

The information that is shown:

- The space and container name
- The server IP adress
- The client(s) IP adress and port
- Connection time -- when the server connected to the space

You can view the connections of spaces in a specific container (see the options below) -- specifying a container URL prints a numbered list of all the spaces in that container, and you can choose a space to view by its number, or all spaces (restart all spaces).

Specifying a URL of a clustered space prints a list of all spaces in the cluster, and you can choose a space to view by its number, or `all` (displays all spaces). 

{% infosign %} Using `-c` (or `-cluster`) with a URL of a clustered space displays live connections of **all** cluster members.

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `url` | The URL of the space you want to view, or of the container -- displays live connections of the spaces under that container. | Container URL: `jini://localhost/my_container`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container`{% wbr %}{% wbr %}Space URL: `jini://localhost/my_container/mySpace`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container` |
| `c` \ `cluster` | Displays the live connections of all cluster members. | |
| `help` \ `h` | Prints help -- the command's usage and options. | |

# Example

