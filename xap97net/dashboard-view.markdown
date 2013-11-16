---
layout: post
title:  Dashboard View
categories: XAP97NET
---

{% compositionsetup %}
{% summary %}Main Dashboard navigation view{% endsummary %}

# Using the Web Dashboard

The main dashboard screen appears immediately after logging into the management console. The dashboard gives you a single click view of the entire cluster, including alerts on various problematic conditions.

![dashboard803.png](/attachment_files/xap97net/dashboard803.png)

# Alerts panel

The Alerts panel displays XAP Alert groups (Alerts are grouped by correlation key) for more details see [Administrative Alerts](http://www.gigaspaces.com/wiki/display/XAP9/Administrative+Alerts)

![dashboard_explained.png](/attachment_files/xap97net/dashboard_explained.png)

# Events time-line panel

Click the _Events_ tag to view the bottom panel of the web dashboard, to view the events time line.
The events time-line shows the deployment life cycle of all the processing units.
To filter by application, the events time line is also available in the Application tab. (see [Application View#Events time-line (per application)](./application-view.html#Events time-line (per application)))

### Life-cycle success events for each instance:

- installation attempt: an attempt to provide a processing unit instance on an available GSC
- instance added: a processing unit instance has successfully been instantiated on a GSC
- instance uninstalled: a processing unit instance has been successfully removed
- Container N/A: a processing unit instance is pending instantiation until an available GSC is discovered

### Life-cycle success events for processing unit:

- installation succeeded: deployment of processing unit has been completed successfully (all instances instantiated)
- installation uninstalled: undeployment of processing unit has been completed (all instances undeployed)

### Life-cycle failure events for each instance:

- installation failed: processing unit instance has failed to instantiate
- installation unresponsive: processing unit instance is unresponsive to "member-is-alive" attempts (suspecting failure)
- installation crashed: processing unit instance unresponsiveness has timed-out (detected failure)
- installation re-detected: processing unit instance was previously unresponsive but is now responsive.

![events_timeline_in_dashboard.png](/attachment_files/xap97net/events_timeline_in_dashboard.png)

Click each event to get a tooltip with more information.

![timeline_event_tool_tip.png](/attachment_files/xap97net/timeline_event_tool_tip.png)
