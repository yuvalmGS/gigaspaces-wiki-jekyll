---
layout: xap97
title:  task - GigaSpaces CLI
page_id: 61867312
---

{% summary %}Submits a task in the form of an Ant configuration file. {% endsummary %}

# Syntax

    usage: task ant-file [target=target-name]

# Description

The `task` command submits a task in the form of an Ant configuration file..

# Options

{: .table .table-bordered}
| Option | Description |
|:-------|:------------|
| `ant-file` | The name of the Ant configuration file, an XML file representing the task. The file must reside in the current directory. |
| `list-of-machines` | A comma-separated list of hostnames or of IP addresses, or the name of a file containing such a list, saying where to submit the Ant configuration file. By default, if machines are available, you receive a list to choose from. If no machines are currently available, are prompted to start an HTTP server. |
