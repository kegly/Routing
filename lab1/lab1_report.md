

University: ITMO University

Faculty: FICT

Course: Introduction in routing

Year: 2023/2024

Group: K33212

Author: Anna Korkina Michailovna

Lab: Lab1

Date of create: 12.10.2023

Date of finished: 

# Лабораторная работ №1 "Установка ContainerLab и развертывание тестовой сети связи"

### Описание
В данной лабораторной работе вы познакомитесь с инструментом ContainerLab, развернете тестовую сеть связи, настроите оборудование на базе Linux и RouterOS.
### Цель работы
Ознакомиться с инструментом ContainerLab и методами работы с ним, изучить работу VLAN, IP адресации и т.д.
### Ход работы
###### 1. Создание топологии в ContainerLab:
#

```sh
       
name: lab1

prefix: ""

mgmt:
  network: statics
  ipv4_subnet: 192.168.100.0/24

topology:
  nodes:
    pc1:
      kind: linux
      image: alpine:latest
      mgmt_ipv4: 192.168.100.11

      # setting dhcp-client on pc :
      #   cmd: sh
      #   apk update
      #   apk add busybox
      #   udhcpc -i eth1
    pc2:
      kind: linux
      image: alpine:latest
      mgmt_ipv4: 192.168.100.22

      # setting dhcp-client on pc :
      #   cmd: sh
      #   apk update
      #   apk add busybox
      #   udhcpc -i eth1

    sw02_1:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt_ipv4: 192.168.100.33
      startup-config: /home/anna/RoutingLabs/Lab1/vrnetlab/routeros/lab1/configs/sw02_1+.rsc
    sw02_2:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt_ipv4: 192.168.100.44
      startup-config: /home/anna/RoutingLabs/Lab1/vrnetlab/routeros/lab1/configs/sw02_2+.rsc
    sw01:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt_ipv4: 192.168.100.55
      startup-config: /home/anna/RoutingLabs/Lab1/vrnetlab/routeros/lab1/configs/sw01+.rsc
    r01:
      kind: vr-ros
      image: vrnetlab/vr-routeros:6.47.9
      mgmt_ipv4: 192.168.100.66
      startup-config: /home/anna/RoutingLabs/Lab1/vrnetlab/routeros/lab1/configs/r01+.rsc
    
  links:
    - endpoints: ["r01:eth1", "sw01:eth3"]
    - endpoints: ["sw02_1:eth1", "sw01:eth1"]
    - endpoints: ["sw02_2:eth1", "sw01:eth2"]
    - endpoints: ["sw02_1:eth2", "pc1:eth1"]
    - endpoints: ["sw02_2:eth2", "pc2:eth1"]

```
- Создаем управляющую сеть mgmt и раздаем статические IP
- Для сетевых устройств используется образ докера на базе Mikrotic RouterOS, для конечных устройств - обычный Linux
- в блоке links указываем физическую связность устройств через порты Ethernet
- Для роутера и коммутатора указываем путь до файла с их конфигурацией, после деплоя сетевые стройства будут настроены 
- Закомментированные команды относящиеся к контейнерам конечных устройств pc1, pc2 необходимо выполнить внутри контейнера:

    ```sh
    docker exec -it pc1 sh
     ```
-  pc1:
     
    ```sh
    apk update
    apk add busybox
    udhcpc -i eth1
    ```
    Эти команды настраивают DHCP клиента :
    каждое конечное устройства получит IP в сети своего vlan от gateway на роутере
    
    
###### 2. Конфигурация Роутера R01
#
 ```sh
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
   ```
- настраиваем vlan10 и vlan20 на интерфейсе, создаем на нем bribge
- создаем два пула адресов для каждого vlan и два dhcp сервера
- задаем тегирование трафика для vlans так как порт транковый 
- назначаем два gateway для каждой сети vlan 

###### 3. Конфигурация Коммутатора второго уровня SW01
#
   ```sh
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface vlan
add name=vlan10 vlan-id=10
add name=vlan20 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=ether3 pvid=20
add bridge=bridge1 interface=ether2 pvid=10
/interface bridge vlan
add bridge=bridge1 tagged=ether4,ether3,ether2,bridge1 vlan-ids=10
add bridge=bridge1 tagged=ether4,ether3,ether2,bridge1 vlan-ids=20
/ip address
add address=172.31.255.30/30 interface=ether1 network=172.31.255.28
/system identity
set name=sw01
   ```
- поднимаем два vlan
- тегирование трафика
- bridge на интерфейсах

###### 4. Конфигурация Коммутаторов третьего уровня SW02_1, SW02_2
#
   ```sh
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
   ```
   
 - поднимаем vlan10 
 - трафик на внешнем порту тегированный, на внутреннем - нет
#
Аналогично SW02_2:
   ```sh
   /interface bridge
add name=bridge1 vlan-filtering=yes
/interface vlan
add interface=bridge1 name=vlan20 vlan-id=20
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3 pvid=20
/interface bridge vlan
add bridge=bridge1 tagged=ether2,bridge1 untagged=ether3 vlan-ids=20
/ip address
add address=172.31.255.30/30 interface=ether1 network=172.31.255.28
/ip dhcp-client
add disabled=no interface=ether1
/system identity
set name=sw02_2

   ```

### Результат работы

топология построенная в Draw.io

![image](https://github.com/kegly/Routing/blob/main/lab1/images/topology_draw_io.png "a title") 

