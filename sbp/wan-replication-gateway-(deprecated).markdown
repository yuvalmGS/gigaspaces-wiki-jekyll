---
layout: sbp
title:  WAN Replication Gateway (Deprecated)
categories: SBP
---

{% compositionsetup %}

{% tip %}
**Summary:** {% excerpt %}WAN Replication Gateway example.{% endexcerpt %}<br/>
**Author**: Shravan (Sean) Kumar, Solutions Architect, GigaSpaces<br/>
**Recently tested with GigaSpaces version**: XAP 7.1.2<br/>

{% toc minLevel=1|maxLevel=1|type=flat|separator=pipe %}

{% endtip %}

# Overview

Mirror Gateway Synchronization can be used to synchronize operations conducted at one local site with data in a remote site or another cluster instance as explained in the [Clusters Over WAN]({%latestjavaurl%}/multi-site-replication-over-the-wan.html) page. This example demonstrates how this can be done using a custom external dataSource implementation running on the mirror.

This is a simple order processing example based on GigaSpaces maven basic-async-persistency template. Product objects in the space maintain available quantity information. New orders coming into the system reduce the number of available products. Example shows how you can synchronize the available Product information across two clusters using a Mirror Gateway.

{% exclamation %} The GigaSpaces WAN Gateway, a solution for synchronizing multiple clusters over the WAN can be found at [Multi-Site Replication over the WAN]({%latestjavaurl%}/multi-site-replication-over-the-wan.html).

# Mirror Gateway - One way

{% indent %}
![rep_over_wan_MirrorGatewayOneway.jpg](/attachment_files/sbp/rep_over_wan_MirrorGatewayOneway.jpg)
{% endindent %}

# Source Code

Some relevant code from the example is in the following sections.

## Data Model

{% inittab Data Model %}

{% tabcontent Product Class %}

{% highlight java %}
package com.gigaspaces.domain;

import com.gigaspaces.annotation.pojo.SpaceId;

public class Product extends MultiClusterEnabled {

	private String id;
	private String name;
	private String description;
	private Integer quantity;

	@SpaceId
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String toString() {
		return "id[" + id + "] name[" + name + "] description[" + description
				+ "] quantity[" + quantity + "]";
	}
}
{% endhighlight %}

{% endtabcontent %}

{% tabcontent MultiClusterEnabled Class %}

{% highlight java %}
package com.gigaspaces.domain;

public abstract class MultiClusterEnabled {

	public boolean multiClusterReplicate = true;

	public boolean isMultiClusterReplicate() {
		return multiClusterReplicate;
	}

	public void setMultiClusterReplicate(boolean multiClusterReplicate) {
		this.multiClusterReplicate = multiClusterReplicate;
	}
}
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

## Mirror Definition

{% inittab Mirror %}

