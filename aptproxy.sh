#!/bin/sh
# Author: Ryan Parrish <ryan@stickystyle.net>

# This script is to emulate the functionality of squid-deb-proxy-client when the 
# avahi dameon is not running (like in a Docker container) so the proxy server
# can be discovered dynamicly without any values being hardcoded

dig +nocmd +noall +answer @224.0.0.251 -p 5353 -t ptr _apt_proxy._tcp.local > /tmp/aptproxy
APTPROXY_HOST=$(grep "IN\sA\s" /tmp/aptproxy | awk '{print $5}')
APTPROXY_PORT=$(grep "IN\sSRV" /tmp/aptproxy | awk '{print $7}')
echo "http://$APTPROXY_HOST:$APTPROXY_PORT/"
