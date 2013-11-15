---
layout: post
title:  Moving early access version into production
page_id: 61867355
---


# Moving Early access wiki into production

1.	Modify _config.yaml

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

2.	Remove early access from main menu

