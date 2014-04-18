---
layout: post97
title:  The Runtime Environment
categories: XAP97NET
parent: administrators-guide.html
weight: 100
---

{% summary %}This section gives a detailed description of the GigaSpaces deployment & runtime environment.{% endsummary %}

{% anchor GSRuntimeEnv %}

A processing unit is deployed onto the XAP runtime environment, which is called the [Service Grid](/product_overview/the-runtime-environment.html). It is responsible for materializing the processing unit’s configuration, provisioning its instances to the runtime infrastructure and making sure they continue to run properly over time.

{%comment%}
# The GigaSpaces Runtime Environment

The basic unit of deployment in the GigaSpaces XAP platform is the [Processing Unit](./packaging-and-deployment.html).

Once packaged, a processing unit is deployed onto the GigaSpaces runtime environment, which is called the **Service Grid**. It is responsible for materializing the processing unit's configuration, provisioning its instances to the runtime infrastructure and making sure they continue to run properly over time.
![archi_deployenv.jpg](/attachment_files/dotnet/archi_deployenv.jpg)

{% info %}
When developing your processing unit, you can [run and debug the processing unit within your IDE]({% currentjavaurl %}/running-and-debugging-within-your-ide.html). You will typically deploy it to the GigaSpaces runtime environment when it's ready for production or when you want to run it in the real-life runtime environment
{% endinfo %}

# Service Grid Architecture

The service grid is composed of a number of components:
![gs_runtime-core.jpg](/attachment_files/dotnet/gs_runtime-core.jpg)

## Core Components

