---
layout: xap97net
title:  Your First XTP Application
categories: XAP97NET
page_id: 63799346
---

{composition-setup}
{summary:page|65}This example demonstrates basic usage of a .NET Processing Unit. The example contains two Processing Unit Containers; one that feeds data objects into the system, and another that reads these objects and processes them.{summary}

{section}
{column:width=7%}
{column}
{column:width=86%}
{align:center}||!GRA:Images^wiki_icon_folder.gif!||Example Root|{{<GigaSpaces Root>\Examples\ProcessingUnit}} |
{align}
{column}
{column:width=7%}
{column}
{section}

h1. Overview

This example demonstrates a simple processing unit architecture project -- a complete SBA application that can easily scale. It demonstrates a usage of GigaSpaces's SBA related components, such as [Event Listener Container|Event Driven Architecture], [Space Based Remoting|Space Based Remoting] and the [Basic Processing Unit Container|Basic Processing Unit Container].

h1. Architecture

This example includes a module that is deployed to the grid, and a domain model that consists of {{Data}} objects. The [DataFeeder|#datafeeder] module runs within a [Basic Processing Unit Container|Basic Processing Unit Container] and writes {{Data}} objects with raw data into the remote space. The space is actually embedded within the other Processing Unit Container, which runs the [DataProcessor|#dataprocessor] module.

The {{DataProcessor}} service takes the new {{Data}} objects, processes the raw data and writes them back to the space.

The example solution is based on three projects:
# Common - holds the {{Data}} object and the common interfaces
# Feeder - holds the DataFeeder processing unit logic.
# Processor - holds the DataProcessor processing unit logic and related classes.

!GRA:Images^dataexample architecture.jpg!

h2. Application Workflow

# The [DataFeeder|#datafeeder] writes non-processed {{Data}} objects into the space every second.
# The [DataProcessor|#dataprocessor] takes non-processed {{Data}} objects, processes them, and writes the processed {{Data}} objects back to the space.

h1. Data Domain Model

The only object in our model is the {{Data}} object.

{code:java}
[SpaceClass]
public class Data
{
[..]
  /// <summary>
  /// Gets the data type, used as the routing index inside the cluster
  /// </summary>
  [SpaceRouting]
  public Nullable<int> Type
  {
    get { return _type; }
    set { _type = value; }
  }
  /// <summary>
  /// Gets the data info
  /// </summary>
  public string Info
  {
    get { return _info; }
    set { _info = value; }
  }
  /// <summary>
  /// Gets or sets the data processed state
  /// </summary>
  public bool Processed
  {
    get { return _processed; }
    set { _processed = value; }
  }
[..]
}
{code}

Note the attributes that are used in this object:
* {{SpaceClass}} -- the marked object is written into a space.
* {{SpaceRouting}} -- when using a partitioned cluster topolgy, {{Data}} objects are routed to the appropriate partitions according to the specified attribute, in this case {{type}}.

Basically, every {{Data}} object is written to the space by the {{DataFeeder}} with the {{processed}} value set to {{false}}, which is later set to {{true}} by the {{DataProcessor}}.

{anchor:dataprocessor}
h2. DataProcessor

The data processor module consists of one class named {{DataProcessor}} which contains the processing business logic.
The {{DataProcessor}} class is created upon deployment of the data processor processing unit project which will be created and managed within a [Basic Processing Unit Container|Basic Processing Unit Container].

The actual work is done by a [Polling Container|Polling Container Component] and the {{DataProcessor}}. The polling container provider the abstraction for data event that triggers the business logic by taking the unprocessed {{Data}} objects from the space and executes the {{DataProcessor.ProcessData}} method on it. Then it writes the processed data back to the space.

The different attributes will be used to create and configure the polling container that will trigger the data event and invoke the {{ProcessData}} method which represents the business logic. The polling container is aware of the mode the space is in, and it will only work when the space is in Primary mode. Additionally the processor as being published as a [remote service|Space Based Remoting], therefore it needs to implement a service contract, in our case it implements the common interface {{IProcessorStatisticsProvider}}, which will later be remotely invoked by the feeder to display statistics of the processor.

In this example the processor is colocated with the space that it needs to process data from, therefore achieving high performance because the processor and the space reside in the same process. This cluster topology is built by a simple matter of configuration of the basic processing unit container which is detailed below.

{gdeck:dataprocessor|top}
{gcard:Code}
{code:java}
/// <summary>
/// This class contain the processing logic, marked as polling event driven.
/// </summary>
[PollingEventDriven(Name = "DataProcessor", MinConcurrentConsumers = 1, MaxConcurrentConsumers = 4)]
[SpaceRemotingService]
internal class DataProcessor : IProcessorStatisticsProvider
{
  [..]

  /// <summary>
  /// Gets an unprocessed data
  /// </summary>
  [EventTemplate]
  public Data UnprocessedData
  {
    get
    {
      Data template = new Data();
      template.Processed = false;
      return template;
    }
  }

  /// <summary>
  /// Fake delay that represents processing time
  /// </summary>
  private const int ProcessingTime = 100;
  /// <summary>
  /// Receives a data and process it
  /// </summary>
  /// <param name="data">Data received</param>
  /// <returns>Processed data</returns>
  [DataEventHandler]
  public Data ProcessData(Data data)
  {
      Console.WriteLine("**** processing - Took element with info: " + data.Info);
      //Process data...
      Thread.Sleep(ProcessingTime);
      //Set data state to processed
      data.Processed = true;
      Console.WriteLine("**** processing - done");
      UpdateStatistics(data);
      return data;
  }

  [..]

  public int GetProcessObjectCount(int type)
  {
      [..]
  }
}
{code}
{gcard}
{gcard:Configuration}
{code:xml}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces.XAP" type="GigaSpaces.XAP.Configuration.GigaSpacesXAPConfiguration, GigaSpaces.Core"/>
  </configSections>
  <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="GigaSpaces.XAP.ProcessingUnit.Containers.BasicContainer.BasicProcessingUnitContainer, GigaSpaces.Core">
      <BasicContainer>
        <ScanAssemblies>
          <add AssemblyName="GigaSpaces.Examples.ProcessingUnit.Processor"/>
        </ScanAssemblies>
        <SpaceProxies>
          <add Name="ProcessingSpace" Url="/./dataExampleSpace"/>
        </SpaceProxies>
      </BasicContainer>
    </ProcessingUnitContainer>
  </GigaSpaces.XAP>
</configuration>
{code}

We configure a single colocated space specified by the Url of the space, in our case "/./dataExampleSpace" (embedded space url). Since there's only one managed space proxy in the basic container, the data processor polling container will operate using that proxy.
{gcard}
{gdeck}

h2. SLA File

This data processor comes with an sla.xml file which define the default topology, which in our case is a cluster of 2 primaries and a single backup per primary. This can be override at deploy time or by editing the sla.xml file that resides in the data processor deployment directory.

{refer}See [Event Driven Architecture|Event Driven Architecture] for more info about event listening abstraction.{refer}
{refer}See [Space Based Remoting|Space Based Remoting] for more info about remoting services over the grid.{refer}
{refer}See [Basic Processing Unit Container|Basic Processing Unit Container] for more info about the built in basic processing unit container.{refer}

{anchor:datafeeder}
h2. DataFeeder

The data feeder is in charge of feeding the cluster with unprocessed data every second. It does so by creating new {{Data}} objects with a random type and random information, and writes it to the cluster.

{gdeck:datafeeder|top}
{gcard:Code}
{code:java}
/// <summary>
/// Data feeder feeds new data to the space that needs to be processed
/// </summary>
[BasicProcessingUnitComponent(Name = "DataFeeder")]
public class DataFeeder
{
  [..]

  /// <summary>
  /// Starts the feeding process once the container is initialized.
  /// </summary>
  /// <param name="container">Managing container.</param>
  [ContainerInitialized]
  private void StartFeeding(BasicProcessingUnitContainer container)
  {
    //Get feed delay from the custom properties, if none found uses the default one
    string feedDelayStr;
    container.Properties.TryGetValue(FeedDelayProperty, out feedDelayStr);
    _feedDelay = (String.IsNullOrEmpty(feedDelayStr) ? DefaultFeedDelay : int.Parse(feedDelayStr);
    //Gets the proxy to the processing grid
    _proxy = container.GetSpaceProxy("ProcessingGrid");
    //Set the started state to true
    _started = true;
    //Create a working thread
    _feedingThread = new Thread(Feed);
    //Starts the working thread
    _feedingThread.Start();
  }

  ///<summary>
  ///Destroys the processing unit, any allocated resources should be cleaned up in this method
  ///</summary>
  public void Dispose()
  {
    //Set the started state to false
    _started = false;
    //Wait for the working thread to finish its work
    _feedingThread.Join(_feedDelay * 5);
  }

  /// <summary>
  /// Generates and feeds data to the space
  /// </summary>
  private void Feed()
  {
    try
    {
      //Create a proxy to the remote service which provide processing statistics
      ExecutorRemotingProxyBuilder<IProcessorStatisticsProvider> builder =
         new ExecutorRemotingProxyBuilder<IProcessorStatisticsProvider>(_proxy);
      IProcessorStatisticsProvider processorStatisticsProvider = builder.CreateProxy();
      int iteration = 0;
      Random random = new Random();
      while (_started)
      {
        //Create a new data object with random info and random type
        Data data = new Data(Guid.NewGuid().ToString(), random.Next(0, DataTypesCount));
        Console.WriteLine("Added data object with info {0} and type {1}", data.Info, data.Type);
        //Feed the data into the cluster
        _proxy.Write(data);
        Thread.Sleep(_feedDelay);
        //Check if should print statistics
        if (++iteration % PrintStatisticIterCount == 0)
        {
          Console.WriteLine("Asking processor of type " + data.Type.Value + " how many objects of that type it has processed");
          int processedTypes = processorStatisticsProvider.GetProcessObjectCount(data.Type.Value);
          Console.WriteLine("Received total processed object of type " + data.Type.Value + " is " + processedTypes);
        }
      }
    }
    [..]
  }
}
{code}
{gcard}
{gcard:Configuration}
{code:xml}
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="GigaSpaces.XAP" type="GigaSpaces.XAP.Configuration.GigaSpacesXAPConfiguration, GigaSpaces.Core"/>
  </configSections>
  <GigaSpaces.XAP>
    <ProcessingUnitContainer Type="GigaSpaces.XAP.ProcessingUnit.Containers.BasicContainer.BasicProcessingUnitContainer, GigaSpaces.Core">
      <BasicContainer>
        <ScanAssemblies>
          <add AssemblyName="GigaSpaces.Examples.ProcessingUnit.Feeder"/>
        </ScanAssemblies>
        <SpaceProxies>
          <add Name="ProcessingGrid" Url="jini://*/*/dataExampleSpace"/>
        </SpaceProxies>
      </BasicContainer>
    </ProcessingUnitContainer>
  </GigaSpaces.XAP>
</configuration>
{code}

We configure a remote proxy to the cluster which is used by the feeder in order to feed unprocessed data into the cluster and to execute a remote service to obtain processing statistics
{gcard}
{gdeck}

The {{Feed()}} method does the actual work, by creating a new {{Data}} object with random data in an unprocessed state every second, and feeds it to the cluster. Additionaly every number of iterations it displays the statistics of processing of a certain type by executing a remote service which the processors expose. It does so by using an [Executor based remoting proxy|Executor Based Remoting] to the remote service which is hosted in the grid.

h1. Building the Example

This example includes {{compile.bat}} script.

From the {{<Example Root>}} directory ({{<GigaSpaces Root>\Examples\ProcessingUnit}}), call:
{code}compile{code}

This compiles all the related projects and creates the processing unit dlls inside each project, under the {{Deployment}} directory. It also copies the Processing Units Deployment directory to the {{<GigaSpaces Root>\Runtime\deploy}} directory, which simplifies deployment through the {{gs-ui}}.

(!) The Deployment config file ({{pu.config}}) should always reside under the root directory of your application.

{anchor:deployment}

h1. Deployment

There are a few ways to deploy the Processing Units:

* [Grid deployment|#grid]
* [IDE integrated deployment|#ide]
* [Standalone deployment|#standalone]

{anchor:grid}
h2. Grid Deployment

Under {{<GigaSpaces Root>\Examples\ProcessingUnit}}, there are two directories: {{Feeder}} and {{Processor}}. These contain the two Processing Unit projects, and in each of these directories there is a {{Deployment\DataFeeder}} and {{Deplotmeny\DataProcessor}} directories correspondingly. This directories are in the required structure to deploy a Processing Unit, and are copied by the {{copydeploymentfiles}} script to the {{<GigaSpaces Root>\Runtime\deploy}} directory. This simplifies the deployment of the processing units in to the Service Grid using GigaSpaces Managament Center or GigaSpaces Command Line Interface.
Alternatively, a specific directory can be deployed using its fullpath, processing units that reside at the {{<GigaSpaces Root>\Runtime\deploy}} directory are automatically detected by GigaSpaces Managament Center or GigaSpaces Command Line Interface and can be deployed by their name.

The {{pu.config}} resides in the {{Deployment\DataFeeder(\Processor)}} directory of each processing unit. This file defines exactly which Processing Unit Container to deploy, in our case {{BasicProcessingUnitContainer}} and configures it.

After you run the build script and the copy deployment files script, the two directories are copied to the {{<GigaSpaces Root>\Runtime\deploy}} directory. This example runs in a partitioned cluster with two primary spaces and one backup space for each partition, you need to run Grid Service Agent which will start and manage one Grid Service Manager (GSM) and two Grid Service Containers (GSC), and then start the GigaSpaces Management Center.

{code}
<GigaSpaces Root>\Bin\Gs-Agent.exe
<GigaSpaces Root>\Bin\Gs-ui
{code}

(!) Since the spaces are running inside the {{DataProcessor}}, the {{DataProcessor}} should be deployed first and the {{DataFeeder}} second. \\ \\

# In the GigaSpaces Management Center, click on the tab named Deployments, Details, and then click the *Deploy new application* button (!GRA:Images^deploy button.jpg!).
{indent}!GRA:Images^deploy picture.jpg!{indent} \\ \\
# Now, all you need to do is type the name of the Processing Unit (identical to the name of the folder that is now in the {{deploy}} directory) in the {{Processing Unit Name}} field. Since there's an existing sla.xml with specific cluster topology, there's no need to specify the cluster topology at deploy time.
# Now in order to deploy the {{DataFeeder}} Procesing Unit, you repeat the same processes but type {{DataFeeder}} in the {{Processing Unit Name}} field. There is no need to select a {{Cluster Schema}} or {{Number Of Instances}}, since the feeder connects to the cluster and doesn't create spaces. However, you can deploy more than one {{DataFeeder}} by changing the {{Number Of Instances}} field. \\ \\
# Now look at the deployed processing units view and see the events firing.

Another way to deploy the processing units will be to use GigaSpaces Command Line Interface, in this case we do not require using GigaSpaces Management Center, we deploy it in the following manner:

{code}
<GigaSpaces Root>\Bin\Gs-Cli.exe deploy DataProcessor
<GigaSpaces Root>\Bin\Gs-Cli.exe deploy DataFeeder
{code}

h3. Application Domain (AppDomain)
Each processing unit instance is deployed in a seperate isolated AppDomain with in the Grid Service Container, therefore they do not affect each other and once undeployed all the related libraries are being unloaded as well.

Once the processing units are deployed, they will appear in the managament center and the different components can be monitored:

!GRA:Images^deployed dataexample.jpg!

{anchor:ide}
h2. IDE Integrated Deployment

One option is to run the processing unit within the IDE, which should be used for debug purposes only since it is not deployed and managed by the service grid. The example contains one project named PUDebugExecuter, that shows how to start the processing unit projects within the IDE. It uses a class named {{ProcessingUnitContainerHost}} to host the processing unit container and manage its life cycle, it does so in the following manner:

{code:java}
ProcessingUnitContainerHost processorContainerHost = new ProcessingUnitContainerHost(@"..\Processor\Deployment\DataProcessor", null, null);
ProcessingUnitContainerHost feederContainerHost = new ProcessingUnitContainerHost(@"..\Feeder\Deployment\DataFeeder", null, null);

[..]
feederContainerHost.Dispose();
processorContainerHost.Dispose();
{code}

This will host the two processing units, processor and feeder, which reside in the specified deployment directory.
When the host is created the hosted processing units are immidiatly created and initialized, once the host is disposed it will dispose of the hosted processing unit container.

{anchor:standalone}
h2. Standalone Process Deployment

One option is to run a standalone process which will host the Processing Unit container. Like above, this should be used for debug purposes only since it is not deployed and managed by the service grid. This is done simply by calling the following commands from your {{<GigaSpaces Root>\Bin}} directory:

The following deploys the data processor:
{code}
PuInstance ..\Examples\ProcessingUnit\Processor\Deployment\DataProcessor
{code}
The following deploys the data feeder:
{code}
PuInstance ..\Examples\ProcessingUnit\Feeder\Deployment\DataFeeder
{code}

Each command creates the standalone process and hosts the {{DataProcessor}} or {{DataFeeder}} Processing Units.