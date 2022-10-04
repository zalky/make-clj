<img src="https://i.imgur.com/GH71uSi.png" title="zalky" align="right" width="250"/>

# Make-clj

A reusable set of make tasks for building Clojure projects with
[io.zalky/build-clj](https://github.com/zalky/build-clj).

First include this repo as a submodule in your project. Assuming you
added it at the path `make-clj`, then create a `Makefile` in your
project root that looks something like:

```make
# Required variables
version-number  = 0.1.0
group-id        = io.zalky
artifact-id     = project

# Optional variables, can be ommitted
description     = Optional project description
license         = :apache|:mit|:epl-1|:epl-2

include make-clj/Makefile
```

You can then run your desired targets:

```
make jar
```

## Releases

The make tasks will append `-SNAPSHOT` to your artifact version by
default. To build a release, simply set `release = true` in your
`Makefile`, or set the `version` explicitly:

```make
include make-clj/Makefile

release = true

# or

version = $(version-number)-rc1
```

## Extending

You can easily extend the defined targets:

```make
include make-clj/Makefile

jar:
    my-pre-scripts
    make jar-super
    my-post-scripts
```

## License

Distributed under the terms of the Apache License 2.0.


