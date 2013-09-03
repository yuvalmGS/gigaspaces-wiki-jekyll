---
layout: post
title:  Pending Notify Templates Information
categories: XAP96
page_id: 61867086
---

{% summary page|60 %}Information regarding pending notify templates{% endsummary %}

# Overview

You may view the information regarding pending notify templates. The following information is exposed:

- Number of pending templates in whole space
- Number of pending templates in space per class
- FIFO indication
- Expiration date
- If the notification is blocked on a specific UID, the UID is shown

In the Classes view, you can click a specific class to view all the pending notify templates that are registered. You can investigate the template values by opening the [Object Inspector](/xap96/2011/04/12/object-inspector.html).

{% indent %}
![Pending Notify Templates Information.gif](/attachment_files/Pending Notify Templates Information.gif)
{% endindent %}

- The information displayed is regards pending notify templates only. Other template types are not supported.
