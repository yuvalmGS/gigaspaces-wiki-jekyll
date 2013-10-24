---
layout: xap96
title:  list - GigaSpaces CLI
page_id: 61867343
---

{% summary %}Lists information about active Service Grid services. {% endsummary %}

# Syntax

    gs> list [type] [options]

# Description

The `list` command lists information about active Service Grid services.

{% refer %}For the space list CLI, please refer to the [space list - GigaSpaces CLI](/xap96/space-list---gigaspaces-cli.html) section.{% endrefer %}

The following values are allowed for **`type`**. Only one type can be specified.

{: .table .table-bordered}
| Type | Description |
|:-----|:------------|
| `gsm` | Grid Service Monitor |
| `gsc` | Grid Service Container |
| `lus` | Lists all active Jini Lookup Service instances and their attributes. |
| Default (none) | List all types of services, but in less detail than when the types are specified individually: only service name, group, and machine. |

# Options

Each option adds to (or subtracts from) the default information listed. You can specify one option, more than one, or none.

**The following options are available for types `gsm`, `gsc`, and default:**

{: .table .table-bordered}
| Option | Description |
|:-------|:------------|
| `cpu` | Lists the CPU utilization of each machine. |
| `jmx` | Lists the jmx connection entry, if any. |
| `codeserver` | Lists the IP addresses to which the service has been exported. |
| `timeout` | Available for type `lus` only (**new in GigaSpaces 6.0.2** and onwards) -- the discovery timeout (in milliseconds). Usage example: `timeout=20000`. Default value is 30000 msec. |

# Examples

{% toczone location=top|type=flat|separator=pipe|minLevel=2|maxlevel=2 %}

## List All Services in the Network

    gs> list
    total services 4
    [1] Lookup gs-grid, gigaspaces-13 11.0.0.3
    [2] Grid Service Container gs-grid pc-nati@11.0.0.3
    [3] Lookup gigaspaces-1365 11.0.0.5
    [4] Grid Service Manager gs-grid pc-nati@11.0.0.3

## List all Service Containers

    gs> list gsc
    total 1
    [1] Grid Service Container gs-grid pc-nati@11.0.0.3
    No contained services

## List Grid Service Managers

    gs> list gsm
    total 1
    [1] Grid Service Manager gs-grid pc-nati@11.0.0.3
    GigaSpace Service Deployment role=primary
    GigaSpace planned=1 actual=1 pending=0
    id=1 11.0.0.3

## List all Active Jini Lookup Service Instances and their Attributes

    gs> list lus
    Searching for available Jini Lookup Services...

    -----------------------------------------------------------------------
    -- Discovered Lookup Service at host [ 192.168.10.133:4160 ].
    -- Lookup Service registered to the following jini groups:
                     Group [ gigaspaces-6.0XAP-DOTNET-PC ]
    -- Lookup Service has [3] services, lookup took [1828] millis, [1] seconds:
                     Service Class: com.j_spaces.core.client.JSpaceProxy | 0ab4e4e1-ca5e-4be3-bc00-ac4648108012
                     Service Attributes Set: [net.jini.lookup.entry.Name(name=myExcelDemoSpace), com.j_spaces.lookup.entry.C
    lusterName(name=NONE), com.j_spaces.lookup.entry.ClusterGroup(electionGroup=null,replicationGroup=NONE,loadBalancingGrou
    p=null), com.j_spaces.lookup.entry.Persistent(type=MEMORY), com.j_spaces.lookup.entry.ContainerName(name=myExcelDemoSpac
    e_container), net.jini.lookup.entry.ServiceInfo(name=JavaSpace,manufacturer=GigaSpaces Technologies Ltd.,vendor=GigaSpac
    es,version=GigaSpaces Platform(TM) 6.0 XAP edition (build 2001-6),model=,serialNumber=), com.j_spaces.lookup.entry.HostN
    ame(name=dotnet-pc), com.j_spaces.lookup.entry.State(state=started,electable=null,replicable=null)]

                     Service Class: com.j_spaces.core.JSpaceContainerProxy | c8bd6d9d-0e79-4541-b7e4-1f3427279e5a
                     Service Attributes Set: [net.jini.lookup.entry.Name(name=myExcelDemoSpace_container), com.j_spaces.look
    up.entry.ContainerName(name=myExcelDemoSpace_container), net.jini.lookup.entry.ServiceInfo(name=JSpaceContainer,manufact
    urer=GigaSpaces Technologies Ltd.,vendor=GigaSpaces,version=GigaSpaces Platform(TM) 6.0 XAP edition (build 2001-6),model
    =,serialNumber=), com.j_spaces.lookup.entry.HostName(name=dotnet-pc)]

                     Service Class: com.sun.jini.reggie.RegistrarProxy | e375ba99-4b1f-4c13-9cf0-4b5b76eb2327
                     Service Attributes Set: [net.jini.lookup.entry.ServiceInfo(name=Lookup,manufacturer=Sun Microsystems, I
    nc.,vendor=Sun Microsystems, Inc.,version=2.1,model=,serialNumber=), com.sun.jini.lookup.entry.BasicServiceType(type=Loo
    kup), net.jini.lookup.entry.Name(name=Lookup), org.jini.rio.entry.OperationalStringEntry(name=Service Grid Infrastructur
    e)]

    -----------------------------------------------------------------------
    -- Discovered Lookup Service at host [ 192.168.10.36:4160 ].
    -- Lookup Service registered to the following jini groups:
                     Group [ gigaspaces-6.0XAP-mishak ]
    -- Lookup Service has [9] services, lookup took [1203] millis, [1] seconds:
                     Service Class: $Proxy18 | 2edbae56-79d6-43bb-abb0-182c5b11a6d0
                     Service Attributes Set: [org.jini.rio.entry.OperationalStringEntry(name=Compute Grid), org.jini.rio.ent

# Troubleshooting

## Terminated services are still listed

The `list` command uses the lookup service to extract the information regarding the services.

A service's entry in the lookup is leased and kept until the next renewal attempt fails. If the service is not properly shutdown, i.e. abruptly terminated, it doesn't unregister itself from the lookup service. Thus, attempts to call `list` will still display the service until its lease expires.

For defaults and configuration options, refer to [Jini Lookup Service configuration](/xap96/lookup-service-configuration.html) settings for `minMaxServiceLease` property.

{% endtoczone %}
