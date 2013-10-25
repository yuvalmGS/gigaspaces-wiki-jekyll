---
layout: sbp
title:  GigaSpaces-Excel Troubleshooting
categories: SBP
page_id: 47218928
---

{summary:page|65}Debugging using Excel; how to write a hosting application for easy debugging.{summary}
{rate}

# Overview

# Writing a Hosting Application for Easy Debugging

(on) If it's the first time you are running UDF of RTD, try running a simple example that only returns a value, to check that the API works in your environment.

Writing applicative UDF/RTD:

- Comment the space API calls inside UDF/RTD code and make it return constant values.
- Create a console or Win-form application that hosts the UDF/RTD DLL and debug it directly to solve the function implementation problems.
