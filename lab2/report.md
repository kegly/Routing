


University: ITMO University
Faculty: FICT
Course: Introduction in routing
Year: 2023/2024
Group: K33212
Author: Anna Korkina Michailovna
Lab: Lab1
Date of create: 12.10.2023
Date of finished: 

# Лабораторная работ №2 "Эмуляция распределенной корпоративной сети связи, настройка статической маршрутизации между филиалами"

### Описание
В данной лабораторной работе вы первый раз познакомитесь с компанией "RogaIKopita Games" LLC которая занимается разработкой мобильных игр с офисами в Москве, Франкфурте и Берлине. Для обеспечения работы своих офисов "RogaIKopita Games" вам как сетевому инженеру необходимо установить 3 роутера, назначить на них IP адресацию и поднять статическую маршрутизацию. В результате работы сотрудник из Москвы должен иметь возможность обмениваться данными с сотрудником из Франкфурта или Берлина и наоборот.  

Ознакомиться с принципами планирования IP адресов, настройке статической маршрутизации и сетевыми функциями устройств.
### Цель работы
Ознакомиться с принципами планирования IP адресов, настройке статической маршрутизации и сетевыми функциями устройств.
### Ход работы
###### 1. Создание топологии в ContainerLab:

---

	name: lab2

	topology:
	  nodes:
	    R01.MSK:
	      image: vrnetlab/vr-routeros:6.47.9
	      kind: vr-ros
	      mgmt-ipv4: 192.168.200.2

	    R01.FRT:
	      image: vrnetlab/vr-routeros:6.47.9
	      mgmt-ipv4: 192.168.200.3
	      kind: vr-ros
	    
	    R01.BRL:
	      image: vrnetlab/vr-routeros:6.47.9
	      kind: vr-ros
	      mgmt-ipv4: 192.168.200.4

	    PC1:
	      kind: vr-ros
	      image: vrnetlab/vr-routeros:6.47.9
	      mgmt-ipv4: 192.168.200.5

	    PC3:
	      kind: vr-ros
	      image: vrnetlab/vr-routeros:6.47.9
	      mgmt-ipv4: 192.168.200.6
	    
	    PC2:
	      kind: vr-ros
	      image: vrnetlab/vr-routeros:6.47.9
	      mgmt-ipv4: 192.168.200.7

	  links:
	    - endpoints: ["R01.MSK:eth1", "PC1:eth1"]
	    - endpoints: ["R01.BRL:eth2", "R01.FRT:eth2"]
	    - endpoints: ["R01.BRL:eth3", "R01.MSK:eth2"]
	    - endpoints: ["R01.MSK:eth3", "R01.FRT:eth3"]
	    - endpoints: ["R01.FRT:eth1", "PC3:eth1"]
	    - endpoints: ["R01.BRL:eth1", "PC2:eth1"]

	mgmt:
	  network: static
	  ipv4-subnet: 192.168.200.0/24

---

### Настройка 
#### 1. Роутеры
настроим DHCP сервера на роутерах для раздачи IP компам и статические маршруты      
MSK:
![изображение](https://github.com/kegly/Routing/assets/90460093/fd3072af-8bc7-43da-9261-10826b19b6fc)

FRT:
![изображение](https://github.com/kegly/Routing/assets/90460093/bcd6f0df-c3c2-4760-866a-89638244cd54)

BRL:
![изображение](https://github.com/kegly/Routing/assets/90460093/add17ece-5817-4895-a1aa-24e62ab2fe5d)

#### 2. Компьютеры
Настроим DHCP-клиента на интерфейсах ether1 и ether2, чтобы получить IP-конфигурацию от DHCP-сервера и статические маршруты
MSK:
![изображение](https://github.com/kegly/Routing/assets/90460093/e2c0cc44-cf4b-4010-a0b6-3dee307d25bd)

FRT:
![изображение](https://github.com/kegly/Routing/assets/90460093/6d1570be-4a17-4b25-9d56-bf09ceaf5d62)

BRL:
![изображение](https://github.com/kegly/Routing/assets/90460093/d02b3bb0-858c-402b-b1cc-5d29422d8d3c)

### Результаты Ping

![изображение](https://github.com/kegly/Routing/assets/90460093/80020c1d-b5e7-4c6a-a1f7-f3a1d17a926f)

![изображение](https://github.com/kegly/Routing/assets/90460093/cc22910b-d246-4223-bf4b-38935438d8b4)

![изображение](https://github.com/kegly/Routing/assets/90460093/4ba0fa61-0e4e-4798-964b-5ec0c84381c9)




