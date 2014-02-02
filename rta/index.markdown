---
layout: post
title:  Real Time Analytics
categories: RTA
---

{% summary %}Real Time Analytics{% endsummary %}

# Overview


<object width="560" height="315"><param name="movie" value="http://www.youtube.com/v/ioHwEsARPWI?version=3&amp;hl=en_US"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/ioHwEsARPWI?version=3&amp;hl=en_US" type="application/x-shockwave-flash" width="560" height="315" allowscriptaccess="always" allowfullscreen="true"></embed></object>


Real-time Analytics or Real-time business intelligence (RTBI) is the process of delivering information about business operations as they occur. Real time means near to zero latency and access to information whenever it is required.

Real-time Analytics may be used with the following applications:  Algorithmic trading , Fraud detection , Systems monitoring , Application performance monitoring , Customer Relationship Management , Demand sensing , Dynamic pricing and yield management , Data validation , Operational intelligence and risk management , Payments & cash monitoring , Data security monitoring , Supply chain optimization , RFID/sensor network data analysis , Workstreaming , Call center optimization , Enterprise Mashups and Mashup Dashboards , Transportation industry.

The Transportation industry for example, leveraging real-time analytics for the railroad network management. Depending on the results provided by the real-time analytics, dispatcher can make a decision on what kind of train he can dispatch on the track depending on the train traffic and commodities shipped.

Today's real-time processing systems
The speed of today's processing systems has moved classical data warehousing into the realm of real-time. The result is real-time analytics. Business transactions as they occur are fed to a real-time business intelligence system that maintains the current state of the enterprise. The RTBI system not only supports the classic strategic functions of data warehousing for deriving information and knowledge from past enterprise activity, but it also provides real-time tactical support to drive enterprise actions that react immediately to events as they occur. In some cases it may replace both the classic data warehouse and the enterprise application integration (EAI) functions. Such event-driven processing is a basic tenet of real-time business intelligence.

In this context, real-time means a range from milliseconds to a few seconds after the business event has occurred. While traditional business intelligence presents historical data for manual analysis, real-time business intelligence compares current business events with historical patterns to detect problems or opportunities automatically. This automated analysis capability enables corrective actions to be initiated and/or business rules to be adjusted to optimize business processes.

With GigaSpaces , RTBI is an approach in which up-to-a-minute data is analyzed, either directly from operational sources or feeding business transactions into a a in-memory data grid. RTBI logic using the IMDG to analyzes these feeds in real time.

Real-time business intelligence makes sense for some applications but not for others – a fact that organizations need to take into account as they consider investments in real-time BI tools. Key to deciding whether a real-time BI strategy would pay dividends is understanding the needs of the business and determining whether end users require immediate access to data for analytical purposes, or if something less than real time is fast enough.

# Evolution of RTBI
In today’s competitive environment with high consumer expectation, decisions that are based on the most current data available to improve customer relationships, increase revenue, maximize operational efficiencies, and yes – even save lives.

This technology is real-time business intelligence. Real-time business intelligence systems provide the information necessary to strategically improve an enterprise’s processes as well as to take tactical advantage of events as they occur.

# Latency
All real-time business intelligence systems have some latency, but the goal is to minimize the time from the business event happening to a corrective action or notification being initiated. Analyst Richard Hackathorn describes three types of latency:
- Data latency; the time taken to collect and store the data
- Analysis latency; the time taken to analyze the data and turn it into actionable information
- Action latency; the time taken to react to the information and take action

Real-time business intelligence technologies are designed to reduce all three latencies to as close to zero as possible, whereas traditional business intelligence only seeks to reduce data latency and does not address analysis latency or action latency since both are governed by manual processes.

# RT Analytics Architecture Foundation Artifacts
### Event-based
Real-time Business Intelligence systems are event driven, and may use Event Stream Processing and Mashup (web application hybrid) techniques to enable events to be analysed without being first transformed and stored in a database. These in- memory techniques have the advantage that high rates of events can be monitored, and since data does not have to be written into databases data latency can be reduced to milliseconds.

# Server-less technology
The latest alternative innovation to "real-time" event driven and/or "real-time" data warehouse architectures is MSSO Technology (Multiple Source Simple Output) which removes the need for the data warehouse and intermediary servers altogether since it is able to access live data directly from the source (even from multiple, disparate sources). Because live data is accessed directly by server-less means, it provides the potential for zero-latency, real-time data in the truest sense.

# Process-aware
This is sometimes considered a subset of Operational intelligence and is also identified with Business Activity Monitoring. It allows entire processes (transactions, steps) to be monitored, metrics (latency, completion/failed ratios, etc.) to be viewed, compared with warehoused historic data, and trended in real-time. Advanced implementations allow threshold detection, alerting and providing feedback to the process execution systems themselves, thereby 'closing the loop'.


## Topics:

{%panel%}

- [Aggregators api]({%latestjavaurl%}/aggregators.html)
- [Counters api]({%latestjavaurl%}/counters.html)
- [Map reduce api]({%latestjavaurl%}/task-execution-over-the-space.html)
- [Doc API]({%latestjavaurl%}/document-api.html)
- [Query API]({%latestjavaurl%}/querying-the-space.html)
- [Processing API]({%latestjavaurl%}/event-processing.html)
- [Big Data Integration]({%latestjavaurl%}/big-data.html)
- should include in some point HBase and Hadoop integration
- Storm Integration – should use the blog content
- Samza Integration – TBD
- Google analytics Integration – TBD
- ElasticSearch / solr Integration – TBD
- Time Series api (working on this)
- Spatial api - TBD
- Other analytics API…

{%endpanel%}




{%children%}