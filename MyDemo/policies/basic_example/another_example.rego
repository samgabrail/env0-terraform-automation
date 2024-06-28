package server_policy

# Rule 1: Servers reachable from the Internet must not expose the insecure 'http' protocol.
violation_http[server_id] {
    server := input.servers[_]
    server_id := server.id
    protocol := "http"
    server.protocols[_] == protocol
}

# Rule 2: Servers are not allowed to expose the 'telnet' protocol.
violation_telnet[server_id] {
    server := input.servers[_]
    server_id := server.id
    protocol := "telnet"
    server.protocols[_] == protocol
}

deny[msg] {
    server_id := violation_http[_]
    msg := sprintf("Server '%s' reachable from the Internet is exposing the insecure 'http' protocol.", [server_id])
}

deny[msg] {
    server_id := violation_telnet[_]
    msg := sprintf("Server '%s' is exposing the 'telnet' protocol, which is not allowed.", [server_id])
}
