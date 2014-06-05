---
layout: post100
title:  Free Text Search
categories: XAP100
parent: querying-the-space.html
weight: 350
---

{%summary%}{%endsummary%}



Free text search is required almost with every application.
Users placing some free text into a form and later the system allows users to search for records that includes one or more words within a free text field.
A simple way to enable such a search without using a regular expression query that my have some overhead can be done by using an array or a collection of String.

# Example

Our Space class includes the following - note the **words** and the **freeText** fields:

{% highlight java %}
public class MyData {
	String[] words;
	String freeText;

	public String[] getWords() {
		return words;
	}

	public void setWords(String words[]) {
		this.words=words;
	}

	public String getFreeText() {
		return freeText;
	}
	public void setFreeText(String freeText) {
		this.freeText = freeText;
		this.words = freeText.split(" ");
	}
....
}
{% endhighlight %}

{% note %} Note how the **freeText** field is broken into the **words** array before placed into the indexed field.
{%endnote%}

You may write the data into the space using the following:

{% highlight java %}
MyData data = new MyPOJO(...);
data.setFreeText(freetext);
gigaspace.write(data);
{% endhighlight %}

You can query for objects having the word **hello** as part of the freeText field using the following:

{% highlight java %}
MyData results[] = gigaspace.readMultiple(new SQLQuery<MyData>(MyData.class, words[*]='hello'));
{% endhighlight %}

You can also execute the following to search for object having the within the freeText field the word **hello** or **everyone**:

{% highlight java %}
MyData results[] = gigaspace.readMultiple(new SQLQuery<MyData>(MyData.class, words[*]='hello' OR words[*]='everyone'));
{% endhighlight %}

With the above approach you avoid the overhead with regular expression queries.


# Indexing

To speed up the query you can create an [index](./indexing-collections.html) on the fields you want to search.

Example:

{% highlight java %}
public class MyData {
	String[] words;
	String freeText;

	@SpaceIndex (path="[*]")
	public String[] getWords() {
		return words;
	}

	public void setWords(String words[]) {
		this.words=words;
	}

	public String getFreeText() {
		return freeText;
	}
	public void setFreeText(String freeText) {
		this.freeText = freeText;
		this.words = freeText.split(" ");
	}
....
}
{% endhighlight %}

{% tip %}
The same approach can be implemented also with the [SpaceDocument](./document-api.html).
{% endtip %}

{% comment %}
To search for specific words in a specific order within the free text field you should use the indexed field and regular expression with another field that stores the free text.
{% endcomment %}


<ul class="pager">
  <li class="previous"><a href="./query-sql.html">&larr; SQL Query</a></li>
  <li class="next"><a href="./query-nested-properties.html">Nested Properties &rarr;</a></li>
</ul>