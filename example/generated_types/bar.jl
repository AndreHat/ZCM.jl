"""
THIS IS AN AUTOMATICALLY GENERATED FILE.
DO NOT MODIFY BY HAND!!
Generated by zcm-gen

This module intended to be imported by the user
after setting up their LOAD_PATH:
    pushfirst!(LOAD_PATH, "path/to/dir/containing/this/file")
    import bar

"""
module bar

__basemodule = parentmodule(bar)
__modulepath = joinpath(dirname(@__FILE__), "bar")
pushfirst!(LOAD_PATH, __modulepath)

function __init__()
    Base.eval(__basemodule, Meta.parse("import foo"))
end

try
    # Submodules

    # Types
    include(joinpath(__modulepath, "_t4.jl"))

finally
    popfirst!(LOAD_PATH)
end

end # module bar;