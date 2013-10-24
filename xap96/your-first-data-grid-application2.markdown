---
layout: xap96
title:  Your First Data Grid Application2
page_id: 61867198
---

{% compositionsetup %}

# Overview

GigaSpace's XAP can be used as a scalable application platform on which you can host your Java applications, similar to JEE and web containers. However, XAP's IMDG can also be used in standalone Java applications. The IMDG can be used in different scenarios; Embedded, Remote, Local/View and Task Execution. The following examples show how to use the GigaSpace IMDG with your application for the different scenarios.
In order to run these examples use the following installation instructions:

- Download the latest version of GigaSpace XAP from here .......
- Unzip the distribution into a working directory; GS_HOME
- Start your favorite Java IDE
- Create a new project
- Include all files from the GS_HOME/lib/required in the classpath
- Include GS_HOME/gs_license.xml in the classpath

You can also download the Java code for these examples here .....

Throughout the tutorial we will use the following Class Model for the example code.
![ClassDiagram.png](/attachment_files/ClassDiagram.png)

{% note %}
Any POJO can be used to interact with the data grid. The POJO needs to implement a default constructor, setters and getters for every property you want to store in the Space and the @SpaceId attribute annotation needs to be added.
{% endnote %}

Here is an example of a simple Purchase Order POJO we will use in this tutorial.

{% highlight java %}
package gs.tutorial.domain.po;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.UUID;
import com.gigaspaces.annotation.pojo.SpaceClass;
import com.gigaspaces.annotation.pojo.SpaceId;

@SpaceClass
public class PurchaseOrder {
    private UUID id;
    private EPurchaseOrderState orderState;
    private EPurchaseOrderType orderType;
    private String number;
    private BigDecimal totalCost;
    private Date orderDate;
    private Date shipDate;
    private Collection<LineItem> items;

    public PurchaseOrder() {
    }
    @SpaceId(autoGenerate = false)
    public UUID getId() {
        return id;
    }
    public boolean validate() {
        if (number == null || number.length() < 10) {
            return false;
        }
        return true;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    public EPurchaseOrderState getOrderState() {
        return orderState;
    }
    public void setOrderState(EPurchaseOrderState orderState) {
        this.orderState = orderState;
    }
    public String getNumber() {
        return number;
    }
    public void setNumber(String number) {
        this.number = number;
    }
    public BigDecimal getTotalCost() {
        return totalCost;
    }
    public void setTotalCost(BigDecimal totalCost) {
        this.totalCost = totalCost;
    }
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public Date getShipDate() {
        return shipDate;
    }
    public void setShipDate(Date shipDate) {
        this.shipDate = shipDate;
    }
    public Collection<LineItem> getItems() {
        return items;
    }
    public void setItems(Collection<LineItem> items) {
        this.items = items;
    }
    public void addLineItem(LineItem item) {
        if (items == null)
            items = new ArrayList<LineItem>();
        items.add(item);
    }
    public EPurchaseOrderType getOrderType() {
        return orderType;
    }
    public void setOrderType(EPurchaseOrderType orderType) {
        this.orderType = orderType;
    }
    @Override
    public String toString() {
        return "PurchaseOrder [id=" + id + ", orderState=" + orderState
                + ", orderType=" + orderType + ", number=" + number
                + ", totalCost=" + totalCost + ", orderDate=" + orderDate
                + ", shipDate=" + shipDate + ", items=" + items + "]";
    }
}
{% endhighlight %}

{% highlight java %}
package gs.tutorial.domain.po;

public enum EPurchaseOrderType {
    NORMAL(1), DROPSHIPMENT(2), BLANKET(3), RELEASE(4);
    private int state;

    EPurchaseOrderType(int state) {
        this.state = state;
    }
    public int getState() {
        return state;
    }
}
{% endhighlight %}

{% highlight java %}
package gs.tutorial.domain.po;

public enum EPurchaseOrderState {
    NEW(1), ONHOLD(2), SHIPPED(3), DELIVERED(4), PROCESSED(5);
    private int state;

    EPurchaseOrderState(int state) {
        this.state = state;
    }
    public int getState() {
        return state;
    }
}
{% endhighlight %}

{% highlight java %}
package gs.tutorial.domain.po;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.UUID;

public class LineItem implements Serializable {
    private static final long serialVersionUID = 1L;
    private UUID id;
    private int quantity;
    private BigDecimal cost;

