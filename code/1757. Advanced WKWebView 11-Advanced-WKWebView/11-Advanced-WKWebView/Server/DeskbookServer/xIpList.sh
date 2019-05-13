#!/bin/bash

# Use ifconfig to list all interfaces, looking for those on 
# ipv4, then we show only the IP

arg=$1

echo ""
if [[ -z "$arg" ]]; then
  read -p "Enter the first part of the conference network (leave empty to see all IPs): " arg
fi

if [[ -z "$arg" ]]; then
  echo "Your Mac is listening on all the following IPs:"
  ifconfig | grep 'inet ' | cut -d' ' -f2
else
  echo "Your Mac is listening on the conference WiFi on the following IP:"
  ifconfig | grep 'inet ' | cut -d' ' -f2 | grep "$arg"
fi
echo ""
