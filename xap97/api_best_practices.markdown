---
layout: post
title:  API Best Practices
categories: XAP97
weight: 200
parent: none
---

{%wbr%}

{%section%}

{%column width=90% %}
This guide contains the API guidelines that should be followed when using XAP to achieve best performance and avoid common mistakes
{%endcolumn%}
{%endsection%}


<hr/>

- Always define an id property
- Always define a routing property.
- Define an index on the properties you need to query. (this one is tricky, cause we don't want them to define indexes on every property)
- Don't change nested properties on embedded space
- Don't use externalizable unless you really know what you're doing 

<hr/>

