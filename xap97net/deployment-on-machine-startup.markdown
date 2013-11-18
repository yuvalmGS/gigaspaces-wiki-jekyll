---
layout: post
title:  Deployment on Machine Startup
categories: XAP97NET
parent: service-grid-components-as-windows-services.html
weight: 100
---

{% summary %}Service Grid deployment using Windows Services{% endsummary %}

# Overview

Service Grid deployment can be considered something that should be done automatically, without user intervention, moreover, if a server machine crashes and reboots, the Service Grid and deployed processing unit should restart and redeploy when the machines restarts. All of these can be acoomplished using GigaSpaces Windows Services Manager and the different [Service Grid components as windows services](./service-grid-components-as-windows-services.html). This page demonstrate how to configure a server machine to start its service grid components and deploy processing units upon machine startup.

# Configure Grid Service Manager and Grid Service Containers

In order to have Grid Service Managers (Gsm) and Grid Service Containers (Gsc) to start on machine startup they should be installed as windows services using [GigaSpaces Windows Service Manager](./service-grid-components-as-windows-services.html#Windows Services Manager). Each installed service needs to be [configured](./service-grid-components-as-windows-services.html#Service Configuration) seperately with the appropriate lookup groups by updating the service configuration file `"-Dcom.gs.jini_lus.groups"` option.

{% highlight xml %}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces" type="GigaSpaces.Core.Configuration.GigaSpacesCoreConfiguration,
  </configSections>
  <GigaSpaces>
    <JvmSettings>
      ...
      <JvmCustomOptions>
        <add Option="-Dcom.gs.jini_lus.locators=$(DefaultLocators)"/>
        <add Option="-Dcom.gs.jini_lus.groups=$(DefaultLookupGroups)"/>
        ...
      </JvmCustomOptions>
    </JvmSettings>
  </GigaSpaces>
</configuration>
{% endhighlight %}

The Starting State should be updated to Automatic.

{% info title=Firewall environment %}
If your environment has connection problems due to firewalls see [how to set gigaSpaces over a firewall]({%currentjavaurl%}/how-to-set-gigaspaces-over-a-firewall.html), this page is in GigaSpaces XAP java context, all the relevant described Jvm System properties should be configured inside `<JvmCustomOptions>` section of each service configuration file as new Option keys.
{% endinfo %}

# Deploy Processing Unit on Startup

In order to have a processing unit deployed automatically at machine startup, Command Line Interface service can be used. The service can be configured to start with a given command line by updating its configuration file. For example, the following configuration will deploy a processing unit named dataprocessor after a timeout of 300000 miliseconds (5 minutes) has passed. The timeout should be used because there's no garantee which windows service will be started first, therefore, the timeout should reflect the amount of time that it should take for all the Gsm's and Gsc's to load. If a processing unit of that name is already deployed in the service grid, the deployment request will be ignored.

{% highlight xml %}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces" type="GigaSpaces.Core.Configuration.GigaSpacesCoreConfiguration, GigaSpaces.Core"/>
    <section name="GigaSpaces.Services.Cli" type="GigaSpaces.Services.Cli.Configuration.GigaSpacesCliConfiguration, GigaSpaces.Services.Cli"/>
  </configSections>
  <GigaSpaces.Services.Cli CommandLine="pudeploy -timeout 300000 dataprocessor"/>
  ...
</configuration>
{% endhighlight %}

{% refer %}For a full list of possible command line options refer to [Cli Command]({%currentjavaurl%}/gs.bat---other-cli-commands.html) page or run Start->Program Files->GigaSpaces XAP.NET->Tools->GigaSpaces Command Line and type help{% endrefer %}

{% exclamation %} The Command Line Interface lookup groups must match the Gsm in which the processing unit is deployed and it is configured in the same way as the lookup groups is configured in Gsc and Gsm.

{% exclamation %} The Starting State should be updated to Automatic as above.
