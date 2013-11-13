---
layout: post
title:  POJO Interaction with the Space
categories: XAP96
---

#POJO Interaction with the Space

XAP has a rich interface for interacting with the space; it includes the following main operations:
•	Data Insert and Update
•	Data Query
o	Indexing space information
•	Data removal

Any POJO can be used to interact with the space as long it follows the Java Beans convention. The POJO needs to implement a default constructor, setters and getters for every property you want to store in the Space and the @SpaceId attribute annotation needs to be added to designate the unique key for each object.

[Write an object to Space ](/xap96/writing-objects-to-space.html)
