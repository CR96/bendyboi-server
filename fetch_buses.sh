#!/bin/bash

# Poll SMART API for location of all buses with vehicle IDs listed in buses_to_locate.txt
while read bus_number; do
    echo "Fetching info for vehicle #$bus_number"
    wget -q -O info_$bus_number.json https://www.smartbus.org/DesktopModules/Smart.Endpoint/proxy.ashx?method=predictionsforbus&vid=$bus_number
    sleep 2
done <buses_to_locate.txt

# Combine all JSON responses into one file (as an array). jq must be installed.
jq -s 'flatten' info_*.json > bus_locations.json
rm info_*.json
