---
layout: xap97net
title:  Service Grid Components as Windows Services
categories: XAP97NET
page_id: 63799352
---

{summary}Installing and managing Service Grid Components as Windows Services{summary}

h1. Overview

When deploying on a Microsoft Windows environment, it is often useful to setup the Service Grid components as Windows Services.
In XAP.NET there are two binaries for each Grid Service component - a console application and a Windows service, allowing administrators to setup their environment as they please. In addition, XAP.NET provides a tool to simplify installation and management of Grid Service components as services.

h1. Benefits of Windows Services

Windows Services have several advantages over standard console applications. Most notable are:
* A service can be configured to start automatically when the machine boots, without any user logging in.
* A service can be configured to run under predefined credentials, e.g. SYSTEM.
* A service has no console/GUI which clutters up the desktop for no reason.
* Windows provides standard management console, command line and API to manage services, which makes managing services a common task for system administrators.

These features can come in handy on servers running Service Grid: For example, a Grid Service Manager and Grid Service Container can be automatically started when the machine restarts, then processing units will be automatically deployed to the service grid using the Command Line Interface service.

{refer}See [Deployment on Machine Startup|Deployment on Machine Startup] to learn how to start service grid and deploy processing units automatically on machine startup{refer}

h1. GigaSpaces Windows Services Manager

The Windows Services management console lets users start/stop installed services and modify their properties, but does not support installing new services. This task is can be done via a command line, or during installation of an application.
GigaSpaces XAP.NET provides a supplementary tool called *Windows Services Manager* which simplifies common administration tasks:
* Install/uninstall instances of GigaSpaces Agent, GSM, GSC, Distributed Transaction Manager and CLI as you please.
* Perform common operations directly from the tool, no need to switch to the Windows Console (e.g. Start, Stop, change startup type).
* Side-by-side support for GigaSpaces Installations of different versions on the same machine.
* Automatically creates a folder for new service instances, with an XML configuration and log files.

!GRA:Images2^ServicesManager.jpg!
The tool can be started from Start->Programs->GigaSpaces XAP.NET->Tools->Windows Services Manager.
(!) *Note:* This tool requires elevated permissions. Make sure you run it with appropriate permissions. If you're using Windows Vista or later and UAC is turned on, it is recommended to use 'Run As Administrator' (for more info see: http://support.microsoft.com/kb/922708)

h1. Advanced

h2. Service Properties

To view a service properties, right-click it and select *Properties*, or simply double-click it. A dialog window with the service properties will appear.

h2. Configuration

The Service Properties window shows the name of the service configuration file. Either Click the configuration label to open the configuration file using your default XML viewer, or click the location label to open the service folder, then edit the configuration file using your favorite XML editor.
(!) *Note:* In order for configuration changes to take effect the service needs to be stopped and restarted.

h2. Logging

When a service is started for the first time, it creates a *log.txt* file in its folder which contains log information.
