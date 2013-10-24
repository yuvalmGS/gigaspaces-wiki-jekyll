---
layout: xap97
title:  The Grid Service Agent
page_id: 61867072
---

{% compositionsetup %}
{% summary page|70 %}A process manager that manages Service Grid processes such as GSM, GSC and LUS{% endsummary %}

# Overview

The Grid Service Agent (GSA) acts as a process manager that can spawn and manage Service Grid processes (Operating System level processes) such as [The Grid Service Manager](./the-grid-service-manager.html), [The Grid Service Container](./the-grid-service-container.html), and [The Lookup Service](./the-lookup-service.html).

Usually, a single GSA is run per machine (on a lookup group or lookup locator level, see more in  [The Lookup Service](./the-lookup-service.html)). The GSA allows to spawn a [Grid Service Manager](./the-grid-service-manager.html), [Grid Service Container](./the-grid-service-container.html), [Lookup Service](./the-lookup-service.html), and custom processes. Once spawned, the GSA assigns a unique id for it and manages its lifecycle. The GSA will restart the process if it exits, or if a specific console output has been encountered (for example, OutOfMemoryError).

The GSA exposes the ability to start, restart, and kill a process either using the [Administration and Monitoring API](./administration-and-monitoring-api.html) or the GigaSpaces UI.

{% lampon %} Although [The Grid Service Manager](./the-grid-service-manager.html), [The Grid Service Container](./the-grid-service-container.html), and [The Lookup Service](./the-lookup-service.html) can be started on their own using their respective scripts, it is preferable that they will be started using the GSA thus allowing to easily monitor and manage them.

# Process Management

The GSA manages Operating System processes. There are two types of process management, local and global.

Local processes simply start the process type (for example, a [Grid Service Container](./the-grid-service-container.html)) without taking into account any other process types running by different GSAs.

Global processes take into account the number of process types ([Grid Service Manager](./the-grid-service-manager.html) for example) that are currently running by other GSAs (within the same lookup groups or lookup locators). It will automatically try and run at least X number of processes **across** all the different GSAs (with a maximum of 1 process type per GSA). If a GSA running a process type that is managed globally fails, another GSA will identify the failure and start it in order to maintain at least X number of global process types.

# Starting the GSA

In order to start the GSA, the `<GSHOME>/bin/gs-agent.(sh/bat)` can be used. The GSA, by default, will start 2 local [Grid Service Container](./the-grid-service-container.html)s, and manage 2 global [Grid Service Manager](./the-grid-service-manager.html)s and 2 global [Lookup Service](./the-lookup-service.html)s.

# Configuring the GSA

JVM parameters (system properties, heap settings etc.) that are shared between all components are best set using the `EXT_JAVA_OPTIONS` environment variable. However, starting from 7.1.1, specific GSA JVM parameters can be easily passed using `GSA_JAVA_OPTIONS` that will be appended to `EXT_JAVA_OPTIONS`. If `GSA_JAVA_OPTIONS` is not defined, the system will behave as in 7.1.0. As a good practice, one can add all components' environment variables ( `GSA_JAVA_OPTIONS`, `GSM_JAVA_OPTIONS`, `GSC_JAVA_OPTIONS`, `LUS_JAVA_OPTIONS`) within the GSA script, or in a wrapper script and the values will be passed to corresponding components.

{% inittab %}
{% tabcontent Linux %}

{% highlight java %}
#Wrapper Script
export GSA_JAVA_OPTIONS=-Xmx256m
export GSC_JAVA_OPTIONS=-Xmx2048m
export GSM_JAVA_OPTIONS=-Xmx1024m
export LUS_JAVA_OPTIONS=-Xmx1024m

#call gs-agent.sh
. ./gs-agent.sh
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Windows %}

{% highlight java %}
@rem Wrapper Script
@set GSA_JAVA_OPTIONS=-Xmx256m
@set GSC_JAVA_OPTIONS=-Xmx2048m
@set GSM_JAVA_OPTIONS=-Xmx1024m
@set LUS_JAVA_OPTIONS=-Xmx1024m

@rem call gs-agent.bat
call gs-agent.bat
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

# GSA Script Parameters

GSA parameters include controlling how many local process the GSA will spawn on startup (per process type), and the number of globally managed process the GSA will maintain (in cooperation with other GSAs) (per process type).

