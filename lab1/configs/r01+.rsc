# nov/02/2023 09:54:16 by RouterOS 6.47.9
# software id = 
#
#
#
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface vlan
add interface=bridge1 name=vlan10 vlan-id=10
add interface=bridge1 name=vlan20 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=vlan10_pool ranges=192.168.10.2-192.168.10.254
add name=vlan20_pool ranges=192.168.20.2-192.168.20.254
/ip dhcp-server
add address-pool=vlan10_pool disabled=no interface=vlan10 name=dhcp10
add address-pool=vlan20_pool disabled=no interface=vlan20 name=dhcp20
/interface bridge port
add bridge=bridge1 interface=ether2
/interface bridge vlan
add bridge=bridge1 tagged=ether2,bridge1 vlan-ids=10
add bridge=bridge1 tagged=ether2,bridge1 vlan-ids=20
/ip address
add address=172.31.255.30/30 interface=ether1 network=172.31.255.28
add address=192.168.10.1/24 interface=vlan10 network=192.168.10.0
add address=192.168.20.1/24 interface=vlan20 network=192.168.20.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.10.0/24 gateway=192.168.10.1
add address=192.168.20.0/24 gateway=192.168.20.1
/system identity
set name=r01
