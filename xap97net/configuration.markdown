---
layout: post97
title:  Configuration
categories: XAP97NET
parent: administrators-guide.html
weight: 400
---

# Section Contents

GigaSpaces XAP.NET installer enables developers to start evaluating and using the product immediately, without any manual configuration changes.

That said, usually at some point there's a need to tweak the configuration. The following aspects can be configured:

- **System Behavior** - First and foremost, the XAP system itself can be customized via a large collection of system properties. Many aspects of the system (e.g. timeouts, ports, batch sizes, etc.) are controlled be system properties which can be overridden in several ways. To learn more about configuring processing units refer to the [System Configuration](./system-configuration.html) section.

{% comment %}
# **Structure**
{% endcomment %}

- **Processing Units** - The Service Grid uses an xml descriptor called **pu.config** to deploy processing units. To learn more about configuring processing units refer to the [Processing Units](./processing-units.html) section.

- **Logs** - Both XAP.NET and XAP use logs to expose information about the system behavior. To learn more about configuring logs refer to the [Log Configuration](./log-configuration.html) section.

- **Jvm** - XAP.NET provides a neat facade on top of the java-based XAP which allows .NET users develop applications in .NET without knowing java or interacting with it. However, when the time comes to deploy the system in a production environment, the IT crew might need to tweak jvm parameters. To learn more about configuring the jvm refer to the [Jvm Configuration](./jvm-configuration.html) section.