By default, the GSA is started with 2 local [Grid Service Container](./the-grid-service-container.html)s, and manage 2 global [Grid Service Manager](./the-grid-service-manager.html) and 2 global [Lookup Service](./the-lookup-service.html). This is the equivalent of starting the GSA with the following parameters:

{% highlight java %}
gs-agent.(sh/bat) gsa.gsc 2 gsa.global.gsm 2 gsa.global.lus 2
{% endhighlight %}

In order to, for example, start 3 local GSCs, 2 global GSMs, and no global LUS, the following command can be used:

{% highlight java %}
gs-agent.(sh/bat) gsa.gsc 3 gsa.global.gsm 2 gsa.global.lus 0
{% endhighlight %}

In general, the `gsa.\[process type]` followed by a number controls the number of local processes of the specific process type that will be spawned by the GSA. The `gsa.global.\[process type\]` following by a number controls the number of globally managed processes of the specific process type.

# Process Type Configuration

GSA manages different process types. Each process type is defined within the `<GSHOME>\config\gsa` directory in an xml file that identifies the process type by its name.

{% tip %}
You can change the default location of the GSA configuration files using the `com.gigaspaces.grid.gsa.config-directory` system property.
{% endtip %}

The following are the process types that come out of the box:

{: .table .table-bordered}
|Processes Type|Description|XML config file name|Properties file name|
|:-------------|:----------|:-------------------|:-------------------|
|gsc|Defines a [Grid Service Container](./the-grid-service-container.html)|gsc.xml|gsc.properties|
|gsm|Defines a [Grid Service Manager](./the-grid-service-manager.html)|gsm.xml|gsm.properties|
|lus|Defines a [Lookup Service](./the-lookup-service.html)| lus.xml|lus.properties|
|gsm\_lus|Defines a [Grid Service Manager](./the-grid-service-manager.html) and [Lookup Service](./the-lookup-service.html) within the same JVM|gsm\_lus.xml|gsm_lus.properties|
|esm|Defines an Elastic Service Manager which is required for deploying [Elastic Processing Unit](./elastic-processing-unit.html)|esm.xml|esm.properties |

Here is an example of the gsc xml configuration file:

{% highlight xml %}
<process initial-instances="script" shutdown-class="com.gigaspaces.grid.gsa.GigaSpacesShutdownProcessHandler" restart-on-exit="always">
    <script enable="true" work-dir="${com.gs.home}/bin"
            windows="${com.gs.home}/bin/gsc.bat"
            unix="${com.gs.home}/bin/gsc.sh">
        <argument></argument>
    </script>
    <vm enable="true" work-dir="${com.gs.home}/bin"
        main-class="com.gigaspaces.start.SystemBoot">
        <input-argument></input-argument>
        <argument>com.gigaspaces.start.services="GSC"</argument>
    </vm>
    <restart-regex>.*OutOfMemoryError.*</restart-regex>
</process>
{% endhighlight %}

The GSA can either spawn a script based process, or a pure JVM (with its arguments) process. The GSC for example, allows for both types of process spawning.

- The `initial-instances` parameter controls what type of spawning will be performed when the GSA spawns processes by itself (and not on demand by the Admin API).
- The `shutdown-class` followed by the `restart-on-exit` flag, controls if the process will be restarted upon termination.
    - There are three types of values:
        - restart-on-exit="always": Always restarts the process if it exits
        - restart-on-exit="never": Never restarts the process if it exists
        - restart-on-exit="!0": Restarts the process only if the exit code is different than 0
    - The `shutdown-class` is an implementation of `com.gigaspaces.grid.gsa.ShutdownProcessHandler` interface and provides the default shutdown hooks before and after shutdown of a process, to make sure it is shutdown properly. The `shutdown-class` can be omitted.

- The `restart-regex` (there can be more than one element) is applied to each console output line of the managed process, and if there is a match, the GSA will automatically restart the process. By default, the GSC will be restarted if there is an `OutOfMemoryError`.

# Lookup Service Considerations

When starting a [Lookup Service](./the-lookup-service.html) and other services in unicast mode (not multicast), it means that specific machines will be the ones that will run the [Lookup Service](./the-lookup-service.html). This means that on the machines running the LUS, the following command will be used (assuming other defaults are used for GSM and GSC):

{% highlight java %}
gs-agent.(sh/bat) gsa.global.lus 0 gsa.lus 1
{% endhighlight %}

And on machines that will not run the LUS, the following command should be used:

{% highlight java %}
gs-agent.(sh/bat) gsa.global.lus 0
{% endhighlight %}

