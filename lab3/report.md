University: [ITMO University](https://itmo.ru/ru/)  
Faculty: [FICT](https://fict.itmo.ru)  
Course: [Introduction in routing](https://github.com/itmo-ict-faculty/introduction-in-routing)  
Year: 2023/2024  
Group: K33212  
Author: Korkina Anna Michailovna
Lab: Lab3  
Date of create: 15.12.2023  
Date of finished: 17.12.2023  

## Лабораторная работа №3 "Эмуляция распределенной корпоративной сети связи, настройка OSPF и MPLS, организация первого EoMPLS"
## Опиcание
Наша компания "RogaIKopita Games" с прошлой лабораторной работы выросла до серьезного игрового концерна, ещё немного и они выпустят свой ответ Genshin Impact - Allmoney Impact. И вот для этой задачи они купили небольшую, но очень старую студию "Old Games" из Нью Йорка, при поглощении выяснилось что у этой студии много наработок в области компьютерной графики и совет директоров "RogaIKopita Games" решил взять эти наработки на вооружение. К сожалению исходники лежат на сервере "SGI Prism", в Нью-Йоркском офисе никто им пользоваться не умеет, а из-за короновируса сотрудники офиса из Санкт-Петерубурга не могут добраться в Нью-Йорк, чтобы забрать данные из "SGI Prism". Ваша задача подключить Нью-Йоркский офис к общей IP/MPLS сети и организовать EoMPLS между "SGI Prism" и компьютером инженеров в Санк-Петербурге.
## Цель работы 
Изучить протоколы OSPF и MPLS, механизмы организации EoMPLS.
## Ход работы
##  Настройка
1. PC1:

 ![изображение](https://github.com/kegly/Routing/assets/90460093/a4c12bac-0caa-4ed8-8e53-4ccecf7b3427)

2. R01-SPB:
![изображение](https://github.com/kegly/Routing/assets/90460093/ff0c9209-a702-4f2a-8c20-7979536d06eb)
![изображение](https://github.com/kegly/Routing/assets/90460093/eb293ac1-8f05-42a4-bc9e-301ce24ed7ab)

3. HKI
![изображение](https://github.com/kegly/Routing/assets/90460093/efe41def-9963-48b3-9e6a-d41380e67bba)

4. MSK
![изображение](https://github.com/kegly/Routing/assets/90460093/2d9332b7-3212-435b-9a86-cb4e6c95f17b)

5. LBN
![изображение](https://github.com/kegly/Routing/assets/90460093/432ac3da-1856-4e4e-832f-04ccb1bee66a)
![изображение](https://github.com/kegly/Routing/assets/90460093/791cfe83-379a-4557-afbe-8c25aa7bba97)

6.LND

![изображение](https://github.com/kegly/Routing/assets/90460093/d2004d85-147d-4931-8b77-c7fcd217914f)
7. NYC

![изображение](https://github.com/kegly/Routing/assets/90460093/df292bbc-f7fd-4cc5-bcee-41886cc66e75)

![изображение](https://github.com/kegly/Routing/assets/90460093/12c1c638-2c8e-4f85-a54e-76962d22afc8)

8.SGI_Prism
![изображение](https://github.com/kegly/Routing/assets/90460093/4666901b-86dc-499b-bd60-38a865112d71)



## Результат настройки MPLS
![изображение](https://github.com/kegly/Routing/assets/90460093/59816e7a-dc3f-4d16-8c17-63b68c69ed45)


## Ping от SGI Prism до PC 
![изображение](https://github.com/kegly/Routing/assets/90460093/403b8f2c-7781-4565-805d-da6fb37e5383)

## Трассировка от роутера NYC До SPB
![изображение](https://github.com/kegly/Routing/assets/90460093/671e5e02-57f6-4499-9df6-14cb129e9268)



