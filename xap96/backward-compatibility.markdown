---
layout: xap96
title:  Backward Compatibility
page_id: 61867265
---

{% summary %}Backward compatibility, rolling upgrades and coexistence of GigaSpaces versions.{% endsummary %}

# Backward Compatibility in GigaSpaces

GigaSpaces 9.6 is a minor release which includes [new features and improvements](http://wiki.gigaspaces.com/wiki/display/RN/What%27s+New+in+GigaSpaces+9.6.X), including the Change API, Custom Eviction Policy and more.

We try to maintain backward compatibility wherever possible. However, in some cases, no backward compatibility is provided.

{% exclamation %} As a best practice, when upgrading to GigaSpaces 9.6, unzip the latest version of GigaSpaces 9.6 and port the necessary changes from your pre-9.6 environment into your new 9.6 environment. It is recommended to use the GigaSpaces 9.6 distribution as-is. Please refer to the {% refer %} **[Upgrade Guide](http://wiki.gigaspaces.com/wiki/display/RN/Upgrading+to+9.6.X)** {% endrefer %} for more details.

{% exclamation %} The following elements affect backward compatibility:

- GigaSpaces API and Configuration
- GigaSpaces XAP binary compatibility (including GigaSpaces management tools)
- Client-Server
- Server-Server

**Notes:**

- {% infosign %} Please refer to the {% refer %} **[public GigaSpaces' product deprecation and End-of-Life (EOL) policy](http://www.gigaspaces.com/EOL)** {% endrefer %} for more details.
- Disclaimer - A patch or minor release might demand a compatibility break in extreme cases. If it is required, this will be made very clear in the the release notes.

The below table describes backwards compatibility support in XAP 9.6:

{: .table .table-bordered}
| Deliverable | GigaSpaces API/Configuration | GigaSpaces XAP Binaries | Client-Server | Server-Server |
|:------------|:-----------------------------|:------------------------|:--------------|:--------------|
| **Patch** | YES | YES | YES | YES |
| **Service Pack** (9.6.1, ...) | YES | YES | YES | YES |
| **Major Version** (8.0, 9.0 ...) | YES(see note on deprecation policy below) | YES | YES | NO |

# Mixing GigaSpaces Versions

{% exclamation %} The following is supported:

- Applications built using 8.0.x or 9.0.x run without any code changes on a clean 9.6 installation.
- Mixing clients and Space servers from different GigaSpaces Major Releases:Clients running on 8.0 or 9.0 can run against 9.6 servers. 8.0, 9.0 servers cannot be part of the same cluster with 9.6 servers.

# Deprecated Functionality

Please refer to [this page](http://wiki.gigaspaces.com/wiki/display/RN/GigaSpaces+9.6.X+API+Changes+and+Deprecation) for details.