    public LineItem() {
        id = UUID.randomUUID();
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public BigDecimal getCost() {
        return cost;
    }
    public void setCost(BigDecimal cost) {
        this.cost = cost;
    }
    public UUID getId() {
        return id;
    }
    public void setId(UUID id) {
        this.id = id;
    }
    @Override
    public String toString() {
        return "LineItem [quantity=" + quantity + ", cost=" + cost + "]";
    }
}
{% endhighlight %}

# Embedded Cache

An embedded cache runs within the application's memory address space.
Embedded space:

- As the primary space configuration setup
- Accessed by reference without going through a network or involving serialization de-serialization calls
- Most efficient configuration mode

![EmbeddedSpace.png](/attachment_files/EmbeddedSpace.png)

Here is an example that demonstrates the interaction with an embedded cache.

{% highlight java %}
package gs.tutorial.firstgrid.embedded;

import java.util.UUID;
import gs.tutorial.domain.po.EPurchaseOrderState;
import gs.tutorial.domain.po.PurchaseOrder;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;

public class EmbeddedSpace {
    // Embedded Space
    static String url = "/./mySpace";

    public static void main(String[] args) throws InterruptedException {

        // Create the Space
        GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer(
                url)).gigaSpace();

        System.out.println("Space is embedded :"
                + gigaSpace.getSpace().isEmbedded());

        // Create a PO
        PurchaseOrder po = new PurchaseOrder();
        po.setId(UUID.randomUUID());
        po.setOrderState(EPurchaseOrderState.NEW);
        po.setNumber("X233FF");

        // Write the PO to the Space
        gigaSpace.write(po);

        // Read the PO from Space
        PurchaseOrder p = gigaSpace.readById(PurchaseOrder.class, po.getId());
        System.out.println(p);
    }
}
{% endhighlight %}

That's it, no configuration files are needed in order to access the space. In this example we used three space operations:

- **Space creation**  : create a local space in the JVM with the URL = "/./mySpace"
- **Write to space**  : create an object in space that lives forever until it is removed from space
- **Read from space** : reading an object from the cache by its unique id(primary key)
There are many more options for interacting with the space available. These options are explained in details in the Programers Guide.

# Remote Cache

Clients can access a remote cache over the network and the cached objects are serialized and de-serialized.
Remote cache is used when:

- Client applications cannot run an embedded space (due to memory capacity limitations, etc.)
- In cases where a large number of concurrent updates on the same cached object using are made by different remote processes

![RemoteSpace.png](/attachment_files/RemoteSpace.png)

Here is the code that shows a client accessing a remote space. Start the RemoteSpace first and then execute the RemoteClient.

{% highlight java %}
package gs.tutorial.firstgrid.remote;

import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;
import com.j_spaces.core.IJSpace;

public class RemoteSpace {

    static String url = "/./mySpace";

    public static void main(String[] args) throws InterruptedException {

        IJSpace space = new UrlSpaceConfigurer(url).space();

        @SuppressWarnings("unused")
        GigaSpace gigaSpace = new GigaSpaceConfigurer(space).gigaSpace();

        System.out.println("Remote Space : 'mySpace' is running ");
        Thread.sleep(Integer.MAX_VALUE);
    }
}
{% endhighlight %}

{% highlight java %}
package gs.tutorial.firstgrid.remote;

import java.util.UUID;
import gs.tutorial.domain.po.EPurchaseOrderState;
import gs.tutorial.domain.po.EPurchaseOrderType;
import gs.tutorial.domain.po.PurchaseOrder;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;

public class SpaceClient {

    // Remote Space
    static String url = "jini://*/*/mySpace";

    public static void main(String[] args) throws InterruptedException {

        // Connect to the Remote Space
        GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer(
                url)).gigaSpace();

        System.out.println("Space is embedded :"
                + gigaSpace.getSpace().isEmbedded());
        // Create a PO
        PurchaseOrder po = new PurchaseOrder();
        po.setId(UUID.randomUUID());
        po.setOrderState(EPurchaseOrderState.NEW);
        po.setOrderType(EPurchaseOrderType.DROPSHIPMENT);
        po.setNumber("X233FF");

        // Write the PO to the Space
        gigaSpace.write(po);

        // Read the PO from Space by its id
        PurchaseOrder p = gigaSpace.readById(PurchaseOrder.class, po.getId());
        System.out.println(p);
    }
}
{% endhighlight %}

{% note %}
The client code for accessing the remote space is exactly the same as in the embedded space. The only difference is the space URL = "jini://\*/\*/mySpace" tells XAP to use JINI to lookup he space.
{% endnote %}

# UI console

