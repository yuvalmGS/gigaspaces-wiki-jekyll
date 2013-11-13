---
layout: post
title:  space clean - GigaSpaces CLI
categories: XAP96
---

{% summary %}Removes all Entries and templates from the space.{% endsummary %}

# Syntax

    gs> space clean [variable [value]]

# Description

Removes all Entries and templates from the space.

The `space clean` command is relevant only for spaces in a started state.

{% tip %}
When using a persistent space, the clean operation might take some time because it needs to erase data and close database connections. It should not be called when other clients are using the space.
{% endtip %}

Specifying a container URL prints a numbered list of all the spaces in the container. You can then choose which space to clear, or `all` (clears all spaces).

Specifying a URL of a clustered space prints a list of all spaces in the cluster, and you can choose a space to clear by its number, or `all` (lists all spaces).

{% tip %}
Using `-c` (or `-cluster`) with a URL of a clustered space clears **all** cluster members.
{% endtip %}

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `url` | The URL of the space you want to clear, or of the container -- clears the spaces under that container. | Container URL: `jini://localhost/my_container`{% wbr %}`rmi://localhost:10098/my_container`{% wbr %}Space URL: `jini://localhost/my_container/mySpace`{% wbr %}`rmi://localhost:10098/my_container` |
| `cluster` / `c` | Clears all spaces in the cluster. | |
| `template` | The template for the class of objects you want to remove from the space. | `com.j_spaces.examples.benchmark.messages.MessageSerializable` |
| `help` / `h` | Prints help -- the command's usage and options. | |

# Example

Tbe following prints a numbered list of spaces, and you can choose a space to clear by its number, or `all` (clears all spaces).

    space clean

The following clears all objects in the `MessageSerializable` class, from a space named `mySpace`.

    space clean -url jini://localhost/my_container/mySpace -template com.j_spaces.examples.benchmark.messages.MessageSerializable
