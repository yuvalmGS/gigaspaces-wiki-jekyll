---
layout: sbp
title:  JMX Space Statistics
categories: SBP
page_id: 48760469
---

{tip}*Summary:* {excerpt}JMX Space Statistics Agent{excerpt}
*Author*: Shay Hassidim, Deputy CTO, GigaSpaces
*Recently tested with GigaSpaces version*: XAP 6.6
*Contents:*
{toc:minLevel=1|maxLevel=1|type=flat|separator=pipe}
{tip}
{rate}

h1. Overview

The [attached example|^JMXSTAT.zip] illustrates usage of the JMX API, getting the JVM statistics and the Space statistics. The example collects statistics and generates a consolidated report of the space and its JVM activity.
This example supports both clustered and single space. For clustered space the report will include statistics for all cluster space members.

The report will include the following columns:
-- Time
-- Space Container
-- Space Host Name
-- JVM thread Count
-- JVM heap Committed
-- JVM heap max
-- JVM heap used
-- Space read Count
-- Space write Count
-- Space update Count
-- Space take Count
-- Space Notify Registration Count
-- Space Trigger Count
-- Space Connections Count

You may view the report using any spread sheet tool, graph the statistics and find correlations between the space activity and the JVM behavior.

To install the example:
Download the [example|^JMXSTAT.zip] and unzip it to an empty folder.

To run the example:
{code}
java -classpath ./;JSpaces.jar com.jmxutil.JMXSpaceStats jini://*/*/space space_stats.txt 10000
{code}

Example usage options:
{code}
java com.jmxutil.JMXSpaceStats space_url logfile sampling_duration
{code}

The example works both with JDK 1.5 and JDK 1.6.


