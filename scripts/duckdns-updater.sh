#!/bin/bash
# Description: Automated DDNS synchronization daemon for DuckDNS profiles.
# Execution: Registered via crontab to evaluate WAN boundary state changes.
# NOTE: To get your domain and unique token, register via https://www.duckdns.org

DOMAIN="yourdomain" # Replace with target profile domain
TOKEN="your-unique-token-here"
LOGFILE="$HOME/duckdns/duckdns.log"

# Execute secure payload transfer to DuckDNS API
RESULT=$(curl -k -s "https://www.duckdns.org/update?domains=${DOMAIN}&token=${TOKEN}&ip=")

echo "$(date): ${RESULT}" >> "$LOGFILE"
