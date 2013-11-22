---
layout: post
title:  space list - GigaSpaces CLI
categories: XAP97
parent: space---gigaspaces-cli.html
weight: 700

---

{% summary %}Lists spaces in the network.{% endsummary %}

# Syntax

    gs> space list [variable [value]]

# Description

Lists spaces in the network. Displays the space URL and if it includes a cluster schema, displays the type of the schema.

You can list spaces in a specific container (see the options below) -- specifying a container URL lists all the spaces in that container.

Specifying a URL of a clustered space prints a list of all spaces in the cluster, and you can choose a space to see by its number, or `all` (lists all spaces).

{% lampon %} Using `\-c` (or `\-cluster`) with a URL of a clustered space lists **all** cluster members.

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `url` | The URL of the space you want to see, or of the container -- lists the spaces under that container. | Container URL: `jini://localhost/my_container`{% wbr %}`    rmi://localhost:10098/my_container`{% wbr %}Space URL: `jini://localhost/my_container/mySpace`{% wbr %}`    rmi://localhost:10098/my_container` |
| `cluster` / `c` | Lists all spaces in the cluster. | |
| `stats` | Displays the number of times different operations are performed in the space. | |
| `noRTI` / `noCount` | Instructs the system not to display the number of objects and templates in the space as part of the list. | |
| `help` / `h` | Prints help -- the command's usage and options. | |

# Example

The following lists all spaces in the network:

    space list

The following lists a space named `mySpace`, displays the operation statistics for this space, and does not display the number of objects and templates in the space.

    space list -url jini://localhost/my_container/mySpace -stats -noRTI