You can start XAP's UI console and inspect the cached objects. In the GigaSpace distribution you will find a command file to launch the console. (GS_HOME/bin/gs_ui.bat for windows and gs_ui.sh for unix)
Start the remote space example from this tutorial and then the remote client. Now you are able to see the space in the XAP UI console. The screen shots below demonstrate on how to use the XAP UI console to inspect cached objects.

![Console1.png! !Console2.png! !Console3.png! !Console4.png](/attachment_files/Console1.png! !Console2.png! !Console3.png! !Console4.png)

# Local Cache

A Local Cache is a client side cache that maintains a subset of the master space's data based on the client application's recent activity. The local cache is created empty, and whenever the client application executes a query the local cache first tries to fulfill it from the cache, otherwise it executes it on the master space and caches the result locally for future queries. Writing to the cache should be performed on the master cache.
This type of cache is used:

- Many distributed clients
- Accessing the same space
- Mostly Read-access

![LocalCache.png](/attachment_files/LocalCache.png)

The following code demonstrates a client with a local cache. Execute first the RemoteSpace example from above and then the LocalSpaceClient code.

{% highlight java %}
package gs.tutorial.firstgrid.local;

import java.util.UUID;
import gs.tutorial.domain.po.EPurchaseOrderState;
import gs.tutorial.domain.po.EPurchaseOrderType;
import gs.tutorial.domain.po.PurchaseOrder;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;
import org.openspaces.core.space.cache.LocalCacheSpaceConfigurer;

public class LocalSpaceClient {

    // Remote Space
    static String url = "jini://*/*/mySpace";

    public static void main(String[] args) throws InterruptedException {

        UrlSpaceConfigurer urlConfigurer = new UrlSpaceConfigurer(url);

        // Connect to remote space
        GigaSpace remoteSpace = new GigaSpaceConfigurer(urlConfigurer)
                .gigaSpace();

        // Create local space
        GigaSpace localCache = new GigaSpaceConfigurer(
                new LocalCacheSpaceConfigurer(urlConfigurer)).gigaSpace();

        // Create a PO
        PurchaseOrder po = new PurchaseOrder();
        po.setId(UUID.randomUUID());
        po.setOrderState(EPurchaseOrderState.NEW);
        po.setOrderType(EPurchaseOrderType.BLANKET);
        po.setNumber("X233FF");

        // Write the PO to the Space
        remoteSpace.write(po);

        // Read the PO from Space
        PurchaseOrder p = localCache.readById(PurchaseOrder.class, po.getId());
        System.out.println(p);
    }
}
{% endhighlight %}

# Local View

A Local View is a client side cache that maintains a subset of the master space's data, allowing the client to read distributed data without performing any remote calls or data serialization. Data is streamed into the client's local view based on a predefined criteria (a collection of SQLQuery objects) specified by the client when the local view is created. During the local view initialization, data is loaded into the client's memory based on the view criteria. Afterwards, the local view is continuously updated by the master space asynchronously and any operation executed on the master space that affects an entry which matches the view criteria is automatically propagated to the client.

![LocalView.png](/attachment_files/LocalView.png)

The following code demonstrates a local client view. A filter is created for the view that only streams PurchaseOrder instances that have a state attribute of PROCESSED.  When you execute the code you will see at the end that only one entry exists in the local view (we inserted two entries into the master space). Execute first the RemoteSpace example from above and then the ViewSpaceClient code.

{% highlight java %}
package gs.tutorial.firstgrid.local;

import gs.tutorial.domain.po.EPurchaseOrderState;
import gs.tutorial.domain.po.PurchaseOrder;
import java.util.UUID;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;
import org.openspaces.core.space.cache.LocalViewSpaceConfigurer;
import com.j_spaces.core.client.SQLQuery;

public class ViewSpaceClient {

    // Remote Space
    static String url = "jini://*/*/mySpace";

    public static void main(String[] args) throws InterruptedException {

        UrlSpaceConfigurer urlConfigurer = new UrlSpaceConfigurer(url);
        // Connect the Remote Space
        GigaSpace remoteSpace = new GigaSpaceConfigurer(urlConfigurer)
                .gigaSpace();
        // Create the view criteria for the local view
        SQLQuery<PurchaseOrder> sqlQuery = new SQLQuery<PurchaseOrder>(
                PurchaseOrder.class, "orderState = ?");
        sqlQuery.setParameter(1, EPurchaseOrderState.PROCESSED);
        LocalViewSpaceConfigurer localViewConfigurer = new LocalViewSpaceConfigurer(
                urlConfigurer).addViewQuery(sqlQuery);
        // Create local view:
        GigaSpace localView = new GigaSpaceConfigurer(localViewConfigurer)
                .gigaSpace();

        // Create a PO
        PurchaseOrder po = new PurchaseOrder();
        po.setId(UUID.randomUUID());
        po.setOrderState(EPurchaseOrderState.NEW);
        po.setNumber("X233FF");

        // Write the PO to the Space
        remoteSpace.write(po);

        // Create a PO
        PurchaseOrder po1 = new PurchaseOrder();
        po1.setNumber("X233XX");
        po1.setId(UUID.randomUUID());
        po1.setOrderState(EPurchaseOrderState.PROCESSED);

        // Write the PO to the Space
        remoteSpace.write(po1);

        // Let XAP execute the writes
        Thread.sleep(1000);
        // Read by template from the localView
        PurchaseOrder p = new PurchaseOrder();
        PurchaseOrder list[] = localView.readMultiple(p);
        System.out.println(list);
    }
}
{% endhighlight %}

