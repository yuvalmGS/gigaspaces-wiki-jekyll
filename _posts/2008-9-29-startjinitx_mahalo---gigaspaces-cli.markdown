---
layout: post
title:  startJiniTX_Mahalo - GigaSpaces CLI
categories: XAP96
page_id: 61867311
---

{% summary %}Starts the Jini Transaction Manager as a stand alone process. {% endsummary %}

# Syntax

    startJiniTX_Mahalo

# Description

The `startJiniTX_Mahalo` starts the Jini Transaction Manager as a stand alone process.

{% tip %}
For details on how to start an embedded Jini Transaction Manager, refer to the [gsInstance - GigaSpaces CLI](/xap96/2008/09/29/gsinstance---gigaspaces-cli.html) section.
{% endtip %}

# Options

None.

# Example

    <GigaSpaces Root>\bin>startJiniTX_Mahalo.bat
    Starting a Mahalo Jini Transaction Manager instance
    JAVA_HOME environment variable is set to D:JDKjdk1.5.0_04 in "<GigaSpaces Root>binsetenv.bat"
    Environment set successfully from E:GigaSpacesXAP6.0bin\..
    Webster listening on port : 1421
    Webster minThreads [3], maxThreads [10]
    Loading mimetypes ...
    Mimetypes loaded
    Waiting on accept() ...
    Accepted request from : 192.168.10.178
    GET lib/jini/mahalo-dl.jar
    getFile = E:GigaSpacesXAP6.0bin..libjinimahalo-dl.jar
    file size: [16470]
    Waiting on accept() ...
    Jan 24, 2006 10:06:02 PM com.sun.jini.mahalo.TxnManagerImpl doInit
    INFO: Mahalo started: com.sun.jini.mahalo.TransientMahaloImpl@15ff48b
    Accepted request from : 192.168.10.178
    GET lib/jini/mahalo-dl.jar
    Waiting on accept() ...
    getFile = E:GigaSpacesXAP6.0bin..libjinimahalo-dl.jar
    file size: [16470]