{% tabcontent Mirror pu.xml %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:os-core="http://www.openspaces.org/schema/core"
	xmlns:os-events="http://www.openspaces.org/schema/events"
	xmlns:os-remoting="http://www.openspaces.org/schema/remoting"
	xmlns:os-sla="http://www.openspaces.org/schema/sla"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.openspaces.org/schema/core http://www.openspaces.org/schema/core/openspaces-core.xsd
       http://www.openspaces.org/schema/events http://www.openspaces.org/schema/events/openspaces-events.xsd
       http://www.openspaces.org/schema/remoting http://www.openspaces.org/schema/remoting/openspaces-remoting.xsd
       http://www.openspaces.org/schema/sla http://www.openspaces.org/schema/sla/openspaces-sla.xsd">

	<bean
		class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
		<property name="locations">
			<value>classpath:mirror.properties</value>
		</property>
	</bean>

	<!-- An external data source that will be responsible for persisting changes
		done -->
	<bean id="myDataSource" class="com.gigaspaces.datasource.MyExternalDataSource"
		init-method="initialize">
		<property name="remoteUrl" value="${remote.url}" />
	</bean>

	<!-- The mirror space. Uses my exteranl data source. Persists changes done
		on the Space to the remote space. -->
	<os-core:space id="space" url="/./mirror-service" schema="mirror"
		external-data-source="myDataSource" />

</beans>
{% endhighlight %}

{% endtabcontent %}

{% tabcontent MyExternalDataSource Implementation %}

{% highlight java %}
package com.gigaspaces.datasource;

import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import net.jini.core.lease.Lease;

import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;

import com.gigaspaces.domain.MultiClusterEnabled;
import com.j_spaces.core.IJSpace;
import com.j_spaces.core.client.UpdateModifiers;

public class MyExternalDataSource implements BulkDataPersister, ManagedDataSource {

	Logger logger = Logger.getLogger(this.getClass().getName());

	private GigaSpace remoteGigaSpace = null;
	private String remoteUrl = null;

	//Modify this appropriately
	private long WRITE_TIMEOUT = 10000l;

	public void executeBulk(List<BulkItem> bulkItems)
			throws DataSourceException {

		for (BulkItem bulkItem : bulkItems) {
			logger.info(bulkItem.toString());

			Object item = bulkItem.getItem();
			if (item instanceof MultiClusterEnabled) {

				switch (bulkItem.getOperation()) {
				case BulkItem.REMOVE:
					logger.info("REMOVING " + item);
					remoteGigaSpace.take(item);
					logger.info("After take operation");
					break;
				case BulkItem.WRITE:
					logger.info("WRITING " + item);

					// Disable write back to this space
					if (((MultiClusterEnabled) item).isMultiClusterReplicate()) {
						((MultiClusterEnabled) item)
								.setMultiClusterReplicate(false);
						remoteGigaSpace.write(item);
						logger.info("After write operation");
					}
					break;
				case BulkItem.UPDATE:
					logger.info("UPDATING " + item);

					// Disable write back to this space
					if (((MultiClusterEnabled) item).isMultiClusterReplicate()) {
						((MultiClusterEnabled) item)
								.setMultiClusterReplicate(false);
						remoteGigaSpace.write(item, Lease.FOREVER, WRITE_TIMEOUT,
                                                                      UpdateModifiers.UPDATE_OR_WRITE);
						logger.info("After update operation");
					}
					break;
				}
			}

		}

	}

	public void initialize() {

		// connect to the remote space using its URL
		IJSpace space = new UrlSpaceConfigurer(remoteUrl).space();
		// use gigaspace wrapper to for simpler API
		this.remoteGigaSpace = new GigaSpaceConfigurer(space).gigaSpace();

	}

	public void setRemoteUrl(String remoteUrl) {
		this.remoteUrl = remoteUrl;
	}

	public void init(Properties arg0) throws DataSourceException {
		// TODO Auto-generated method stub

	}

	public DataIterator initialLoad() throws DataSourceException {
		// TODO Auto-generated method stub
		return null;
	}

	public void shutdown() throws DataSourceException {
		// TODO Auto-generated method stub

	}
}
{% endhighlight %}

{% endtabcontent %}

{% endinittab %}

# Running the example

{% note %}
 This example is using Maven for packaging and build. Please [install the OpenSpaces Maven plugin]({%latestjavaurl%}/maven-plugin.html#MavenPlugin-Installation) before you run this example.
Some instructions below might use windows syntax please use appropriate **nix syntax if you are running the example in a **nix machine.
Example was tested using a single machine with ip address, 192.168.2.100 and Lookup Server ports for SiteA and SiteB as 14164 and 14165 respectively. Please modify these corresponding to your environment.
{% endnote %}

1. Extract the [example](/attachment_files/sbp/multi-cluster.zip) archive into a folder. Navigate to the folder (calling it <multi-cluster-example>) and open a command shell. Modify the setDevEnv-SiteA.bat/sh and setDevEnv-SiteB.bat/sh files to have proper paths for GigaSpaces home and Java home. Also modify the NIC_ADDR variable to have proper ip address for each site.
2. Run setDevEnv-SiteA script to set the environment variables.

{% tip %}
Make sure you change the `pom.xml` <gsVersion> paramter to use the GigaSpaces release version you are testing with.
{% endtip %}

3. Run maven clean using following command

{% highlight java %}
mvn clean
{% endhighlight %}

4. Run maven package (skip the tests) using following command

{% highlight java %}
mvn package -DskipTests
{% endhighlight %}

5. Start a gs-ui instance.
6. Run gs-agent-SiteA and gs-agent-SiteB scripts on appropriate machines.
This will start GSA, GSM, LUS and 2 GSC's for SiteA with SiteA zone and GSA, GSM, LUS and 3 GSC's for SiteB with SiteB zone. Hosts tab in gs-ui will look like something below after you add the appropriate groups and locators in gs-ui,
![after_gsa_start.jpg](/attachment_files/sbp/after_gsa_start.jpg)

7. Deploy the SiteA space cluster (2,1) by running deploy-SiteA script from <multi-cluster-example> directory.
8. Deploy the SiteB space cluster (3,1) using following,

{% highlight java %}
cd <multi-cluster-example>\processor
mvn os:deploy -Dsla=../config/SiteB-sla.xml -Dgroups=SiteB -Dlocators=192.168.2.100:14165 -Dmodule=processor
{% endhighlight %}

9. Deploy the mirror using following,

{% highlight java %}
cd <multi-cluster-example>\mirror
mvn os:deploy -Dgroups=SiteB -Dlocators=192.168.2.100:14165 -Dmodule=mirror
{% endhighlight %}

10. Ensure that the spaces are mirror are available in gs-ui. Space Browser tab after everything is deployed will look like below,
![after_deploying_everything.jpg](/attachment_files/sbp/after_deploying_everything.jpg)
11. For running the clients you need the common jar in the maven repo. Install the common jar using following,

{% highlight java %}
cd <multi-cluster-example>\common
mvn install
{% endhighlight %}

12. Create products (in SiteB) by running `WriteProducts` client using following,

{% highlight java %}
cd <multi-cluster-example>\feeder
mvn exec:java -Dexec.classpathScope=compile -Dexec.mainClass="com.gigaspaces.client.WriteProducts"
-Dexec.args="jini://*/*/SiteB?groups=SiteB"
{% endhighlight %}

13. You will notice Products are available on the SiteA as well.
14. Write new orders into the system using `WriteOrders` client using following,

{% highlight java %}
mvn exec:java -Dexec.classpathScope=compile -Dexec.mainClass="com.gigaspaces.client.WriteOrders"
-Dexec.args="jini://*/*/SiteB?groups=SiteB"
{% endhighlight %}

New orders will update the Product quantities on SiteB which are in turn replicated to SiteA instance as well.