If you launch the XAP UI console you will notice under statistics the communication between remote cache and the local view (Notify sent, ack and reg)
![Stats2.png](/attachment_files/Stats2.png)

# Task Executor

OpenSpaces comes with support for executing tasks in a collocated asynchronous manner with the Space (processing unit that started an embedded Space). Tasks can be executed directly on a specific cluster member using typical routing declarations. Tasks can also be executed in a "broadcast" mode on all the primary cluster members concurrently and reduced to a single result on the client side. Tasks are completely dynamic both in terms of content and class definitions (the task class definition does not have to be defined within the space classpath).
A DistributedTask is a task that ends up executing more than once (concurrently) and returns a result that is a reduced operation of all the different executions. A distributed task is used when executing a task is directed to several nodes based on different routing values, or one that is broadcast to all the primary nodes of the cluster.

Sending the Task to the Space
![Task1.png](/attachment_files/Task1.png)

Collecting the results to be reduced
![Task2.png](/attachment_files/Task2.png)

Here is an example how to implement a distributed task that executes on the space.  In this example, the distributed task will be executed on all the primary spaces of the cluster. All Purchase Orders sum up the cost of each item and returns the total cost. Once all tasks are executed the result is reduced and the total sum of all PO's is returned. Start the RemoteSpace code from above first and then execute the DistributedTaskExecutorClient code.

{% highlight java %}
package gs.tutorial.firstgrid.executor;

import gs.tutorial.domain.po.EPurchaseOrderState;
import gs.tutorial.domain.po.EPurchaseOrderType;
import gs.tutorial.domain.po.LineItem;
import gs.tutorial.domain.po.PurchaseOrder;
import gs.tutorial.firstgrid.executor.task.PODistributedTask;
import java.math.BigDecimal;
import java.util.UUID;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.GigaSpaceConfigurer;
import org.openspaces.core.space.UrlSpaceConfigurer;
import com.gigaspaces.async.AsyncFuture;

public class DistributedTaskExecutorClient {

    // Remote Space
    static String url = "jini://*/*/mySpace";

