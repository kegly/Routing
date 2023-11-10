# nov/02/2023 11:02:20 by RouterOS 6.47.9
# software id = 
#
#
#
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface vlan
add name=vlan10 vlan-id=10
add name=vlan20 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether3 pvid=10
add bridge=bridge1 interface=ether2
/interface bridge vlan
add bridge=bridge1 tagged=ether4,ether3,ether2,bridge1 vlan-ids=10
add bridge=bridge1 tagged=ether4,ether3,ether2,bridge1 vlan-ids=20
/ip address
add address=172.31.255.30/30 interface=ether1 network=172.31.255.28
/system identity
set name=sw01
