---
layout: post
title:  Service Annotations
categories: XAP97
parent: pojo-metadata.html
weight: 300
---

{% summary %}This section explains the different service  annotations.{% endsummary %}




# Notify Container

{: .table .table-bordered}
|Class Annotation    | @EventDriven @Notify|
|Method Annotation|  @EventTemplate - defines a template{%wbr%}  @SpaceDataEvent - event handler method |
|Description         | The Notify Container is the equivalent of  publish/subscribe messaging. |
|Note | @EventDriven , @Notify   can’t be placed on interface classes. You should place these on the implementation class.|
|Reference  | [Notify Container](./notify-container.html)|


{% togglecloak id=1 %}**Example**{% endtogglecloak %}
{% gcloak 1 %}
{%highlight java%}
@EventDriven @Notify
public class SimpleListener {

    @EventTemplate
    Data unprocessedData() {
        Data template = new Data();
        template.setProcessed(false);
        return template;
    }

    @SpaceDataEvent
    public Data eventListener(Data event) {
        //process Data here
    }
}
{%endhighlight%}
{% endgcloak %}


# Polling Container

{: .table .table-bordered}
|Class Annotation    | @EventDriven @Polling|
|Method Annotation|  @EventTemplate - defines a template{%wbr%}  @SpaceDataEvent - event handler method |
|Description         | The Polling Container is the equivalent of point to point messaging. |
|Note | @EventDriven , @Polling   can’t be placed on interface classes. You should place these on the implementation class.|
|Reference  | [Polling Container](./polling-container.html)|

{% togglecloak id=2 %}**Example**{% endtogglecloak %}
{% gcloak 2 %}
{%highlight java%}
@EventDriven @Polling
public class SimpleListener {

    @EventTemplate
    Data unprocessedData() {
        Data template = new Data();
        template.setProcessed(false);
        return template;
    }

    @SpaceDataEvent
    public Data eventListener(Data event) {
        //process Data here
    }
}
{%endhighlight%}
{% endgcloak %}


# Remoting

{: .table .table-bordered}
|Class Annotation    | @RemotingService|
|Description         | Spring provides support for various remoting technologies. GigaSpaces uses the same concepts to provide remoting, using the space as the underlying protocol |
|Attribute Annotation|  @ExecutorProxy  |
|Method argument     | @Routing |
|Reference  | [Space based Remoting](./space-based-remoting.html)|

{% togglecloak id=3 %}**Example**{% endtogglecloak %}
{% gcloak 3 %}
{%highlight java%}
// Service Implementation
@RemotingService
public class DataProcessor implements IDataProcessor {

    public Data processData(Data data) {
    	data.setProcessor(true);
    	return data;
    }
}

// Client remoting proxy
public class DataRemoting {

    @ExecutorProxy
    private IDataProcessor dataProcessor;

    // ...
}

// remote method with routing parameter
public interface MyService {

    void doSomething(@Routing int param1, int param2);
}
{%endhighlight%}
{% endgcloak %}