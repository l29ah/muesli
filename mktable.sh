#!/bin/sh
# Usage: $0 http://ndb.nal.usda.gov/ndb/foods/show/738?manu=&fgcd=
curl -s 'http://ndb.nal.usda.gov/ndb/foods/show/'`echo "$1" | sed -e 's#[^0-9]*\([0-9]*\).*#\1#'`'?format=Full&reportfmt=csv' | iconv -f cp1251 | sed -e 's#^([^)]*)##' | ./mktable.hs
