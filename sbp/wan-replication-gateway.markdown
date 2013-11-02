---
layout: sbp
title:  WAN Replication Gateway
categories: SBP
page_id: 56428286
---

{% compositionsetup %}


{% tip %}
**Summary:** {% excerpt %}WAN Replication Gateway example.{% endexcerpt %}
**Author**: Shay Hassidim, Deputy CTO GigaSpaces
**Recently tested with GigaSpaces version**: XAP 8.0.3

{% toc minLevel=1|maxLevel=1|type=flat|separator=pipe %}

{% endtip %}


# Overview

This [WAN Gateway|XAP91:Multi-Site Replication over the WAN] example includes PU folders with config files for a [Multi-Master|XAP91:Multi-Site Replication over the WAN#Multi-Master Topology] topology that includes 3 sites: DE , RU , US. Each site have an independent cluster and a Gateway.
!GRA:Images2^wan_example1.jpg!

You will find folders for the following PUs:
- wan-gateway-DE - Deployed into **DE** zone, using the **DE** lookup group and a lookup service listening on port 4366.
- wan-gateway-RU - Deployed into **RU** zone, using the **RU** lookup group and a lookup service listening on port 4166.
- wan-gateway-US - Deployed into **US** zone, using the **US** lookup group and a lookup service listening on port 4266.
- wan-space-DE - Deployed into **DE** zone, using the **DE** lookup group and a lookup service listening on port 4366.
- wan-space-RU - Deployed into **RU** zone, using the **RU** lookup group and a lookup service listening on port 4166.
- wan-space-US - Deployed into **US** zone, using the **US** lookup group and a lookup service listening on port 4266.

The internal architecture of the setup includes a clustered space and a Gateway, where each Gateway includes a Delegator and a Sink:
!GRA:Images2^wan_example2.jpg|thumbnail!

# Installing the Example
1. Download the [WAN_Gateway_example.zip|WAN Replication Gateway^WAN_Gateway_example.zip]. It includes two folders: **deploy** and **scripts**.
2. Please extract the file and and copy the content of the **deploy folder** into `\gigaspaces-xap-premium-8.0.X-ga\deploy` folder. It should looks like this:


{% highlight java %}
Directory of D:\gigaspaces-xap-premium-8.0.3-ga\deploy

09/11/2011  04:41 AM    <DIR>          .
09/11/2011  04:41 AM    <DIR>          ..
07/05/2011  03:08 PM    <DIR>          templates
09/11/2011  04:44 AM    <DIR>          wan-gateway-DE
09/11/2011  04:44 AM    <DIR>          wan-gateway-RU
09/11/2011  04:43 AM    <DIR>          wan-gateway-US
09/11/2011  04:43 AM    <DIR>          wan-space-DE
09/11/2011  05:15 AM    <DIR>          wan-space-RU
09/11/2011  04:42 AM    <DIR>          wan-space-US
{% endhighlight %}

3. Please move into the `scripts` folder and edit the `setExampleEnv.bat/sh` to include correct values for `NIC_ADDR` as the machine IP and `GS_HOME` to have Gigaspaces root folder location.

# Running the Example
You will find within the `scripts` folder running scripts to start [Grid Service Agent|XAP91:The Grid Service Agent] for each site and a deploy script for all sites. This will allow you to run the entire setup on one machine to test. Here are the steps to run the example:
1. Run `startAgent-DE.bat/sh` or to start DE site.
2. Run `startAgent-RU.bat/sh` to start RU site.
3. Run `startAgent-US.bat/sh` to start US site.
4. Run `deployAll.bat/sh` file to deploy all the PUs listed above.

# Viewing the Clusters
- Start the `\gigaspaces-xap-premium-8.0.X-ga\bin\GS-UI.bat/sh`.
- Once you deployed make sure you enable the relevant groups within the GS-UI:
!GRA:Images2^wan_example3.jpg!

You should check all Groups:
!GRA:Images2^wan_example4.jpg!

You should see this:
!GRA:Images2^wan_example5.jpg|thumbnail!

Once deployed successfully you should see this:
!GRA:Images2^wan_example6.jpg|thumbnail!

# Testing the WAN Gateway Replication
You can test the setup by using the [benchmark utility|XAP91:Benchmark View - GigaSpaces Browser] comes with the GS-UI. Move the one of the Clusters Benchmark icon and click the Start Button:
!GRA:Images2^wan_example7.jpg|thumbnail!

You will see all spaces **Object Count** across all clusters by clicking the **Spaces icon** on the Space Browser Tab. You should see identical number of objects (5000) for all members:
!GRA:Images2^wan_example8.jpg|thumbnail!

You can remove objects from each space cluster by selecting the **Take operation** and click Start:
!GRA:Images2^wan_example9.jpg|thumbnail!

You will see the Object Count changing having zero object count for each space:
!GRA:Images2^wan_example10.jpg|thumbnail!

# Replication Throughput Capacity

The total TP a gateway can push out into remote sites depends on:
- Network speed
- Partition count
- Partition activity Distribution
- Partition TP
- Replication Frequency
- Replication packet size
- Network bandwidth
- Replication Meta data size

The total TP will be:


{% highlight java %}
Total TP = (Partition TP X Partitions count X Distribution X Network Speed)+ Replication Meta data size / Replication Frequency
{% endhighlight %}


If we have 10 IMDG partitions, each sending 5000 objects/sec 1K size to the GW with a replication frequency of 10 replication cycles per/sec (100 ms delay between each replication cycle , i.e. 1000 operations per batch) with even distribution (1) and network speed between the sites is 10 requests/sec (i.e. 100 ms latency) the Total TP we will have is: (10 X 5000 X 1 X 10) / 10 = 50,000 objects per second. = 50M per second
 
The above assumes the network bandwidth is larger than 50M.

# WAN Gateway Replication Benchmark

With the following benchmark we have 2 sites; one located in the US East coast EC2 region and another one located within EC2 EU Ireland region. The latency between the sites is 95 ms and the maximum bandwidth measured is 12MByte/sec.

A client application located within the US East coast EC2 region running multiple threads perform continuous write operation to a clustered space in the same region. The space cluster within the US East coast EC2 region has a WAN Gateway configured , replicating data to a clustered space running within the EC2 EU Ireland region via a Gateway running within the same region.

!GRA:Images3^wan_bench1.jpg!

{% color blue %}Blue line{% endcolor %} - The amount of data generated at the source site (EC2 EU East coast region) by the client application.

{% color green %}Green line{% endcolor %}- The amount of consumed bandwidth is measured  at the target site (EC2 EU Ireland region).

{% color red %}Red line{% endcolor %} - The network bandwidth.

!GRA:Images3^wan_bench2.jpg!

Up to 16 client threads at the client application, the utilized bandwidth at the target site is increasing. Once the maximum bandwidth has been consumed, no matter how many client threads will be writing data to the source space, the target site bandwidth consumption will stay the same.

We do see some difference between the amount of data generated and replicated at the source site and the amount of bandwidth consumed at the target site. This difference caused due-to the overhead associated with the replicated data over the WAN and the network latency. For each replicated packet some meta data is added. It includes info about the order of the packet, its source location, etc.
