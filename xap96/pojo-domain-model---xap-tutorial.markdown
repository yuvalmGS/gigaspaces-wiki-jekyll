---
layout: xap96
title:  POJO Domain Model - XAP Tutorial
page_id: 61867090
---

{% compositionsetup %}

# POJO Domain Model

{% urhere %}{% sub %}[Overview](#1) - [The Application Workflow](#2) - [Implementation](#3) - ![sstar.gif](/attachment_files/sstar.gif) **[POJO Domain Model](#4)** - [Writing POJO Services](#5) - [Wiring with Spring (PU Configuration)](#6) - [Building and Packaging](#7) - [Deployment](#8) - [What's Next?](#9){% endsub %}{% endurhere %}

Because our domain model is used throughout the entire application by the different Processing Units, we should define it in a generic place, so we can then include it in each of the PUs.
{% anchor deck1 %}

{% inittab QSG_OS %}
{% tabcontent OrderEvent %}
An `OrderEvent` has an ID, username, price and operation (buy or sell):

{% highlight java %}
package org.openspaces.example.oms.common;

import com.gigaspaces.annotation.pojo.SpaceClass;
import com.gigaspaces.annotation.pojo.SpaceId;
import com.gigaspaces.annotation.pojo.SpaceRouting;

/**
 * OrderEvent object important properties include the orderID
 * of the object, userName (also used to perform routing when working with partitioned space),
 * price ,operation , and a status indicating if this OrderEvent object
 * was processed, or rejected for a reason.
 * <p>
 * <code>@SpaceClass</code> annotation in this example is only to indicate that this class is a space class.
 */
@SpaceClass
public class OrderEvent {

	public static final String STATUS_NEW = "New";
	public static final String STATUS_PENDING = "Pending";
	public static final String STATUS_PROCESSED = "Processed";
	public static final String STATUS_INSUFFICIENT_FUNDS = "InsufficientFunds";
	public static final String STATUS_ACCOUNT_NOT_FOUND = "AccountNotFound";

	public static final int BUY_OPERATION = 1;
	public static final int SELL_OPERATION = 2;

	/**
	 * Static values representing the differnet values the operation property can have.
	 * */
    public static short[] OPERATIONS = {BUY_OPERATION, SELL_OPERATION};

    /**
     * Indicates if this is a buy or sell order.
     */
    private Short operation;

    /**
     * ID of the order.
     */
    private String orderID;

    /**
     * User name of the order.
     */
    private String userName;

    /**
     * Price of order.
     */
    private Integer price;

    /**
     * 	Possible values: New, Pending, Processed, InsufficientFunds, AccountNotFound
     * */
    private String status;

    /**
     * Constructs a new OrderEvent object.
     * */
    public OrderEvent() {
    }

    /**
     * Constructs a new OrderEvent object with the given userName, price
     * and operation.
     * @param userName
     * @param price
     * @param operation - Sell or buy operation.
     */
    public OrderEvent(String userName, Integer price, short operation) {
        this.userName = userName;
    	this.price = price;
        this.operation = operation;
        this.status = STATUS_NEW;
    }

    /**
     * Gets the ID of the orderEvent.<p>
     * <code>@SpaceID</code> annotation indicates that its value will be auto generated
     * when it is written to the space.
     */
    @SpaceId(autoGenerate = true)
    public String getOrderID() {
        return orderID;
    }

    /**
     * Sets the ID of the orderEvent.
     * @param account
     */
    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    /**
     * @return userName - Gets the user name of the orderEvent object.<p>
     * Used as the routing field when working with a partitioned space.
     */
    @SpaceRouting
    public String getUserName() {
        return userName;
    }

    /**
     * @param userName - set the user name of the orderEvent object.
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * Outputs the orderEvent object attributes.
     */
    public String toString() {
        return "userName[" + userName + "] operation[" + operation + "] price[" + price + "] status[" + status + "]";
    }

	/**
	 * @return the orderEvent operation (buy or sell).
	 */
	public Short getOperation() {
		return operation;
	}

	/**
	 * @param operation - Sets the orderEvent operation ("Buy" or "Sell")
	 */
	public void setOperation(Short operation) {
		this.operation = operation;
	}

	/**
	 * @return price - Gets the orderEvent price.
	 */
	public Integer getPrice() {
		return price;
	}

	/**
	 * @param price - Sets the orderEvent price.
	 * */
	public void setPrice(Integer price) {
		this.price = price;
	}

	/**
	 * @return status - the orderEvent status.
	 */
	public String getStatus() {
		return status;
	}

	/**
	 *  @param status - Sets the orderEvent status.
	 */
	public void setStatus(String status) {
		this.status = status;
	}
}
{% endhighlight %}

[Choose another tab](#deck1) (back to top)
{% endtabcontent %}
{% tabcontent AccountData %}
The `AccountData` objects represent the user accounts that are preloaded to the cache, and later referenced by the different services.

{% highlight java %}
package org.openspaces.example.oms.common;

import com.gigaspaces.annotation.pojo.SpaceClass;
import com.gigaspaces.annotation.pojo.SpaceId;
import com.gigaspaces.annotation.pojo.SpaceRouting;

/**
 * AccountData represents an account data object that is preloaded to the runtime processing
 * unit's embedded space by the feeder processing unit's AccountDataLoader bean.
 * In this example the account data objects consist the in-memory data grid, and are used by
 * runtime processing unit's OrderEventValidator bean to validate the OrderEvents.
 * The account data object's balance is updated by the runtime processing unit's OrderEventProcessor
 * bean to reflect buy/sell operations.
 * <p>
 * Properties include the account's userName(used as the Account unique ID, also used as a routing
 * index to perform routing when working with partitioned space) and the balance.
 * <p>
 * <code>@SpaceClass</code> annotation in this example is only to Illustrate that this class is a space class.
 */
@SpaceClass
public class AccountData {

	/**
	 * User name for the Account (Serves also as the account unique ID, and routing index).
	 */
	private String userName;

	/**
	 * Balance for the Account.
	 */
	private Integer balance;

	/**
	 * AccountData no-args constructor.
	 */
	public AccountData() {
	}

	/**
	 * AccountData constructor.
	 * @param userName
	 * @param balance
	 */
	public AccountData(String userName, Integer balance) {
		this.userName = userName;
		this.balance = balance;
	}

	/**
	 * @return the balance of the account.
	 */
	public Integer getBalance() {
		return balance;
	}

	/**
	 * @param balance - Sets the balance for the account.
	 */
	public void setBalance(Integer balance) {
		this.balance = balance;
	}

	/**
	 * @return the user name of the account.
	 * <p>
	 * <code>SpaceId</code> controls the unique identity of the account within
	 * the Space.
	 * <p>
	 * <code>SpaceRouting</code> annotation controls which partition this
	 * account will be written to when using a partitioned Space (using hash
	 * based routing).
	 */
	@SpaceId
	@SpaceRouting
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName - Sets the user name for the account.
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * Outputs the account properties (userName, balance).
	 */
	public String toString() {
		return "userName[" + userName + "] balance[" + balance + "]";
	}

}
{% endhighlight %}

[Choose another tab](#deck1) (back to top)
{% endtabcontent %}
{% endinittab %}

As you can see, the code is pretty straight forward, what's interesting though, are the annotations used in it:

- **`@SpaceClass`** -- marks this class as an Entry that will be written to a space (and then probably read or taken from the space).
- **`@SpaceId(autoGenerate = true)`** -- marks the following method as the generator of the unique key for that object type. In this case, the `orderID` attribute is unique per instance and is automatically generated by the container.
- **`@SpaceRouting`** -- marks the attribute according to which routing to the correct space partitions will be done. This is only relevant when we deploy a cluster of spaces in partitioned mode, and objects written to the cluster need to be routed in a certain manner.
