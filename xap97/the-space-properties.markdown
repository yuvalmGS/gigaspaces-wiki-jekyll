---
layout: post
title:  Properties
categories: XAP97
parent: the-space.html
weight: 300
---


{% summary %}Describes the main XAP API for interacting with the space{% endsummary %}

# Overview

OpenSpaces provides a simpler space API using the [GigaSpace](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/index.html) interface, by wrapping the [IJSpace](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/j_spaces/core/IJSpace.html) (and the Jini [JavaSpace](http://www.gigaspaces.com/docs/JiniApi/net/jini/space/JavaSpace.html)), and simplifying both the API and its programming model.


The interface allows a POJO or a Document domain model to be stored in the space, use declarative transactions, use Java 5 Generics, coherent runtime exception hierarchy, and more.

There are multiple runtime configurations you may use when interacting with the space:


# Basic Properties

The Space component support the following basic properties:


{: .table .table-bordered}
|Property |Description|Default|
|:-----------|:-----------------|:----------|:------|
|lookupGroups|The Jini Lookup Service group to use when running in multicast discovery mode. you may specify multiple groups comma separated| gigaspaces-X.X.X-XAP<Release>-ga |


{% togglecloak id=1 %}**Example**{% endtogglecloak %}
{% gcloak 1 %}
{% inittab os_simple_space|top %}
{% tabcontent java %}
{%highlight java%}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer("/./space").lookupGroups("test");
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{%endhighlight%}
{% endtabcontent %}
{% tabcontent Name Space %}
{%highlight xml%}
 <os-core:space id="space" url="/./space" />
 <os-core:giga-space id="gigaSpace" space="space" lookupGroups="test"
 </os-core:giga-space>
{%endhighlight%}
{% endtabcontent %}
{% endinittab %}
{% endgcloak %}

{: .table .table-bordered}
|Property|Description|Default|
|:-----------------|:----------|:------|
|lookupLocators |The Jini Lookup locators to use when running in unicast discovery mode. In the form of: host1:port1,host2:port2.| |

{% togglecloak id=2 %}**Example**{% endtogglecloak %}
{% gcloak 2 %}
{% inittab os_simple_space|top %}
{% tabcontent java %}
{%highlight java%}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer(url).lookupLocators("192.165.1.21:7888, 192.165.1.22:7888");
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{%endhighlight%}
{% endtabcontent %}
{% tabcontent Name Space %}
{%highlight xml%}
 <os-core:space id="space" url="/./space" />
 <os-core:giga-space id="gigaSpace" space="space" lookupLocators="192.165.1.21:7888, 192.165.1.22:7888"
 </os-core:giga-space>
{%endhighlight%}
{% endtabcontent %}
{% endinittab %}
{% endgcloak %}


{: .table .table-bordered}
|Property|Description|Default|Time Unit
|:-----------------|:----------|:------|:--------|
|lookupTimeout |The max timeout in milliseconds to use when running in multicast discovery mode to find a lookup service| 5000 | milliseconds |

{% togglecloak id=3 %}**Example**{% endtogglecloak %}
{% gcloak 3 %}
{% inittab os_simple_space|top %}
{% tabcontent java %}
{%highlight java%}
UrlSpaceConfigurer urlSpaceConfigurer = new UrlSpaceConfigurer(url).lookupTimeout(1000);
GigaSpace gigaSpace = new GigaSpaceConfigurer(urlSpaceConfigurer).gigaSpace();
{%endhighlight%}
{% endtabcontent %}
{% tabcontent Name Space %}
{%highlight xml%}
 <os-core:space id="space" url="/./space" />
 <os-core:giga-space id="gigaSpace" space="space" lookupTimout="1000"
 </os-core:giga-space>
{%endhighlight%}
{% endtabcontent %}
{% endinittab %}
{% endgcloak %}



# The giga-space Bean

The `os-core:giga-space` Spring Bean provides a simple way to confgire a GigaSpace object to be injected into the relevant Bean. It can have the following elements:

{: .table .table-bordered}
|Element|Description|Required|Default Value|
|:------|:----------|:-------|:------------|
|space| [The Space bean](./the-space-component.html). This can be an embedded space , remote space , local view or local cache proxy. |YES| |
|clustered|Boolean. [Cluster flag](./clustered-vs-non-clustered-proxies.html). Controlling if this GigaSpace will work with a clustered view of the space or directly with a cluster member. By default if this flag is not set it will be set automatically by this factory. It will be set to true if the space is an embedded one AND the space is not a local cache proxy. It will be set to false otherwise (i.e. the space is not an embedded space OR the space is a local cache proxy)| NO | true for remote proxy , false for embedded proxy|
|default-read-timeout|Numerical Value. Sets the default read timeout for `read(Object)` and `readIfExists(Object)` operations.|NO| 0 (NO\_WAIT). TimeUnit:millsec|
|default-take-timeout|Numerical Value. Sets the default take timeout for `take(Object)` and `takeIfExists(Object)` operations.|NO| 0 (NO\_WAIT). TimeUnit:millsec|
|default-write-lease| Numerical Value. Sets the default [space object lease](./leases---automatic-expiration.html) (TTL) for `write(Object)` operation. |NO| FOREVER. TimeUnit:millsec|
|default-isolation| Options: DEFAULT , READ\_UNCOMMITTED, READ\_COMMITTED , REPEATABLE\_READ|NO| DEFAULT|
|tx-manager|Set the transaction manager to enable transactional operations. Can be null if transactional support is not required or the default space is used as a transactional context. |NO| |
|write-modifier|Defines a single default write modifier for the space proxy. Options: NONE, WRITE\_ONLY, UPDATE\_ONLY, UPDATE\_OR\_WRITE, RETURN\_PREV\_ON\_UPDATE, ONE\_WAY, MEMORY\_ONLY\_SEARCH, PARTIAL\_UPDATE|NO| UPDATE\_OR\_WRITE |
|read-modifier|The modifier constant name as defined in ReadModifiers. Options:NONE, REPEATABLE\_READ, READ\_COMMITTED, DIRTY\_READ, EXCLUSIVE\_READ\_LOCK, IGNORE\_PARTIAL\_FAILURE, FIFO, FIFO\_GROUPING\_POLL, MEMORY\_ONLY\_SEARCH|NO|READ\_COMMITTED|
|take-modifier|Defines a single default take modifier for the space proxy. Options:NONE, EVICT\_ONLY, IGNORE\_PARTIAL\_FAILURE, FIFO, FIFO\_GROUPING\_POLL, MEMORY\_ONLY\_SEARCH|NO| NONE|
|change-modifier|Defines a single default change modifier for the space proxy. Options:NONE, ONE\_WAY, MEMORY\_ONLY\_SEARCH, RETURN\_DETAILED\_RESULTS|NO| NONE|
|clear-modifier|Defines a single default count modifier for the space proxy. Options:NONE, EVICT\_ONLY, MEMORY\_ONLY\_SEARCH|NO| NONE|
|count-modifier|Defines a single default count modifier for the space proxy. Options:NONE, REPEATABLE\_READ, READ\_COMMITTED, DIRTY\_READ, EXCLUSIVE\_READ\_LOCK, MEMORY\_ONLY\_SEARCH|NO| NONE|

Here is an example of the giga-space Bean:

{% inittab gigaspace|top %}
{% tabcontent Namespace %}

{% highlight xml %}
 <os-core:giga-space id="gigaSpaceClustered" space="space" clustered="true"
  	 default-read-timeout="10000"
  	 default-take-timeout="10000"
  	 default-write-lease="100000">
  	 <os-core:read-modifier value="FIFO"/>
  	 <os-core:change-modifier value="RETURN_DETAILED_RESULTS"/>
  	 <os-core:clear-modifier value="EVICT_ONLY"/>
  	 <os-core:count-modifier value="READ_COMMITTED"/>
  	 <os-core:take-modifier value="FIFO"/>

  	 <!-- to add more than one modifier, simply include all desired modifiers -->
  	 <os-core:write-modifier value="PARTIAL_UPDATE"/>
  	 <os-core:write-modifier value="UPDATE_ONLY"/>
  	</os-core:giga-space>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Plain XML %}

{% highlight xml %}
<bean id="gigaSpace" class="org.openspaces.core.GigaSpaceFactoryBean">
 	 <property name="space" ref="space" />
 	 <property name="clustered" value="true" />
 	 <property name="defaultReadTimeout" value="10000" />
 	 <property name="defaultTakeTimeout" value="100000" />
 	 <property name="defaultWriteLease" value="100000" />
 	 <property name="defaultWriteModifiers">
 	 <array>
 	 <bean id="updateOnly"
 	 class="org.openspaces.core.config.modifiers.WriteModifierFactoryBean">
 	 <property name="modifierName" value="UPDATE_ONLY" />
 	 </bean>
 	 <bean id="partialUpdate"
 	 class="org.openspaces.core.config.modifiers.WriteModifierFactoryBean">
 	 <property name="modifierName" value="PARTIAL_UPDATE" />
 	 </bean>
 	 </array>
 	 </property>
</bean>
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}


