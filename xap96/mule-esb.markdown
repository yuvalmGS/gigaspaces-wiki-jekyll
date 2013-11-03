---
layout: post
title:  Mule ESB
page_id: 61867050
---

{% summary section|65 %}OpenSpaces Mule ESB integration allows you to use the Space as a Mule external transport, replace Mule VM transport with transport over the Space, enhances the Mule SEDA model, and can be packaged and run as a Processing Unit.{% endsummary %}

# Overview

OpenSpaces comes with comprehensive support for [Mule](http://www.mulesoft.org/) 3.3. It allows you to use the Space as a Mule external [transport](/xap96/mule-event-container-transport.html), enabling receiving and dispatching of POJO messages over the Space.

An additional transport called [os-queue](/xap96/mule-queue-provider.html) allows you to replace Mule VM transport with highly available inter VM transport over the Space.

OpenSpaces Mule integration also [enhances the Mule SEDA model](/xap96/mule-seda-model.html), allowing you to store a Mule internal SEDA queue over the Space.

Last, a Mule application can be [packaged and run as a Processing Unit](/xap96/mule-processing-unit.html) within one of the OpenSpaces Processing Unit containers -- most importantly the SLA-driven container.

{% exclamation %} See the [Distributed Multi Mule service example](/sbp/mule-esb-example.html) for a best practice approach when designing your Mule based application.
{% children %}

