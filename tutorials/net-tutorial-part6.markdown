---
layout: post
title:  Space Transactions
categories: TUTORIALS
weight: 600
parent: net-home.html
---



{%summary%}This part of the tutorial will introduce you to transactions.{%endsummary%}

# Overview
{%section%}
{%column width=70% %}

In this part of the tutorial we will introduce you to the transaction processing capabilities of XAP.
{%endcolumn%}
{%column width=20% %}
<img src="/attachment_files/qsg/transaction.png" width="100" height="100">

{%endcolumn%}
{%endsection%}

# Transaction Management
XAP provides several transaction managers, and changing the implementation you work with is just a matter of changing the configuration. In this part of the tutorial will use XAP's Distributed Transaction Manager to demonstrate some of the features and capabilities.



{%highlight csharp%}
public void readWithTransaction()
{
	ITransactionManager mgr = GigaSpacesFactory.CreateDistributedTransactionManager ();

	// Create a transaction using the transaction manager:
	using (ITransaction txn = mgr.Create ()) {
		try {
			// ...
			SqlQuery<User> query = new SqlQuery<User> ("contacts.home = '770-123-5555'");
			User user = proxy.Read<User> (query, txn, 0, ReadModifiers.RepeatableRead);
			// ....
			txn.Commit ();
		} catch (Exception e) {
			// rollback the transaction
			txn.Abort ();
		}
	}
}
{%endhighlight%}

{%comment%}
Here is an example how you define a distributed transaction manager via the Spring configuration:
{%highlight xml%}
<!-- A bean representing a space (an IJSpace implementation) -->
<os-core:space id="space" url="/./xapTutorialSpace" />

<!-- Defines a distributed transaction manager. -->
<os-core:distributed-tx-manager id="transactionManager" />

<!-- Define the GigaSpace instance that the application will use to access the space -->
<os-core:giga-space id="xapTutorialSpace" space="space" tx-manager="transactionManager" />

<!-- enable the configuration of transactional behavior based on annotations -->
<tx:annotation-driven transaction-manager="transactionManager" />
{%endhighlight%}

{%note%}In order to make the XAP Interface transactional, the transaction manager must be provided to it when constructing the GigaSpace bean. You also need to add <tx:annotation-driven transaction-manager="transactionManager" />  to enable the configuration of transactional behavior based on annotations.{%endnote%}

### Transaction Demarcation
In your Java code you can annotate your class or methods with the Spring `@Transactional` annotation and configure Spring to process the annotation such that every call to the annotated methods will be automatically performed under a transaction. The transaction starts before the method is called and commits when the method call returns. If an exception is thrown from the method the transaction is rolled back automatically. Note that you can control various aspects of the transaction like propagation by using the attributes of the `@Transactional` annotation.

Here is an example how to use the transactions in your code:
{%highlight java%}
@Transactional
public void createPayment() {
	Payment payment = new Payment();
	payment.setCreatedDate(new Date(System.currentTimeMillis()));
	payment.setPayingAccountId(new Integer(1));
	payment.setStatus(ETransactionStatus.PROCESSED);

	space.write(payment);
}
{%endhighlight%}
If an exception is thrown in this example, the object that was written into the space will be rolled back.

### Transaction propagation
Normally all code executed within a transaction runs in the same transaction scope. However, there are several options specifying behavior if a transactional method is executed when a transaction context already exists. For example, simply running in the existing transaction (the most common case); or suspending the existing transaction and creating a new transaction.

Here is the example how you can define a new transaction to be started for a method:
{%highlight java%}
@Transactional(propagation = Propagation.REQUIRES_NEW)
public void createNewPayment() {
	Payment payment = new Payment();
	payment.setCreatedDate(new Date(System.currentTimeMillis()));
	payment.setPayingAccountId(new Integer(1));
	payment.setStatus(ETransactionStatus.PROCESSED);

	space.write(payment);
}
{%endhighlight%}
{%learn%}{%latestneturl%}/transaction-management.html{%endlearn%}

{%endcomment%}


# Event Processing
All event containers support transactions.

### Polling container
Both the receive operation and the actual event action can be configured to be performed under a transaction. Transaction support is required when, for example, an exception occurs in the event listener, and the receive operation needs to be rolled back (and the actual data event is returned to the space). Adding transaction support is very simple in the polling container, and can be done by injecting a transaction manager into it. Let's take our payment polling container and make it transactional.

You make a polling container transactional by adding the `[TransactionalEvent]` annotation:
{%highlight csharp%}
using System;

using GigaSpaces.Core.Events;
using GigaSpaces.XAP.Events.Polling;
using GigaSpaces.XAP.Events;

using xaptutorial.model;

[PollingEventDriven]
[TransactionalEvent]
public class AuditListener {

	[EventTemplate]
	Payment unprocessedData() {
		Payment template = new Payment();
		template.setStatus(ETransactionStatus.AUDITED);
		return template;
	}

	[DataEventHandler]
	public Payment eventListener(Payment e) {
		// process Payment
		Console.WriteLine("Polling Received a payment:");
		return null;
	}
}
{%endhighlight%}

