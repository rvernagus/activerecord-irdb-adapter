= ActiveRecord IRDb Adapter

* http://github.com/rvernagus/activerecord-irdb-adapter
* mailto:r.vernagus@gmail.com

== DESCRIPTION:

The IRDb ActiveRecord adapter is a Rails ActiveRecord adapter
for IronRuby based on IRDb. It supports multiple databases and
is written in 100% Ruby.

== SYNOPSIS:

Core specs:
  rake spec:core
  
Specs in IronRuby:
  rake spec:core_ir
  rake spec:sql_server
  rake spec:oracle

Or run at the command line:
  ir mspec/bin/mspec -B spec/core_ir.mspec
  ir mspec/bin/mspec -B spec/oracle.mspec
  ir mspec/bin/mspec -B spec/sql_server.mspec

== REQUIREMENTS:

* IronRuby
* hoe
* irdb

== INSTALL:

* igem install activerecord-irdb-adapter

== LICENSE:

(The MIT License)

Copyright (c) Ray Vernagus

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
