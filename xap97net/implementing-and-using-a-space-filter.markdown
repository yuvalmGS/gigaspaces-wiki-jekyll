---
layout: xap97net
title:  Implementing and Using a Space Filter
categories: XAP97NET
page_id: 63799349
---

{edit-subjects}

# Overview

A Space Filter is a special hook point inside the engine that enables integration with external systems, or implementation of user defined logic. There are two ways to implement such a filter and integrate it with the space, both of which are covered in this page.

- depanlinkImplementing the ISpaceFilter interfacetengahlink./ispacefilter-interface.htmlbelakanglink
- depanlinkImplementing a Space Filter using SpaceFilterOperationDelegatetengahlink./spacefilteroperationdelegate.htmlbelakanglink

{% refer %}For a full SpaceFilter implementation and usage demo, visit the **depanlinkSpace Filter Demotengahlink./space-filter-demo.htmlbelakanglink** section.{% endrefer %}

# Integrating the Space Filter with a Space

A space filter is integrated into a space upon creation of that space.

Each space filter that integrates with a space, needs a depanlinkSpaceFilterConfigtengahlink./spacefilterconfig-class.htmlbelakanglink instance that defines it.

A depanlinkSpaceFilterConfigtengahlink./spacefilterconfig-class.htmlbelakanglink can be created in two ways, depending on the implementation of the filter itself.

#### Implementing the ISpaceFilter Interface

If the filter implements the depanlinkISpaceFilter Interfacetengahlink./ispacefilter-interface.htmlbelakanglink, then a depanlinkSpaceFilterConfigtengahlink./spacefilterconfig-class.htmlbelakanglink needs to be created for it, and each operation that needs to be filtered should be added to the `FilterOperations` list, as in the following code:


{% highlight java %}
SpaceFilterConfig mySpaceFilterConfig = new SpaceFilterConfig();
mySpaceFilterConfig.FilterOperations = new List<FilterOperation>(new FilterOperation[]{ FilterOperation.BeforeWrite });
mySpaceFilterConfig.Filter = new MySpaceFilter();
{% endhighlight %}


#### Implementing a Space Filter using SpaceFilterOperationDelegate

If the filter is based on the depanlinkSpaceFilterOperationDelegatetengahlink./spacefilteroperationdelegate.htmlbelakanglink, then a depanlinkSpaceFilterConfigtengahlink./spacefilterconfig-class.htmlbelakanglink needs to be created. This is done with the appropriate `SpaceFilterConfigFactory`, either depanlinkAttributeSpaceFilterConfigFactorytengahlink./spacefilteroperationdelegate.html#Attribute based implementationbelakanglink, or depanlinkMethodNameSpaceFilterConfigFactorytengahlink./spacefilteroperationdelegate.html#Method name based implementationbelakanglink, using the `CreateSpaceFilterConfig()` method.

Once a depanlinkSpaceFilterConfigtengahlink./spacefilterconfig-class.htmlbelakanglink is created, it needs to be used when starting the space.


{% highlight java %}
spaceConfig.SpaceFiltersConfig = new List<SpaceFilterConfig>();
spaceConfig.Add(mySpaceFilterConfig);

ISpaceProxy embeddedSpace = GigaSpacesFactory.FindSpace("/./mySpace", spaceConfig);
{% endhighlight %}


{% lampon %} A space can have multiple space filters integrated in it. Simply create a depanlinkSpaceFilterConfigtengahlink./spacefilterconfig-class.htmlbelakanglink instance per filter, and add it to the `SpaceFiltersConfig` list.
