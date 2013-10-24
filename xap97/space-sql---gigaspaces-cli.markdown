---
layout: xap97
title:  space sql - GigaSpaces CLI
page_id: 61867046
---

{% summary %}Queries specified space.{% endsummary %}

# Syntax

    gs> space sql [variable [value]]

# Description

Queries the space you specified -- according to the space URL and SQL query supplied.

You can query spaces in a specific container (see the options below) -- specifying a container URL prints a numbered list of all the spaces in that container, and you can choose a space to query by its number, or all spaces (queries all spaces).

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|--------------|
| `url` | The URL of the space you want to restart, or of the container -- restarts the spaces under that container -- **mandatory option**. | Container URL: `jini://localhost/my_container`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container`{% wbr %}{% wbr %}Space URL: `jini://localhost/my_container/mySpace`{% wbr %}{% wbr %}`rmi://localhost:10098/my_container` |
| `query` | The query that is run on the space -- **mandatory option**. | `select uid,* from com.j_spaces.examples.benchmark.messages.Message WHERE rownum<10` |
| `multispace` | Indicates if this query is multi space, default is single space. | |
| `help` \ `h` | Prints help -- the command's usage and options. | |

# Example

    space sql -url rmi://localhost:10098/mySpace_container/mySpace -query select uid,* from com.j_spaces.examples.benchmark.messages.Message
    WHERE rownum<10
