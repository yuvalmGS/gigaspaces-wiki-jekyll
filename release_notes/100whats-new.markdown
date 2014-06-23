---
layout: post
title:  What's New
categories: RELEASE_NOTES
parent: xap100.html
weight: 100
---

{%summary%}{%endsummary%}

# Overview

This page lists the main new features in XAP 10.0 (Java and .Net editions). It's not an exhaustive list of all new features. For a full change log for 10.0 please refer to the [new features](./100new-features.html) and [fixed issues](./100fixed-issues.html) pages.



# Off Heap Storage Abstraction


# Native Integration with Solid State Drives

# Global HTTP Session Sharing

# Query Aggregation

XAP provides the common functionality to perform aggregations across the space. There is no need to retrieve the entire data set from the space to the client side , iterate the result set and perform the aggregation. This would be an expensive activity as it might return large amount of data into the client application. The Aggregators allow you to perform the entire aggregation activity at the space side avoiding any data retrieval back to the client side. Only the result of each aggregation activity performed with each partition is returned back to the client side where all the results are reduced and returned to the client application.

{%comment%}
<a href="/xap100/aggregators.html">Java |</a><a href="/xap100net/aggregators.html">
            .Net</a><br>
{%endcomment%}

{%section%}
{%column width=50% %}
{%endcolumn%}
{%column width=10% %}
{%javalearn%}/xap100/aggregators.html{%endjavalearn%}
{%endcolumn%}
{%column width=10% %}
{%netlearn%}/xap100net/aggregators.html{%endnetlearn%}
{%endcolumn%}
{%endsection%}

# Optimized Initial Data Load

# Custom Change Operation


# Query Execution Information


# Web UI Enhancements

# Upgrade to Jetty 9.0


# Java 8.0 Certification

