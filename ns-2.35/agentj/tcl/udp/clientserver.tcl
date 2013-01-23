# This example uses the Java PAICommands class to 
# send data between two NS2 nodes.  The actual Java
# code specifies which nodes to communicate with.
# This simple example demonstrates how Java objects
# can be attached to an NS2 nodes and used to 
# create sockets and send data between nodes.

# Create multicast enabled simulator instance
set ns_ [new Simulator]

# Create two nodes
set n1 [$ns_ node]
set n2 [$ns_ node]

# Put a link between them
$ns_ duplex-link $n1 $n2 64kb 100ms DropTail
$ns_ queue-limit $n1 $n2 100
$ns_ duplex-link-op $n1 $n2 queuePos 0.5
$ns_ duplex-link-op $n1 $n2 orient right

   
puts "Creating JavaAgent NS2 agents and attach them to the nodes..."   
set p1 [new Agent/Agentj]
$ns_ attach-agent $n1 $p1

set p2 [new Agent/Agentj]
$ns_ attach-agent $n2 $p2

puts "In script: Initializing agents  ..." 
	
$ns_ at 0.1 "$p1 startup"
$ns_ at 0.1 "$p2 startup"

puts "Setting Java Object to use by each agent ..." 

$ns_ at 0.2 "$p2 attach-agentj agentj.examples.udp.Server"
$ns_ at 0.2 "$p1 attach-agentj agentj.examples.udp.Client"

puts "Starting simulation ..." 

$ns_ at 0.5 "$p2 agentj init"
$ns_ at 0.5 "$p1 agentj init"

$ns_ at 1.0 "$p1 agentj send hello [$n2 node-addr]"


$ns_ at 10.0 "$p1 shutdown"
$ns_ at 10.0 "$p2 shutdown"

$ns_ at 10.0 "finish $ns_"

proc finish {ns_} {
$ns_ halt
delete $ns_
}

$ns_ run

