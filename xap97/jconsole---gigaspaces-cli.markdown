---
layout: post
title:  jconsole - GigaSpaces CLI
page_id: 61867281
---

{% summary page|60 %}Launches Admin UI for browsing the JMX instance associated with a specific GSC. {% endsummary %}

# Syntax

    gs> jconsole [jmx-connection-string]

# Description

The `jconsole` command launches the Service Grid Admin UI, allowing you to browse the JMX instance associated with a specific Grid Service Container (GSC).

{% tip %}
JMX provides remote management capabilities for monitoring memory utilization, VM system configuration, performance and garbage collection characteristics etc. By default, each GSC is set to run a JMX enabled VM.
{% endtip %}

{% tip %}
For more details on monitoring and management using JMX, refer to the [JMX Management](./space-jmx-management.html) section.
{% endtip %}

{% include /COM7/jconsolejmapwarning.markdown %}

# Options

{: .table .table-bordered}
| Option | Description |
|:-------|:------------|
| `jmx-connection-string` | The JMX connection string to be used for starting the Java Management Console. If not provided, a selection list of all GSCs is displayed. You can select the appropriate instance from the list. |
| `h` / `help`  | Prints help |

# Example

    gs> jconsole
    total services 2
    [1]   Grid Service Container   gs-grid   69.203.99.5
    [2]   Grid Service Manager     gs-grid   69.203.99.5

    Choose a service for jconsole support or "c" to cancel : 1
    Launching jconsole, command successful

    gs> jconsole service:jmx:rmi:///jndi/rmi://192.10.10.10:10098/jmxrmi
    Launching jconsole, command successful
