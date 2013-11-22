---
layout: post
title:  login - GigaSpaces CLI
categories: XAP97
parent: commands.html
weight: 1100
---

{% summary %}This CLI command allows you to login to secured services: GSM, GSC and spaces. {% endsummary %}

# Syntax

    gs> login
    gs> login -user xxx -password yyy

# Description

{% refer %}[Command Line Interface (CLI) Security](./command-line-interface-(cli)-security.html){% endrefer %}
This CLI command allows you to login to secured services: GSM, GSC and spaces.
Each time you invoke this command, you are required afterwards to type in the user name and password (if not supplied in the command). The user name and password are used in order to attempt to authenticate secured services before invoking any operation for them ( e.g. pudeploy, undeploy, space clear, space connections ... ).

# Options

None.

# Example

    gs> login
    Please enter user name:
    my_name
    Please enter user password:

    gs>
