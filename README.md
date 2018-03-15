## ABAP Markdown

A Markdown parser in ABAP based on [Parsedown](http://parsedown.org)

### Features

* Pure ABAP (version 7.30)
* Fully tested with automated ABAPUnit test cases
* Parses GitHub flavored Markdown

### Motivation

Until the start of this project, there is no available Markdown parser in SAP.

This project started with the idea of creating a modern automated documentation tool for ABAP programs.

### Installation

Install the ZMARKDOWN class as a global class.

### Code Example

``` abap
data(o_markdown) = new zmarkdown( ).

data(v_html) = o_markdown->text( 'Hello _ABAP Markdown_!' ).
write / v_html.
```

### Tests

Inside the `test` directory you will find the `zmarkdown_tests.abap` file, containing the code for the local test classes.

### Contributors

* Guilherme Maeda (http://abap.ninja)

### License

This code is distributed under the MIT License, meaning you can freely and unrestrictedly use it, change it, share it, distribute it and package it with your own programs as long as you keep the copyright notice, license and disclaimer.

Parsedown is copyright(c) 2013 Emanuil Rusev, erusev.com
