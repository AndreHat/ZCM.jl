#TODO:
#TODO: This example still doesn't work, something wrong with the encoding/decoding steps. Wrong data arrives in the callback
#TODO:


using ZCM

include("../example/_example_t.jl")
using Main._example_t
include("../example/_little_endian_t.jl")
using Main._little_endian_t

numReceived = 0
function handler(rbuf, channel::String, msg::little_endian_t)
    println("Received message on channel: ", channel)
    global numReceived
    @assert (numReceived == msg.timestamp) "Received message with incorrect timestamp"
    numReceived = numReceived + 1
end

# a handler that receives the raw message bytes
function untyped_handler(rbuf, channel::String, msgdata::Vector{UInt8})
    println("Recieved raw message data on channel: ", channel)
    buf = IOBuffer(msgdata)
    global gbuf = buf
    global gmsgdata = msgdata

    # @assert (ltoh(reinterpret(Int64, read(buf, 8))[1]) == ZCM.getHash(little_endian_t))
            # "Incorrect encoding for little endian"
    # @show (ltoh(reinterpret(Int64, read(buf, 8))[1]) == ZCM.getHash(little_endian_t))
    # decode(little_endian_t, msgdata)
end

zcm = Zcm("udpm://239.255.76.67:7667?ttl=1")
if (!good(zcm))
    error("Unable to initialize zcm");
end

sub = subscribe(zcm, "EXAMPLE", handler, little_endian_t)
sub2 = subscribe(zcm, "EXAMPLE", untyped_handler)

msg = little_endian_t()

msg.position = [ 1.0, 2.0, 3.0 ];
msg.orientation = [ 1.0, 2.0, 3.0, 4.0 ];
msg.num_ranges = 3;
msg.ranges = [1, 2, 3];
msg.name = "example";
msg.enabled = true

start(zcm)

msg.timestamp = 0;
publish(zcm, "EXAMPLE", msg)
msg.timestamp = 1;
publish(zcm, "EXAMPLE", msg)
msg.timestamp = 2;
publish(zcm, "EXAMPLE", msg)

sleep(0.5)

msg.timestamp = 3;
publish(zcm, "EXAMPLE", msg)
msg.timestamp = 4;
publish(zcm, "EXAMPLE", msg)
msg.timestamp = 5;
publish(zcm, "EXAMPLE", msg)

sleep(0.5)
stop(zcm)

unsubscribe(zcm, sub)

@assert (numReceived == 6) "Didn't receive proper number of messages"

println("Success!")
