---
layout: xap97
title:  Supported Platforms
page_id: 61867269
---

**Navigate to the required category**:

{% toczone minLevel=1|maxLevel=1|type=list|location=top %}

# Overview

GigaSpaces [Data Grid and Messaging Grid core middleware](./product-architecture.html#ProductArchitecture-CoreMiddleware), [Database Cache and Persistency](./persistency.html), [Service Grid and OpenSpaces](./product-architecture.html#OpenSpaces - API and Components) are 100% [Java technology](http://java.sun.com) based.

**You can run GigaSpaces on every operating system that supports the Java Platform Standard Edition technology** -- i.e., Windows , Linux x86, Linux AMD64 (Opteron), Sun Solaris, Hewlett Packard HP-UX, IBM AIX, Apple Mac OS/X, etc.

The list below represents only the platforms that have been tested by GigaSpaces.

{% exclamation %} GigaSpaces components (space, cluster of spaces, Processing Unit, GSM, GSC, LUS, Mahalo, GUI, CLI) can run only with the same GigaSpaces JARs (i.e., the same version and build number).

# Mixing GigaSpaces Versions

The following is supported:

- Runtime backward compatibility: **Starting from GigaSpaces 7.1, GigaSpaces Space instances are backward compatible with Space clients across major versions.** That means that clients running on version 8.0, 9.0 or  9.1 are compatible with Space instances running on version 9.6.
- Binary compatibility: applications built using 8.0.x or higher run without any code changes on a clean 9.6.x installation.
- Servers (GSMs, GSCs and Space instances) running on any future service pack of version 9.6 (e.g. 9.6.1) are guaranteed to work with older service packs of that version (e.g. 9.6.0).

# Tested & Certified Platforms

{% info title=Recommended and Certified Environment %}
GigaSpaces recommends that customers upgrade to a fully-supported environment, such as the latest GigaSpaces XAP 9.6.x and the latest *Java 1.6/1.7  SDK.
{% endinfo %}

GigaSpaces is being tested with (32bit and 64bit JVMs):

- Windows 2008 Server SP2
- Linux RHEL 5.x/6.x
- Solaris 10

{% warning %}
SUSE-10 sp3 has bugs which make OS network layer unreliable. This OS should be avoided with GigaSpaces.
{% endwarning %}

{% info title=Supported Java Versions & SDK End-of-Life %}
* Java SE 1.5 EOL - based on information made publicly available by The Oracle Corporation (formerly Sun Microsystems), as of October 30th 2009, Java SE 1.5 SDK has reached its End of Service Life (EOSL).

- Oracle has already ceased to support the 1.5 JVM. In addition, the other major JVM vendor, namely IBM, announced its limited ability to support these JVMs in light of Oracle's announcement. This in turn will limit GigaSpaces' ability to provide support for applications running on this JVM.
- **From version 8.0 onwards**, GigaSpaces XAP no longer supports the **Java 1.5 SDK**, and will require the use of Java 1.6 SDK or higher.
{% endinfo %}

{% info %}
* Please refer to the public website page for the latest updates about the [JVM & Third-Party End-Of-Life Policy](http://www.gigaspaces.com/content/product-lifecycle-and-eol#jvm).
{% endinfo %}

See below tested JVMs:

- Oracle 6 - XAP was tested using Sun JVM version 643 and above.
- Oracle 7 - XAP was tested using Sun JVM version 7u21 and above.
- JRockit/BEA 1.6.x - XAP was tested using BEA JRockit(R) build 1.6.0_31-b05
- IBM 1.6.0 - XAP was tested using IBM JVM version 1.6.0 IBM J9 VM (build 2.4, JRE 1.6.0 IBM J9 2.4 Linux amd64-64 jvmxa6460sr12-20121024_126067 (JIT enabled, AOT enabled)

# .NET Interface

{% include /xap96net/installation.markdown %}

# C++ Interface

GigaSpaces C\+\+ source code can be built on Linux and Windows 32bit or 64bit machines.

The current supported platforms and compilers are:

- Linux
    - 64bit -- gcc.4.1.2
    - 32bit -- gcc.4.1.2
- Windows
    - 32/64bit C++ for VisualStudio 2008/2010 (VS8.0/VS9.0)

# Integrations with 3rd Party Products

The following products/projects were tested and certified using GigaSpaces 9.7:

- Spring 3.1.3.RELEASE
- Hibernate version 3.6.1.Final
- Mule 3.3.0
- Jetty 8.1.8.v20121106
- Groovy 1.8.6
- Maven 3.0.4
- Hyperic SIGAR 1.6.5
- Apache Cassandra 1.1.6

{% endtoczone %}
