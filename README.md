# Set function library for shells

Shell functions for set operations such as intersection, difference, disjoint,
and union.

## Why?

Yes, it's impractical, but:

* It's fun.  One is almost certainly better off
reimplementing the task in [Python](https://docs.python.org/3/library/stdtypes.html#set)
or [Rust](https://doc.rust-lang.org/std/collections/struct.HashSet.html) or
really any programming langauge with a standard library or proper library
management system ([go example](https://github.com/deckarep/golang-set)).

* I wanted to experiment with unit testing bash scripts.

* Sometimes you're working in bash and you need to find the symmetric
  difference between two sets.



## Tests

Running tests requires [bats](https://github.com/sstephenson/bats).

```
bats test
```
