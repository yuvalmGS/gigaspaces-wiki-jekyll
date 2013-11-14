---
layout: xap97net
title:  Modeling your Data
categories: XAP97NET
---

{% summary %}How to model application data for in-memory data grid{% endsummary %}

# Moving from Centralized to Distributed Data Model

When moving from a centralized to a distributed data store, your data must be partitioned across multiple nodes (partitions). Implementing the partitioning mechanism technically is not a hard task; however, planning the distribution of your data for scalability and performance, requires some thinking.

### Planning for Data Partitioning

Two issues should be taken into consideration when planning the data partitioning:

- **What information is stored in memory?**

When planning the partitioning and how much memory to allocate for the application, the important factors to consider are how much the data is expected to grow over time, and how long the data is expected to available for. Estimated data storage needs should not be confused with the data structure, which is considered separately.

Use the following table to successfully predict the memory necessary to support your application:

{: .table .table-bordered}
|Data item|Estimated Quantity|Expected Growth|Estimated Object Size|
|Data Type A|100K|10%|2K|
|Data Type B|200K|20%|4K|

- **What are my application's use cases?**

While you might be used to modeling your data on the logical relationship of your data items, a different approach should be adopted in the case of distributed data. The key is to avoid cross cluster relationships as much as possible. Cross cluster relationships lead to cross cluster queries and updates which are usually much less scalable and run slower than their local counterparts.

Thinking in terms of traditional relationships ("one to one", "one to many" and "many to many"), is deceiving with distributed data. Instead, you must consider how many different associations each entity has.

If an entity is associated with several containers (parent entities), it can't be embedded within the containing entity. It might be also impossible to store it with all of its containers on the same partition.

In the [Pet Clinic application](http://www.openspaces.org/display/DAE/GigaSpaces+PetClinic), a Pet is only associated with an Owner. We can therefore store each Pet with its owner on the same partition. We can even embed the Pet object within the physical Owner entry.
![petclinic_class_model.gif](/attachment_files/xap97net/petclinic_class_model.gif)

However, if a Pet were also associated with a Vet, we could not embed the Pet in the Vet physical entry (without duplicating each Pet entry) and could not store the Pet and the pet's Vet in the same partition.

# What are Embedded and Non Embedded Relationships?

**Embedded Relationships** mean that one object physically contains the associated objects and there is a **strong** lifecycle dependency between them. When the containing object is deleted, so are all of  its contained objects. With this type of object association, you ensure there is always a local transaction, since the entire object graph is stored in the same entry within the Space.

![model_embed.jpg](/attachment_files/xap97net/model_embed.jpg)

### Data Access for Embedded Relationships

Embedded Object Query: The `info` property is an object within the `Person` class:

{% highlight java %}
SqlQuery<Person> query = new SqlQuery<Person>
	("info.socialSecurity < ? and info.socialSecurity >= ?");
{% endhighlight %}

Embedded Map Query: The `info` property is a Map within the `Person` class:

{% highlight java %}
SqlQuery<Person> query =
new SqlQuery<Person>("info.salary < 15000 and info.salary >= 8000");
{% endhighlight %}

Embedded Collection Query: The `employees` property is a collection within the `Company` class:

{% highlight java %}
SqlQuery<Company> query =
	new SqlQuery<Company>
	("employees[**].children[**].name = 'Junior Doe');
{% endhighlight %}

See the [SqlQuery](./sqlquery.html) section for details about embedded entities query and indexing.

**Non Embedded Relationships** means that one object is associated with a number of other objects, so you can navigate from one object to another. However, there is no life cycle dependency between them, so if you delete the referencing object, you don't automatically delete the referenced object(s). The association is therefore manifested in storing IDs rather than storing the actual associated object itself. This type of relationship means that you don't duplicate data but you are more likely to access more than one node in the cluster when querying or updating your data.

![model_non_embed.jpg](/attachment_files/xap97net/model_non_embed.jpg)

{% tip %}
See the [Parent Child Relationship]({% currentjavaurl %}/parent-child-relationship.html) for an example for non-embedded relationships.
{% endtip %}

## Embedded vs. Non Embedded Relationships

We have already seen that embedding objects is not ideal for distributed data storage systems. Other factors to consider when choosing a relationship type are:

- Embedding means no direct access: When an entity is embedded within another entity you cannot apply CRUD operations to it directly. Instead, you need to get its root parent entity from the space via a regular query and then navigate down the object graph until you get the entity you need. This is not just a matter of convenience, it has also performance implications: whenever you want to perform CRUD operations on an embedded entity, you read the entire graph first and (if you need to also update it) you write the entire object graph back to the Space.
- When an object is embedded, the client application receives all objects when fetching the parent object. Conversely, by using non-embedded relationships, the client application is responsible for loading all connected objects within the client application code.

##  When Should Objects be Embedded?

- Embed when an entity is meaningful only with the context of its containing object. For example, in the pet clinic application, a Pet has a meaning only when it has an Owner. A Pet in itself is meaningless without an Owner in this specific application. There is no business scenario for transferring a Pet from owner to owner or admitting a Pet to a Vet without the owner.
- Embedding may sometimes mean duplicating your data. For example, if you want to reference a certain Visit from both the Pet and Vet class, you'll need to have duplicate Visit entries. So let's look into duplications:
    - Duplication means preferring scalability over footprint. The reason to duplicate is to avoid cluster wide transactions and in many cases it's the only way to partition your object in a scalable manner.
    - Duplication means higher memory consumption. While memory is considered a commodity and low cost today, duplication has a higher price to pay. You might have two space objects that contain the same data.
    - Duplication means more lenient consistency. When you add a Visit to a Pet and Vet for example, you need to update them both. You can do it in one (potentially distributed) transaction, or in two separate transactions, which will scale better but be less consistent. This may be sufficient for many types of applications (e.g. social networks), where losing a post, although undesired, does not incur significant damage. In contrast, this is not feasible for financial applications where every operation must be accounted for.
