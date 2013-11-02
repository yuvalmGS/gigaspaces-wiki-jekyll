---
layout: sbp
title:  .NET Benchmark Example
categories: XAP97NET
page_id: 63799403
---

{% compositionsetup %}

{% summary %}The Benchmark Example measures the performance of several GigaSpaces .Net API operations.{% endsummary %}

{% section %}

{% column width=7% %}


{% endcolumn %}


{% column width=86% %}

{% align center %}||depanimagewiki_icon_folder.giftengahimage/attachment_files/sbp/wiki_icon_folder.gifbelakangimage||Example Root|`<GigaSpaces Root>\Examples\Benchmark` |
{% endalign %}

{% endcolumn %}


{% column width=7% %}


{% endcolumn %}

{% endsection %}

# Overview

The Benchmark Example is used to measure simple space operation throughput.

You can customize the example and run a benchmark on customized scenarios and objects.

There are two options for using the benchmark:

**1. Out-of-the-box benchmark.**

Use the Benchmark Example and customize the Benchmark run:
- by changing the space-url to connect to the space topology that you want to check.
- by configuring the input xml file and changing configuration parameters.

For more information please read depanlinkXAP66:Out-of-the-box benchmarktengahlink#1belakanglink

**2. Develop a custom benchmark with your own code for the benchmark scenario and the benchmark object.**

You can create your own benchmark by using the Benchmark Framework:
- extending the framework's BenchmarkStandard abstact class.
- using the framework's interfaces: IBenchmarkContainer, IBenchmarkObjectAdapter.

For more information please read depanlinkXAP66:Develop a custom benchmarktengahlink#2belakanglink

The structure of the depanlinkXAP66:configuration xml filetengahlink#Example configuration filebelakanglink is the same for the two benchmark options.

{% anchor 1 %}

# Option 1: Out-of-the-box Benchmark

The syntax of the command line for running the out-of-the-box benchmark is as follows:


{% highlight java %}
..\..\lib\GigaSpaces.Core.Benchmarks.Launcher.exe {space-url}  {Input xml} {Results xml}
{% endhighlight %}

**space-url** - The url for finding the Space. You can control the Space topology by changing the space-url parameter.
Examples:
Embedded:


{% highlight java %}
"/./benchmarkSpace?NoWriteLease=true&schema=cache&groups=myGroup"
{% endhighlight %}

Remote:


{% highlight java %}
"jini://localhost/*/remoteBenchmarkSpace?NoWriteLease=true&groups=myGroup"
{% endhighlight %}

**Input xml** - Location of the xml file that contains the benchmark run configuration. The default is Xmls\BenchmarkPerson.xml.
You can control the benchmark by changing parameters in the configuration file.

The configuration file includes the following information:
-  **<assembly>** elements. Each element defines an assembly that needs to be loaded (for custom objects).
-  **<Benchmark>** elements. Each element defines a benchmark that will be included in the benchmark run.

The Benchmark elements contain the following parameters:
- **type** - Define the benchmark type name. The type structure is:


{% highlight java %}
{Benchmark type name}`2[[Object type name, Assembly name],[Adapter type name, Assembly name]], Assembly name
{% endhighlight %}


Example:


{% highlight java %}
<type>GigaSpaces.Core.Benchmarks.Implementations.Basic.ReadBenchmark`2[[GigaSpaces.Core.Benchmarks.Implementations.Basic.Objects.Person,
GigaSpaces.Core.Benchmarks.Implementations.Basic],[GigaSpaces.Core.Benchmarks.Implementations.Basic.ObjectAdapters.PersonAdapter,
GigaSpaces.Core.Benchmarks.Implementations.Basic]], GigaSpaces.Core.Benchmarks.Implementations.Basic</type>
{% endhighlight %}


- **repeats** - Number of times to repeat the benchmark
- **warmups** - Number of repeats that will count as warm-up repeats, which will not be taken into consideration when calculating the benchmark performance results
- **chunks** - The batch size of the operation. Single operations use a chunk size of 0. This is relevant to multiple benchmarks, such as writemultiple
- **executions** - Number of executions of the benchmark single operation in each repeat
- **payload** - Use this field to manually enlarge the size of the Object (in bytes)
- **txn-type** - Transaction type. (Available transaction types: None, Jini, Local)
- **show-info** - Instructs detailed info to be displayed for each repeat
- **threads** - Number of concurrent threads that will execute this benchmark
- **Results xml** - Location of benchmarks results xml file. The default is the Results directory.

{% anchor 2 %}

# Option 2: Develop a Custom Benchmark

Develop a custom benchmark with your own code for the benchmark scenario and the benchmark object.

