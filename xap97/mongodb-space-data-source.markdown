{composition-setup} 

## Configuration 
A MongoDB based implementation of the [Space Data Source](./space-data-source-api.html). 

### Library dependencies 
The MongoDB Space Data Source uses [MongoDB Driver](http://www.allanbank.com/mongodb-async-driver/index.html) For communicating with the MongoDB cluster.
 
include the following in your `pom.xml`
{% highlight xml %}
<!-- currently the MongoDB library is not the central maven repository --> 
<repositories>
		<repository>
			<id>org.openspaces</id>
			<name>OpenSpaces</name>
			<url>http://maven-repository.openspaces.org</url>
		</repository>

		<repository>
			<releases>
				<enabled>true</enabled>
				<updatePolicy>always</updatePolicy>
				<checksumPolicy>warn</checksumPolicy>
			</releases>
			<id>allanbank</id>
			<name>Allanbank Releases</name>
			<url>http://www.allanbank.com/repo/</url>
			<layout>default</layout>
		</repository>
</repositories>


<!-- mongodb java driver -->
<dependency>
	<groupId>org.mongodb</groupId>
	<artifactId>mongo-java-driver</artifactId>
	<version>2.11.2</version>
</dependency>
<dependency>
	<groupId>com.allanbank</groupId>
	<artifactId>mongodb-async-driver</artifactId>
	<version>1.2.3</version>
</dependency>

<dependency> 
	<groupId>org.antlr</groupId> 
	<artifactId>antlr4-runtime</artifactId> 
	<version>4.0</version> 
</dependency> 

{% endhighlight %}

### Setup 

An example of how the MongoDB Space Data Source can be configured for a space that loads data back from MongoDB once initialized and 
also asynchronously persists the data using a mirror (see [MongoDB Space Synchronization Endpoint](./mongodb-space-synchronization-endpoint.html))). 

{% inittab Configuration Examples %}
{% tabcontent Spring %}{% highlight xml %} 
<?xml version="1.0" encoding="utf-8"?> 
<beans xmlns="http://www.springframework.org/schema/beans" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context" 
xmlns:os-core="http://www.openspaces.org/schema/core" xmlns:os-jms="http://www.openspaces.org/schema/jms" 
xmlns:os-events="http://www.openspaces.org/schema/events" 
xmlns:os-remoting="http://www.openspaces.org/schema/remoting" 
xmlns:os-sla="http://www.openspaces.org/schema/sla" xmlns:tx="http://www.springframework.org/schema/tx" 

xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd 
http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.0.xsd 
http://www.openspaces.org/schema/core http://www.openspaces.org/schema/9.1/core/openspaces-core.xsd 
http://www.openspaces.org/schema/events http://www.openspaces.org/schema/9.1/events/openspaces-events.xsd 
http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-3.1.xsd 
http://www.openspaces.org/schema/remoting http://www.openspaces.org/schema/9.1/remoting/openspaces-remoting.xsd"> 

<bean id="propertiesConfigurer" 
class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer" /> 

<os-core:space id="space" url="/./dataSourceSpace"
	space-data-source="spaceDataSource" mirror="true" schema="persistent">
	<os-core:properties>
		<props>
			<!-- Use ALL IN CACHE, put 0 for LRU --> 
			<prop key="space-config.engine.cache_policy">1</prop>				
			<prop key="cluster-config.cache-loader.central-data-source">true</prop>
			<prop key="cluster-config.mirror-service.supports-partial-update">true</prop>
		</props>
	</os-core:properties>
</os-core:space>

<os-core:giga-space id="gigaSpace" space="space" /> 

<bean id="mongoClient"
		class="com.gigaspaces.persistency.MongoClientConnectorBeanFactory">
		<property name="db" value="${mongo.db}" />
		<property name="config">
			<bean class="com.allanbank.mongodb.MongoClientConfiguration">
				<constructor-arg value="mongodb://${mongo.host}:${mongo.port}/${mongo.db}"
					type="java.lang.String" />
				<property name="defaultDurability" value="ACK"/>		
			</bean>
		</property>
</bean>

<bean id="spaceDataSource" 
		class="com.gigaspaces.persistency.MongoSpaceDataSourceBeanFactory">
		<property name="mongoClientConnector" ref="mongoClient" />
</bean>


</beans> 

{% endhighlight %} 
{% endtabcontent %}
{% tabcontent Code %}
{% highlight java %}
MongoClientConfiguration config = new MongoClientConfiguration();

config.addServer(host);				
config.setDefaultDurability(Durability.ACK);

MongoClientConnector client = new MongoClientConnectorConfigurer()
		.config(config)
		.db(dbName)
		.create();	

MongoSpaceDataSource dataSource = new MongoSpaceDataSourceConfigurer()
		.mongoClientConnector(client)
		.create();

GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer("/./space")	
.schema("persistent") 
.mirror(true) 
.cachePolicy(new LruCachePolicy()) 
.addProperty("cluster-config.cache-loader.central-data-source", "true") 
.addProperty("cluster-config.mirror-service.supports-partial-update", "true") 
.spaceDataSource(spaceDataSource) 
.space()).gigaSpace(); 

{% endhighlight %} 
{% endtabcontent %}
{% endinittab %}

For more details about different configurations see [Space Persistency](./space-persistency.html). 

### `MongoSpaceDataSource` Properties 
{: .table .table-bordered}
|Property|Description|Default|
|:-------|:----------|:------|
|mongoClientConnector|A configured `com.gigaspaces.persistency.MongoClientConnector` bean. Must be configured| | 

## Considerations 

### General limitations 
- All classes that belong to types that are to be introduced to the space during the initial metadata load must exist on the classpath of the JVM the Space is running on. 

### Cache miss Query limitations 
Supported queries:
- `id = 1234` 
- `name = 'John' AND age = 13` 
- `address.streetName = 'Liberty'` 
- `age > 15`
- `age < 20`
- `age <= 20`
- ` age >= 15`
- `name = 'John' OR name = 'Jane'`
- `name rlike 'A.*B'`
- `name like 'A%'`
- `name is NULL`
- `name is NOT NULL`

note: java types Short, Float, BigDecimal and BigInt supported only =,<> quieries >,<,>=,<= is not supported.

Unsupported quieries:
- Contains is unsupported
