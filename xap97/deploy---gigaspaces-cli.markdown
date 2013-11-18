---
layout: post
title:  deploy - GigaSpaces CLI
categories: XAP97
---

{% summary page|70 %}Deploys a Processing Unit onto the Service Grid.{% endsummary %}

# Syntax

    gs> deploy [processing unit jar file / directory location / name]
{% note %}
The `deploy` command replaces the `pudeploy` command and is identical to it in terms of supported arguments and options.
`pudeploy` is still supported but is considered a deprecated command and will be removed in future versions
{% endnote %}

# Description

A Processing Unit can be easily deployed onto the Service Grid. In order to deploy a Processing Unit, the Processing Unit must follow the [processing unit directory structure](./the-processing-unit-structure-and-configuration.html).
Before deploying the processing unit you will need to jar it and then specify that jar file as the parameter to the `deploy` command. The deployment process will upload the jar file to all the GSMs it finds and unpack it under the `deploy` directory. It will then issue the deploy command.

{% tip %}
You may use the [GigaSpaces Universal Deployer](/sbp/universal-deployer.html) to deploy complex multi processing unit applications.
{% endtip %}

# Third Party jars Location and Property Files

Third party jars should be placed within one of the following locations:

- Within the deployed jar under the lib folder - Good if you have relatively small amount of jars and few PU instances within the same GSC. These will be copied automatically by GigaSpaces during the deploy process to the `\gigaspaces-xap-premium\work` folder on all the machines running GSCs hosting the PU instances. You may control this folder location using the `com.gs.work` system property.
- Within the `\gigaspaces-xap-premium\lib\optional\pu-common` folder for each machine running GSCs - Each PU instance will have its own instance of the loaded class. Speed up the deployed time. You may control this folder location using the `com.gs.pu-common` system property.
- Within the `\gigaspaces-xap-premium\lib\platform\ext` folder for each machine running GSCs - All PUs class loaders will share the same loaded class. Speed up the deployed time. Optimize the JVM perm gem space usage since all 3rd party jars are loaded only once. You may control this folder location using the `com.gigaspaces.lib.platform.ext` system property.

Property files and other resources should be jared and placed within any of the above locations.

# Deploy Command Options

{: .table .table-bordered}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| Processing Unit Location/Name -- **mandatory** | The location of the processing unit directory or jar file on your file system (see [this page](./deploying-onto-the-service-grid.html)).{% wbr %}If you are using a few options in the `deploy` command, pass this option as the **last parameter**.{% wbr %}For example: `gs> deploy hello-world.jar`{% wbr %}(`hello-world.jar` is the processing jar file). | |
| `-cluster` |Allows you to control the clustering characteristics of the processing unit.{% wbr %}The cluster option is a simplified option that overrides the cluster part of the processing unit's built in SLA (if such exists).{% wbr %}The following options are available (used automatically by any embedded space included in the Processing Unit):{% wbr %}- `schema` -- the cluster schema used by the Processing Unit.{% wbr %}- `total_members` -- the number of instances, optionally followed by the number of backups{% wbr %}(number of backups is required only if the `partitioned-sync2backup` schema is used). | `-cluster schema=\[schema name\] {% wbr %}otal_members=numberOfInstances[,numberOfBackups\]` |
| `-properties` | Allows you to control [deployment properties](./deployment-properties.html). | `-properties \[bean name\] location` |
| `-sla` | Allows you to specify a link (default to file-system) to a Spring XML configuration, holding the SLA definition. | `-sla \[slaLocation\]` |
| `-zones` | Allows you to specify a list of deployment zones that are to restrict that the deployment to specific GSCs. | `-zones \[zoneName1, zoneName2 ... \]` |
| `-timeout` | Allows you to specify a timeout value (in milliseconds) when looking up the GSM to deploy to.
  Defaults to `5000` milliseconds (5 seconds).| `-timeout \[timeoutValue\]`|
| `-override-name` | Allows you to specify an override name for the deployed Processing Unit{% wbr %}(a different name than the directory name under `deploy`).{% wbr %}Mainly used when using a Processing Unit as a template.| `-override-name \[processing unit name\]` |
| `-max-instances-per-vm` | Allows you to set the SLA number of instances per VM | |
| `-max-instances-per-machine` | Allows you to set the SLA number of instances per machine | |
| `-max-instances-per-zone` | Allows you to set the SLA number of instances per zone in the format of `zoneX/number,zoneY/number` | |
| `h` / `help`  | Prints help | |
| `-secured` | Deploys a secured processing unit (implicit when using -user/-password) - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-secured \[true/false\]`|
| `-user` `-password` | Deploys a secured processing unit propagated with the supplied user and password - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-user xxx -password yyyy`|

{% tip %}
You may use the [Primary-Backup Zone Controller](/sbp/primary-backup-zone-controller.html) to deploy primary and backup on specific different zones.
{% endtip %}

# Example

The following deploys a processing unit jar file named `data-processor.jar` using the `sync_replicated` cluster schema with 2 instances (`total_members`).

    gs> deploy -cluster schema=sync_replicated total_members=2 data-processor.jar

The following deploys a processing unit archive called `data-processor.jar` using deployment properties file called `pu.properties`.

    gs> deploy -properties file://config/pu.properties data-processor.jar

The following deploys a processing unit archive called `data-processor.jar` using an SLA element read from an external `sla.xml` file.

    gs> deploy -sla file://config/sla.xml data-processor.jar

The following example deploys a `partitioned-sync2backup` space cluster with the name `mySpace` for both the processing unit and the Space it contains.

    deploy -cluster schema=partitioned-sync2backup total_members=2,1 -override-name mySpace -properties embed://dataGridName=mySpace myPUFolder

{% tip %}
Multiple deployment properties can be injected by having ; between each property - see below example:

{% highlight java %}
>gs deploy -cluster schema=partitioned-sync2backup total_members=10,1
-properties "embed://dataGridName=myIMDG;space-config.proxy.router.active-server-lookup-timeout=5000;space-config.engine.max_threads=256"
-override-name myPU /tmp/myPu.jar
{% endhighlight %}
{% endtip %}