# URL Properties

The following are optional property string values.

These strings are defined as part of the `SpaceURL` class (`com.j_spaces.core.client.SpaceURL`; see [Javadoc](http://www.gigaspaces.com/docs/JavaDoc{% currentversion %}/com/j_spaces/core/client/SpaceURL.html)) as static attributes.

{: .table .table-bordered}
| Property name | Property String | Description | Optional values |
|:--------------|:----------------|:------------|:----------------|
| `ANY` | * | Used with Jini protocol to indicate any host or container name | |
| `CREATE` | `create` | Creates a new space using the container's default parameters. New spaces use the default space configuration file. Example: `java://localhost:10098/containerName`{% wbr %}`/JavaSpaces?create=true` | |
| `EMBEDDED_SPACE`{% wbr %}`_PROTOCOL` | java: | Start the space in local embedded mode. Make sure you have the `com.gs.home` JVM property defined to specify the space configuration file directory | |
| `FIFO_MODE` | fifo | Indicates that all take/write operations be conducted in FIFO mode. Default is false. Example: `jini://localhost:10098/containerName`{% wbr %}`/JavaSpaces?fifo=true` | `false` |
| `GROUPS` | `groups` | The Jini Lookup Service group to find container or space using multicast. Example: `jini://*/containerName/spaceName?groups=grid`{% wbr %}{% infosign %} The default value of the `LOOKUPGROUPS` variable is the GigaSpaces version number, preceded by `XAP`. For example, in GigaSpaces XAP 6.0 the default lookup group is `XAP6.0`. This is the lookup group which the space and Jini Transaction Manager register with, and which clients use by default to connect to the space.{% wbr %}{% exclamation %} Jini groups are irrelevant when using unicast lookup discovery -- they are relevant only when using multicast lookup discovery. If you have multiple spaces with the same name and you are using unicast lookup discovery, you might end up getting the wrong proxy. In such a case, make sure you have a different lookup for each space, where each space is configured to use a specific lookup. A good practice is to have different space names. | `Group name` |
| `LOCATORS` | `locators` | Instructs the started space or a client to locate the Jini Lookup Service on specific host name and port. For more details please refer to [How to Configure Unicast Discovery](./how-to-configure-unicast-discovery.html#HowtoConfigureUnicastDiscovery-Configuringthelookuplocatorsproperty) page. | |
| `JINI_PROTOCOL` | `jini:` | Using JINI Lookup service to search for the space | |
| `LOCAL_CACHE`{% wbr %} `UPDATE_MODE` | `updateMode` | Push or pull update mode. Example: {%wbr%}`jini://localhost:10098/containerName /JavaSpaces?useLocalCache&updateMode=1` | `UPDATE_`{% wbr %} `MODE`{% wbr %} `_PULL`{% wbr %} `= 1` {% wbr %} `UPDATE_`{% wbr %} `MODE`{% wbr %} `_PUSH`{% wbr %} `= 2` |
| `SECURITY_MANAGER` | `security`{% wbr %} `Manager` | When false, `SpaceFinder` will not initialize RMISecurityManager. Default is `true`. Example: `jini://localhost:10098/containerName`{% wbr %} `/JavaSpaces?securityManager=false` | |
| `TIMEOUT` | `timeout` | The max timeout in \[ms\] to find a Container or Space using multicast {% wbr %} `jini://` protocol. Default: 5000\[ms\] Example: `jini://<code>*</code>/containerName`{% wbr %} `/JavaSpaces?timeout=10000` | |
| `USE_LOCAL`{% wbr %} `CACHE` | `useLocalCache` | Turn Master-Local Space mode.By default Master-Local mode is turned off. To enable master local have the `useLocalCache` as part of the URL |  |
| `VERSIONED` | versioned | When false, optimistic lock is disabled. In a local cache and views the default is `true`, otherwise the default value is `false`. Example: `jini://localhost:10098/containerName/JavaSpaces?versioned=false` | |
| `CLUSTER_NAME` | `clustername` | The cluster name to lookup using multicast. The returned object is a clustered proxy. | |
| `CLUSTER_GROUP` | `clustergroup` | The cluster group to lookup using multicast. The returned object is a clustered proxy. | |
| `CLUSTER_SCHEMA` | `cluster_schema` | The cluster schema XSL file name to be used to setup a cluster config on the fly in memory. If the `?cluster_schema option` is passed e.g. `?cluster_schema=sync_replication`, the system will use the `sync_replication-cluster-schema.xsl` together with a cluster Dom which will be built using user's inputs on regards # of members, # of backup members etc. | |
| `SCHEMA_NAME` | `schema` | Using the schema flag, the requested space schema name will be loaded/parsed while creating an embedded space. If the space already has configuration file then the requested schema will not be applied and the that file exist, it will overwrite the default configuration defined by the schema. Note that when using the option ?create with java:// protocol, the system will create a container, space and use the default space configuration schema file (default-space-schema.xml) | |
| `CLUSTER_TOTAL`{% wbr %} `MEMBERS` | `total_members` | The `total_members` attribute in the space URL stands for the total number of cache members within the cache cluster.{% wbr %}The number is used to create the list of members participating in the cluster on the fly based on the cache name convention. This pattern is used to avoid the need for creating a cluster topology file. {% wbr %}The number of actual running cache instances can vary dynamically between `1<=total_members`.{% wbr %}The format of the `total_members` = number of primary instances, number of backup instances per primary. In this example the value is 4,2 which means that this cluster contains up to 4 primary instances each containing 2 backup instances. The backup\_id is used to define whether the instance is a backup instance or not.{% wbr %}If this attribute is not defined the instance will be considered a primary instance. The container name will be translated in this case to \[cache name\]\_container\[id\]\[backup_id\].{% wbr %}In this case it will be expanded to mySpace_container1\_1 | |
| `CLUSTER_BACKUP_ID` | `backup_id` | Used in case of Partitioned Cache (when adding backup to each partition). The backup_id is used to define whether the instance is a backup instance or not. If this attribute is not defined the instance will be considered a primary cache instance.{% wbr %}The container name will be translated in this case to \[cache name\]_container\[id\]_\[backup_id\].{% wbr %} In this case it will be expanded to mySpace_container1_1. | |
| `NO_WRITE_LEASE` | `NOWriteLease` | If true - Lease object would not return from the write/writeMultiple operations. Default: false | |
| `CLUSTER_MEMBER_ID` | `id` | The id attribute is used to distinguish between cache instances in this cluster. | |
| `PROPERTIES_FILE`{%wbr%}`NAME` | `properties` | if properties property is used as part of the URL space, space and container schema will be loaded and the properties listed as part of the properties file (`[prop-file-name].properties`) which contains the values to override the schema space/container/cluster configuration values that are defined in the schema files.{% wbr %}Another benefit of using the ?properties option is when we want to load system properties while VM starts or set SpaceURL attributes. See /config/gs.properties file as a reference. | |
| `MIRROR` | `mirror` | When setting this URL property it will allow the space to connect to the Mirror service to push its data and operations for asynchronous persistency.{% wbr %}Example:{% wbr %}`/./JavaSpace?cluster_schema=sync_replicated&mirror`{% wbr %} Default: no mirror connection | |

Example for space URL using Space URL options:

{% highlight java %}
jini://*/*/mySpace?useLocalCache&versioned=false
/./mySpace?cluster_schema=partitioned&total_members=4&id=1
{% endhighlight %}