---
layout: post
title:  Scripts
page_id: 61867124
---

{% compositionsetup %}
{% summary page|70 %}Scripts included in the `<gigaspaces root>/bin` directory{% endsummary %}

The `<gigaspaces root>/bin` folder includes several scripts for windows and linux needed to manage GigaSpaces Runtime Components and Applications:

- [gs-agent.bat/sh](/xap96/the-grid-service-agent.html) - This is the main script you should use when starting the [GigaSpaces runtime environment](/xap96/the-runtime-environment.html) - [The Grid Service Agent](/xap96/the-grid-service-agent.html) (GSA). It acts as a process manager, parent process for the following:
    - [Lookup Service](/xap96/the-lookup-service.html) (LUS) - GigaSpaces Directory Service.
    - [GigaSpaces Manager](/xap96/the-grid-service-manager.html) (GSM) - Deployment and provisiosning Manager service.
    - [GigaSpaces Container](/xap96/the-grid-service-container.html) (GSC) - Universal  Container.

- [gs-ui.bat/sh](/xap96/gigaspaces-management-center.html) - starts the rich UI.
- [gs.bat](/xap96/commands.html) - starts the GigaSpaces interactive shell / Command line.
- [gsc.bat/sh](/xap96/the-grid-service-container.html) - starts an instance of the GSC. Called by the GSA. You should not use this script directly when using the GSA.
- [gsInstance.bat/sh](/xap96/gsinstance---gigaspaces-cli.html) - starts an instance of a space. Used usually in development.
- [gsm.bat/sh](/xap96/the-grid-service-manager.html) - starts an instance of the GSM and LUS. You should not use this script directly when using the GSA.
- [gsm_nolus.bat/sh](/xap96/the-grid-service-manager.html) - starts an instance of the GSM. Called by the GSA. You should not use this script directly when using the GSA.
- lcp.bat - utility script.
- gs-memcached.bat/sh - starts an instance of [Memcached API](/xap96/memcached-api.html) listener. Used usually in development.
- lookupbrowser.bat/sh - Used with for special debug scenarios to inspect the lookup service.
- [platform-info.bat/sh](/xap96/platforminfo---gigaspaces-cli.html) - prints GigaSpaces version info.
- puInstance.bat/sh - starts a single instance of a PU. Used usually in development.
- setenv.bat - general settings. Used by all scripts.
- [startJiniLUS.bat/sh](/xap96/startjinilus---gigaspaces-cli.html) - starts an instance of the LUS. Called by the GSA. You should not use this script directly when using the GSA.
- [startJiniTX_Mahalo.bat/sh](/xap96/startjinitx_mahalo---gigaspaces-cli.html) - starts an instance of the Distributed transaction manager. You should not use this script directly when using the GSA.
- gs-focalserver.bat/sh - an old script used to run a server that is consolidating data from multiple JMX servers. It is there for backward compatibility.

{% tip %}
You can use the [GigaSpaces Universal Deployer](/sbp/universal-deployer.html) to deploy complex multi processing unit applications.
{% endtip %}

