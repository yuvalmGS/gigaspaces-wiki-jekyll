---
layout: xap97net
title:  How to Configure Multicast
categories: XAP97NET
page_id: 64127787
---

{summary}Enabling multicast on Linux and windows. {summary}

# Overview

Multicast is the delivery of information to a group of destinations simultaneously, using the most efficient strategy to deliver messages over each link of the network only once, and create copies only when the links to the destinations split.

The word "multicast" is typically used to refer to IP Multicast, the implementation of the multicast concept on the IP routing level, where routers create optimal spanning tree distribution paths for datagrams sent to a multicast destination address in realtime. However, there are also other implementations of the multicast distribution strategy listed below.
(Source - wikipedia: [http://en.wikipedia.org/wiki/Multicast]).

GigaSpaces uses multicast in the following cases:
- [When deploying onto the service grid|Deploying onto the Service Grid] GigaSpaces XAP uses multicast to discover the [Lookup Service|Lookup Service Configuration ], and register their proxies.
- Clients use multicast to discover the [Lookup Service|Lookup Service Configuration ] and look up a matching service proxy (such as the space).


{% tip title=What should I do in order to determine if multicast is enabled on my environment? %}
Refer to the [How to Determine Whether Multicast is Available] section for more details.
{% endtip %}


To enable the important capabilities above, you should enable multicast on machines running clients, spaces or services.
{% tip title=What should I do if I can't enable multicast? %}
- If you cannot enable multicast in your environment, you can use unicast discovery to allow services and clients to locate the Lookup Service.
- Space cluster replication uses unicast by default. You should use multicast replication when having more than 10 clients acting as replica spaces per target space.
{% endtip %}


{% exclamation %} In case you want to **disable the Jini Lookup Service Multicast announcements** please refer to [this|Lookup Service Configuration#Multicast Settings] section in the Wiki.

# Configuring Multicast on Windows

To enable multicasting from a token ring on a Windows® 2000 workstation to any Windows 98/NT machine, set the `TrFunctionalMcastAddress` parameter to `0` in the Windows 2000 registry:
1. Click **Start** > **Run** on the Windows 2000 taskbar.
2. In the **Open** field, select or type **REGEDIT**.
3. Click **OK**. The **Registry Editor** window opens.
4. Click **HKEY_LOCAL_Machine** > **SYSTEM** > **CurrentControlSet** > **Services** > **Tcpip** > **Parameters**.
5. Right-click **TrFunctionalMcastAddress**, and click **Modify**. The **Edit DWORD Value** window opens.
6. In the **Value** data field, type `0`.
7. Click **OK** to save changes and exit.
8. Close the **Registry Editor**.

# Configuring Multicast Scope Time-To-Live (TTL) Value

The **[multicast Time-To-Live (TTL)|http://en.wikipedia.org/wiki/Time_to_live]** value specifies the number of routers (hops) that multicast traffic is permitted to pass through before expiring on the network. For each router (hop), the original specified TTL is decremented by one (1). When its TTL reaches a value of zero (0), each multicast datagram expires and is no longer forwarded through the network to other subnets.

The problem of multicasts/broadcasts not passing the router/switch is a well known issue - most routers (Cisco, 3Com, etc) have multicast forwarding disabled by default - otherwise the networks will be flooded with packets coming from very distant locations. To get it delivered all over the globe takes below 30 hops, so TTL 20 means delivery to more than half of it. It is very common that network experts in large networks hate the flooding problem caused by multicasts/broadcasts sent with the large TTL, and block it.


# Packet Sniffer/Network Analyzer Tool

[Wireshark (formerly Ethereal)|http://www.wireshark.org/] - accumulates years of network analyzing experience and is far more mature and known than other tools. It is a cross-platform packet sniffer/network analyzer tool (used both in Windows and Unix/Linux). It allows you to examine data from a live network, or from a capture file on disk. You can interactively browse the capture data, viewing summary and detail information for each packet. It has several powerful features, including a rich display filter language and the ability to view the reconstructed stream of a TCP session.

{% infosign %} **To find TTL**, you should monitor some traffic (start-stop on the proper interface), in the monitoring log. Choose the packet you are interested in, and look at its IP layer - TTL (and other parameters) are shown.

{% infosign %} The **default TTL value is 3** (was 15). See [Multicast Settings|Lookup Service Configuration#LookupServiceConfiguration-MulticastSettings] section for details of how to modify that value.