A processing unit can be deployed to the Service Grid using one of GigaSpaces deployment tools (UI, CLI, API), which uploads it to the **GSM** ([Grid Service Manager](/product_overview/service-grid.html#gsm), the component which manages the deployment and life cycle of the processing unit). The GSM analyzes the deployment descriptor and determines how many instances of the processing unit should be created, and which containers should run them. It then ships the processing unit code to the running **GSC**'s ([Grid Service Container](/product_overview/service-grid.html#gsc)) and instructs them to instantiate the processing unit instances. The GSC provides an isolated runtime for the processing unit instance, and exposes its state to the GSM for monitoring.  This phase in the deployment process is called **provisioning**.

Once provisioned, the GSM continuously monitors the processing unit instances to determine if they're functioning properly or not. When a certain instance fails, the GSM identifies that and re-provisions the failed instance on to another GSC, thus enforcing the processing unit's SLA.

In order to discover one another in the network, the GSCs and GSMs use a [Lookup Service](/product_overview/service-grid.html#lus), also called **LUS**. Each GSM and GSC registers itself in the LUS, and monitors the LUS to discover other GSM and GSC instances.

Finally, the **GSA** ([Grid Service Agent](/product_overview/service-grid.html#gsa)) component is used to start and manage the other components of the Service Grid (i.e. GSC, GSM, LUS). Typically, the GSA is started with the hosting machine's startup. Using the agent, you can bootstrap the entire cluster very easily, and start and stop additional GSCs, GSMs and lookup services at will.

All of the above components are fully manageable from the GigaSpaces management interfaces such as the [UI]({% currentjavaurl %}/graphical-user-interface.html), CLI and [Admin API](./administration-and-monitoring-api.html).

{%endcomment%}

# Starting a Service Grid

The Service Grid can be started in two fashions:

1. **Console Application** - using `<GSHOME>\bin\gs-agent.exe`
2. **Windows Service** - using the [GigaSpaces Services Manager](./gigaspaces-services-manager.html) tool bundled with XAP.NET.

Usually the console application is used by developers whereas the Windows service is used in production environments.

The preferable (and easiest) way to start a Service Grid is the [Grid Service Agent (GSA)](/product_overview/service-grid.html#gsa). However, each of the components can be started manually.

The following table summarized how to start each component:

{: .table .table-bordered}
| Component | Linux (XAP) | Windows (XAP) | Windows (XAP.NET) |
| GSA | `gs-agent.sh` | `gs-agent.bat` | gs-agent.exe |
| GSC | `gsc.sh` | `gsc.bat` | `gsc.exe` |
| GSM | `gsm_nolus.sh` | `gsm_nolus.bat` | N\A |
| LUS | `startJiniLUS.sh` | `startJiniLUS.bat` | `lus.exe` |
| GSM + LUS | `gsm.sh` | `gsm.bat` | `gsm.exe` |

## GSA Parameters

The GSA parameters control how many local process the GSA will spawn on startup (per process type), and the number of globally managed process the GSA will maintain (in cooperation with other GSAs) (per process type). By default, the GSA is started with 2 local [Grid Service Container](/product_overview/service-grid.html#gsc), and manage 2 global [Grid Service Manager](/product_overview/service-grid.html#gsm) and 2 global [Lookup Service](/product_overview/service-grid.html#lus). This is the equivalent of starting the GSA with the following parameters:

{% highlight java %}
gs-agent gsa.gsc 2 gsa.global.gsm 2 gsa.global.lus 2
{% endhighlight %}

In order to, for example, start 3 local GSCs, 2 global GSMs, and no global LUS, the following command can be used:

{% highlight java %}
gs-agent gsa.gsc 3 gsa.global.gsm 2 gsa.global.lus 0
{% endhighlight %}

In general, the `gsa.[process type]` followed by a number controls the number of local processes of the specific process type that will be spawned by the GSA. The `gsa.global.[process type]` following by a number controls the number of globally managed processes of the specific process type.

### Lookup Service Considerations

When starting a [Lookup Service](/product_overview/service-grid.html#lus) and other services in unicast mode (not multicast), it means that specific machines will be the ones that will run the Lookup Service. This means that on the machines running the LUS, the following command will be used (assuming other defaults are used for GSM and GSC):

{% highlight java %}
gs-agent gsa.global.lus 0 gsa.lus 1
{% endhighlight %}

And on machines that will not run the LUS, the following command should be used:

{% highlight java %}
gs-agent gsa.global.lus 0
{% endhighlight %}


# Service Grid Configuration

The `<XAP_NET>\Config` folder contains a default configuration file for each of the service grids component: `gsc.config`, `gsm.config`, `lus.config`, `gs-agent.config`. These files extend the `ServiceGrid.config` file, which contains the configuration settings which are shared in the service grid.

When overriding configuration settings it is highly recommended NOT to modify these files - this will make version upgrades a complex process, as you'll need to merge your modifications with possible changes in those files.

Instead, follow one of the following procedures.

### Configuring a Service Grid - Console Application

The `<XAP_NET>\Bin` folder contains a folder called `gs-agent`, which contains a script called `gs-agent.bat` and a set of configuration files which extend the default configuration files from the `Config` folder. You can safely modify these files (both the script and the overrides) to customize your gs-agent configuration, and use the script to launch the customized GSA.

{% info %}
We recommend to create a copy of the `gs-agent` folder and make the modifications in it - that way you can copy your modified agent as you move between environments and versions without hassle.

You can create multiple copies of the `gs-agent` folder to support multiple agent configurations on the same machine.
{%endinfo%}

{%anchor Service-Grid %}

### Configuring a Service Grid - Windows Service

The `<XAP_NET>\Config` folder contains a `ServiceTemplates` folder, which the **GigaSpaces Services Manager** tool uses to create and configure Windows Services. Each subfolder denotes a type of service. Within each subfolder there is a `service-template.config` file which bootstraps the service and and a set of configuration files which extend the default configuration files from the `Config` folder.

{% info %}
We recommend to create a copy of the `gs-agent` folder and make the modifications in it - that way you can copy your modified agent as you move between environments and versions without hassle. Make sure you modify the `DisplayName` in `service-template.config` so you can tell your modified service from the original one.

You can create multiple copies of the `gs-agent` folder to support multiple agent configurations on the same machine.
{%endinfo%}


# Configuring components

Service Grid configuration is often composed of two layers: system-wide configuration and component-specific configuration.
The system-wide configuration specifies settings which all components share, e.g. discovery (unicast/multicast), security, zones, etc. These are set in the `EXT_JAVA_OPTIONS` environment variable.
The component-specific configuration specifies settings per component type, e.g. the GSC memory limit is greater than the GSM and LUS. These are set in one or more of the following environment variables:

- `GSA_JAVA_OPTIONS`
- `GSC_JAVA_OPTIONS`
- `GSM_JAVA_OPTIONS`
- `LUS_JAVA_OPTIONS`

For example:

{% section %}
{% column width=50% %}
{% highlight java %}
Linux
export GSA_JAVA_OPTIONS=-Xmx256m
export GSC_JAVA_OPTIONS=-Xmx2048m
export GSM_JAVA_OPTIONS=-Xmx1024m
export LUS_JAVA_OPTIONS=-Xmx1024m

. ./gs-agent.sh
{% endhighlight %}
{% endcolumn %}

{% column width=45% %}
{% highlight java %}
Windows
set GSA_JAVA_OPTIONS=-Xmx256m
set GSC_JAVA_OPTIONS=-Xmx2048m
set GSM_JAVA_OPTIONS=-Xmx1024m
set LUS_JAVA_OPTIONS=-Xmx1024m

call gs-agent.bat

{% endhighlight %}
{% endcolumn %}
{% endsection %}

#### Component Configuration

It is highly recommended that the Service Grid is started (and configured) using the gs-agent as shown above. If you do need to start a specific component separately, you can use the same environment variables shown above.

For example:

{% section %}
{% column width=50% %}
{% highlight java %}
Linux
export GSC_JAVA_OPTIONS=-Xmx1024m

. ./gsc.sh
{% endhighlight %}
{% endcolumn %}
{% column width=45% %}
{% highlight java  %}
Windows
set GSC_JAVA_OPTIONS=-Xmx1024m

call gsc.bat
{% endhighlight %}
{% endcolumn %}
{% endsection %}

{% note %}
Component specific configuration can be set using system properties (follows the [component name].[property name] notation).
{%endnote%}
