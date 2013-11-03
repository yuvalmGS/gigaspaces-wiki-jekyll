---
layout: xap97net
title:  SpaceFilterConfig Class
categories: XAP97NET
page_id: 63799362
---

{edit-subjects}

# SpaceFilterConfig

The `SpaceFilterConfig` is used to start a space integrated with a space filter.

||Name||Description||
| `Name` | The name of the space filter. |
| `IsActiveWhenBackup` | States if this filter is active when the space is in backup mode. |
| `IsSecurityFilter` | States if this filter is a security filter. |
| `ShutdownSpaceOnInitFailure` | States if the space should shutdown on filter init failure. |
| `Priority` | The filter's [priority](#priority). |
| `FilterOperations` | The list of [operations](#priority) to be filtered. |
| `CustomProperties` | List of properties to be passed to the filter on initialization. |
| `Enabled` | Is this filter enabled. |
| `Filter` | The filter itself (an instance implementing ISpaceFilter). |

A filter is integrated into a space upon creation of that space, and each space filter that integrates with a space needs a `SpaceFilterConfig` instance that defines it.

The following code starts an embedded space, with a space filter that implements `ISpaceFilter`:


{% highlight java %}
SpaceFilterConfig mySpaceFilterConfig = new SpaceFilterConfig();
mySpaceFilterConfig.FilterOperations = new List<FilterOperations>(new FilterOperation[]{ FilterOperation.BeforeWrite });
mySpaceFilterConfig.Filter = new MySpaceFilter();

SpaceConfig spaceConfig = new SpaceConfig();
spaceConfig.SpaceFiltersConfig = new List<SpaceFilterConfig>();
spaceConfig.SpaceFiltersConfig.Add(mySpaceFilterConfig);

ISpaceProxy embeddedSpace = GigaSpacesFactory.FindSpace("/./mySpace", spaceConfig);
{% endhighlight %}


{% anchor priority %}

## FilterOperation and its Relevance to Priority

Filters are grouped by priorities, and activated by a specific operation.

Filters with higher priorities are activated closer to the hook point. This means that:

- Before filters (filters with lower priorities), will be activated first.
- After filters (filters with higher priorities), will be activated first.

For example, if two filters are activated at BeforeWrite and AfterWrite operation, the filter with the higher priority is activated last at the BeforeWrite operation, and first at the AfterWrite operation. Doing that keeps this filter activation closer to the actual space operation, hence, closer to the hook point.
