---
layout: post
title:  undeploy - GigaSpaces CLI
categories: XAP97
parent: command-line-interface.html
weight: 2000
---

{% summary page|70 %}Undeploys an application from the service grid. {% endsummary %}

# Syntax

    gs> undeploy-application application_name

# Description

Undeploys an [application](./deploying-onto-the-service-grid.html#Application Deployment and Processing Unit Dependencies) from the service grid, while respecting pu dependency order.

{% tip %}
For deploying an application see the [deploy-application ](./deploy-application---gigaspaces-cli.html) command.
{% endtip %}

# Options

{: .table .table-bordered}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| `-timeout` | Allows you to specify a timeout value (in milliseconds) when looking up the GSM to deploy to.
  Defaults to `5000` milliseconds (5 seconds).| `-timeout \[timeoutValue\]`|
| `-undeploy-timeout` | Timeout for deploy operation (in milliseconds), otherwise blocks until all successful/failed deployment events arrive (default)" |`-undeploy-timeout \[timeoutValue\]`|
| `-h` / `-help`  | Prints help | |
| `-secured` | Deploys a secured processing unit (implicit when using -user/-password) - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-secured \[true/false\]`|
| `-user` `-password` | Deploys a secured processing unit propagated with the supplied user and password - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-user xxx -password yyyy`|

# Example

The following undeploys the data-app example application (which includes a feeder and a processor).

    gs> undeploy-application data-app
