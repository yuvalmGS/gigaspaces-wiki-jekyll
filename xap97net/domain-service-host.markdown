---
layout: xap97net
title:  Domain Service Host
categories: XAP97NET
page_id: 63799411
---

{composition-setup}
{summary:page}Domain service host is used to host services within the hosting processing unit domain which are exposed for remote invocation.{summary}

h1. Overview

The domain service host is used to host services within the hosting processing unit domain which are exposed for remote invocation. A service is an implementation of one or more interfaces which acts upon the service contract. Each service can be hosted by publishing it through the domain service host later to be invoked by a remote client.

{refer}To learn how to create a remote proxy to the service please refer to [Executor Based Remoting|Executor Based Remoting]{refer}
{refer}For a full SBA example demonstrating remote services usage please refer to the [SBA Example]{refer}

h1. Defining the Contract

In order to support remoting, the first step is to define the contract between the client and the server. In our case, the contract is a simple interface. Here is an example:

{code:java}
public interface IDataProcessor
{
    // Process a given Data object, returning the processed Data object.
    Data ProcessData(Data data);
}
{code}

(!) The {{Data}} object should be {{Serializable}}

h1. Implementing the Contract

Next, an implementation of this contract needs to be provided. This implementation will "live" on the server side. Here is a sample implementation:

{code:java}
[SpaceRemotingService]
public class DataProcessor : IDataProcessor
{
    public Data ProcessData(Data data)
    {
    	data.Processed = true;
    	return data;
    }
}
{code}

h1. Hosting the Service in the Grid

The next step is hosting the service in the grid. Hosting the service is done on the server side within a processing unit that hosts the service, when using the [Basic Processing Unit Container|Basic Processing Unit Container], all types which has the \[SpaceRemotingService\] attribute, will automatically be created and hosted:

{code:java}
[SpaceRemotingService]
public class DataProcessor : IDataProcessor
{
...
}
{code}

Alternatively, or when using a custom [processing unit container|Processing Unit Container], a service can be directly hosted using the {{DomainServiceHost.Host.Publish}}

{code:java}
public ServiceHostProcessingUnitContainer : AbstractProcessingUnitContainer
{
    ...

    public void Initialize()
    {
        ...

        DomainServiceHost.Host.Publish(new DataProcessor());
    }
}
{code}

h1. Service Lookup Name

By default, the service will be published under the interfaces it implements, its lookup names will be the full name of the interfaces types it implements. In some scenarios it may be needed to specify a different lookup name, for instance, when there are two hosted services that implement the same interface. There are a few options to specify a different lookup name. When choosing one of the following options for alternative lookup name, the service will only be hosted under the alternative lookup names overriding the default behavior of investigating which interfaces the provided service implements.

h2. Service Attribute

A different lookup name can be specified by the \[SpaceRemotingService\] {{LookupName}} property:

{code:java}
[SpaceRemotingService(LookupName="MyDataProcessor")]
public class DataProcessor : IDataProcessor
{
...
}
{code}

h2. Publish Lookup Names

When publishing a service it is possible to specify a list of lookup names to publish it under as part of the {{Publish}} method arguments:

{code:java}
DomainServiceHost.Host.Publish(new DataProcessor(), "MyDataProcessor", "MySpecialDataProcessor");
{code}

h2. Publish For Specific Types

Alternatively, a service can be hosted under specific types instead of querying all the interfaces it implements, This can be achieved with the {{Publish}} method as well:

{code:java}
DomainServiceHost.Host.Publish(new DataProcessor(), typeof(IDataProcessor), typeof(IMyService));
{code}

h1. Unpublishing a Service

Once the processing unit that hosts the service is unloaded, all the services within that pu are also removed.
However, it is possible to explicitly unpublish a service during the processing unit life cycle if needed, this is done by the {{Unpublish}} method, with the specific registration of the service that we want to unpublish.

{code:java}
IServiceRegistration registration = DomainServiceHost.Host.Publish(new DataProcessor());
...
DomainServiceHost.Host.Unpublish(registration);
{code}

h1. Execution Aspects

Space based remoting allows you to inject different "aspects" that can wrap the invocation of a remote method on the client side, as well as wrapping the execution of an invocation on the server side. The different aspect can add custom logic to the execution, for instance, loggings or security.

The server side invocation aspect interface is shown below. You should implement this interface and wire it to the {{DomainServiceHost}} (this is the component that is responsible for hosting and exposing your service to remote clients):

{code:java}
public interface IServiceExecutionAspect
{
    /// <summary>
    /// Executed each time a service remote invocation is requested allowing a pluggable behavior
    /// for service execution. The aspect can decide whether to return the execution result value by
    /// setting the <see cref="IInvocationInterception.ResultValue"/> or
    /// to proceed with the execution process pipeline by using <see cref="IInvocationInterception.Proceed()"/>
    /// </summary>
    /// <param name="invocation">Object representing the invocation interception.</param>
    /// <param name="service">The service the invocations refers to.</param>
    void Intercept(IInvocationInterception invocation, Object service);
}
{code}

Here is an example of a security aspect implemention

{code:java}
public class SecurityExecutionAspect : IServiceExecutionAspect
{
    void Intercept(IInvocationInterception invocation, Object service)
    {
        Object[] metaArguments = invocation.SpaceRemotingInvocation.MetaArgument;
        if (!ValidateCredentials(metaArguments, service))
            throw new SecurityException("Unauthorized Execution");
        invocation.Proceed();
    }

    ...
}
{code}

An implementation of such an aspect can be wired as follows:

{code:java}
DomainServiceHost.Initialize(new ExecutionLoggingAspect(), new SecurityExecutionAspect());
{code}

The different execution aspects can be wired only once, and that is when the DomainServiceHost is initialized, which means before publishing any service in it.

The execution of the aspects follows a pattern of pipeline execution of all the aspects followed by the order in which they were set. Each aspect can decide whether to continue with the pipeline execution using the {{invocation.Proceed()}} method. It can either alter a return value of the next aspect in line by setting the {{invocation.ReturnValue}} or it can immidiately return the execution result without continuing to the next aspect by setting the return value using the {{invocation.ReturnValue}} property and not calling the {{invocation.Proceed()}} method. The final service execution it self is an aspect which is the last one to be executed. Plugging custom aspects can decide according to the aspect implementation whether to execute the actual operation on the service or not.