---
layout: post
title:  Platform Configuration
categories: XAP97NET
parent: configuration.html
weight: 200
---

You will find the platform specific configuration under `GS_HOME\NET v....\Config\Settings.xml`.

{: .table .table-bordered}
| Property name  | Description | Default value  |
|XapNet.Path| XAP .NET folder location |$(XapNet.SettingsFile)\..\.. |
|XapNet.Install.Path| Location of XAP .NET Installation| $(XapNet.Path)\..|
|XapNet.Config.Path| Location of Configuration folder| $(XapNet.Path)\Config|
|XapNet.Runtime.Path| XAP Runtime files Location | $(XapNet.Install.Path)\Runtime|
|XapNet.Runtime.JavaHome| JDK home folder|$(XapNet.Runtime.Path)\Java|
|XapNet.Logs.ConfigurationFile| logging config folder|$(XapNet.Config.Path)\Logs\gs_logging.properties|
|XapNet.Logs.Path| log files folder|$(XapNet.Path)\Logs|
|XapNet.Logs.FileName| logging file name. This include log file format| {date,yyyy-MM-dd~HH.mm}-gigaspaces-{service}-{host}-{pid}.log|
|XapNet.HostName| Machine Name or IP| %COMPUTERNAME%|
|XapNet.Multicast.Enabled| Lookup multicast discovery mode|true|
|XapNet.Groups| Lookup discovery group|  XAP-x.x.x-ga-NET-x-x|
|XapNet.Locators| Lookup discovery locators. Should include list of all machines running lookup service|  |
|XapNet.Zones| Service grid container zone. |  |
|XapNet.Security.Enabled| security enabled mode| false|
|XapNet.ServiceGrid.Deploy.Path| Processing Unit Deploy folder| $(XapNet.Path)\Deploy|
|XapNet.ServiceGrid.Work.Path| work folder. Used to store temp files such deployed PU files , redo log overflow files|$(XapNet.Path)\Work|
|XapNet.GsAgent.Config.Path| Agent config folder| $(XapNet.Config.Path)\GsAgent\||
|XapNet.Gsc.Memory.Initial| GSC initial heap size in MB |16 |
|XapNet.Gsc.Memory.Maximum| GSC max heap size in MB |512 |
|XapNet.Gsm.Memory.Initial| GSM initial heap size in MB |16 |
|XapNet.Gsm.Memory.Maximum| GSC max heap size in MB |512 |
|XapNet.Lus.Memory.Initial| Lookup initial heap size in MB |16 |
|XapNet.Lus.Memory.Maximum| Lookup max heap size in MB|512 |
|DefaultLookupGroups| Default Lookup Groups - used with older versions | $(XapNet.Groups) |
|DefaultLocators| Default Locators  - used with older versions| $(XapNet.Locators) |