1. Use the Benchmark Framework:
    - write space operation classes, by extending the framework's BenchmarkStandard abstact class, and using the framework's interfaces: IBenchmarkContainer, IBenchmarkObjectAdapter.
    - write your own object, or use the Person (Benchmark\Objects\Person.cs) and the PersonAdapter (Benchmark\ObjectAdapters\PersonAdapter.cs) as a template.
2. Prepare the inputs for your benchmark run:
    - Adjust the configuration parameters in the input xml file:
    - Type your object definition



{% highlight java %}
<type>GigaSpaces.Core.Benchmarks.Implementations.Basic.ReadBenchmark`2

[[GigaSpaces.Core.Benchmarks.Implementations.Basic.Objects. MyObject, GigaSpaces.Core.Benchmarks.Implementations.Basic],

[GigaSpaces.Core.Benchmarks.Implementations.Basic.ObjectAdapters. MyObjectAdapter,

 GigaSpaces.Core.Benchmarks.Implementations.Basic]], GigaSpaces.Core.Benchmarks.Implementations.Basic
</type>
{% endhighlight %}


3. For running the customized benchmark, follow the steps below in **Building and Running the Example**

# Building and Running the Example

- To build the example, execute compile.bat (You can also build GigaSpaces.Examples.Benchmarks.sln from Visual Studio).
- To run a benchmark on an embedded space, execute runEmbeddedBenchmark.bat.
- To run a benchmark on a remote space, execute runRemoteBenchmark.bat.
- The results are stored in a results folder. There are two results files: an excel file which includes a summary of the results, and an xml with more detailed results.

Both run scripts use the following pattern:


{% highlight java %}
..\..\lib\GigaSpaces.Core.Benchmarks.Launcher.exe {space-url}  {Input xml} {Results xml}
{% endhighlight %}

Example command line for running an embedded benchmark run:


{% highlight java %}
..\..\lib\GigaSpaces.Core.Benchmarks.Launcher.exe "/./benchmarkSpace?NoWriteLease=true&schema=cache&groups=myGroup"

 Xmls\BenchmarkPerson.xml Results\EmbeddedBenchmarkPersonResult.xml
{% endhighlight %}


# Example Configuration File

The **Input xml** structure is the same for the two benchmark options (the Out-of-the-box benchmark and the Customized benchmark).

{% lampon %} It is recommended that you use the `BenchmarkPerson.xml` file that is provided with the benchmark example, as a template.

Example configuration file:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<benchmarks>
  !--Defines an additional assembly that needs to be loaded, in this case the benchmark implementation assembly
  Each assembly should be defined in a new <addembly>
    element-->
    <assembly>
      <path>..\..\lib\GigaSpaces.Core.Benchmarks.Implementations.Basic.dll</path>
    </assembly>

    <!--Define one benchmark that will run, each benchmark should be defined in a new <benchmark> element-->
    <benchmark>
      <!--Define the benchmark type name, it is recommended to use Fully Qualifed names,
            The type structure is: <Benchmark type name>'2[[Object type name],[Object adapter type name]]-->
      <type>GigaSpaces.Core.Benchmarks.Implementations.Basic.ReadBenchmark`2

[[GigaSpaces.Core.Benchmarks.Implementations.Basic.Objects.Person, GigaSpaces.Core.Benchmarks.Implementations.Basic],

[GigaSpaces.Core.Benchmarks.Implementations.Basic.ObjectAdapters.PersonAdapter,

 GigaSpaces.Core.Benchmarks.Implementations.Basic]], GigaSpaces.Core.Benchmarks.Implementations.Basic</type>
      <!--Number of times to repeat the benchmark-->
      <repeats>100</repeats>
      <!--Number of repeats that will count as warm up repeats and will not be taken into consideration
          when calculating the benchmark performance results-->
      <warmups>10</warmups>
      <!--The batch size of the operation, single operation use chunk size of 0, this is relevent to multiple
          benchmarks such as writemultiple-->
      <chunks>0</chunks>
      <!--Number of execution of the benchmark single operation in each repeat-->
      <executions>1000</executions>
      <!--Use this field to manually enlarge the size of the Object (in bytes)-->
      <payload>100</payload>
      <!--Transaction type, available (None, Jini, Local)-->
      <txn-type>None</txn-type>
      <!--Should display detailed info of each repeat-->
      <show-info>true</show-info>
      <!--Number of concurrent threads that will execute this benchmark-->
      <threads>1</threads>
    </benchmark>

    </benchmark>
    ...
    </benchmark>
  ...
  </benchmarks>
{% endhighlight %}