    public static void main(String[] args) {

        // Connect to the remote space
        GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer(
                url)).gigaSpace();
        try {
            // Create a PO
            PurchaseOrder po = new PurchaseOrder();
            po.setId(UUID.randomUUID());
            po.setOrderState(EPurchaseOrderState.NEW);
            po.setOrderType(EPurchaseOrderType.BLANKET);
            po.setNumber("X23456787890");
            // Add Line Item
            LineItem item = new LineItem();
            item.setCost(new BigDecimal(100.00));
            po.addLineItem(item);

            // Write PO to Space
            gigaSpace.write(po);

            po = new PurchaseOrder();
            po.setId(UUID.randomUUID());
            po.setOrderState(EPurchaseOrderState.PROCESSED);
            po.setOrderType(EPurchaseOrderType.DROPSHIPMENT);
            po.setNumber("X2345");

            LineItem item1 = new LineItem();
            item1.setCost(new BigDecimal(400.00));
            po.addLineItem(item1);
            gigaSpace.write(po);

            // Create Distributed Task
            PODistributedTask task = new PODistributedTask();

            // Execute Task
            AsyncFuture<BigDecimal> future = gigaSpace.execute(task);
            System.out.println(future.get());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
{% endhighlight %}

{% highlight java %}
package gs.tutorial.firstgrid.executor.task;

import gs.tutorial.domain.po.EPurchaseOrderType;
import gs.tutorial.domain.po.LineItem;
import gs.tutorial.domain.po.PurchaseOrder;
import java.math.BigDecimal;
import java.util.List;
import org.openspaces.core.GigaSpace;
import org.openspaces.core.executor.DistributedTask;
import org.openspaces.core.executor.TaskGigaSpace;
import com.gigaspaces.annotation.pojo.SpaceRouting;
import com.gigaspaces.async.AsyncResult;

public class PODistributedTask implements
        DistributedTask<BigDecimal, BigDecimal> {

    private static final long serialVersionUID = 1L;
    @TaskGigaSpace
    private transient GigaSpace gigaSpace;

    @Override
    public BigDecimal execute() throws Exception {

        PurchaseOrder template = new PurchaseOrder();
        BigDecimal sum = BigDecimal.ZERO;

        // Sum up cost of PO Items
        for (PurchaseOrder po : gigaSpace.readMultiple(template)) {
            for (LineItem item : po.getItems()) {
                sum = sum.add(item.getCost());
            }
        }
        return sum;
    }
    @Override
    public BigDecimal reduce(List<AsyncResult<BigDecimal>> results)
            throws Exception {

        BigDecimal sum = BigDecimal.ZERO;
        for (AsyncResult<BigDecimal> result : results) {
            if (result.getException() != null) {
                throw result.getException();
            }
            sum = sum.add(result.getResult());
        }
        return sum;
    }
}
{% endhighlight %}

# Starting a Data Grid Cluster

XAP lets you start a grid node with a Grid Service Agent on every machine you wish to run a data grid node. The agent is responsible for bootstrapping the GigaSpaces cluster environment implicitly, and starting all of the required components. All agents use a peer to peer communication between each other to ensure a successful cluster wide startup of all infrastructure components. Once all agents have started, you can issue simple API calls from within your application to connect to the data grid and interact with it.
The following example shows how to run the GigaSpaces Data Grid with partitions within your application.
In order to run this example:

- Start the data grid with the following command: GS_HOME\bin\gs_agent.bat for unix GS_HOME/bin/gs_agent.sh
- Execute the DeployGridPU code
- Run any of the above remote client samples

When you consult the XAP UI console, you will now see one primary and one backup space.
The XAP Light version is limited to one primary and one backup partition. You can download the XAP Premium Edition (three months trial) from here .... With this version you can increase the number of partitions.

{% highlight java %}
package gs.tutorial.firstgrid.grid;

import java.util.concurrent.TimeUnit;
import org.openspaces.admin.Admin;
import org.openspaces.admin.AdminFactory;
import org.openspaces.admin.gsm.GridServiceManager;
import org.openspaces.admin.pu.ProcessingUnit;
import org.openspaces.admin.space.SpaceDeployment;
import org.openspaces.core.GigaSpace;

public class DeployGridPU {

    public static void main(String[] args) {

        try {
            // create an admin instance to interact with the cluster
            Admin admin = new AdminFactory().createAdmin();
            // locate a grid service manager and deploy a partioned data grid
            // with 1 primary and one backup
            GridServiceManager esm = admin.getGridServiceManagers()
                    .waitForAtLeastOne();
            ProcessingUnit pu = esm.deploy(new SpaceDeployment("mySpace").partitioned(1, 1));
            // Once your data grid has been deployed, wait for 2 instances (1
            // primaries and 1 backups)
            pu.waitFor(2, 30, TimeUnit.SECONDS);
            // and finally, obtain a reference to it
            @SuppressWarnings("unused")
            GigaSpace gigaSpace = pu.waitForSpace().getGigaSpace();

            System.out.println("Deployment done");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
{% endhighlight %}

# Web UI Console

You can also deploy the data grid with the web UI console. (Instead of using the DeployGridPU client from above)

- Start the data grid cluster : `GS_HOME\bin\gs_agent.bat` for `unix GS_HOME/bin/gs_agent.sh`
- Start the UI console : `GS_HOME\bin\gs_webui.bat` for `unix GS_HOME/bin/gs_webui.sh`
- Open a web browser with `http://<yourmachine>:8099` for the XAP UI console (login anonymous)
- Follow the screens below to deploy the data grid.

![Web Ui 4.png](/attachment_files/Web%20Ui%204.png) ![Web UI 3.png](/attachment_files/Web%20UI%203.png) ![Web UI 2.png](/attachment_files/Web%20UI%202.png) ![Web UI 1.png](/attachment_files/Web%20UI%201.png)

# Summary

These simple examples demonstrate the basic concepts of GigaSpaces XAP IMDG capabilities. All above examples execute against any cache; embedded, remote, local and view in a non clustered or clustered deployment scenario. No special code needs to be written to accommodate the various scenarios for accessing the space. Of course, there are many more features and options available for the IMDG which are presented in detail the the Programmers Guide.
