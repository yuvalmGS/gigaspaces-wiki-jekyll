---
layout: post
title:  Security
page_id: 61867437
---

{% summary %}This section describes GigaSpaces security model{% endsummary %}

# Overview

{% section %}
{% column %}
This section provides an understanding of GigaSpaces XAP Security, where it fits in the GigaSpaces architecture, which components can be secured, and how to configure and customize the security depending on your application security requirements.
{% endcolumn %}
{% column %}
![security-logo.jpg](/attachment_files/security-logo.jpg)
{% endcolumn %}
{% endsection %}

# What is GigaSpaces Security?

GigaSpaces Security provides comprehensive support for securing your data, services, or both. GigaSpaces provides a set of authorities granting privileged access to data, and for performing operations on services.

{% indent %}
![security_ovreview.jpg](/attachment_files/security_ovreview.jpg)
{% endindent %}

Security comprises two major operations: **authentication** and **authorization**. **Authentication** is the process of establishing and confirming the authenticity of a _principal_. A _principal_ in GigaSpaces terms, means a user (human or software) performing an action in your application. **Authorization** refers to the process of deciding whether a principal is allowed to perform this action. The flow means that a principal is first established by the authentication process, and then authorized by the authorization decision process, when performing actions. These concepts are common and not specific to GigaSpaces Security.

At the authentication level, GigaSpaces Security is equipped with standard encryption algorithms (such as AES and MD5), which can be easily configured and replaced. The authentication layer is provided with a default implementation, which can be customized to integrate with other security standards (i.e. Spring Security). This layer is also known as the **authentication manager**.

The authentication layer is totally independent from the authorization decision layer. The **authorization decision manager** is internal to GigaSpaces components, and is used to intercept unauthorized access/operations to data and services.

GigaSpaces Security architecture has been designed to meet the needs of enterprise application security. We have tried to provide a complete experience throughout all the components, for a useful, configurable and extendable security system.

GigaSpaces Main Security Features:

- Authority roles based security
    - System , Monitor , Grid , Data-Grid Authorities
- Spring Based Security support
    - LDAP Authenticating
    - Database Authenticating 
- Custom Security 
    - Kerberos Authenticating
- Data-Grid operations Auditing 
- SSL Transport Layer security
- UI, CLI and API Security Tools

# Getting Started

To help you get started, the section goes through the [basics](Security Basics), how to secure the [components](Securing XAP Components), [administration tools](./security-administration.html), applying security to the [HelloWorld example](./securing-the-helloworld-example.html), and finally once you gain an in-depth understanding, shows you how to [customize](./custom-security.html) the security based on your application requirements. One such custom security implementation is the [Spring Security Bridge](./spring-security-bridge.html).

{% children %}