{%learn%}{%latestneturl%}/polling-container.html{%endlearn%}


### Notify Container
Just like the Polling container, both the receive operation and the actual event action can be configured to be performed under a transaction. However, in case an error occurs (rollback), the notification is lost and not sent again.

{%learn%}{%latestneturl%}/notify-container.html{%endlearn%}


# Task Execution
Executors fully support transactions similar to other XAP operations. Once an execute operation is executed within a declarative transaction, it will automatically join it. The transaction itself is then passed to the node the task executed on and added declaratively to it. This means that any XAP operation performed within the task execute operation will automatically join the transaction started on the client side.
{%learn%}{%latestneturl%}/task-execution-over-the-space.html{%endlearn%}



# Remoting Service
Executor remoting supports transactional execution of services. On the client side, if there is an ongoing declarative transaction during the service invocation (a Space based transaction), the service will be executed under the same transaction. The transaction itself is passed to the server and any Space related operations (performed using XAP) will be executed under the same transaction.
{%learn%}{%latestneturl%}/space-based-remoting.html{%endlearn%}




# Concurrency
Locking of objects occurs in multi-user systems to preserve the integrity of changes, so that changes made by one process do not accidentally overwrite changes made by another process. XAP provides two strategies for locking objects: Optimistic and pessimistic. The focus is on optimistic locking, the preferred strategy in the XAP context.

### Optimistic Locking
With optimistic locking, you write your business logic allowing multiple users to read the same object at the same time, but allow only one user to update the object successfully. The assumption is that there will be a relatively large number of users trying to read the same object, but a low probability of having a small number of users trying to update the same object at the same time. In the case of multiple users trying to update the same object at the same time, the one(s) that try to update a non-recent object version fail.

XAP uses a version number for an object to accomplish optimistic locking. When a client makes updates to an object an additional where clause is added to the update operation where the client version number of the object is compared against the version number of the object in space. If the the version number is not the same, the operation is rejected, indicating that the object has been modified by some other client or process.

Here is an example of how optimistic locking is enabled in XAP. First we need to indicate to the space that it will hold versioned objects.

{%highlight csharp%}
public void creatVersionedSpace()
{
	// Embedded Space
	String url = "/./xapTutorialSpace";

	// Create the SpaceProxy
	ISpaceProxy spaceProxy = GigaSpacesFactory.FindSpace(url);
	spaceProxy.OptimisticLocking = true;
}
{%endhighlight%}

You should enable the Space class to support the optimistic locking, by including the `[SpaceVersion]` decoration on an int getter field. This field stores the current object version and is maintained by XAP. See below for an example:
{%highlight csharp%}
namespace xaptutorial.model
{
	[SpaceClass]
	public class Account {
		[SpaceID]
		[SpaceRouting]
		private int? id { set; get; }
		private String number{ set; get; }
		private Double receipts{ set; get; }
		private Double feeAmount{ set; get; }
		private EAccountStatus status{ set; get; }
		[SpaceVersion]
		private int version{ set; get; }

		// ...
	}
}
{%endhighlight%}

{%comment%}
{%learn%}{%latestneturl%}/optimistic-locking.html{%endlearn%}
 {%endcomment%}



### Pessimistic Locking
The pessimistic locking protocol provides data consistency in a multi user transactional environment. It should be used when there might be a large number of clients trying to read and update the same object(s) at the same time. This protocol utilize the system resources (CPU, network) in a very efficient manner both at the client and space server side.
This scenario is different from the optimistic locking protocol since we assume with the pessimistic locking protocol, that every object that is read and retrieved from the space will eventually be updated where the transaction duration is relatively very short.

Here is an example of pessimistic locking that uses the exclusive read lock ReadModifier:
{%highlight csharp%}
ITransactionManager mgr = GigaSpacesFactory.CreateDistributedTransactionManager ();

// Create a transaction using the transaction manager:
using (ITransaction txn = mgr.Create ()) {
    try {
	    // Read and lock the payment object
	    Payment payment = proxy.ReadById(1,txn,ReadModifiers.ExclusiveReadLock);

	    payment.setStatus(ETransactionStatus.CANCELLED);
	    space.Write(payment,txn);
	    txn.Commit ();
	} catch (Exception e) {
       	// rollback the transaction
        txn.Abort ();
    }
}
{%endhighlight%}

{%comment%}
{%learn%}{%latestneturl%}/pessimistic-locking.html{%endlearn%}
{%endcomment%}

XAP provides additional read modifiers to denote the isolation level:

- RepeatableRead  - default modifier
- DirtyRead
- ReadCommitted
- ExclusiveReadLock

{%comment%}
{%learn%}{%latestneturl%}/gigaspaces-read-modifiers.html{%endlearn%}
{%endcomment%}

{%comment%}
<ul class="pager">
  <li class="previous"><a href="./net-tutorial-part5.html">&larr; The Processing Unit</a></li>
  <li class="next"><a href="./net-tutorial-part7.html">Space Persistence &rarr;</a></li>
</ul>
{%endcomment%}
