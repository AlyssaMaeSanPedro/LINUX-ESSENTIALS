#!/bin/bash

display_network_connections() {
    echo "Active network connections:"
    netstat -tulnp 2>/dev/null || ss -tulnp
}

display_network_connections