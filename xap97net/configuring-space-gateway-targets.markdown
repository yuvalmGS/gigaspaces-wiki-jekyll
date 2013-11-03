---
layout: xap97net
title:  Configuring Space Gateway Targets
categories: XAP97NET
page_id: 63799430
---

{% summary %}This page explains how to configure replication gateway targets of a space.{% endsummary %}

{% compositionsetup %}

{% info %}
This page assume prior knowledge of multi-site replication, please refer to [Multi-Site Replication (WAN)](./multi-site-replication-over-the-wan.html) before reading this page.
{% endinfo %}

# Overview

Each space that is replicating to another space (or spaces) is actually replicating to the local gateway of the target space,
and that gateway is in charge of dispatching the replication to the relevant partitions. Such replicating space needs be configured with the name of each of the target gateways and
replication related parameters per gateway or for all gateways.

Here is an example of how this configuration should look:

{% inittab %}

{% tabcontent Using pu.config %}

{% highlight xml %}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces.XAP" type="GigaSpaces.XAP.Configuration.GigaSpacesXAPConfiguration, GigaSpaces.Core"/>
  </configSections>
  <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="GigaSpaces.XAP.ProcessingUnit.Containers.BasicContainer.BasicProcessingUnitContainer, GigaSpaces.Core">
      <BasicContainer>
        <ScanAssemblies>
          ..
        </ScanAssemblies>
        <SpaceProxies>
          <add Name="Space" Url="/./myNYSpace">
            <Gateway LocalGatewayName="NEWYORK" BulkSize="1000" MaxRedoLogCapacity="1000000">
              <Targets>
                <add Name="LONDON"/>
                <add Name="HONGKONG" BulkSize="100"/>
              </Targets>
            </Gateway>
          </add>
        </SpaceProxies>
      </BasicContainer>
    </ProcessingUnitContainer>
  </GigaSpaces.XAP>
</configuration>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent Code Construction %}
When using code construction for creating a space, the gateway configuration should be part of the `SpaceConfig` object that is used to create the space:

{% highlight java %}
SpaceConfig spaceConfig = new SpaceConfig();
//... Configure all other space properties
spaceConfig.GatewayConfig = new GatewayConfig();
spaceConfig.GatewayConfig.LocalGatewayName = "NEWYORK";
spaceConfig.GatewayConfig.BulkSize = 1000;
spaceConfig.GatewayConfig.MaxRedoLogCapacity = 1000000;
spaceConfig.GatewayConfig.GatewayTargets = new List<GatewayTargetConfig>();
//Configure london gateway target
GatewayTargetConfig londonTarget = new GatewayTargetConfig();
londonTarget.Name = "LONDON";

spaceConfig.GatewayConfig.GatewayTargets.Add(londonTarget);
//Configure hong-kong gateway target
GatewayTargetConfig hongkongTarget = new GatewayTargetConfig();
hongkongTarget.Name = "HONGKONG";
hongkongTarget.BulkSize = 100;

spaceConfig.GatewayConfig.GatewayTargets.Add(hongkongTarget);

BasicProcessingUnitContainer container = //... obtain container reference
container.CreateSpaceProxy("Space", "/./myNYSpace", spaceConfig);
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

Each configuration can be configured for all gateways or specifically per each gateway as seen in the above example, max-redo-log-capacity is configured for all gateways while bulk-size is specifically overridden in the configuration of HONGKONG gateway target. A recommended reading regarding the replication redo-log is [Controlling the Replication Redo Log](http://wiki.gigaspaces.com/wiki/display/XAP95/Controlling+the+Replication+Redo+Log).

# Configurable Parameters

||Property||Description||Default||
|BulkSize|Specifies the size of each replication bulk in terms of replication packets| 100 packets |
|PendingOperationThreshold|Specifies the threshold of number of packets that are pending replication that once breached, a replication bulk will be transmitted | 100 packets |
|IdleTimeThreshold|Specifies the maximum time to wait since the last time a replication bulk was transmitted, once elapsed, a replication bulk will be transmitted even if the `pending-operation-threshold` is not reached| 1000 miliseconds |
|MaxRedoLogCapacity|Specifies the maximum number of packets that should be held in the redo-log for a replication gateway (-1 means unlimited) | 100,000,000 |
|OnRedoLogCapacityExceeded| `DropOldest` will result in dropping the oldest packet in the redo-log once the capacity is exceeded, `BlockOperations` will result in blocking all new replicated operations by denying such new operation by throwing an exception to the operation invoker. | `DropOldest` |

If one of the gateway targets name matches the local-gateway-name, it will be filtered and removed from the list at deploy time. This may be helpful for creating symmetric configuration which is demonstrated at [Multi-Site Replication (WAN)](./multi-site-replication-over-the-wan.html) page.
