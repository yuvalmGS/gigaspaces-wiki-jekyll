---
layout: post
title:  deploy application
categories: XAP97
parent: deploy-command-line-interface.html
weight: 200
---

{% summary page|70 %}Deploys an application onto the service grid. {% endsummary %}

# Syntax

    gs> deploy-application [-user xxx -password yyy] [-secured true/false] application_directory_or_zipfile

# Description

Deploys an [application](./deploying-onto-the-service-grid.html#Application Deployment and Processing Unit Dependencies), which deploys one or more processing units in dependency order onto the service grid.

{% tip %}
For undeploying an application see [undeploy-application ](./undeploy-application---gigaspaces-cli.html) command.
{% endtip %}

# Options

{: .table .table-bordered}
|Option|Description|Value Format|
|:-----|:----------|:-----------|
| `-timeout` | Allows you to specify a timeout value (in milliseconds) when looking up the GSM to deploy to.{% wbr %}Defaults to `5000` milliseconds (5 seconds).| `-timeout [timeoutValue]`|
| `-deploy-timeout` | Timeout for deploy operation (in milliseconds),{% wbr %}otherwise blocks until all successful/failed deployment events arrive (default)" |`-deploy-timeout [timeoutValue]`|
| `-h` / `-help`  | Prints help | |
| `-secured` | Deploys a secured processing unit (implicit when using -user/-password) - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-secured [true/false]`|
| `-user` `-password` | Deploys a secured processing unit propagated with the supplied user and password - [(CLI) Security](./command-line-interface-(cli)-security.html)| `-user xxx -password yyyy`|

# Example

The following deploys the data-app example application (which includes a feeder and a processor).

    gs> deploy-application examples/data/dist.zip

The dist.zip file includes:

    application.xml
    feeder.jar
    processor.jar

application.xml file describes the application dependencies:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
	xmlns:os-admin="http://www.openspaces.org/schema/admin"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.1.xsd
	                    http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.1.xsd
	                    http://www.openspaces.org/schema/admin http://www.openspaces.org/schema/{% currentversion %}/admin/openspaces-admin.xsd">

	<context:annotation-config />

	<os-admin:application name="data-app">

		<os-admin:pu processing-unit="processor.jar"
			cluster-schema="partitioned-sync2backup"
			number-of-instances="2" number-of-backups="1"
			max-instances-per-vm="1" max-instances-per-machine="0" />

		<os-admin:pu processing-unit="feeder.jar">
			<os-admin:depends-on name="processor" min-instances-per-partition="1"/>
		</os-admin:pu>

	</os-admin:application>
</beans>
{% endhighlight %}
