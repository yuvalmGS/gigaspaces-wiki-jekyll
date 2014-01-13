---
layout: post
title:  Configuration
categories: XAP97
parent: web-management-console.html
weight: 100
---

{% compositionsetup %}{% summary %}Configuring various options and customizing the management console.{% endsummary %}


# Internationalization

The management console allows for alternative locales which can be configured via XML. Currently, the supported locales
are Chinese and English (which is the default). Users wishing to change the locale should update the configuration file,
like so:

* Open the *gs-webui.war* archive (found under `[XAP_HOME]/tools/gs-webui`) for exploring and navigate to */WEB-INF/lib*.
Open the *gs-webui-[version-build].jar* archive for exploring.

* Edit *xap-webui-context.xml* to add the `localeConf` bean with the desired locale string (`zh_CN` for Chinese and
`en` for English):

{% highlight xml %}
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="
    http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.1.xsd">

    <import resource="classpath:webui-context.xml" />

    ...

    <bean id="localeConf" class="com.gigaspaces.admin.webui.shared.beans.LocaleConf">
        <property name="name" value="zh_CN"/>
    </bean>

</beans>
{% endhighlight %}
