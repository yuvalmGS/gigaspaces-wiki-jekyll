---
layout: post
title:  space cluster-members - GigaSpaces CLI
categories: XAP97
parent: space---gigaspaces-cli.html
weight: 300
---

{% summary  %}Show the full list of cluster members, including members that aren't "alive".{% endsummary %}

# Syntax

    gs> space cluster-members [variable [value]]

# Description

This command prints a list of all cluster members (spaces belonging to the specified cluster), including members that are not "alive". The list includes each member's name, whether it is alive or not (`is alive`), and its URL. Additionally, the command prints out the total number of members (including members that aren't alive), and the total number of live members.

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `-url` | Specify one of the following:{% wbr %}* The space URL of any member belonging to the cluster{% wbr %}* A URL containing the cluster name{% wbr %}* A URL containing the Jini group and the cluster name | * Member URL -- `jini://*/trade_cache_container1/trade_cache?groups=gigaspaces-{%currentversion%}XAP`{% wbr %}* Cluster name -- `space cluster-members -url jini://*/*/*?clustername=test`{% wbr %}* Jini group and cluster name -- `space cluster-members -url jini://*/*/*?groups=gigaspaces-{%currentversion%}XAP-Evgeny&clustername=test` |

# Example

The following prints a list of all members in a cluster named `test`:

    space cluster-members -url jini://*/*/*?groups=gigaspaces-{%currentversion%}XAP&clustername=test

The following prints a list of all members in the same cluster as the `gigaspaces-{%currentversion%}XAP` member:

    space cluster-members -url jini://*/trade_cache_container1/trade_cache?groups=gigaspaces-{%currentversion%}XAP

The same functionality can be achieved by running the following command, using only the cluster name:

    space cluster-members -clustername myClusterName
