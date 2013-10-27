---
layout: xap97net
title:  Data Grid View
categories: XAP97NET
page_id: 63799321
---

{composition-setup}{summary}Cluster wide queries or single Space instance queries on your data{summary}

The Data Grid view provides Space and Space instance navigation, for querying data and viewing class metadata.
Select a "Space" or press the arrow to drill down into the Space instances of each Space (cluster).

!GRA:Images^DataGrid_SpaceInstanceSelection.png|border=1!

Navigate back to show all the Spaces, by clicking on the breadcrumb on the left.

!GRA:Images^DataGrid_SpaceSelection.png|border=1!

# Query Editor

The Query editor supports SQL queries. For example, to query a specific class:

{% highlight java %}
SELECT * FROM my.company.com.MyPojo WHERE rownum < 1000
{% endhighlight %}


In the screenshot below, we also provide the UID column of each object in the Space.

{% highlight java %}
SELECT uid,* FROM com.gigaspaces.sba.trading.model.TradePojo WHERE rownum < 7
{% endhighlight %}


Press the **"Play"** icon to execute the query. The Query is executed against the selected Space (cluster) or Space instance.
If the query has too many results, use the paging at the bottom to move between them. Paging is static, meaning that these results are fetched once per execute request.
Use the **back** and **forward** arrows to navigate between previously executed queries.

!GRA:Images^query.png|border=1!

# Space Types

The metadata of the Types in the Space are shown by clicking on the "Types" tab. This lists all the types registered with the Space.
Displayed for each type are: **instance count**, **notify template count**, **Space key** (index), **Space routing key**, and **indexed fields**.

!GRA:Images^data_types.png|border=1!

# Object inspection

Double click on a single result set in the query results table, to show the metadata and values of each result.
Object inspection shows the **field name**, **field type**, and **field value**. For compound fields, drill down using the arrow toggles.
For array types, the array length and toString is displayed.

!GRA:Images^object_inspector_from_query_results.png|border=1!

