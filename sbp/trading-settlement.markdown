---
layout: sbp
title:  Trading Settlement
categories: SBP
page_id: 56429380
---

{composition-setup}
{tip}*Summary:* {excerpt}Trading Settlement Demo.{excerpt}
*Authors*: Shay Hassidim, Deputy CTO, GigaSpaces; Norm Leitman, Sales Engineer, GigaSpaces; Shravan (Sean) Kumar, Solutions Architect, GigaSpaces
*Recently tested with GigaSpaces version*: XAP 8.0.4
*Last Update:* Nov 2011
{toc:minLevel=1|maxLevel=1|type=flat|separator=pipe}
{tip}
{rate}

#  Overview
This is a demo of a trading settlement system.  Settlement occurs after a trade, and involves the delivery of securities for payment between one party and another.  Because the demo operates in real-time, it can be expanded to provide risk management or be integrated with a rules engine for complex event processing (CEP).

Due to the speed at which markets move today, reliable risk assessment requires the ability to analyze trades and their impact on a portfolio in as close to real-time as possible.  In addition, having a [straight-through processing|http://en.wikipedia.org/wiki/Straight-through_processing] capability provides major benefits for risk and cost reduction. This demo illustrates how such minimum-latency systems can be built and we do so with the entire tier-based architecture built on GigaSpaces, including the following components:
- Data tier
- Business logic execution tier
- Messaging tier
- Web tier
- Database persistence tier

It is designed to be real-time, mission-critical and provide:
- Scalability
- Elasticity
- High availability
- Low latency

The following GigaSpaces features are utilized:
- Remoting
- Events
- Event Processing
- Asynchronous persistency
- Transparent HTTP session clustering
- Elastic Processing Unit
- Document API

#  Architecture

Blotter clients connect to the servlet through HTTP.  The blotter displays user trades, counter-party trades and matched deals.  It is also used to control the feeder.

The feeder generates random trade objects and places them into the space.

The [grid topology|http://www.gigaspaces.com/wiki/display/XAP8/Terminology+-+Data+Grid+Topologies] for the event processing engine consists of 2 partitions with backup instances.

It receives an event when an unprocessed trade is placed in the space and starts a transaction.  The transaction consists of several operations:
- For an unprocessed trade, query the space to see if there is a matching trade.
- If a matching trade is found, create a deal object and write it to the space.  Set the matched flag for both the unprocessed trade and the matching trade to true.
- Set the unprocessed trade to processed.

The messaging processor receives events when deals are matched and generates an XML message with the deal specifics.  These messages can be sent to external systems.

The monitor is a thread that periodically counts the number of matched deal objects in the space.  If this number exceeds 50, it will scale the grid up.  The grid will be scaled down if this number falls below 50.

The [mirror service|http://www.gigaspaces.com/wiki/display/XAP8/Asynchronous+Persistency+with+the+Mirror] provides reliable asynchronous persistence to a HSQL database through a hibernate interface.

!SA-Architecture.png!

#  Processing Unit Relationships and Events

The feeder, web servlet, monitor, messaging and mirror are deployed as [Processing Units (PUs)|http://www.gigaspaces.com/wiki/display/XAP8/A+Typical+SBA+Application].

The event processing engine is deployed as an [_Elastic_ PU|http://www.gigaspaces.com/wiki/display/XAP8/Elastic+Processing+Unit] with [replication|http://www.gigaspaces.com/wiki/display/XAP8/Replication].  The elasticity enables the grid to scale up or down based on user-defined metrics.  In this case, we use the number of trade objects in the space, which is counted by the monitor PU.  When this exceeds 50, memory capacity is increased through the [admin API|http://www.gigaspaces.com/wiki/display/XAP8/Administration+and+Monitoring+API+Security].  This causes new [processing containers|http://www.gigaspaces.com/wiki/display/XAP8/The+Grid+Service+Container] to be provisioned and the Elastic PUs to be rebalanced across the new nodes.  Scaling down is the reverse process.

You can step through the demo code in your favorite IDE by deploying the target processing unit(s) in an [Integrated Processing Unit Container|http://www.gigaspaces.com/wiki/display/XAP8/Deploying+and+Running+the+Processing+Unit].

Deal matching uses a [polling container|http://www.gigaspaces.com/wiki/display/XAP8/Polling+Container] and [transactions|http://www.gigaspaces.com/wiki/display/XAP8/Transaction+Management].

!SA-PUs.png!

#  Key Features
h2. Event Processing for Trade Matching
Trade matching for deals is based on the following fields: trading party, counter-party, instrument, matched flag, and buy/sell flag.  A polling container receives an event for each unprocessed trade in the space, and the matching process is done by transaction.

{code}
@EventDriven @Polling(gigaSpace = "gigaSpace") @TransactionalEvent(transactionManager="transactionManager")
public class TradeMatchingProcessor {
	@EventTemplate
	public SQLQuery<Trade> getUnprocessedTrade() {
		SQLQuery<Trade> template = new SQLQuery<Trade>(Trade.class, "processed = false");
        return template;
	}
	@SpaceDataEvent
	public Trade onEvent(Trade trade) throws Exception {
		SQLQuery<Trade> template =
			new SQLQuery<Trade>(Trade.class, "instrument = '" + trade.getInstrument() +
					"' and counterparty = '" + trade.getTradingParty() +
					"' and tradingParty = '" + trade.getCounterparty() +
					"' and matched = false and 	buySellFlag = " +
					(trade.getBuySellFlag().equals("B") ? "'S'" : "'B'"));

		Trade[] matchingTrades = gigaSpace.readMultiple(template, Integer.MAX_VALUE);
		trade.setProcessed(true);
		return trade;
	}
{code}

h2. Data Partitioning
In a partitioned space, data is routed to a particular partition based on a routing property.  Here we use a hash based on the trading party and counter-party.  This provides data affinity so that trades between these parties are located in the same space, which minimizes latency.
{code}
@SpaceClass
public class Trade implements Serializable {
...
@SpaceRouting
public String getRouting() {
	if (tradingParty == null) {
		return null;
	}
	String[] entities = new String[] {tradingParty,counterparty};
	Arrays.sort(entities);
	routing = entities[0] + "-" + entities[1];
	return routing;
}
}
{code}

h2. Scaling the Elastic Processing Unit (EPU)

When the number of trade objects in the space equals 50, the memory available for processing containers is increased from 128MB to 256MB.

{code}
pu = admin.getProcessingUnits().waitFor("settlement-app-components", 5,TimeUnit.SECONDS);
pu.scale(new ManualCapacityScaleConfigurer()
        .memoryCapacity(TARGET_MEMEORY_CAPACITY_MB_SCALED_UP,MemoryUnit.MEGABYTES)
        .create());
        );
{code}

Click [here|http://www.gigaspaces.com/wiki/display/XAP8/Elastic+Processing+Unit#ElasticProcessingUnit-MaximumMemoryCapacity] to see how the number of processing containers is dynamically calculated based on the amount of memory.

h2. Space Document
A [document store|http://www.gigaspaces.com/wiki/display/XAP8/Document+(Schema-Free)+API] is used for saving matched deals.  This document contains the following items:
- Deal ID
- Routing string
- Buy-side party
- Sell-side party
- MatchedDeal object

The document properties are _get_ and _set_ with code like this:
{code}
public class MatchedDeal extends SpaceDocument {
	public String getDealId() {
		return getProperty("DealId");
	}

	public MatchedDeal setDealId(String dealId) {
		setProperty("DealId", dealId);
		return this;
	}
	...
}
{code}

h2. Data Access Object (DAO)
The below interface defines how to interact with the space.
{code}
public interface SettlementAppDAO {
	MatchedDeal[] getMatchedDeals(String entity);

	MatchedDeal[] getMatchedDeals(String entity, String counterparty);

	Trade[] getTrades(String entity, String counterparty);

	SpaceDocument saveDocument(SpaceDocument document);

	Trade saveTrade(Trade trade);

	Trade[] getCounterpartyTrades(String entity, String counterparty);

	void clearUnmatchedTrades();
}
{code}

h2. Database Table Mapping
The trade and matched deal objects are persisted to the HSQL database through Hibernate.  An example of the Hibernate mapping is below.
{code}
<hibernate-mapping>
    <class
        name="com.gigaspaces.settlement.model.Trade"
        table="TRADE"
        mutable="true">

        <id
            name="tradeId"
            column="TRADE_ID"
            type="java.lang.String">

            <generator class="assigned">
	</generator>
        </id>

        <property
            name="tradingParty"
            type="java.lang.String"
            update="true"
            insert="true"
            column="trading_party"
        />

............
{code}

h2. Web Session Management
HTTP Sessions are maintained in the space and a copy is also kept in a [local cache|http://www.gigaspaces.com/wiki/display/XAP8/Client+Side+Caching], with 1 object per client.  Sessions are accessed using the following:
{code}
jetty.sessions.spaceUrl=jini://*/*/settlementSpace?useLocalCache
{code}

#  Running the Demo
- *Download* the [TradingSettlement.zip|Trading Settlement^TradingSettlement.zip] file and *extract* it into an empty folder.
- *Move* into the settlement-app folder.
- *Rename* the files ending in *.at* to *.bat*.
- *Edit* setExampleEnv.bat and change JAVA_HOME and JSHOMEDIR.
- *Add* \gigaspaces-xap-premium-8.0.4-ga\tools\maven\apache-maven-3.0.2\bin to you *path*.
- *Run* \gigaspaces-xap-premium-8.0.4-ga\tools\maven\installmavenrep.bat.
- *Build* the demo by *running* the following command:  mvn package
- *Execute* the demo by running the start and deploy scripts in the following order:
    1. *gs-agent-esm.bat*: starts the GigaSpaces agent in elastic deployment mode
    1. *gs-ui.bat*: starts the GigaSpaces user interface
    1. *start-hsqldb.bat*: starts the HSQL database
    1. *start-DatabaseManager.bat*: starts the HSQL database manager
    1. *deploy-app.bat*
    1. *deploy-messaging.bat*
    1. *deploy-feeder.bat*
    1. *deploy-monitor.bat*
    1. *deploy-mirror.bat*
    1. *deploy-blotter.bat* (could take up to 10 minutes to deploy)
- *Connect* to the blotter (gwt-dealsBlotter processing unit) using your browser (http://127.0.0.1:8080/gwt-dealsBlotter/).
- *Log in* with username that matches this format:  <any characters>@<trading entity> where <trading entity> = bank1 or cust1 or bank2 or cust2, etc.  For example, username = 123@bank1.  Password can be any characters.
- *Start* the application by clicking on the Administration tab and then clicking Start Feeder. You can Speed up the feeder rate by decreasing the refresh Interval to 1000 and clicking the Start Feeder.
- When the number of com.gigaspaces.settlement.model.Trade object > 50 (use the GS-UI - Data Type List for the settlementSpace to see the amount of objects), the settlementSpace will scale up by creating 2 additional GSCs. See the Hosts view.
- You can scale the application down by clicking on the Administration tab and then clicking on Clear Trades.

#  Questions and Feedback
[mailto:nleitman@gigaspaces.com]