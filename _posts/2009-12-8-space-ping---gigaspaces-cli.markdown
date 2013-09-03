---
layout: post
title:  space ping - GigaSpaces CLI
categories: XAP96
page_id: 61867383
---

{% summary %}Provides a convenient way to test a space.{% endsummary %}

# Syntax

    gs> space ping [variable [value]]

# Description

Provides a convenient way to test a space. This option does the following:

- Writes a set of message objects (each with a specific ID and configurable length).
- Reads or takes them.

The average time of write/take is calculated and printed to the console.

This is useful for verifying that a space exists and is running correctly as a basic performance-testing tool.

The `space ping` command is relevant only for spaces in a started state.

You can ping spaces in a specific container (see the options below) -- specifying a container URL prints a numbered list of all the spaces in that container, and you can choose a space to ping by its number, or `all` (ping all spaces).

Specifying a URL of a clustered space prints a list of all spaces in the cluster, and you can choose a space to ping by its number, or `all` (pings all spaces). 

{% tip %}
Using `-c` (or `-cluster`) with a URL of a clustered space pings **all** cluster members.
{% endtip %}

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `url` | The URL of the space you want to restart, or of the container -- pings the spaces under that container. | Container URL: `jini://localhost/my_container`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container`{% wbr %}{% wbr %}Space URL: `jini://localhost/my_container/mySpace`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container` |
| `cluster` / `c` | Pings all cluster members. | |
| `t` |  Sets the message objects' lease timout (in `\[ms\]`). Default is `FOREVER`. | `1000` |
| `ft` | Sets a a timeout (in `\[ms\]`) for the Jini protocol. | `1000` |
| `s` | Sets the byte size of the object. | `128` |
| `i` |  Sets the iteration number. Default is `5`. | `10` |
| `read` | Reads from the space. Cannot be performed together with take -- either read or take is performed. If you do not specify read nor take, read is performed by default. | |
| `take` | Takes from the space. Cannot be performed together with read -- either take or read is performed. If you do not specify read nor take, read is performed by default. | |
| `x` | All operations performed as part of `space ping` are under a transaction. | | 
| `help` \ `h` | Prints help -- the command's usage and options. | |

# Example

The following, writes a set of message objects to the space, and reads them back:

    space ping -url jini://host:port/mySpace_container1/mySpace -read

The following, writes a set of message objects to the space, and takes them from the space:

