# nov/02/2023 11:03:52 by RouterOS 6.47.9
# software id = 
#
#
#
/interface bridge
add fast-forward=no name=bridge1 vlan-filtering=yes
/interface vlan
add interface=bridge1 name=vlan10 vlan-id=10
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3 pvid=10
/interface bridge vlan
add bridge=bridge1 tagged=ether2,bridge1 untagged=ether3 vlan-ids=10
/ip address
add address=172.31.255.30/30 interface=ether1 network=172.31.255.28
/ip dhcp-client
add disabled=no interface=ether1
/system identity
set name=sw02_1
