---
layout: post
title:  Scala
categories: XAP97INST
parent: none
weight: 300
---


{% summary %}Requirements and how to install Scala for GigaSpaces with Windows, Linux or Unix.{% endsummary %}

# Overview

Scala is a general purpose programming language designed to express common programming patterns in a concise, elegant, and type-safe way. It smoothly integrates features of object-oriented and functional languages, enabling Java and other programmers to be more productive.

Scala programs run on the Java VM, are byte code compatible with Java so you can make full use of existing Java libraries or existing application code. You can call Scala from Java and you can call Java from Scala, the integration is seamless. Because of this, Scala applications can use of GigaSpaces libraries and API like any other Java library or API.

# Scala Interpreter

Scala also comes with an interpreter ([REPL](http://www.scala-lang.org/node/2097)) which can be handy for development and testing. It is an interactive "shell" for writing Scala expressions and programs.

Interestingly, REPL can also be embedded in your application which is discussed in detail by Josh Suereth  [here](http://suereth.blogspot.com/2009/04/embedding-scala-interpreter.html) and by Vassil Dichev [here](http://speaking-my-language.blogspot.com/2009/11/embedded-scala-interpreter.html). Running REPL in your application is a useful trick which is theoretically possible but the ramifications of doing this on top of GigaSpaces are unknown. It is not recommended to run Scala on top of GigaSpaces using this approach.




{%note%}For a list of supported platforms please consult [the realease notes](/release_notes) {%endnote%}



TODO

Add supported platforms to release notes !!!!
