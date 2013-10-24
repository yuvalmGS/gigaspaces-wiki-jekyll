---
layout: xap97
title:  deploy-space GigaSpaces CLI
page_id: 61867333
---

{% summary page|70 %}Deploys a Space onto the Service Grid.{% endsummary %}

# Syntax

    gs> deploy-space [space name]

# Description

A Space only Processing Unit can be easily deployed onto the Service Grid.

# Options

{: .table .table-bordered}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| Space Name -- **mandatory** | The name of the space to be deployed.| |
| `-cluster` |Allows you to control the clustering characteristics of the space.{% wbr %}The following options are available (used automatically by any embedded space included in the Processing Unit):{% wbr %}- `schema` -- the cluster schema used by the Processing Unit.{% wbr %}- `total_members` -- the number of instances, optionally followed by the number of backups {% wbr %}  (number of backups is required only if the `partitioned-sync2backup` schema is used). | `-cluster schema=\[schema name\]`{% wbr %}`total_members=numberOfInstances[,numberOfBackups\]` |
| `-properties` | Allows you to control [deployment properties](./deployment-properties.html). | `-properties \[bean name\] location` |
| `-sla` | Allows you to specify a link (default to file-system) to a Spring XML configuration, holding the SLA definition. | `-sla \[slaLocation\]` |
| `-zones` | Allows you to specify a list of deployment zones that are to restrict that the deployment to specific GSCs. | `-zones \[zoneName1, zoneName2 ... \]` |
| `-max-instances-per-vm` | Allows you to set the SLA number of instances per VM | |
| `-max-instances-per-machine` | Allows you to set the SLA number of instances per machine | |
| `-max-instances-per-zone` | Allows you to set the SLA number of instances per zone in the format of `zoneX/number,zoneY/number` | |
| `h` / `help`  | Prints help | |
| `-secured` | Deploys a secured processing unit (implicit when using -user/-password) - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-secured \[true/false\]`|
| `-user` `-password` | Deploys a secured processing unit propagated with the supplied user and password - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-user xxx -password yyyy`|

{% tip %}
You may use the [GigaSpaces Universal Deployer](http://wiki.gigaspaces.com/wiki/display/SBP/Universal+Deployer) to deploy complex multi processing unit applications.
{% endtip %}

{% tip %}
 You may use the [Primary-Backup Zone Controller](http://wiki.gigaspaces.com/wiki/display/SBP/Primary-Backup+Zone+Controller) to deploy primary and backup instances on different zones.
{% endtip %}

# Example

The following deploys a space named `mySpace` using the `sync_replicated` cluster schema with 2 instances (`total_members`).

    gs> deploy-space -cluster schema=sync_replicated total_members=2 mySpace

The following deploys a space named `mySpace` using deployment properties file called `pu.properties`.

    gs> deploy-space -properties file://config/pu.properties mySpace

The following deploys a space called `mySpace` using an SLA element read from an external `sla.xml` file.

    gs> deploy-space -sla file://config/sla.xml mySpace
