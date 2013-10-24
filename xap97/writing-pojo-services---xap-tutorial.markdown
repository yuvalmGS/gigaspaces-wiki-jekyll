---
layout: xap97
title:  Writing POJO Services - XAP Tutorial
page_id: 61867305
---

{% compositionsetup %}

# Writing POJO Services

{% urhere %}{% sub %}[Overview](#1) - [The Application Workflow](#2) - [Implementation](#3) - [POJO Domain Model](#4) - ![sstar.gif](/attachment_files/sstar.gif) **[Writing POJO Services](#5)** - [Wiring with Spring (PU Configuration)](#6) - [Building and Packaging](#7) - [Deployment](#8) - [What's Next?](#9){% endsub %}{% endurhere %}

Once we're done with the implementation of our domain model, it's time to implement each of the six services described in the above diagram. We will cover each one of them, but first, we want to make the code of the services oblivious to the underlying space so that our code will not be dependent on the GigaSpaces solution.

Solving the dependency issue for the event objects (`OrderEvent`) is easy, as Open Spaces takes care of the polling and notification operations behind the scenes since it's all configured in the `pu.xml` file of the Processing Unit. Doing the same with the `AccountData` objects is not possible as the services have to access those objects according to the application's specific business logic. To solve this, we'll implement a DAO (Data Access Object) that will take care of the space operations.

## AccountDataDAO

{% anchor deck2 %}

{% inittab QSG_OS %}
{% tabcontent Interface %}

{% highlight java %}
package org.openspaces.example.oms.common;

/**
 * accountData data access object interface.
 */
public interface IAccountDataDAO {

	/**
	 * Checks if the accountData object for a given userName is found.
	 * @param userName
	 * @return true if account found, otherwise returns false.
	 */
	boolean isAccountFound(String userName);

	/**
	 * Updates the stored accountData object with the new parameters.
	 * @param accountData - accountData object containing the new parameters to use for updating,
	 * 		accountData.userName attribute is used as the unique accountData identifier.
	 */
	void updateAccountData(AccountData accountData);

	/**
	 * Gets the accountData object matching the userName, blocks until found.
	 * @param userName
	 * @return AccountData
	 */
	AccountData getAccountData(String userName);

	/**
	 * Saves the accountData object.
	 * @param accountData - accountData to be saved.
	 */
	void save(AccountData accountData);
}
{% endhighlight %}

[Choose another tab](#deck2) (back to top)
{% endtabcontent %}
{% tabcontent Implementation %}

{% highlight java %}
package org.openspaces.example.oms.common;

import net.jini.core.lease.Lease;

import org.openspaces.core.GigaSpace;
import org.openspaces.core.context.GigaSpaceContext;
import org.openspaces.example.oms.common.AccountData;

import com.j_spaces.core.client.ReadModifiers;
import com.j_spaces.core.client.UpdateModifiers;

/**
 * A gigapsaces based implementation of the account data access abstraction.
 */
public class AccountDataDAO implements IAccountDataDAO {

	/**
	 *  gigaSpace is injected through the pu.xml using the setter.
	 */
	@GigaSpaceContext(name = "gigaSpace")
	private GigaSpace gigaSpace;

	/**
	 * @param gigaSpace - Sets gigaSpace
	 */
	public void setGigaSpace(GigaSpace gigaSpace) {
		this.gigaSpace = gigaSpace;
	}

	/**
	 * isAccountFound<p>
	 * Checks if account found in space, works even if the account is blocked.
	 *
	 * @param userName
	 * @return true if account with the following userName is found in the space, otherwise returns false.
	 */
	public boolean isAccountFound(String userName) {
		AccountData accountDataTemplate = new AccountData();
		accountDataTemplate.setUserName(userName);
		// read the accountData with dirty read making to read even blocked accounts.
		AccountData accountData = gigaSpace.read(accountDataTemplate, 0/* nowait */, ReadModifiers.DIRTY_READ);
		if (accountData != null)
			return true;
		else
			return false;
	}

	/**
	 * Reads the accountData with exclusive read, making it invisible to other
	 * processor threads, Blocks until found.
	 *
	 * @param userName - user name of the account.
	 * @return accountData - the accountData read.
	 */
	public AccountData getAccountData(String userName) {
		AccountData accountDataTemplate = new AccountData();
		accountDataTemplate.setUserName(userName);
		// read the accountData with exclusive read making it invisible to other
		// processor threads, block until found
		AccountData accountData = gigaSpace.read(accountDataTemplate, Long.MAX_VALUE,
			ReadModifiers.EXCLUSIVE_READ_LOCK);
		return accountData;
	}

	/**
	 * Updates the accountData object according to its userName unique
	 * attribute. Blocks until updates.
	 */
	public void updateAccountData(AccountData accountData) {
		// Writes the account data to the space, using <code>Long.MAX_VALUE_VALUE</code>
		// as the update timeout (which basically means forever).
		gigaSpace.write(accountData, Lease.FOREVER, Long.MAX_VALUE, UpdateModifiers.UPDATE_ONLY);
	}

	/**
	 * Writes the accountData object to the space.
	 *
	 * @param accountData - accountData to be written.
	 */
	public void save(AccountData accountData) {
		gigaSpace.write(accountData);
	}
}
{% endhighlight %}

[Choose another tab](#deck2) (back to top)
{% endtabcontent %}
{% endinittab %}

Let's move on to the services, each described in its own tab below:
{% anchor deck3 %}

{% inittab QSG_OS %}
{% tabcontent Account Preloader %}

## Account Preloader -- Feeder Processing Unit

The preloader simply loads 100 accounts into the space. You should note two things in the code below. First, it implements `InitializingBean`, which means its `afterPropertiesSet` method is called when the service is loaded for the first time. The second thing to note is the use of the DAO that we implemented earlier in order to write the 100 accounts. The DAO is not initialized in the class, instead it's injected by the container (the Processing Unit).

{% highlight java %}
package org.openspaces.example.oms.feeder;

import org.openspaces.example.oms.common.AccountData;
import org.openspaces.example.oms.common.IAccountDataDAO;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.util.Assert;

/**
 * A loader bean that writes AccountData objects with unique userNames to the
 * space. Since the write is executed directly in the afterPropertiesSet method
 * (and not in a new thread), the processing unit waits until the loading is
 * finished before initializing the next bean.
 */
public class AccountDataLoader implements InitializingBean {

	/**
	 * Number of accounts to be loaded by the loader, hardcoded to 100, can be overridden
	 * in the pu.xml (by setting the prop key "numberOfAccounts")
	 */
	private int numberOfAccounts = 100;

	/**
	 * DAO object used to access the AccountData objects implicitly. Will be
	 * injected from the pu.xml. Interface enables different DAO
	 * Implementations.
	 */
	private IAccountDataDAO accountDataDAO;

	/**
	 * Sets the DAO object used to access the accountData objects.
	 * @param accountDataDAO<p>
	 * <code>@Required</code> annotation provides the 'blow up if this
	 * required property has not been set' logic.
	 */
	@Required
	public void setAccountDataDAO(IAccountDataDAO accountDataDAO) {
		this.accountDataDAO = accountDataDAO;
	}

	/**
	 * Allows to control the number of accounts that will be initally
	 * loaded to the Space. Defaults to <code>100</code>.
	 */
	public void setNumberOfAccounts(int numberOfAccounts) {
		this.numberOfAccounts = numberOfAccounts;
	}

	/**
	 * The first method run upon bean Initialization when implementing InitializingBean.
	 * Writes <numberOfAccounts> AccountData through the accountDataDAO.
	 */
	public void afterPropertiesSet() throws Exception {
		// Checks and outputs if accountDataDAO is null.
		Assert.notNull(accountDataDAO, "accountDao is required property");
		System.out.println("---[Start writing AccountData objects]---");
		// Writing <numberOfAccounts> accountData objects to the space.
		AccountData accountData = new AccountData();
		for (int i = 1; i <= numberOfAccounts; i++) {
			accountData.setUserName("USER" + i);
			accountData.setBalance(1000);
			// Saving the accountData
			accountDataDAO.save(accountData);
		}

		System.out.println("---[Wrote " + numberOfAccounts + " AccountData objects]---");
	}
}
{% endhighlight %}

[Choose another tab](#deck3) (back to top)
{% endtabcontent %}
{% tabcontent Event Feeder %}

## Event Feeder -- Feeder Processing Unit

The Feeder writes `OrderEvents` to the space that trigger the process of the application. The service implements the `InitializingBean` interface, which means the `afterPropertiesSet` method is called when the service is loaded. Additionaly, it implements `DisposableBean`, which invokes the `destroy` method when the service is stopped.

The objects are written directly to the space (as defined in the `OrderEventFeederTask` inner class). The reference to the space proxy is received through injection from the Processing Unit by using the **`@GigaSpaceContext(name = "gigaSpace")`** annotation before the declaration of the `GigaSpace` member. This annotation marks the injection of a GigaSpace object that is defined with a certain name (e.g. `gigaSpace`) within the `pu.xml` file.

{% highlight java %}
package org.openspaces.example.oms.feeder;

import org.openspaces.core.GigaSpace;
import org.openspaces.core.context.GigaSpaceContext;
import org.openspaces.example.oms.common.OrderEvent;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;

import java.util.Random;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/**
 * A feeder bean that starts a scheduled task that writes a new OrderEvent object to the space.
 *
 * <p>The space is injected into this bean using OpenSpaces support for @GigaSpaceContext
 * annoation.
 *
 * <p>The scheduled support uses the java.util.concurrent Scheduled Executor Service. It
 * is started and stopped based on Spring lifeceycle events.
 */
public class OrderEventFeeder implements InitializingBean, DisposableBean {

	private Random randomGen = new Random();

    private ScheduledExecutorService executorService;

    //	Delayed result bearing action
    private ScheduledFuture<?> sf;

    /**
     * Delay between scheduled tasks
     */
    private long defaultDelay = 1000;

	/**
	 * Number of accounts loaded by the loader, injected from the pu.xml to calculate
	 * the number of non-matching (without matching accounts) orderEvents to feed.
	 */
    private Integer numberOfAccounts;

    /**
     * Percent of AccountData objects to be rejected due to missing account.
     * This is used artificially in this example to create orderEvents that
     * will not have any matching account.
     */
    private Integer dropOffPercent=20;

    /**
     * This number is used to create dropOffPercent rejected orderEvents
     */
    private Integer numberOfAccountsPlusAccountsToDrop;

    /**
     * The scheduled orderEvent feeding task.
     */
    private OrderEventFeederTask orderEventFeederTask;

    @GigaSpaceContext(name = "gigaSpace")
    private GigaSpace gigaSpace;

    /**
     * @param defaultDelay - Sets default delay between feeding tasks.
     */
    public void setDefaultDelay(long defaultDelay) {
        this.defaultDelay = defaultDelay;
    }

    /**
     * @param numberOfAccounts - Sets number of accounts preloaded by the loader.
     */
    public void setNumberOfAccounts(Integer numberOfAccounts) {
		this.numberOfAccounts = numberOfAccounts;
	}

	/**
	 * The first method run upon bean Initialization when implementing InitializingBean.
	 * Starts a scheduled orderEvent feeding task.
	 */
	public void afterPropertiesSet() throws Exception {
        numberOfAccountsPlusAccountsToDrop = (100*numberOfAccounts)/(100-dropOffPercent);
    	System.out.println("---[Starting feeder with cycle <" + defaultDelay + "> ]---");
        //	Create a thread pool containing 1 thread capable of performing scheduled tasks
        executorService = Executors.newScheduledThreadPool(1);
        orderEventFeederTask = new OrderEventFeederTask();
        //	Schedule the thread to execute the task at fixed rate with the default delay defined
        sf = executorService.scheduleAtFixedRate(orderEventFeederTask, /* initialDelay */defaultDelay, defaultDelay,
                TimeUnit.MILLISECONDS);
    }

    public void destroy() throws Exception {
    	//	Shuting down the thread pool upon bean disposal
    	sf.cancel(true);
        sf = null;
        executorService.shutdown();
    }

    public class OrderEventFeederTask implements Runnable {

        private int counter;

        public void run() {
            try {
            	//	Create a new orderEvent with randomized userName , price and
            	//	operation divided between buy and sell values.
            	OrderEvent orderEvent = new OrderEvent
                	("USER" +randomGen.nextInt(numberOfAccountsPlusAccountsToDrop+1), 100/*price*/,
                	 OrderEvent.OPERATIONS[counter++ % OrderEvent.OPERATIONS.length]);
                gigaSpace.write(orderEvent);
                System.out.println("---[Wrote orderEvent: "+orderEvent+" ]---");
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }

        public int getCounter() {
            return counter;
        }
    }

    public int getFeedCount() {
        return orderEventFeederTask.getCounter();
    }
}
{% endhighlight %}

[Choose another tab](#deck3) (back to top)
{% endtabcontent %}
{% tabcontent Event Validator %}

## Event Validator -- Runtime Processing Unit

The `OrderEventValidator` takes `OrderEvents` with status `New` from the space, and checks if there's an account with a matching username. When you follow the code, you'll see there is no indication to the type of `OrderEvents` the validator is handling. All this logic is defined in the `pu.xml`, as well as the type of operation the validator performs on the space (by default a take operation of a single object that matches the defined template) and at which interval.

The service implementation does not need to implement any specific interface or to have any special code. The only thing necessary is the use of the *`@SpaceDataEvent`* annotation that marks the method that handles the event (in this case the event is a take of an `OrderEvent` from the space). Note that the same event-handling method (`validatesOrderEvent` in our case) has a return value. That returned object is written back to the space by the container. Again, we are using the DAO object to access the accounts within the space without writing any specific GigaSpaces code.

As you can see, the implementation has no use of propietary code. The `OrderEvents` are received and written to the space automatically by the container. Accessing the accounts is done through the DAO, so there is no code that gives any indication to the use of GigaSpaces as the underlying layer for data and messaging.

{% highlight java %}
package org.openspaces.example.oms.runtime;

import org.openspaces.events.adapter.SpaceDataEvent;
import org.openspaces.example.oms.common.IAccountDataDAO;
import org.openspaces.example.oms.common.OrderEvent;
import org.springframework.beans.factory.annotation.Required;

public class OrderEventValidator {

    private long workDuration = 100;

    /**
     *	DAO object used to access the AccountData objects implicitly.
     *	Will be injected from the pu.xml.
     *	Interface enables different DAO Implementations.
     */
    private IAccountDataDAO accountDataDAO;

    @Required
    public void setAccountDataDAO(IAccountDataDAO accountDataDAO) {
		this.accountDataDAO = accountDataDAO;
	}

	/**
     * Sets the simulated work duration (in milliseconds). Default to 100.
     */
    public void setWorkDuration(long workDuration) {
        this.workDuration = workDuration;
    }

    /**
     * Validate the given OrderEvent object and returning the validated OrderEvent.
     *
     * Can be invoked using OpenSpaces Events when a matching event
     * occurs or using OpenSpaces Remoting.
     */
    @SpaceDataEvent	//	This annotation marks the method as the event listener.
    public OrderEvent validatesOrderEvent(OrderEvent orderEvent) {

    	// sleep to simluate some work
        try {
            Thread.sleep(workDuration);
        } catch (InterruptedException e) {
            // do nothing
        }

        System.out.println("---[Validator: Validating orderEvent:"+orderEvent+" ]---");

        //	Getting the AccountData object matching the orderEvent userName through the DAO
        boolean isAccountFound = accountDataDAO.isAccountFound(orderEvent.getUserName());
        if (isAccountFound == true){
        	//	Matching accountData found - changing orderEvent status to pending.
        	orderEvent.setStatus("Pending");
        	System.out.println("---[Validator: OrderEvent approved, status set to PENDING]---");
        }
        else {
        	//	No matching accountData found - changing orderEvent status to account not found.
        	orderEvent.setStatus("AccountNotFound");
        	System.out.println("---[Validator: OrderEvent rejected, ACCOUNT NOT FOUND]---");
        }

        //  orderID is declared as primary key and as auto-generated.
    	//	It must be null before writing an operation.
    	orderEvent.setOrderID(null);

        return orderEvent;
    }

    /**
     * Prints out the OrderEvent object passed as a parameter. Usually invoked
     * when using OpenSpaces remoting.
     */
    public void sayData(OrderEvent orderEvent) {
        System.out.println("+++[Saying: "+orderEvent+"]+++");
    }
}
{% endhighlight %}

[Choose another tab](#deck3) (back to top)
{% endtabcontent %}
{% tabcontent Event Processor %}

## Event Processor -- Runtime Processing Unit

Very similiar to how we implemented the `OrderEventValidator`, the `OrderEventProcessor` has a method that is annotated with **`@SpaceDataEvent`** to mark it as the handler of events. Again, the events are taken as `OrderEvents` from the space, this time only orders with status `Pending` that were validated by the `Validator`.

With the help of the container that routes the events and the DAO to access the accounts, there is no reference to GigaSpaces' proprietary code.

{% highlight java %}
package org.openspaces.example.oms.runtime;

import org.openspaces.events.adapter.SpaceDataEvent;
import org.openspaces.example.oms.common.AccountData;
import org.openspaces.example.oms.common.IAccountDataDAO;
import org.openspaces.example.oms.common.OrderEvent;

/**
 * An implementation of IOrderEventProcessor. Can set the simulated work done when
 * processOrderEvent is called by setting the work duration (defaults to 100 ms).
 *
 * <p>This implementaiton is used to demonstrate OpenSpaces Events, using simple Spring configuration to cause
 * processOrderEvent to be invoked when a matching event occurs. The processor uses
 * OpenSpaces support for annotation markup allowing to use @SpaceDataEvent to
 * mark a method as an event listener. Note, processOrderEvent does not use any space
 * API on the OrderEvent object (though it can), receiving the OrderEvent object to be processed
 * and returning the result that will be automatically written back to the space.
 *
 * <p>Note, changing the event container is just a matter of configuration (for example,
 * switching from polling container to notify container) and does not affect this class.
 *
 * <p>Also note, the deployment model or the Space topology does not affect this orderEvent processor
 * as well. The data processor can run on a remote space, embedded within a space, and using
 * any Space cluster topology (partitioned, replicated, primary/backup). It is all just a
 * matter of configuraion.
 *
 */
public class OrderEventProcessor {

    private long workDuration = 100;

    /**
     *	DAO object used to access the AccountData objects implicitly.
     *	Will be injected from the pu.xml.
     *	Interface enables different DAO Implementations.
     */
    private IAccountDataDAO accountDataDAO;

    public void setAccountDataDAO(IAccountDataDAO accountDataDAO) {
		this.accountDataDAO = accountDataDAO;
	}

    /** Sets the simulated work duration (in milliseconds). Defaut to 100. */
    public void setWorkDuration(long workDuration) {
        this.workDuration = workDuration;
    }

    /**  Process the given OrderEvent object and returning the processed OrderEvent.
         Can be invoked using OpenSpaces Events when a matching event
         occurs or using OpenSpaces Remoting. */
    @SpaceDataEvent
    public OrderEvent processOrderEvent(OrderEvent orderEvent) {
        // sleep to simluate some work
        try {
            Thread.sleep(workDuration);
        } catch (InterruptedException e) {
            // do nothing
        }
        System.out.println("---[Processor: Processing orderEvent:"+orderEvent+" ]---");

        //	read the accountData with exclusive read making it invisible to other processor threads, block until found
        AccountData accountData = accountDataDAO.getAccountData(orderEvent.getUserName());

        if (accountData != null) {
        	System.out.println("---[Processor: Found accountData matching the orderEvent: "+accountData+ "]---");

        	if (orderEvent.getOperation() == OrderEvent.BUY_OPERATION) {
        		//	orderEvent operation is buy

        		if (accountData.getBalance() >= orderEvent.getPrice()){
        			//	balance is enough to buy
        			accountData.setBalance(accountData.getBalance()-orderEvent.getPrice());
        			orderEvent.setStatus("Processed");
        			System.out.println("---[Processor: OrderEvent PROCESSED successfully!]---");
        			//	update the accountData object with the new balance
        			accountDataDAO.updateAccountData(accountData);
        		}
        		else {
        			//	balance insufficient
        			orderEvent.setStatus("InsufficientFunds");
        			System.out.println("---[Processor: OrderEvent rejected due to INSUFFICIENT FUNDS]---");
        		}
        	}
        	else {
        		//	orderEvent operation is sell
        		accountData.setBalance(accountData.getBalance()+orderEvent.getPrice());
        		orderEvent.setStatus("Processed");
        		System.out.println("---[Processor: OrderEvent PROCESSED successfully!]---");
        		//	update the accountData object with the new balance
        		accountDataDAO.updateAccountData(accountData);
        	}
        }

        //  orderID is declared as primary key and as auto-generated.
    	//	It must be null before writing an operation.
    	orderEvent.setOrderID(null);

    	return orderEvent;
    }

    /** Prints out the OrderEvent object passed as a parameter. Usually invoked
        when using OpenSpaces remoting. */
    public void sayData(OrderEvent orderEvent) {
        System.out.println("+++[Saying: "+orderEvent);
    }
}
{% endhighlight %}

[Choose another tab](#deck3) (back to top)
{% endtabcontent %}
{% tabcontent Account Counter %}

## Account Counter -- Statistics Processing Unit

The `@SpaceDataEvent` annotation marks the `outputInfo(AccountData accountData)` method to receive events and increment a counter. Note that as opposed to the `Validator` and `Processor`, the method here does not return any value, which means that nothing is written to the space when the method exits.

{% highlight java %}
package org.openspaces.example.oms.stats;

import org.openspaces.events.adapter.SpaceDataEvent;
import org.openspaces.example.oms.common.AccountData;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * A simple bean outputting the accountData updated balance.
 *
 */
public class OutputAccountData {

    private AtomicInteger accountDataUpdatedCounter = new AtomicInteger(0);

    @SpaceDataEvent	//	Indicates that this method should be invoked upon notification.
    public void outputInfo(AccountData accountData) {
        accountDataUpdatedCounter.incrementAndGet();
        System.out.println("---{ AccountData balance for ["+accountData.getUserName()+"] was updated to ["
                           +accountData.getBalance()+"] ,Total account updates [" + accountDataUpdatedCounter + "] }---");
    }

    public int getAccountDataUpdatedCount() {
        return accountDataUpdatedCounter.intValue();
    }
}
{% endhighlight %}

[Choose another tab](#deck3) (back to top)
{% endtabcontent %}
{% tabcontent Event Counter %}

## Event Counter -- Statistics Processing Unit

This service receives notifications about `OrderEvents` that are written to the space with different states. Since it implements the `InitializingBean` interface, when the service is loaded, the `afterPropertiesSet()` method is called and several count operations are performed on the space (each for an `OrderEvent` with a different state). After this initialization, the counters are updated on each event that is received by the service.

Later we'll show how these counters are used as monitors that are displayed in the GigaSpaces Management Center.

{% highlight java %}
package org.openspaces.example.oms.stats;

import org.openspaces.core.GigaSpace;
import org.openspaces.core.context.GigaSpaceContext;
import org.openspaces.events.adapter.SpaceDataEvent;
import org.openspaces.example.oms.common.OrderEvent;
import org.springframework.beans.factory.InitializingBean;

import java.util.concurrent.atomic.AtomicInteger;

/**
 * A simple bean counting the number of orderEvent writes , processes and rejection due to
 * account not found.
 * Holds a 3 simple counters that are incremented each time a matching event occurs.
 * Outputting the orderEvent updated status.
 *
 * <p>Also note, the orderEvent that will be counted depends on the
 * configuration. For example, this example uses the "non clustered" view
 * of the space while running within an embedded space. This means this
 * coutner will count only the relevant partition processed data. It is
 * just a matter of configuration to count the number of processed data
 * across a cluster.
 *
 */
public class OutputOrderEventCounter implements InitializingBean {

	private AtomicInteger orderEventWrittenCounter = new AtomicInteger(0);
    private AtomicInteger orderEventProcessedCounter = new AtomicInteger(0);
    private AtomicInteger orderEventAccountNotFoundCounter = new AtomicInteger(0);

    @GigaSpaceContext(name = "gigaSpace")
    private GigaSpace gigaSpace;

    public void afterPropertiesSet() throws Exception {
		//	Upon bean instantiating counts how many New, Processed and AccountNotFound
    	//	are in the space and setting the relevant counters.
    	OrderEvent orderEvent = new OrderEvent();
    	orderEvent.setStatus("New");
    	int counter = gigaSpace.count(orderEvent);
    	orderEventWrittenCounter = new AtomicInteger(counter);
    	orderEvent.setStatus("Processed");
    	counter = gigaSpace.count(orderEvent);
    	orderEventProcessedCounter = new AtomicInteger(counter);

    	orderEvent.setStatus("AccountNotFound");
    	counter = gigaSpace.count(orderEvent);
    	orderEventAccountNotFoundCounter = new AtomicInteger(counter);
	}

    @SpaceDataEvent
    public void outputInfo(OrderEvent orderEvent) {
        System.out.println("---{ OrderEvent ["+orderEvent.getStatus()+
        					"], Total operations on orderEvents [" + orderEventWrittenCounter + "] }---");
        if (orderEvent.getStatus().equals("New")){
        	orderEventWrittenCounter.incrementAndGet();
        }
        else {
        	if (orderEvent.getStatus().equals("Processed")){
            	orderEventProcessedCounter.incrementAndGet();
        	}
        	else {
            	if (orderEvent.getStatus().equals("AccountNotFound")){
                	orderEventAccountNotFoundCounter.incrementAndGet();
            	}
        	}
        }
    }

    public int getOrderEventWrittenCounter() {
        return orderEventWrittenCounter.intValue();
    }

    public int getOrderEventProcessedCounter() {
        return orderEventProcessedCounter.intValue();
    }

    public int getOrderEventAccountNotFoundCounter() {
        return orderEventAccountNotFoundCounter.intValue();
    }
}
{% endhighlight %}

[Choose another tab](#deck3) (back to top)
{% endtabcontent %}
{% endinittab %}

