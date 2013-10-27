---
layout: post
title:  Writing Objects to Space
page_id: 63079280
---

{% compositionsetup %}
{% summary page|60 %}This page explains how to write an objects to the space{% endsummary %}

# Writing Objects to the Space

{% section %}
{% column %}
![POJO_write.jpg](/attachment_files/POJO_write.jpg)
{% endcolumn %}

{% column %}
In order to write an object into the Space, the write method of the OpenSpaces interface is used. The default write method writes the object to the space if it does not exist. If the object already exists, meaning an object with the same id already exists in space, it will update the existing object.
{% endcolumn %}
{% endsection %}

### Write API

{% highlight java %}
<T> LeaseContext<T> write(T entry,
                          long lease,
                          long timeout,
                          WriteModifiers modifiers)
                      throws DataAccessException
{% endhighlight %}

### Default:

{% highlight java %}
 <T> LeaseContext<T> write(T entry) throws DataAccessException
{% endhighlight %}

### Parameters:

entry - The entry to write to the space
lease - The lease the entry will be written with, in milliseconds.
timeout - The timeout of an update operation, in milliseconds. If the entry is locked by another transaction wait for the specified number of milliseconds for it to be released.
modifiers - one or a union of WriteModifiers.

Returns:
A usable Lease on a successful write, or null if performed with the proxy configured with NoWriteLease flag.

## Write API

{% inittab Write001 %}
{% tabcontent Write|top %}

{% highlight java %}
<T> LeaseContext<T> write(T entry,
                          long lease,
                          long timeout,
                          WriteModifiers modifiers)
                      throws DataAccessException
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Default %}

{% highlight java %}
<T> LeaseContext<T> write(T entry) throws DataAccessException
{% endhighlight %}

{% endtabcontent %}
{% tabcontent Parameters %}
Parameters:
entry - The entry to write to the space
lease - The lease the entry will be written with, in milliseconds.
timeout - The timeout of an update operation, in milliseconds. If the entry is locked by another
          transaction wait for the specified number of milliseconds for it to be released.
modifiers - one or a union of WriteModifiers.
Returns:
A usable Lease on a successful write, or null if performed with the proxy configured with NoWriteLease flag.
{% endtabcontent %}
{% tabcontent Modifiers %}

{: .table .table-bordered}
| Property | Description | Default |
|:---------|:------------|:--------|
| MEMORY\_ONLY\_DEARCH | chris| more |
| NONE | chris| more |
| ONE\_WAY | chris| more |
| PARTIAL\_UPDATE | chris| more |
| RETURN\_PREV\_ON\_UPDATE | chris| more |
| UPDATE\_ONLY | chris| more |
| UPDATE\_OR\_WRITE | chris| more |
| WRITE\_ONLY | chris| more |

{% endtabcontent %}
{% endinittab %}

## Example

{% inittab hello|top %}
{% tabcontent Java %}

{% highlight java %}
        String url = "/./mySpace";
        // Create the Space
        GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer(
				url)).gigaSpace();

        // Create a User
	User user = new User();
	user.setId("10000");
	user.setFirstName("CHris");
	user.setLastName("Roffler");
	user.setFlag(false);

	// Write the User to the Space
	gigaSpace.write(user);
}
{% endhighlight %}

{% endtabcontent %}
{% tabcontent .NET %}

{% highlight java %}
        String url = "/./mySpace";
        // Create the Space
        GigaSpace gigaSpace = new GigaSpaceConfigurer(new UrlSpaceConfigurer(
				url)).gigaSpace();

        // Create a User
	User user = new User();
	user.setId("10000");
	user.setFirstName("CHris");
	user.setLastName("Roffler");
	user.setFlag(false);

	// Write the User to the Space
	gigaSpace.write(user);
}
{% endhighlight %}

{% endtabcontent %}
{% endinittab %}

