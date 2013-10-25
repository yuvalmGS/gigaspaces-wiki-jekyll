---
layout: sbp
title:  Event Driven Remoting Example
categories: SBP
page_id: 47219276
---

{composition-setup}

{tip}**Summary:** {excerpt}Event based remoting example{excerpt}
**Author**: Shay Hassidim, Deputy CTO, GigaSpaces
**Recently tested with GigaSpaces version**: XAP 8.0.4
**Contents:**
{toc:minLevel=1|maxLevel=1|type=flat|separator=pipe}
{tip}
{rate}

# Overview

OpenSpaces provides the ability to perform service method invocations on remote services, using the space as the transport layer. You may use the [Event Driven Remoting|XAP8:Event Driven Remoting] and [Executor Based Remoting|XAP8:Executor Based Remoting].

The benefits of using the Event Driven Remoting Compared to the Executor Based Remoting:
- Service and Data can be located in different locations.
- Service can be shut down without impacting the Data.

The downside using Event Driven Remoting is performance and scalability. Since it is using polling container that is asynchronous consumer where the trigger to the invocation is a space write operation the internal overhead compared to the Executor Based Remoting is higher.

# Event Driven Remoting Example

The Event Driven Remoting allows you to:
- Immediately returns a 'Future'
- Allows the client to determine when to get the results
- Calling Future.get() is a synchronous call
- Is designed for long-running computation requests

{toc-zone:minLevel=2|maxLevel=2|type=flat|separator=pipe|location=top}

## Installing and Running the example

1. Download the [example|Event Driven Remoting Example^event_remoting_Example.zip] package and unzip it under your <GigaSpaces Root>\examples folder.
2. Load the example into your IDE (eclipse or your favorite Java development environment).
3. Edit the project to include the correct GigaSpaces libraries location.
4. Setup the Service PU run configuration:
!event_remot3.jpg!
!event_remot4.jpg!
5. Setup the Client PU run configuration:
!event_remot1.jpg!
!event_remot2.jpg!
6. Run the Service PU
7. Run the Client PU. This will invoke the service to that will immediately return and after 10 seconds will receive the result.

## The Flow

To allow the client to invoke the service and immediately return the actual dialog between the client and the service done via request/response space objects. The service business logic is executed in the background, and when completed returns the result back to the client:
- Client is writing a Request object to the space.
- The Request object is taken by the service (using a polling container).
- The Service is writing back a Response object.
- The client takes the Response object.

!async_remot1.jpg!

## Sample Client Output

{code}
EventRemotingClient: I am being constructed.
2011-11-08 09:11:46,871  INFO [org.openspaces.pu.container.integrated.IntegratedProcessingUnitContainer] -
Processing unit(s) started successfully
---------------------------------------------------
2011-11-08 09:11:47.867 About to invoke Service - Request #1
2011-11-08 09:11:47.97 Got EventDrivenRemoteFuture back...
2011-11-08 09:11:47.97 Future.get() returns Hi
---------------------------------------------------
2011-11-08 09:11:57.983 About to invoke Service - Request #2
2011-11-08 09:11:57.985 Got EventDrivenRemoteFuture back...
2011-11-08 09:11:57.985 Future.get() returns Hi
---------------------------------------------------
{code}

## Sample Service Output
{code}
SimpleServiceImpl constructed...
2011-11-08 09:11:40,036  INFO [org.openspaces.pu.container.integrated.IntegratedProcessingUnitContainer] -
Processing unit(s) started successfully
2011-11-08 09:11:47.965 SimpleServiceImpl - Request Number:1 called!
2011-11-08 09:11:57.985 SimpleServiceImpl - Request Number:2 called!
{code}
