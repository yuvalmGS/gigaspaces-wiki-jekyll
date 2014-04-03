---
layout: post
title:  VMWare Guidelines
categories: RELEASE_NOTES
parent: xap97.html
weight: 700
---

{%summary%}GigaSpaces XAP Data-Grid , Message-Grid , Compute-Grid , local cache , remoting, Persistency , Service Grid
and OpenSpaces API support deployment in virtualized environments running on VMWare Type 1 Hypervisors.{%endsummary}

# Supported versions

GigaSpaces supports VMWare vSphere 5+ running the following guest operating systems:

- Windows 2008 Server SP2
- Linux RHEL 5.x/6.x
- Solaris 10

{%warning%}
SUSE linux is not supported, due to the instability of its network support layer.
{%endwarning%}

# Configuration

- Only Type 1 is supported.
- vCPU may be over-subscribed, if it is under-utilized (less than 50%). In environments with high CPU utilization, vCPU must be reserved (pinned).
- Hyper-threading should be enabled.
- vMEM must be reserved (pinned).

# References

High-performance settings should be used, per VMWare's recommendations [here](http://www.vmware.com/pdf/Perf_Best_Practices_vSphere5.0.pdf) and [here](http://www.vmware.com/files/pdf/techpaper/VMW-Tuning-Latency-Sensitive-Workloads.pdf).


