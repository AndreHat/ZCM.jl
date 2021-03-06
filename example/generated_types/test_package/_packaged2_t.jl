# THIS IS AN AUTOMATICALLY GENERATED FILE.
# DO NOT MODIFY BY HAND!!
#
# Generated by zcm-gen
#

begin
@assert (endswith(string(@__MODULE__), "test_package")) "Only import this file through its module"

import ZCM


export packaged2_t
mutable struct packaged2_t <: ZCM.AbstractZcmType

    # **********************
    # Members
    # **********************

    packaged                      ::Bool
    e                             ::ZCM.AbstractZcmType # example4_t


    function packaged2_t()

        self = new()

        # **********************
        # Members
        # **********************

        self.packaged = false
        self.e = __basemodule._example4_t.example4_t()

        return self
    end

end

const __test_package_packaged2_t_hash = Ref(Int64(0))
function ZCM._get_hash_recursive(::Type{packaged2_t}, parents::Array{String})
    if __test_package_packaged2_t_hash[] != 0; return __test_package_packaged2_t_hash[]; end
    if "test_package_packaged2_t" in parents; return 0; end
    newparents::Array{String} = [parents[:]; "test_package_packaged2_t"::String];
    hash::UInt64 = 0x471a628ba5e54d99 + reinterpret(UInt64, ZCM._get_hash_recursive(__basemodule._example4_t.example4_t, newparents))
    hash = (hash << 1) + ((hash >>> 63) & 0x01)
    __test_package_packaged2_t_hash[] = reinterpret(Int64, hash)
    return __test_package_packaged2_t_hash[]
end

function ZCM.getHash(::Type{packaged2_t})
    return ZCM._get_hash_recursive(packaged2_t, Array{String,1}())
end

function ZCM._encode_one(msg::packaged2_t, buf)
    write(buf, msg.packaged)
    @assert isa(msg.e, __basemodule._example4_t.example4_t) "Msg of type `test_package.packaged2_t` requires field `e` to be of type `example4_t`"
    ZCM._encode_one(msg.e,buf)
end

function ZCM.encode(msg::packaged2_t)
    buf = IOBuffer()
    write(buf, hton(ZCM.getHash(packaged2_t)))
    ZCM._encode_one(msg, buf)
    return ZCM._takebuf_array(buf);
end

function ZCM._decode_one(::Type{packaged2_t}, buf)
    msg = packaged2_t();
    msg.packaged = reinterpret(Bool, read(buf, 1))[1]
    msg.e = ZCM._decode_one(__basemodule._example4_t.example4_t,buf)
    return msg
end

function ZCM.decode(::Type{packaged2_t}, data::Vector{UInt8})
    buf = IOBuffer(data)
    if ntoh(reinterpret(Int64, read(buf, 8))[1]) != ZCM.getHash(packaged2_t)
        throw("Decode error")
    end
    return ZCM._decode_one(packaged2_t, buf)
end

end # `begin` block
