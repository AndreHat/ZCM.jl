push!(LOAD_PATH,dirname(Base.source_path())*"/generated_types")
using ZCM

using _example_t

numReceived = 0
handler = function(rbuf, channel::String, msg::example_t)
    println("Received message on channel: ", channel)
    global numReceived
    @assert (numReceived == msg.timestamp) "Received message with incorrect timestamp"
    numReceived = numReceived + 1
end

zcm = Zcm("nonblock-inproc")
if (!good(zcm))
    println("Unable to initialize zcm");
    exit()
end

sub = subscribe(zcm, "EXAMPLE", handler, example_t)

msg = example_t()

msg.timestamp = 0;
publish(zcm, "EXAMPLE", msg)
handle_nonblock(zcm)
msg.timestamp = 1;
publish(zcm, "EXAMPLE", msg)
handle_nonblock(zcm)
msg.timestamp = 2;
publish(zcm, "EXAMPLE", msg)
handle_nonblock(zcm)

unsubscribe(zcm, sub)

@assert (numReceived == 3) "Didn't receive proper number of messages"
println("Success!")
