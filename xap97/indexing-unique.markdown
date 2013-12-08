---
layout: post
title:  Unique Index
categories:
parent:
weight: 100
---


{% summary %} TODO. {% endsummary %}

# Overview

Unique constraint ensure uniqueness of indexed attributes stored in the space. It is applicable to all types of indices- Basic, Extended, Compound and Collection indices.

{%note%}
The uniqueness is enforced per partition and not over the whole cluster.
{%endnote%}

# Operation

When the system encounters a violation in a unique constraint in one of the index-changing apis (write/update/change) a  UniqueConstraintViolationException is thrown, and the operation which caused the violation is revoked- in case of a write the entry is removed and in case of an update/change operation- the original value is restored.  Note that even if the operation(write or update)  is done under a transaction the unique value check is done when the operation is performed  (eager mode) and not when the transaction is committed.


# API

A unique attribute is added to the `@SpaceIndex` annotation. Unique = true will designate a unique constraint.

Example:

{%highlight java%}

public class Person
{
  @SpaceIndex(type=SpaceIndexType.BASIC, unique = true)
  private String lastName;

  private String firstName;
 .
 .
{%endhighlight%}


unique=true can be added to GSXML and PUXML files too.
Example of a GSXML extract:

{%highlight xml %}
        <property name="field">
            <index type="BASIC" unique="true"/>
        </property>
        <property name="counter">
            <index type="EXTENDED" unique="true"/>
        </property>
{%endhighlight%}

# Limitations

*	Supported only for ALL_IN_CACHE cache policy, not supported for LRU and other evictable cache policies
*	Not supported for local-cache/local-view since its only per-partition enforcement
*	Currently not supported for dynamic (on-the-fly) indices.


