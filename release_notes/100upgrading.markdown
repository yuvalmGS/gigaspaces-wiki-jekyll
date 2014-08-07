---
layout: post
title:  Upgrading from previous versions
categories: RELEASE_NOTES
parent: xap100.html
weight: 800
---

{%comment%}
{% summary %}This page contains information about changes in this release which can affect upgrading from previous versions.{% endsummary %}

# Changes in Behavior / Syntax 

## Externalizable

Externalizable support is now disabled by default, as part of its EOL lifecycle. 
A system property can be set to restore it: com.gs.transport_protocol.lrmi.serialize-using-externalizable=true

### Removed APIs
A couple of deprecated APIs have been removed in 10.0: 

* `IServerAdmin.GetTypeDescriptor`
* `ISpaceProxy.CreateLocalView` 
* `NoWriteLease`
* `SpaceClassAttribute.Fifo`
* `data event sessions with transactions`
* `local transaction manager in XAP.NET`
* `non-generic SQLQuery in XAP.NET`
* `Clean operation in .NET`
* `Shutting down a space from a remote proxy`
* `IRemoteJSpaceAdmin.start/stop/restart() operations`

{%endcomment%}

