---
layout: post97adm
title:  Main View
categories: XAP97ADM
parent: gigaspaces-management-center.html
weight: 50
---


{% note title=Using the XAP Management Center in production and large-scale environments %}

- It is highly recommended to run the XAP Management Center on the **same network subnet** as the Data-Grid and other GigaSpaces runtime components are running. Since the Management Center communicates with the Data-Grid,GSCs, GSM, GSA and Lookup-Service continuously, it should have fast connectivity with these components. High latency connectivity will impact the responsiveness of the  Management Center and its initial bootstrap time. In production environments you should use remote desktop products such as [VNC](http://www.realvnc.com/products/free/4.1/index.html) or [No Machine](http://www.nomachine.com), run the  Management Center at the **same** network subnet as the Data-Grid and the other XAP runtime components and run the VNC or NX client side to access the remote machines desktop from the administrator machine desktop.
- With relatively large amount of GSCs , Services or Data-Grid partitions (over 20 units) it is recommended to increase the heap size of the XAP Management Center to 1G (-Xmx1g).
{% endnote %}



{% include /COM/about-gigaspaces-management-center.markdown %}


# Space Browser tab

{% include /COM/about-using-space-browser-tab---gigaspaces-management-center.markdown %}


