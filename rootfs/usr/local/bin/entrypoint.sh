#!/bin/bash

mkdir --parents /etc/dhcp/ mkdir --parents /run/dhcpd{4,6}  || true

if [ "${DHCP_IP+x}" = "x" ] && [ ${DHCP_IP} == "6" ]; then
  touch /var/lib/dhcp/dhcpd6.leases
  /usr/bin/dhcpd -6 -cf /etc/dhcp/dhcpd6.conf -pf /run/dhcpd6/dhcpd.pid -d ${DHCP_INTERFACES}
else
  touch /var/lib/dhcp/dhcpd.leases
  /usr/bin/dhcpd -4 -cf /etc/dhcp/dhcpd.conf -pf /run/dhcpd4/dhcpd.pid -d ${DHCP_INTERFACES}
fi