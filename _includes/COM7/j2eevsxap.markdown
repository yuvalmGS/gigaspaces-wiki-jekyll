# J2EE vs. XAP

Here is a simple mapping between the J2EE common components and equivalent XAP components:

|Component|J2EE|XAP|
|:--------|:---|:--|
|Persistency|JPA|[Hibernate](http://wiki.gigaspaces.com/wiki/display/XAP8/Hibernate+External+Data+Source), [JPA](http://wiki.gigaspaces.com/wiki/display/XAP8/JPA+Support)|
|Messaging|JMS,MDB|[JMS](http://wiki.gigaspaces.com/wiki/display/XAP8/JMS+API+Support), [Polling Container](http://wiki.gigaspaces.com/wiki/display/XAP8/Polling+Container), [XAP8:Notify Container] , [Native Messaging API](http://wiki.gigaspaces.com/wiki/display/XAP8/Session+Based+Messaging+API), MDB {% star %} |
|Security|JAAS, SSL|[Spring Security](http://wiki.gigaspaces.com/wiki/display/XAP8/Spring+Security+Bridge), [SSL](http://wiki.gigaspaces.com/wiki/display/XAP8/Securing+the+Transport+Layer+%28using+SSL%29)|
|Web Session Management|HttpSession|[HttpSession (via Jetty)](http://wiki.gigaspaces.com/wiki/display/XAP8/HTTP+Session+Management)|
|Transaction Management|JTA|[Spring Transaction via Jini Transaction Manager](http://wiki.gigaspaces.com/wiki/display/XAP8/Transaction+Management)|
|Data Access|JDBC , Session Bean (Stateless or Stateful), Entity Bean|[JDBC](http://wiki.gigaspaces.com/wiki/display/XAP8/JDBC+Driver), [Space](http://wiki.gigaspaces.com/wiki/display/XAP8/The+GigaSpace+Interface), [JPA](http://wiki.gigaspaces.com/wiki/display/XAP8/JPA+Support) , Session Bean(Stateless or Stateful) {% star %}, Entity Bean {% star %}|
|Remoting|EJB, IIOP, RMI|[Spring remoting over LRMI](http://wiki.gigaspaces.com/wiki/display/XAP8/Executor+Based+Remoting) , EJB {% star %}|
|Web|Servlet, JSP |[Servlet, JSP (via Jetty)|XAP8:Web Processing Unit Container]|
|Packaging and deployment|EAR , war|[jar](http://wiki.gigaspaces.com/wiki/display/XAP8/The+Processing+Unit+Structure+and+Configuration), [war](http://wiki.gigaspaces.com/wiki/display/XAP8/Web+Processing+Unit+Container) , EAR {% star %}|
|Contexts and Dependency Injection|JSR 299|Spring IOC|
|System Management|JMX|[JMX](http://wiki.gigaspaces.com/wiki/display/XAP8/SNMP+Connectivity+via+Alert+Logging+Gateway) , [SNMP](http://wiki.gigaspaces.com/wiki/display/XAP8/SNMP+Connectivity+via+Alert+Logging+Gateway), [Native Admin API](http://wiki.gigaspaces.com/wiki/display/XAP8/Administration+and+Monitoring+API)|
|Java Naming and Directory Service|JNDI|[Jini Lookup Service](http://wiki.gigaspaces.com/wiki/display/XAP8/About+Jini)|

-  {% star %} Available via [EasyBeans](http://www.easybeans.net/xwiki/bin/view/Main/WebHome), [openejb](http://openejb.apache.org), [embedded jboss](http://docs.jboss.org/ejb3/embedded/embedded.html) or [embedded-glassfish](http://embedded-glassfish.java.net).

## Messaging Concepts & Patterns

|Functionality|J2EE|XAP|
|:------------|:---|:--|
|Queue|JMS Queue|[Polling Container](http://wiki.gigaspaces.com/wiki/display/XAP8/Polling+Container)|
|Topic|JMS Topic|[Notify Container](http://wiki.gigaspaces.com/wiki/display/XAP8/Notify+Container)|
|Unit of Order|JMS UOO|[XAP Unit Of Work](http://wiki.gigaspaces.com/wiki/display/SBP/Unit+Of+Work)|
|Queue Partitioning|JMS Service Activator Aggregator Strategy|[XAP Parallel Queue](http://wiki.gigaspaces.com/wiki/display/SBP/Parallel+Queue+Pattern)|
|Distributed Priority Queue|JMS Quality of Service|[XAP Priority Based Queue](http://wiki.gigaspaces.com/wiki/display/SBP/Priority+Based+Queue)|
|Compute Grid|MDB + Custom code|[XAP Master-Worker](http://wiki.gigaspaces.com/wiki/display/SBP/Master-Worker+Pattern)|
