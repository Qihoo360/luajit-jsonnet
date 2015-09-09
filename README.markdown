# Name
====
|luarocks|
|:------:|
|[![](https://img.shields.io/badge/luarocks-0.1--1-blue.svg)](https://luarocks.org/modules/chenyuduan/jsonnet)|

luajit-jsonnet - The Google Jsonnet( operation data template language) for Luajit


Table of Contents
=================

* [Name](#name)
* [Description](#description)
* [install](#install)
* [Methods](#methods)
	 * [new](#new)
	 * [make](#make)
	 * [evaluate_file](#evaluate_file)
	 * [evaluate_snippet](#evaluate_snippet)
	 * [evaluate_file_multi](#evaluate_file_multi)
	 * [evaluate_snippet_multi](#evaluate_snippet_multi)
	 * [destroy](#destroy)

Description
===========


jsonnet is a domain specific configuration language that helps you define JSON data. Jsonnet lets you compute fragments of JSON within the structure, bringing the same benefit to structured data that templating languages bring to plain text. The example below illustrates a few features -- referring to another part of the structure, overriding object fields, and string operations......

luajit-jsonnet - Use the luajit ffi jsonnet interface calls and operation

Google jsonnet documet: (http://google.github.io/jsonnet/doc/)

install
===========
Simple executing the following command

```
make install

```

Methods
=======

new
---
Create a luajit - jsonnet object

```
local jso = require "jsonnet"
jsonnet = jso:new()

```
make
---
Create a new Jsonnet virtual machine.

```
syntax: res, err = jsonnet:make()
```
evaluate_file
---
Evaluate a file containing Jsonnet code, return a JSON string.

```
syntax: res,err = jsonnet:evaluate_file("t.jsonnet")
```
```
local jso = require "jsonnet"
jsonnet = jso:new()
jsonnet:make()
res,err = jsonnet:evaluate_file("t.jsonnet")
if err == nil then
	print(res)
else
	print(err)
end
```
evaluate_snippet
---
Evaluate a file containing Jsonnet code, return a JSON string.

```
syntax: res,err = jsonnet:evaluate_snippet(snippet)
```

```
local snippet = '{ person1: { name: "Alice", welcome: "Hello " + self.name + "!", }, person2: self.person1 { name: "Bob" },}'
res,err = jsonnet:evaluate_snippet(snippet)
if err == nil then
	print(res)
else
	print(err)
end
```

evaluate_file_multi
---
Evaluate a file containing Jsonnet code, return a number of JSON files.  The returned character buffer contains an even number of strings, the filename and JSON for each

```
syntax: res,err = jsonnet:evaluate_file_multi("t.jsonnet")
```


evaluate_snippet_multi
---
Evaluate a string containing Jsonnet code, return a number of JSON files. The returned character buffer contains an even number of strings, the filename and JSON for each 

```
syntax: res,err = jsonnet:evaluate_snippet_multi(snippet)
```


destroy
---
Shut down and release  Jsonnet virtual machine. 

```
syntax: res,err = jsonnet:destroy(vm)
```

```
local jso = require "jsonnet"
jsonnet = jso:new()
jsonnet:make()
res,err = jsonnet:evaluate_file("t.jsonnet")
jsonnet:destroy()
```

Author
======

Yuduan Chen (陈毓端) <yumin1985@php.net> 
