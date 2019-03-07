push!(LOAD_PATH,dirname(Base.source_path())*"/generated_types")
using ZCM

# include("../example/_example_t.jl")
using _example_t

numReceived = 0
function handler(rbuf, channel::String, msg::example_t)
    println("Received message on channel: ", channel)
    global numReceived
    global gmsgdata
    gmsgdata = msg
    @assert (numReceived == msg.timestamp) "Received message with incorrect timestamp"
    numReceived = numReceived + 1

end

# a handler that receives the raw message bytes
function untyped_handler(rbuf, channel::String, msgdata::Vector{UInt8})
    println("Recieved raw message data on channel: ", channel)
    global gumsgdata
    gumsgdata = msgdata

    u2msgdata = decode(example_t, msgdata)
    global gu2msgdata
    gu2msgdata = u2msgdata
end

#zcm = Zcm("inproc")
zcm = Zcm("udpm://239.255.76.67:7667?ttl=1")
if (!good(zcm))
    error("Unable to initialize zcm");
end

sub = subscribe(zcm, "EXAMPLE", handler, example_t)
sub2 = subscribe(zcm, "EXAMPLE", untyped_handler)

msg = example_t()

ZCM.start(zcm)

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
unsubscribe(zcm, sub2)

@assert (numReceived == 6) "Didn't receive proper number of messages"

println("Success!")
