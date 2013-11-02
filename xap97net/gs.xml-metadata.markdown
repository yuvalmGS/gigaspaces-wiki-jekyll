---
layout: xap97net
title:  GS.XML Metadata
categories: XAP97NET
page_id: 63799396
---

{% summary page|65 %}This page explains how to use GS.XML to define space objects metadata.{% endsummary %}

# Overview

This page describes the usage of GS.XML to define space objects metadata.
GS.XML is an XML file that contains the space type's metadata definitions. The metadata definitions available using the XML are equivalent to attribute-based space metadata functionality. The main advantage of using the GS.XML file for the space metadata definitions, is that the data model remains unchanged when used in the space. Data objects can have independent space metadata definitions that have no impact on the objects' code.

{% refer %}For more info about space metadata definitions, refer to [Object Metadata]{% endrefer %}

# GS.XML File Naming and Location

All GS.XML files (`\*.gs.xml`) should be located in the execution directory.
All files have to use the .GS.XML extension.
A single file name can contain one or more type definitions.
The files can be named as follows:
1) File name = the type fully qualified name. Example: type name: MyPackage.MyType, GS.XML file: MyPackage.MyType.GS.XML
2) File name = class name only. Example: type name: MyPackage.MyType, GS.XML file: MyType.GS.XML
3) Any other file name with .GS.XML extension -- this option is the last to be searched and naturally works a bit slower.

## GS.XML Schema Definitions

Schema definitions for the .NET GS.XML can be found in two locations
1)	Web: http://www.gigaspaces.com/dtd/6_5/gigaspaces-metadata-net.dtd
2)	Local: under <install Dir>\ Bin\gigaspaces-metadata-net.dtd

# GS.XML Example

See blow an example of `Car` class's space metadata definitions in GS.XML

{% highlight java %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE gigaspaces-mapping SYSTEM "..\..\..\Bin\gigaspaces-metadata-net.dtd">
<gigaspaces-mapping>
  <class name="GigaSpaces.Examples.SpaceOperations.Entities.Car" persist="true" fifo="true" replicate="true" >
    <id name="CarId" />
    <routing name="CarType"/>
    <property name="CarId" null-value="-1" />
    <property name="Make" index="basic" />
    <property name="ManufacturingDate" null-value="1900-01-01T12:00:00" index="basic/>
    <exclude name="MaintenanceBook" />
    <version name="VersionProperty" />
  </class>
</gigaspaces-mapping>
{% endhighlight %}


# XML Elements

### Class Level Elements

- `**<class>**` -- a `class` element encapsulates metadata information of a concrete class. The below table shows the available attributes for the Class element.
|| Attribute || Description ||
| `name` | (Required) Contains the full qualified name of the specified class. There can only be one `class` element defined per class. |
| `persist` | This property indicates the persistency mode of the object. When a space is defined as persistent, a `true` value for this property persists objects of this type. {% refer %}For more details, refer to the [.NET Persistency] section. {% endrefer %} |
| `fifo` | Indicates whether the POJO should be saved in FIFO order in the space. To enable FIFO-based notifications and take operations, this annotation should be `true`. {% refer %}For more details, refer to the [FIFO operations|FIFO Support] section.{% endrefer %} |
| `replicate` | Valid only in cluster toplogies that have replication defined. In this case, it specifies whether each class should be replicated or not |
| `include-properties` |Gives the ability to expose or hide properties from the space (default is public).
For more details, see: [Object Metadata|Object Metadata#Including/Excluding Content from the Space] |
| `include-fields` |Gives the ability to expose or hide fields from the space (default is public) {% refer %}For more details, see: [Object Metadata|Object Metadata#Including/Excluding Content from the Space]{% endrefer %} |
| `alias-name` |Gives the ability to map a .NET class name (including namespace) to a space class name |

### Field Level Elements

- `**<property>**` - contains metadata information for a class's field.
|| Attribute || Description ||
| `name` | (Required) Maps to the relevant class's field name. |
| `index` | Indicates if the field is indexed in the space. |
| `null-value` | Represents a `null` value for the current field. Applicable mainly for primitive type fields that does not have explicit null vallue. |
| `alias-name` | Defines the name the field will have when stored to the space. |
| `storage-type` | Defines the storage format the field will have once stored to the space. See [this|Property Storage Type] page for details|


{% highlight java %}
<class name="GigaSpaces.Examples.SpaceOperations.Entities.Person" persist="false" replicate="false" fifo="false" >
	<property name="Int_Field" null-value="-1" alias-name="int_Field" />
	<property name="DateTime_Field" null-value="00:00:00.0000000, January 1, 0001" alias-name="dateTime_Field"/>
	<property name="Address" alias-name="address" storage-type="Object" />
</class>
{% endhighlight %}


- `**<id>**` - Defines whether this field can used as the objects unique identifier. The value is used when generating the object UID in the space.
|| Attribute || Description ||
| `name` | (Required) Maps to the relevant class's field name. |
| `auto-generate` | Specifies if the object UID is generated automatically by the space when written into the space. If `false`, the UID will be generated using the field value, and if `true`, the field should be left null and the auto generated UID will be stored in it once written to the space. |

- `**<version>**` - Uses for optimistic concurrency, as the field that contains the objects version in the space. This must be an `int` data type field.
|| Attribute || Description ||
| `name` | (Required) Maps to the relevant class's field name. |

- `**<routing>**` - Defines the field the will be used by the load balancing mechanism to calculate the routing track.
|| Attribute || Description ||
| `name` | (Required) Maps to the relevant class's field name. |

- `**<exclude>**` - A filed marked as Exclude will not be stored into the space.
|| Attribute || Description ||
| `name` | (Required) Maps to the relevant class's field name. |
