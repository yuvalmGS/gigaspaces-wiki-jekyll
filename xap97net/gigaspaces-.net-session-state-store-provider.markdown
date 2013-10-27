---
layout: xap97net
title:  GigaSpaces .NET Session State Store Provider
categories: XAP97NET
page_id: 63799345
---

{summary:page|60}How to use the .Net GigaSpaces Session State Store Provider implementation. {summary}

# Overview

The session state store provider is used by the IIS (Internet Information Services) to supply a data store for active sessions. This implementation uses GigaSpaces as the session data storage provider.

(i) See how to install the package **[below|#Installation]**.

Using the session-state store provider, values that need to be persisted during a user session are stored into session variables. These variables are unique in each user session. You can set and access session information from within an ASP .NET application. For example:

{% highlight java %}
//Assign a value to the buttonCount session variable:
Session["buttonCount"] = 0;
{% endhighlight %}


# Installation

To use this practice, compile the reference: `<GigaSpaces Root>\Bin\GigaSpaces.Practices.HttpSessionProvider.dll` through Visual Studio, using the solution located at `<GigaSpaces Root>\Practices\HttpSessionProvider\GigaSpaces.Practices.HttpSessionProvider.sln`.

# Configuration

Session state implementations can be configured by setting the `mode` attribute to a valid `SessionStateMode sessionState` element in your application configuration.
{refer}For more details, see: [msdn; Session-State Modes|http://msdn2.microsoft.com/en-us/library/ms178586.aspx].{refer}
The `mode` attribute is set up in the `web.config` file (or the `machine.config` file). The `machine.config` file is located in `c:Microsoft.NET\Frameworkconfig\machine.config`.
Configure your `web.config` file as follows:

{% highlight xml %}
<configuration xmlns="http://schemas.microsoft.com/.NetConfiguration/v2.0">

  <connectionStrings>

    <!--This specifies the connection string to connect to the space-->

    <add name="SpaceSessionProviderURL" connectionString="--Connection String Url to the GigaSpaces session state storage provider
(you can use "jini://*/*/mySpace" for remote space)--" />
  </connectionStrings>
  <system.web>
    <sessionState mode="Custom"
    customProvider="GigaSpaceSessionProvider"
    cookieless="true"
    timeout="5"
    regenerateExpiredSessionId="true">

     <providers>
        <!--
        the name type and connectionStringName should be set as follows,
        writeExceptionToEventLog states weather unexpected exception should be written to a log or thrown back to the client.
        supportSessionOnEndEvents states weather the provider should support triggering Session_End events when sessions expires.-->
        <add name="GigaSpaceSessionProvider"
        type="GigaSpaces.Practices.HttpSessionProvider.GigaSpaceSessionProvider"
        connectionStringName="SpaceSessionProviderURL"
        writeExceptionsToEventLog="--true/false--"
        supportSessionOnEndEvents="--true/false--" />
      </providers>
    </sessionState>
  </system.web>
</configuration>
{% endhighlight %}

To use a custom provider, `mode` must be set to `Custom`, and the `providers` element must also be used.
{refer}For more details, see the [sessionState|http://msdn2.microsoft.com/en-us/library/h6bb9cz9.aspx] element.{refer}
{refer}[Learn how to to implement a session state store provider|http://msdn2.microsoft.com/en-us/library/ms178587.aspx].{refer}

# Exceptions

When enabled, the `writeExceptionToEventLog` parameter instructs exceptions thrown by the provider to be written in detail to the Event Log (only a general exception is thrown to the client). Otherwise, the exceptions are thrown only to the client.

# Expired Sessions

The `supportExpiredSessions` parameter, when enabled, instructs the provider to trigger `Session_End` events when a session expires.

{% exclamation %} If you do not need a certain method to be called when a session expires (`Time out`), it is not recommended to enable this parameter, since this creates additional load on the provider.

# Deployment

The type of deployment depends on if the load-balancer is configured to work with sticky sessions, or not (session stick at the same server once created).

If the load-balancer is configured to work with sticky sessions, a recommended deployment pattern is the master-local topology, where each server has a local cache that is connected to a remote master cluster or space topology. If this is not the case, master-local is not recommended since it creates larger overhead when sessions are transferred between the servers.

# Reducing Network Load

It is possible to reduce the network load by splitting the `SessionDataEntry` object (the object that holds the session information in the space) in the implementation into two classes; where one class holds the session item's data, and the other class holds the inner variables such as locked state, locked date, etc. This way, each session includes two objects that represent it in the space. Using such a data model might complicate the space interaction a bit, since managing the dependencies between the objects and synchronizing the lease expiration requires some more coding.