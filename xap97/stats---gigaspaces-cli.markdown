---
layout: post
title:  stats - GigaSpaces CLI
categories: XAP97
---

{% summary %}Provides statistics from the GSC and GSM of the local machine. {% endsummary %}

# Syntax

    gs> stats

# Description

The `stats` comand provides statistics from the Grid Service Container (GSC) and Grid Service Monitor (GSM) of the local machine. The following statistics are reported:

{: .table .table-bordered}
| Statistic | Decription |
|:----------|:-----------|
| User name | Current user name in local operating system. |
| Home directory | Service Grid installation directory. |
| Time of login | Time the Service Grid CLI was started. |
| Elapsed time since login | Elapsed time since the Service Grid CLI was started. |
| Pathname of log file | Where advertised, the group advertised, and the time when the service was found to be discarded. |
| HTTP | Address (plus roots) if any HTTP server has been started under this session . |
| Lookup service discovery statistics | Statistics on discovered lookup instances, including IP address and port, group, and time elapsed. At the end, statistics are shown for discarded lookup services, if any. |

# Options

None.

# Example

    gs> stats

    User : nuser
    Home directory :  GigaSpacesXAP6.0ServiceGridbin
    Login time : Mon Jan 30 12:02:59 GMT+02:00 2006
    Time logged in : 14 minutes, 14 seconds
    Log file :  GigaSpacesXAP6.0ServiceGridbings.log
    http : No HTTP server started
    Lookup Service Discovery Statistics
            No lookup services discovered
    Lookup Service Discarded Statistics
            127.0.0.1:4160     gs-grid, gigaspaces-13 Mon Jan 30 12:04:16 GMT+02:00 2006
