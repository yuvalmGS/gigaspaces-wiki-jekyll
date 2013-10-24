---
layout: xap96
title:  Custom Triggering of an Alert
page_id: 61867032
---

{% compositionsetup %}
{% summary %}Administrative alerts of problematic issues monitored at runtime.{% endsummary %}

{% warning %}
This page is currently restricted to R&D only
{% endwarning %}

# Custom Triggering of an Alert

The `AlertManager` provides a `void triggerAlert(Alert alert)` method for triggering of alerts. The predefined alerts use this method to trigger alerts to be delegated to registered alert event listeners.

XAP 8.0 **does not** provide building blocks for integrating your own custom alerts. These will be provided in future releases. This means that the lifecycle of your 'custom alert trigger' will not be managed by the `AlertManager` API (i.e. `configure`, `enableAlert`, `disableAlert`, etc.). As such, we don't support creation of a custom alert in the alert.xml.

However, you can still create custom code to call the `triggerAlert` method - as in the following code snippet:

##### Custom "GSC Removed Alert"

Let's define the following conditions/rules:

- Raise an alert if GSC has been removed from the lookup service
- Resolve alert if same GSC has re-registered with the lookup service

{% highlight java %}
/*
 * Register for Grid Service Container added/removed events and trigger an alert accordingly.
 */
public class CustomGscRemovedAlertTrigger implements GridServiceContainerLifecycleEventListener {

    private final Admin admin;

    public CustomGscRemovedAlertTrigger(Admin admin) {
        this.admin = admin;
    }

    public void startMe() {
        admin.getGridServiceContainers().addLifecycleListener(this);
    }

    public void stopMe() {
        admin.getGridServiceContainers().removeLifecycleListener(this);
    }

    // @see GridServiceContainerLifecycleEventListener#gridServiceContainerAdded
    public void gridServiceContainerAdded(GridServiceContainer gridServiceContainer) {

        triggerMe(gridServiceContainer, AlertStatus.RESOLVED, "Grid Service Container at host: "
                + gridServiceContainer.getMachine().getHostName() + " has been restored");

    }

    // @see GridServiceContainerLifecycleEventListener#gridServiceContainerRemoved
    public void gridServiceContainerRemoved(GridServiceContainer gridServiceContainer) {

        triggerMe(gridServiceContainer, AlertStatus.RAISED, "Grid Service Container at host: "
                + gridServiceContainer.getMachine().getHostName() + " has been removed");
    }

    private void triggerMe(GridServiceContainer gridServiceContainer, AlertStatus status, String description) {
        AlertFactory factory = new AlertFactory();

        factory.name("GSC Removed Alert");

        factory.description(description);

        factory.severity(AlertSeverity.WARNING);

        factory.status(status);

        factory.componentUid(gridServiceContainer.getUid());

        factory.groupUid(this.hashCode() + gridServiceContainer.getUid()); //unique per trigger-to-component

        // runtime properties that can be extracted
        factory.putProperty("host-name", gridServiceContainer.getMachine().getHostName());
        factory.putProperty("host-address", gridServiceContainer.getMachine().getHostAddress());

        Alert alert = factory.toAlert();
        admin.getAlertManager().triggerAlert(alert);
    }
}
{% endhighlight %}
