#TODO:
#TODO: This example does not work yet
#TODO:

push!(LOAD_PATH,pwd()*"/example")
using ZCM

using _example_t
push!(LOAD_PATH,pwd()*"/example/test_package")
import test_package: packaged_t

function prepMsg!(m::packaged_t, tf::Bool)
    m.packaged = tf;
    m.a.packaged = tf;
    m.a.e.timestamp = (tf ? 1 : 0);
    m.a.e.p.packaged = tf;
end

function checkMsg(m::packaged_t, tf::Bool)
    @assert (m.packaged       == tf)           "Received msg with incorrect packaged flag"
    @assert (m.a.packaged     == tf)           "Received msg with incorrect a.packaged flag"
    @assert (m.a.e.timestamp  == (tf ? 1 : 0)) "Received msg with incorrect a.e.timestamp"
    @assert (m.a.e.p.packaged == tf)           "Received msg with incorrect a.e.p.packaged flag"
end

numReceived = 0
function handler(rbuf, channel::String, msg::packaged_t)
    println("Received message on channel: ", channel)
    global numReceived
    checkMsg(msg, (numReceived % 2) == 0)
    numReceived += 1
end

# zcm = Zcm("inproc")
zcm = Zcm("udpm://239.255.76.67:7667?ttl=1")
if (!good(zcm))
    println("Unable to initialize zcm");
    exit()
end

sub = subscribe(zcm, "EXAMPLE", handler, packaged_t)

msg = packaged_t()

start(zcm)

prepMsg!(msg, true);
publish(zcm, "EXAMPLE", msg)
prepMsg!(msg, false);
publish(zcm, "EXAMPLE", msg)
prepMsg!(msg, true);
publish(zcm, "EXAMPLE", msg)

# This *should* assert
#=
msg.a = example_t()
publish(zcm, "EXAMPLE", msg)
# =#

sleep(0.5)
stop(zcm)

unsubscribe(zcm, sub)

@assert (numReceived == 3) "Didn't receive proper number of messages"
println("Success!")
