---
layout: post10
title:  Blob Store - Cache Policy
categories: XAP10
parent: memory-management-overview.html
weight: 600
---


# Intoduction

When running in BLOB-STORE cache policy mode, the space uses its available physical memory to store objects indexes only, the objects data is stored on Flash device. When running in a persistent space mode and having Space Persistency defined, the space data is backed with the underlying database, but the overall capacity of the space does not exceed the capacity of the available physical memory.There is also a small LRU cache which store all objects content (data+indexes).

{% indent %}
![data-grid-xap.jpg](/attachment_files/data-grid-async-persist.jpg)
{% endindent %}

XAP is using [SanDisk Flash Data Fabric (FDF)](http://www.sandisk.com/) which enables direct flash access for In-Memory performance, When a user write an object to the space it's indexes are stored in the space and its data is stored at the flash device using FDF.
With blob store cache policy the space (RAM) can store much more data, while quering the space overhead remains the same.

{%note title=Supported OS%}Current version support only CentOS 5.8-5.10{%endnote%}

# The BlobStore Data-Grid Processing Unit

The BlobStore settings includes the following options:

{: .table .table-bordered}
| Property               | Description                                               | Default | Use |
|:-----------------------|:----------------------------------------------------------|:--------|:--------|
| devices | Flash devices. |  | required |
| volume-dir | Directory path which contains a link to the the SSD device. | | required |
| blob-store-capacity-GB | Flash device allocation size in Gigabytes. | 200 | optional |
| blob-store-capacity-MB | Flash device allocation size in Megabytes. | 204800 | optional |
| blob-store-capacity-MB | FDF internal cache size in Megabytes. | 100 | optional |
| blob-store-reformat | Whether to clear all SSD data in the space initialization pahse or not. | false | optional |
| enable-admin | Whether to start an FDF admin or not. FDF admin provides a simple command line interface (CLI) through a TCP port. The FDF CLI uses port 51350 by default. This port can be changed through the configuration parameter FDF_ADMIN_PORT. | true |
| statistics-interval | Applications can optionally enable periodic dumping of statistics to a specified file (XAP_HOME/logs). This is disabled by default. | | optional |
| durability-level | PERIODIC: sync storage every 1024	writes.Up to 1024 objects can be lost in the event of application crash.{%wbr%}SW_CRASH_SAFE: This policy guarantees no data loss in the event of software crashes. But some data might be lost in the event of hardware failure.{%wbr%}HW_CRASH_SAFE: This policy guarantees no data loss if the hardware crashes.Since there are performance implication it is recommended to work with NVRAM device and configure log-flash-dir to a folder on this device. | PERIODIC | optional |
| log-flush-dir | In case of HW_CRASH_SAFE, directory in a filesystem on top of NVRAM backed disk. This directory must be unique per space, you can add ${clusterInfo.runningNumber} as suffix | /tmp | optional |

The IMDG BlobStore settings includes the following options:{%wbr%}

{: .table .table-bordered}
| Property | Description | Default | Use |
|:---------|:------------|:--------|:--------|
| blob-store-handler | BlobStore implementation |  | required |
| cache-entries-percentage | Cache percentage form JVM max memory(-Xmx).In case of missing -Xmx configuration the cache size is 10000. This is an LRU cache which store the whole object.| 20% | optional |
| avg-object-size-KB |  Average object size. | 5KB | optional |


# Usage

Creating a BlobStore GigaSpace is similar to creating a GigaSpace, except that we inject a blobstore implementation to the GigaSpace. The BlobStore can be configured at design time using `SanDiskBlobStoreDataPolicyFactoryBean`, or at runtime using `SanDiskBlobStoreConfigurer`. For example:


{% inittab os_simple_space|top %}
{% tabcontent Namespace %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xmlns:blob-store="http://www.openspaces.org/schema/blob-store"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
       http://www.openspaces.org/schema/core http://www.openspaces.org/schema/10.0/core/openspaces-core.xsd
       http://www.openspaces.org/schema/blob-store http://www.openspaces.org/schema/10.0/blob-store/openspaces-blobstore.xsd">

    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"/>

    <blob-store:sandisk-blob-store id="blobstoreid" volume-dir="/tmp" devices="/dev/xvdb,/dev/xvdc"
            blob-store-capacity-GB="200" blob-store-cache-size-MB="50" blob-store-reformat="true" durability-level="SW_CRASH_SAFE">
    </blob-store:sandisk-blob-store>

    <os-core:space id="space" url="/./mySpace" lookup-groups="${user.name}">
        <os-core:blob-store-data-policy blob-store-handler="blobstoreid" cache-entries-percentage="10" avg-object-size-KB="5"/>
    </os-core:space>

    <os-core:giga-space id="gigaSpace" space="space"/>
</beans>
{% endhighlight %}
{% endtabcontent %}

{% tabcontent Plain XML %}

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:os-core="http://www.openspaces.org/schema/core"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.2.xsd
       http://www.openspaces.org/schema/core http://www.openspaces.org/schema/10.0/core/openspaces-core.xsd">

    <bean id="propertiesConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer"/>

    <bean id="blobstoreid" class="com.gigaspaces.blobstore.storagehandler.SanDiskBlobStoreHandler">
        <property name="blobStoreCapacityGB" value="200"/>
        <property name="blobStoreCacheSizeMB" value="50"/>
        <property name="blobStoreDevices" value="/dev/xvdb,/dev/xvdc"/>
        <property name="blobStoreVolumeDir" value="/tmp"/>
        <property name="blobStoreDurabilityLevel" value="SW_CRASH_SAFE"/>
    </bean>

    <os-core:space id="space" url="/./mySpace" lookup-groups="${user.name}">
        <os-core:blob-store-data-policy blob-store-handler="blobstoreid" cache-entries-percentage="10"
                                        avg-object-size-KB="5"/>
    </os-core:space>

    <os-core:giga-space id="gigaSpace" space="space"/>
</beans>
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Code %}

{% highlight java %}
	SanDiskBlobStoreConfigurer configurer = new SanDiskBlobStoreConfigurer();
        configurer.addDevices("/dev/xvdb,/dev/xvdc");
        configurer.addVolumeDir("/tmp");
        configurer.setBlobStoreCapacityGB(200);
        configurer.setBlobStoreCacheSizeMB(50);
        configurer.setDurabilityLevel(DurabilityLevel.SW_CRASH_SAFE);

        SanDiskBlobStoreHandler blobStoreHandler = configurer.create();
        BlobStoreDataCachePolicy cachePolicy = new BlobStoreDataCachePolicy();
        cachePolicy.setAvgObjectSizeKB(5l);
        cachePolicy.setCacheEntriesPercentage(10);
        cachePolicy.setBlobStoreHandler(blobStoreHandler);

        UrlSpaceConfigurer urlConfig = new UrlSpaceConfigurer(spaceURL);
        urlConfig.cachePolicy(cachePolicy);

        gigaSpace = new GigaSpaceConfigurer(urlConfig).gigaSpace();
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

The above example:
- Configures the SanDisk BlobStore bean.{%wbr%}
- Configures the Space to use the above blobStore implementation also configure the cache size, in this LRU cache the space store the whole object and not just the object indexes.


# Metadata
When writing POJO to the Space, you can provide a metadata whether this type will disable blob store even if cache-policy is BlobStore.

Here is a sample POJO class:

{% highlight java %}
@SpaceClass(disableBlobStore = true)
public class Person {
    private Integer id;
    private String name;
    private String lastName;
    private int age;

    ...
    public Person() {}

    @SpaceId(autoGenerate=false)
    @SpaceRouting
    public Integer getId() { return id;}

    public void setId(Integer id) {  this.id = id; }

    @SpaceProperty(index=BASIC)
    public Long getLastName() { return lastName; }

    public void setLastName(String type) { this.lastName = lastName; }

    @SpaceProperty(nullValue="-1")
    public int getAge(){ return age; }

    .......
}
{% endhighlight %}


If you wish to add Async Persistency - Mirror to your IMDG please refer to [Async Persistency with Mirror](./asynchronous-persistency-with-the-mirror.html).

