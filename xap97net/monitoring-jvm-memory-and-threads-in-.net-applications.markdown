---
layout: xap97net
title:  Monitoring JVM Memory and Threads in .NET Applications
categories: XAP97NET
page_id: 63799356
---


{% summary %}Monitoring JVM memory and threads in .Net Applications, when troubleshooting application memory and thread consumption. {% endsummary %}


# Overview

In some cases, you might want to monitor the activity of the JVM running as part of your .NET application. The depanlinkjconsoletengahlinkhttp://java.sun.com/j2se/1.5.0/docs/guide/management/jconsole.htmlbelakanglink is a great tool that allows you to troubleshoot the JVM internals.

**To view and monitor the JVM loaded into the .NET process memory address using `jconsole`:**
1. Have the following settings as part of your `app.config` file:

{% highlight xml %}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces" type="GigaSpaces.Core.Configuration.GigaSpacesCoreConfiguration, GigaSpaces.Core"/>
  </configSections>
  <GigaSpaces>
    <JvmSettings>
      <JvmCustomOptions IgnoreUnrecognized="false">
        <add Option="-Dcom.sun.management.jmxremote.port=5144"/>
        <add Option="-Dcom.sun.management.jmxremote.ssl=false"/>
        <add Option="-Dcom.sun.management.jmxremote.authenticate=false"/>
      </JvmCustomOptions>
    </JvmSettings>
  </GigaSpaces>
</configuration>
{% endhighlight %}

2. Start `jconsole` -- jconsole is located under the bin directory of the Java home, by default it is under `<Installation dir>\Runtime\java\bin`
3. Once the `jconsole` is started, select the **Local** tab:


{% indent %}
depanimagejcon1.jpgtengahimage/attachment_files/xap97net/jcon1.jpgbelakangimage
{% endindent %}


4. This shows the status of the JVM running in your .NET application:

depanimagejcon2.jpgtengahimage/attachment_files/xap97net/jcon2.jpgbelakangimage

{% refer %}For more details on JMX and `jconsole`, refer to:{% endrefer %}
- depanlinkSun - Monitoring and Management Using JMXtengahlinkhttp://java.sun.com/j2se/1.5.0/docs/guide/management/agent.htmlbelakanglink
- depanlinkSun - Using jconsoletengahlinkhttp://java.sun.com/j2se/1.5.0/docs/guide/management/jconsole.htmlbelakanglink
