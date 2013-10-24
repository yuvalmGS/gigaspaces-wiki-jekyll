---
layout: xap96
title:  Benchmark Utility - GigaSpaces CLI
page_id: 61867101
---

{% summary %}A tool for running performance benchmarks on the space in various scenarios.{% endsummary %}

# Overview

The benchmark example provides a good tool for running performance benchmarks on the cache in various scenarios. This program performs a loop of `write/put` and `read/get` or `take/remove` operations from a space according to a different set of parameters. The result is the average time it took to perform the operations. You can define a sampling rate to allow you to track the intermediate performance while the benchmark example is running. You may also dump the results into a file to be converted into graphs and analyzed using a spreadsheet and analysis tools.


