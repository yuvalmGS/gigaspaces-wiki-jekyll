---
layout: post
title:  deploy-memcached - GigaSpaces CLI
page_id: 61867167
---

{% summary page|70 %}Deploys a memcached-enabled space onto the service grid. {% endsummary %}

# Syntax

    gs> deploy-memcached [-sla ...] [-cluster ...] [-properties ...] [-user xxx -password yyy] [-secured true/false] space_url

# Description

Deploys a [memcached-enabled space](/xap96/memcached-api.html), which exposes the [memcached protocol](http://code.google.com/p/memcached/wiki/NewProtocols), onto the service grid.

# Options

{: .table .table-bordered}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| space_url | The url of the space, can be embedded, eg: `/./myMemcachedSpace`, or remote eg: `jini://*/*/myMemcachedSpace` | |
| `-cluster` |Allows you to control the clustering characteristics of the processing unit. {% wbr %}The cluster option is a simplified option that overrides the cluster part of the processing unit's built in SLA (if such exists). {% wbr %}The following options are available (used automatically by any embedded space included in the Processing Unit):{% wbr %}- `schema` -- the cluster schema used by the Processing Unit.{% wbr %}- `total_members` -- the number of instances, optionally followed by the number of backups {% wbr %}(number of backups is required only if the `partitioned-sync2backup` schema is used). | `-cluster schema=\[schema name\] total_members=numberOfInstances[,numberOfBackups\]` |
| `-properties` | Allows you to control [deployment properties](/xap96/deployment-properties.html). | `-properties \[bean name\] location` |
| `-sla` | Allows you to specify a link (defaults to file-system) to a Spring XML configuration, holding the SLA definition. | `-sla \[slaLocation\]` |
| `-zones` | Allows you to specify a list of deployment zones that are to restrict that the deployment to specific GSCs. | `-zones \[zoneName1, zoneName2 ... \]` |
| `-timeout` | Allows you to specify a timeout value (in milliseconds) when looking up the GSM to deploy to.{% wbr %}Defaults to `5000` milliseconds (5 seconds).| `-timeout \[timeoutValue\]`|
| `-max-instances-per-vm` | Allows you to set the SLA number of instances per VM | |
| `-max-instances-per-machine` | Allows you to set the SLA number of instances per machine | |
| `-max-instances-per-zone` | Allows you to set the SLA number of instances per zone in the format of `zoneX/number,zoneY/number` | |
| `h` / `help`  | Prints help | |
| `-secured` | Deploys a secured processing unit (implicit when using -user/-password) - [(CLI) Security](/xap96/command-line-interface-(cli)-security.html)| `-secured \[true/false\]`|
| `-user` `-password` | Deploys a secured processing unit propagated with the supplied user and password - [(CLI) Security](/xap96/command-line-interface-(cli)-security.html)| `-user xxx -password yyyy`|

{% tip %}
You can use the [GigaSpaces Universal Deployer](/sbp/universal-deployer.html) to deploy complex multi processing unit applications.
{% endtip %}

# Example

The following deploys a memcached-enabled space named `mySpace` using the `partitioned-sync2backup` cluster schema with 2 primaries and 1 primary per backup.

    gs> deploy-memcached -cluster schema=partitioned-sync2backup total_members=2,1 mySpace

The following deploys a memcached-enabled space called `mySpace` using an SLA element read from an external `sla.xml` file.

    gs> deploy-space -sla file://config/sla.xml mySpace

