---
layout: post
title:  space config - GigaSpaces CLI
categories: XAP97
parent: space---gigaspaces-cli.html
weight: 400
---

{% summary %}Displays the specified spaces's configuration details.{% endsummary %}

# Syntax

    gs> space config [variable [value]]

# Description

Displays the specified spaces's configuration details: space configuration, container configuration, cluster configuration, system properties, system environment and variables, Java properties, network interfaces, GigaSpaces build or version.

You can view the configuration details of spaces in a specific container (see the options below) -- specifying a container URL prints a numbered list of all the spaces in that container, and you can choose a space to view by its number, or `all` (view all spaces).

Specifying a URL of a clustered space prints a list of all spaces in the cluster, and you can choose a space to view by its number, or `all` (view all spaces).

{% tip %}
Using `-c` (or `-cluster`) with a URL of a clustered space displays configuration details of **all** cluster members.
{% endtip %}

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `url` | The URL of the space you want to view, or of the container -- shows the configuraion details of spaces under that container. | Container URL: `jini://localhost/my_container`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container`{% wbr %}{% wbr %}Space URL: `jini://localhost/my_container/mySpace`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container` |
| `cluster` \ `c` | Displays the configuration details of all cluster members. | |
| `help` \ `h` | Prints help -- the command's usage and options. | |

# Example

