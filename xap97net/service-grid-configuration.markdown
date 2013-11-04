---
layout: xap97net
title:  Service Grid Configuration
categories: XAP97NET
page_id: 64127766
---

{% compositionsetup %}

{% summary page|70 %}How to configure a Service Grid{% endsummary %}

# Overview

The `<XAP_NET>\Config` folder contains a default configuration file for each of the service grids component: `gsc.config`, `gsm.config`, `lus.config`, `gs-agent.config`. These files extend the `ServiceGrid.config` file, which contains the configuration settings which are shared in the service grid.

When overriding configuration settings it is highly recommended NOT to modify these files - this will make version upgrades a complex process, as you'll need to merge your modifications with possible changes in those files.

Instead, follow one of the following procedures.

# Configuring a Service Grid - Console Application

The `<XAP_NET>\Bin` folder contains a folder called `gs-agent`, which contains a script called `gs-agent.bat` and a set of configuration files which extend the default configuration files from the `Config` folder. You can safely modify these files (both the script and the overrides) to customize your gs-agent configuration, and use the script to launch the customized GSA.

{% plus %} We recommend to create a copy of the `gs-agent` folder and make the modifications in it - that way you can copy your modified agent as you move between environments and versions without hassle.
{% plus %} You can create multiple copies of the `gs-agent` folder to support multiple agent configurations on the same machine.

# Configuring a Service Grid - Windows Service

The `<XAP_NET>\Config` folder contains a `ServiceTemplates` folder, which the **GigaSpaces Services Manager** tool uses to create and configure Windows Services. Each subfolder denotes a type of service. Within each subfolder there is a `service-template.config` file which bootstraps the service and and a set of configuration files which extend the default configuration files from the `Config` folder.

{% plus %} We recommend to create a copy of the `gs-agent` folder and make the modifications in it - that way you can copy your modified agent as you move between environments and versions without hassle. Make sure you modify the `DisplayName` in `service-template.config` so you can tell your modified service from the original one.
{% plus %} You can create multiple copies of the `gs-agent` folder to support multiple agent configurations on the same machine.
