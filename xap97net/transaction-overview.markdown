---
layout: post
title:  Transactions
categories: XAP97NET
parent: programmers-guide.html
weight: 2400
---


{%wbr%}

{%section%}
{%column width=10% %}
![transaction.png](/attachment_files/subject/transaction.png)
{%endcolumn%}
{%column width=90% %}
XAP .Net transaction management programing model.
{%endcolumn%}
{%endsection%}

{%wbr%}

- [Transaction interface](./transactions.html){%wbr%}
Transaction concept and API

- [Locking and Blocking](./transaction-locking-and-blocking.html){%wbr%}
Using optimistic and pessimistic locking to preserve the integrity of changes in a multi-user scenarios.

- [Read Modifiers](./transaction-read-modifiers.html){%wbr%}
XAP's ExclusiveReadLock, ReadCommitted, DirtyRead, and RepeatableRead modifiers.

- [Optimistic Locking](./transaction-optimistic-locking.html){%wbr%}
The optimistic locking protocol provides better performance and scalability when having concurrent access to the same data. Optimistic locking offers higher concurrency and better performance than pessimistic locking. It also avoids deadlocks.

{%comment%}
- [Pessimistic Locking](./transaction-pessimistic-locking.html){%wbr%}
In the pessimistic locking approach, your program must explicitly obtain a lock using a transaction on one or more objects before making any changes.
{%endcomment%}