#!/bin/sh
set -eu


# Validate input
if test -z "$INTERFACE_EXTERN"; then
    echo "!> Missing env-var \$INTERFACE_EXTERN"
    exit 1
fi
if test -z "$INTERFACE_SUBNET"; then
    echo "!> Missing env-var \$INTERFACE_SUBNET"
    exit 1
fi


# Start command
exec /libexec/mdns-repeater -f "$INTERFACE_EXTERN" "$INTERFACE_SUBNET"
