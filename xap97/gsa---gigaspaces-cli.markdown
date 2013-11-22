---
layout: post
title:  gsa - GigaSpaces CLI
categories: XAP97
parent: commands.html
weight: 700
---

{% summary %}Invoke gsa CLI command.{% endsummary %}

# Syntax

    gs> gsa <command> [-host<host name/ip address>]

# Description

The following gsa CLI commands are available:

{: .table .table-bordered}
| Command | Description |
|:--------|:------------|
| shutdown | shutdown gsa |
| start-gsc | starts gsc agent within specific gsa service |
| start-gsm | starts gsm agent within specific gsa service |
| start-lookup | starts lus agent within specific gsa service |

# Options

{: .table .table-bordered}
| Option | Description | Value Format |
|:-------|:------------|:-------------|
| `help` / `h` | Prints help -- the command's usage and options. | |
| `host` / `h` | Host name, optional parameter, allows to locate gsa that is running on specific machine. | |

# Example

The following prints a numbered list of GSA services, and you can choose a GSA service to create gsc within it:

    gs> gsa start-gsc
    total 5
    [1]  10278  Grid Service Agent  gigaspaces-8.0.0-XAPPremium...  pc-lab43@192.xxx.x.xx
    [2]  20157  Grid Service Agent  gigaspaces-8.0.0-XAPPremium...  pc-lab37@192.xxx.x.xx
    [3]  26850  Grid Service Agent  gigaspaces-8.0.0-XAPPremium...  pc-lab38@192.xxx.x.xx
    [4]  11752  Grid Service Agent  gigaspaces-8.0.0-XAPPremium...  Evgeny@192.xxx.xx.xxx
    [5]  1608   Grid Service Agent  gigaspaces-8.0.0-XAPPremium...  pc-lab42@192.xxx.x.xx

    Enter a number of service to gsa start-gsc or "c" to cancel :

Example fo gsa shutdown when specific host name provided:

    gs> gsa shutdown -host pc-lab43
    total 1
    [1]  10278  Grid Service Agent  gigaspaces-8.0.0-XAPPremium...  pc-lab43@192.xxx.x.xx
    [2]  all

    Enter a comma-separated list to gsa shutdown or "c" to cancel :

