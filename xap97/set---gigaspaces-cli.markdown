---
layout: post
title:  set - GigaSpaces CLI
page_id: 61867146
---

{% summary %}Sets the Service Grid system environment variables. {% endsummary %}

# Syntax

    gs> set [variable [value]]

# Description

The `set` comand sets the Service Grid system environment variables.

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `groups` | The Jini lookup groups value. The group filters the specific group of services that should be managed by the current shell context. | * List of comma-delimited names: `group1,group2,...`{% wbr %}    - `all_groups` assigns the current context to all available GridService elements in the network. |
| `locators` | A list of Jini locators hosts. The locators provide an alternate discovery mechanism, if multicast is not working. The locator points to the location of Jini lookup hosts. Normally a lookup service is running as an embedded instance with the Grid Service Monitor (GSM). | `jini://<hostname1>`{% wbr %}    To set several locators you have to execute:{% wbr %}    `set locators jini://<hostname1>`{% wbr %}    `set locators jini://<hostname2>`{% wbr %}    ...{% wbr %}    To empty the locators variable you have to execute:{% wbr %}
`set locators null` |
| `system-props` | Should be one of the properties used by the system. Omit this parameter to view a list of the available properties. | `<system property name>=<property value>` |
| `disco-timeout` | Jini discovery timeout \[in ms\]. Defines the time for waiting for service discovery announcements. Relevant for multicast discovery only. | |
| `wait-on-deploy` | Timeout \[in ms\] for finding deployable servers. | |
| `deploy-timeout` | Timeout \[in ms\] for blocking for deployment status. |

{% tip %}
Make sure your network and machines running GigaSpaces are configured to have multicast enabled.
See the [How to Configure Multicast](/xap96/how-to-configure-multicast.html) section for details on how to enable multicast.
{% endtip %}

# Examples

{% toczone location=top|type=flat|separator=pipe|minLevel=2|maxlevel=2 %}

## Displaying Current System Variables

    gs> set
    groups ALL_GROUPS
    locators null
    system-props com.gigaspaces.grid.lib=C:demosGS-Cache1362GigaSpacesXAP6.0ServiceGridlib
    com.gigaspaces.grid.home=C:demosGS-Cache1362GigaSpacesXAP6.0ServiceGrid
    com.gs.jini_lus.groups=gigaspaces-1346
    com.gigaspaces.jini.lib=C:demosGS-Cache1362GigaSpacesXAP6.0ServiceGrid..libjini
    com.gigaspaces.lib=C:demosGS-Cache1362GigaSpacesXAP6.0ServiceGrid..lib
    com.gs.home= C:demosGS
    disco-timeout 5000
    wait-on-deploy true
    deploy-timeout 5000

## Setting New Location for Two Properties with Timeout

This example sets new locations for the properties `com.gigaspaces.lib` and `com.gs.home`, with a timeout of five and a half seconds for discovery.

    gs> set system-props com.gigaspaces.lib=c:gslib,com.gs.home=c:gs
    gs> set discovery-timeout 5500
    gs> set groups all_groups
    gs> set groups gs-grid,test

{% endtoczone %}
