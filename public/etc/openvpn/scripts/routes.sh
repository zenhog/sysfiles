#!/usr/bin/env bash

case "${script_type}" in
  route-up)
    ip route add default via "$route_vpn_gateway" table "$dev"
    ip rule add priority 1000 fwmark "${dev/vpn/}" table "$dev"
    ;;
  route-pre-down)
    sudo /sbin/ip rule del priority 1000 fwmark "${dev/vpn/}" table "$dev"
    ;;
  *)
    echo "Unsupported script_type: '$script_type'"
    ;;
esac
