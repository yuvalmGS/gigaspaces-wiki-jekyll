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
latest_maven_version: "9.7.0-10496-RELEASE"
latest_build_filename: "gigaspaces-xap-premium-9.7.0-ga-b10496.zip"
latest_msi_filename: "GigaSpaces-XAP.NET-Premium-9.7.0.10496-GA-x64.msi"
latest_gshome_dirname: "gigaspaces-xap-premium-9.7.0-ga"
latest_gshome_net_dirname: "XAP.NET 9.7.0 x86"
latest_default_lookup_group: "gigaspaces-9.7.0-XAPPremium-ga"
latest_java_url: "/xap97"
latest_net_url: "/xap97net"
{%endhighlight%}



