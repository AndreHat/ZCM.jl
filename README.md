# ZCM.jl
Julia package for ZCM

This is a module for ZCM in Julia 1.0. The original source code was found [here](https://github.com/ZeroCM/zcm/tree/master/zcm/julia) and then modified for Julia 1.0 from Julia 0.6.

To install ZCM, please follow the instructions at the official [ZCM repository](https://github.com/ZeroCM/zcm) found [here](https://github.com/ZeroCM/zcm/blob/master/docs/building.md).
Remember to configure for Julia with either ./waf configure --use-julia to include Julia in the configuration or with ./waf configure --use-all to include all options.

This is an unregistered package and can be added with:
```julia
(1.0) pkg> add https://github.com/AndreHat/ZCM.jl.git
```
### Examples

Most examples should work as is.
little_endian.jl, logfiles.jl, packaged_type.jl and prefixed_types.jl does not work yet.