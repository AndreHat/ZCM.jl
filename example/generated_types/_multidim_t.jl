# THIS IS AN AUTOMATICALLY GENERATED FILE.
# DO NOT MODIFY BY HAND!!
#
# Generated by zcm-gen
#

# This file intended to be imported by user
# after setting up their LOAD_PATH,
# but you must import the type directly into the user's module:
#     pushfirst!(LOAD_PATH, "path/to/dir/containing/this/file")
#     import _multidim_t : multidim_t
module _multidim_t
__basemodule = parentmodule(_multidim_t)
__basemodule == _multidim_t && (__basemodule = Main)

import ZCM

function __init__()
end

export multidim_t
mutable struct multidim_t <: ZCM.AbstractZcmType

    # **********************
    # Members
    # **********************

    rows                          ::Int8
    jk                            ::Int32
    mat                           ::Array{Float64,3}


    function multidim_t()

        self = new()

        # **********************
        # Members
        # **********************

        self.rows = 0
        self.jk = 0
        self.mat = [ 0.0 for dim0=1:self.rows, dim1=1:2, dim2=1:self.jk ]

        return self
    end

end

const __multidim_t_hash = Ref(Int64(0))
function ZCM._get_hash_recursive(::Type{multidim_t}, parents::Array{String})
    if __multidim_t_hash[] != 0; return __multidim_t_hash[]; end
    if "multidim_t" in parents; return 0; end
    hash::UInt64 = 0xe450cfbc53e83411
    hash = (hash << 1) + ((hash >>> 63) & 0x01)
    __multidim_t_hash[] = reinterpret(Int64, hash)
    return __multidim_t_hash[]
end

function ZCM.getHash(::Type{multidim_t})
    return ZCM._get_hash_recursive(multidim_t, Array{String,1}())
end

function ZCM._encode_one(msg::multidim_t, buf)
    write(buf, hton(msg.rows))
    write(buf, hton(msg.jk))
    @assert size(msg.mat,1)==msg.rows "Msg of type `multidim_t` requires field `mat` dimension `1` to be size `msg.rows`"
    @assert size(msg.mat,2)==2 "Msg of type `multidim_t` requires field `mat` dimension `2` to be size `2`"
    @assert size(msg.mat,3)==msg.jk "Msg of type `multidim_t` requires field `mat` dimension `3` to be size `msg.jk`"
    for i0=1:msg.rows
        for i1=1:2
            for i2=1:msg.jk
                write(buf, hton(msg.mat[i0,i1,i2]))
            end
        end
    end
end

function ZCM.encode(msg::multidim_t)
    buf = IOBuffer()
    write(buf, hton(ZCM.getHash(multidim_t)))
    ZCM._encode_one(msg, buf)
    return ZCM._takebuf_array(buf);
end

function ZCM._decode_one(::Type{multidim_t}, buf)
    msg = multidim_t();
    msg.rows = reinterpret(Int8, read(buf, 1))[1]
    msg.jk = ntoh(reinterpret(Int32, read(buf, 4))[1])
    msg.mat = Array{Float64, 3}(undef,msg.rows,2,msg.jk)
    for i0=1:msg.rows
        for i1=1:2
            for i2=1:msg.jk
                msg.mat[i0,i1,i2] = ntoh(reinterpret(Float64, read(buf, 8))[1])
            end
        end
    end
    return msg
end

function ZCM.decode(::Type{multidim_t}, data::Vector{UInt8})
    buf = IOBuffer(data)
    if ntoh(reinterpret(Int64, read(buf, 8))[1]) != ZCM.getHash(multidim_t)
        throw("Decode error")
    end
    return ZCM._decode_one(multidim_t, buf)
end

end # `module _multidim_t` block