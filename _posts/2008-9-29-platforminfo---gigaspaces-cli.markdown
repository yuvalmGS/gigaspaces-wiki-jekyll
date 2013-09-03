---
layout: post
title:  PlatformInfo - GigaSpaces CLI
categories: XAP96
page_id: 61867221
---

{% summary %}Provides full information on the system configuration. {% endsummary %}

# Syntax

    platform-info.(sh/bat) [-verbose]

# Description

The `platform-info` outputs the current version of the GigaSpaces platform.

The `platform-info -verbose` provides full information about the system configuration. It is a very useful means while opening a support ticket:

- JVM System properties.
- OS System environment variables.
- Network Card interface information.
- File content of `<GigaSpaces Root>/config directory: \*.xml, \*.properties and \*.config` only.
