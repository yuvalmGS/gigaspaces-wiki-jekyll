---
layout: post
title:  startJiniLUS - GigaSpaces CLI
page_id: 61867398
---

{% summary %}Starts the Jini Lookup Service as a standalone process. {% endsummary %}

# Syntax

    startJiniLUS

# Description

The `startJiniLUS` starts the Jini Lookup Service as a stand alone process.

{% tip %}
For details on how to configure the Jini Looup Service, refer to the [Lookup Service Configuration](/xap96/lookup-service-configuration.html) section.
{% endtip %}

{% tip %}
For details on how to start an embedded Mahalo (Jini Transaction Manager), refer to the [gsInstance - GigaSpaces CLI](/xap96/gsinstance---gigaspaces-cli.html) section.
{% endtip %}

# Options

None.

# Example

    <GigaSpaces Root>\bin>startJiniLUS.bat
    Starting a Reggie Jini Lookup Service instance
    JAVA_HOME environment variable is set to D:\JDK\jdk1.5.0_04 in "<GigaSpaces Root>\bin\setenv.bat"
    Environment set successfully from c:\GigaSpacesXAP6.0\bin
      ..
    Webster listening on port : 1411
    Webster minThreads [3], maxThreads [10]
    Loading mimetypes ...
    Mimetypes loaded
    Waiting on accept() ...
    Accepted request from : 192.168.10.178
    GET lib/jini/reggie-dl.jar
    Waiting on accept() ...
    getFile = c:\GigaSpacesXAP6.0\bin\..\lib\jini\reggie-dl.jar
    file size: [58054]
    Jan 24, 2006 10:05:51 PM com.sun.jini.reggie.RegistrarImpl init
    INFO: started Reggie: 0881db0d-2736-46e2-9e75-2af4c7cd4961, [gigaspaces-1358], ConstrainableLookupLocator[[jini://192.16
    8.10.178/], [null]]
    Accepted request from : 192.168.10.178
    GET lib/jini/reggie-dl.jar
    Waiting on accept() ...
    getFile = c:\GigaSpacesXAP6.0\bin\..\lib\jini\reggie-dl.jar
    file size: [58054]
    Accepted request from : 192.168.10.146
    GET lib/jini/reggie-dl.jar
    Waiting on accept() ...
    getFile = c:\GigaSpacesXAP6.0\bin\..\lib\jini\reggie-dl.jar
    file size: [58054]
