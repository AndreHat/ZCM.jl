"""
THIS IS AN AUTOMATICALLY GENERATED FILE.
DO NOT MODIFY BY HAND!!
Generated by zcm-gen

This module intended to be imported by the user
after setting up their LOAD_PATH:
    pushfirst!(LOAD_PATH, "path/to/dir/containing/this/file")
    import test_package

"""
module test_package

__basemodule = parentmodule(test_package)
__modulepath = joinpath(dirname(@__FILE__), "test_package")
pushfirst!(LOAD_PATH, __modulepath)

function __init__()
    Base.eval(__basemodule, Meta.parse("import _example4_t: example4_t"))
end

try
    # Submodules

    # Types
    include(joinpath(__modulepath, "_packaged2_t.jl"))
    include(joinpath(__modulepath, "_packaged_t.jl"))

finally
    popfirst!(LOAD_PATH)
end

end # module test_package;
