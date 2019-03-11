# ZCM.jl
Julia package for ZCM

[![Build Status](https://travis-ci.org/AndreHat/ZCM.jl.svg?branch=master)](https://travis-ci.org/AndreHat/ZCM.jl)

This is a module for ZCM in Julia 1.0. The original source code was found [here](https://github.com/ZeroCM/zcm/tree/master/zcm/julia) and then modified for Julia 1.0 from Julia 0.6.

## Install

This is an unregistered package and can be added with (using binaries from ZCMBuilder):
```julia
(1.0) pkg> add https://github.com/AndreHat/ZCM.jl.git
```

## Generating Types
`zcm-gen` can be used to automatically generate the Julia types from zcm types. It is build in the deps/usr/local/bin folder.
If you want the latest zcm-gen then clone and builld [this](https://github.com/AndreHat/zcm.git) repository.

## Examples

Most examples should work as is.
packaged_type.jl and prefixed_types.jl does not work yet.
I am having some trouble with parentmodule() function in Julia, so I am still working on the packaged_type.jl example
