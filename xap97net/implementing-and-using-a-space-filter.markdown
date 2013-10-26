---
layout: xap97net
title:  Implementing and Using a Space Filter
categories: XAP97NET
page_id: 63799349
---

{edit-subjects}

h1. Overview

A Space Filter is a special hook point inside the engine that enables integration with external systems, or implementation of user defined logic. There are two ways to implement such a filter and integrate it with the space, both of which are covered in this page.

- [Implementing the ISpaceFilter interface|ISpaceFilter Interface]
- [Implementing a Space Filter using SpaceFilterOperationDelegate|SpaceFilterOperationDelegate]

{refer}For a full SpaceFilter implementation and usage demo, visit the *[Space Filter Demo]* section.{refer}

h1. Integrating the Space Filter with a Space

A space filter is integrated into a space upon creation of that space.

Each space filter that integrates with a space, needs a [SpaceFilterConfig|SpaceFilterConfig Class] instance that defines it.

A [SpaceFilterConfig|SpaceFilterConfig Class] can be created in two ways, depending on the implementation of the filter itself.

h4. Implementing the ISpaceFilter Interface
If the filter implements the [ISpaceFilter Interface|ISpaceFilter Interface], then a [SpaceFilterConfig|SpaceFilterConfig Class] needs to be created for it, and each operation that needs to be filtered should be added to the {{FilterOperations}} list, as in the following code:

{code:java}
SpaceFilterConfig mySpaceFilterConfig = new SpaceFilterConfig();
mySpaceFilterConfig.FilterOperations = new List<FilterOperation>(new FilterOperation[]{ FilterOperation.BeforeWrite });
mySpaceFilterConfig.Filter = new MySpaceFilter();
{code}

h4. Implementing a Space Filter using SpaceFilterOperationDelegate
If the filter is based on the [SpaceFilterOperationDelegate|SpaceFilterOperationDelegate], then a [SpaceFilterConfig|SpaceFilterConfig Class] needs to be created. This is done with the appropriate {{SpaceFilterConfigFactory}}, either [AttributeSpaceFilterConfigFactory|SpaceFilterOperationDelegate#Attribute based implementation], or [MethodNameSpaceFilterConfigFactory|SpaceFilterOperationDelegate#Method name based implementation], using the {{CreateSpaceFilterConfig()}} method.

Once a [SpaceFilterConfig|SpaceFilterConfig Class] is created, it needs to be used when starting the space.

{code:java}
spaceConfig.SpaceFiltersConfig = new List<SpaceFilterConfig>();
spaceConfig.Add(mySpaceFilterConfig);

ISpaceProxy embeddedSpace = GigaSpacesFactory.FindSpace("/./mySpace", spaceConfig);
{code}

(on) A space can have multiple space filters integrated in it. Simply create a [SpaceFilterConfig|SpaceFilterConfig Class] instance per filter, and add it to the {{SpaceFiltersConfig}} list.
