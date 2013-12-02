---
layout: post
title:  Moving into Production
parent: none
weight: 400
categories: HOWTO
---


To make a current early access release the official GA release, you should perform the following steps: 

### Modify `_config.yaml`

{%highlight xml%}
latest_xap_release: "9.7"
latest_xap_version: "9.7.0"
latest_maven_version: "9.6.2-9900-RELEASE"
latest_build_filename: "gigaspaces-xap-premium-9.6.2-ga-b9900.zip"
latest_gshome_dirname: "gigaspaces-xap-premium-9.7.0-ga"
latest_default_lookup_group: "gigaspaces-9.7.0-XAPPremium-ga"
latest_java_url: "/xap97"
latest_net_url: "/xap97net"
{%endhighlight%}



