---
layout: post
title:  Class Annotations
categories: XAP97
parent: pojo-metadata.html
weight: 100
---

{% summary %}This section deals with the class level annotations.{% endsummary %}



# Persistence

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `persist` | boolean | When a space is defined as persistent, a `true` value for this annotation persists objects of this type.  | `true` |

{% refer %}For more details, refer to the [Persistency](./persistency.html) section.{% endrefer %}

# Include properties

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `includeProperties` | String | `IncludeProperties.IMPLICIT` takes into account all POJO fields -- even if a `get` method is not declared with a `@SpaceProperty` annotation, it is taken into account as a space field.{% wbr %}`IncludeProperties.EXPLICIT` takes into account only the `get` methods which are declared with a `@SpaceProperty` annotation. | `IMPLICIT` |


# FIFO support

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `fifoSupport` | enum of `FifoSupport` | To enable FIFO operations, set this attribute to `FifoSupport.OPERATION`.  | `FifoSupport.NOT_SET` |

{% refer %}For more details, refer to the [FIFO operations](./fifo-support.html) section.{% endrefer %}

# Include Properties

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `includeProperties` | String | `IncludeProperties.IMPLICIT` takes into account all POJO fields -- even if a `get` method is not declared with a `@SpaceProperty` annotation, it is taken into account as a space field.{% wbr %}`IncludeProperties.EXPLICIT` takes into account only the `get` methods which are declared with a `@SpaceProperty` annotation. | `IMPLICIT` |

# Inherit Indexes

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `inheritIndexes` | `boolean` | Whether to use the class indexes list only, or to also include the superclass' indexes. {% wbr %}If the class does not define indexes, superclass indexes are used. {% wbr %}Options:{% wbr %}- `false` -- class indexes only.{% wbr %}- `true` -- class indexes and superclass indexes. | `true` |


# Storage Type

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `storageType` | enum of `StorageType` | To determine a default storage type for each non primitive property for which a (field level) storage type was not defined.{% wbr %} | `StorageType.OBJECT` |


{% refer %}For more details, refer to the [Storage Types - Controlling Serialization](./storage-types---controlling-serialization.html) section.{% endrefer %}

# Replication

{: .table .table-bordered}
| Annotation Element Name | Type | Description | Default Value |
|:------------------------|:-----|:------------|:--------------|
| `replicate` | boolean | When running in a partial replication mode, a **`false`** value for this property will not replicates all objects from this class type to the replica space or backup space.}  | `true` |

To control replication at the object level you should specify a [replication filter](./cluster-replication-filters.html)
