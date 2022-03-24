# Tunels VPN 24.03.22

# APUNTES

<br>

Tunel Host to Host [no_xifrat]

Tunel Host to Host [pre_shared_key]

Tunel con Host 2 Host con Clave Publica o Clave Privada [TLS_Public/Secret_Key]

Tunel Network to Network --> Todo es una RED y otro es una RED. Un host es un ROUTER. y otra red es ROUTER.

Enrutar 2networks - iproute add - Reglas de ENRUTAMIENTO.

Todo lo que vaya a Barcelona a tal tiene que ir por el tunel y salir por el ROUTER X.

**PRIMERO LOS 4 EJEMPLOS Y LUEGO SERVEI OPENVPN**

<br>

--------------------------------------------------------------------------------------

> **IMPORTANTE USAR VERBOSE**

# VPN

Crear un túnel VPN és com tenir un aparell màgic que us obre una porta al rebedor de casa que quan la travesseu us porta per art de màgia / ciència a un altre edifici en una altra habitació. 

Estem tips de veure-ho, les naus espaials entren per un túnel del hiperespai i
apareixen en una altra galàxia.

`tun = Interficie de Tunel VPN`

<br>
<br>

## Instalación

> apt-get update

> apt-get install openvpn

> man openvpn

> openvpn --help

<br>
<br>


# Ejemplo 1: "A simple tunnel without security"

Consisteix en fer una VPN entre dos hosts (may.jk i june.jk), estiguin on estiguin en una mateixa LAN o separats per internet. 

Podeu usar dos ordinadors de l’aula, o dos de casa o un ordinador de casa i un a AWS EC2 (caldrà obrir els ports apropiats de VPN). 

Quan els
dos ordinadors es comuniquen per la seva interfície pública el tràfic és pel canal normal, quan es comuniquen a través de les interfícies TUN el tràfic viatja pel túnel (que no està
xifrat).

En aquest exercici simplement observem l’establiment d’un túnel entre dos hosts, però no és un túnel xifrat sinó en text pla. 

No aporta res a nivell de seguretat, però podem observar com s’estableixen els túnels.

Assegureu-vos de:

● Observar l’aparició de les noves interfícies de túnel.

● Observar les rutes.

● Fer ping, telnet, ssh i accedir a algun servei daytyme o echo de l’altre peer

<br>
<br>

### EJEMPLO

June = Girona / --dev tun1 --ifconfig ip ip --verb 9

> `openvpn −−remote june.kg −−dev tun1 −−ifconfig 10.4.0.1 10.4.0.2 −−verb 9`

> `openvpn −−remote may.kg −−dev tun1 −−ifconfig 10.4.0.2 10.4.0.1 −−verb 9`


May = Barcelona

<br>

-----------------------------------------------------------------------------------------

### KESHI

* I11 : Ordenador Aaron

> `openvpn −−remote i14 −−dev tun1 −−ifconfig 10.4.0.1 10.4.0.2 −−verb 9`

* I14 : Ordenador Aaron Secundario

> `openvpn −−remote i11 −−dev tun1 −−ifconfig 10.4.0.2 10.4.0.1 −−verb 9`

`NOTA: Inventarse la IP`

> /30 - Conexión SERIAL POINT to POINT. En lugar de /8

<br>
<br>

## Verificar

> i11: `ping 10.4.0.2`

> i14: `ping 10.4.0.1`

> `ip address show`

> La opción **−−verb 9** producirá una salida detallada, similar al programa tcpdump(8). 

> Omitir la opción **−−verb 9** para que OpenVPN funcione silenciosamente. 


<br>
<br>


# Ejemplo 2: "A tunnel with static-key security (i.e. using a pre-shared secret)"

Consisteix en fer una VPN entre dos hosts (may.jk i june.jk), estiguin on estiguin en una mateixa LAN o separats per internet. 

Podeu usar dos ordinadors de l’aula, o dos de casa o un ordinador de casa i un a AWS EC2 (caldrà obrir els ports apropiats de VPN). 

Quan els
dos ordinadors es comuniquen per la seva interfície pública el tràfic és insegur. 

Quan es
comuniquen entre ells utilitzant les interfćies dels túnels el tràfic és segur.

En aquest exemple el mecanisme de xifrat és utilitzar com a ​ Key un ​ pre-shared-secret​. 

És a dir, un secret compartit per els dos extrems de túnel. En configurar el túnel s’ha acordat un secret que saben les dues parts (per exemple jupiter) i que és la clau d’encriptació del tràfic
segur. 

Així doncs, en aquest exemple NO s’utilitzen certificats digitals.
Assegureu-vos de:

● Observar l’aparició de les noves interfícies de túnel.

● Observar les rutes.

● Fer ping, telnet, ssh i accedir a algún servei daytime o echo de l’altre peer.

● Malauradament amb wireshark no veurem la diferència entre tràfic segur i insegur si
analitzem el tràfic en un dels nodes extrem. 

    wireshark en un node router a mig camí (per on passi el tràfic cap a internet). 
    
    Llavors podem veure quan es tràfic és insegur i quan és segur.

<br>
<br>

### Ejemplo

### Example 2: A tunnel with static-key security (i.e. using a pre-shared secret)

First build a static key on may.
openvpn −−genkey −−secret key

This command will build a random key file called key (in ascii format). 

Now copy key to june over a secure medium such as by using the scp(1) program.

On may:
> openvpn −−remote june.kg −−dev tun1 −−ifconfig 10.4.0.1 10.4.0.2 −−verb 5 −−secret key

On june:
> openvpn −−remote may.kg −−dev tun1 −−ifconfig 10.4.0.2 10.4.0.1 −−verb 5 −−secret key

Now verify the tunnel is working by pinging across the tunnel.

On may:

ping 10.4.0.2

On june:
ping 10.4.0.1



<br>

-----------------------------------------------------------------------------------------

### KESHI

* I11 : Ordenador Aaron

> `openvpn --genkey secret i11-key`

**Usar NETCAT**

https://nakkaya.com/2009/04/15/using-netcat-for-file-transfers/

* i14 [servidorAaron]

> nc -l -p 1234 > i11-key

* i11 [clienteAaron]

> nc -w 3 i14 1234 < i11-key

**Después**

> `openvpn --remote i14 --dev tun1 --ifconfig 10.4.0.1 10.4.0.2 --verb 5 --secret i11-key`

* I14 : Ordenador Aaron Secundario

> `openvpn --remote i11 --dev tun1 --ifconfig 10.4.0.2 10.4.0.1 --verb 5 --secret i11-key`

**Para irse a la RED de i11 tienes que salir por el Router tun1 IP 10.4.0.1 y entrarás a 10.4.0.2**

`NOTA: Inventarse la IP`

> /30 - Conexión SERIAL POINT to POINT. En lugar de /8

<br>
<br>

## Verificar

> i11: `ping 10.4.0.2`

> i14: `ping 10.4.0.1`

> `ip address show`

`tun1`

* i11

```
9: tun1: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 500
    link/none 
    inet 10.4.0.1 peer 10.4.0.2/32 scope global tun1
       valid_lft forever preferred_lft forever
    inet6 fe80::4a5a:97a1:3efa:77f3/64 scope link stable-privacy 
       valid_lft forever preferred_lft forever

```

* i14

```
5: tun1: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 500
    link/none 
    inet 10.4.0.2 peer 10.4.0.1/32 scope global tun1
       valid_lft forever preferred_lft forever
    inet6 fe80::44b5:682d:3d93:a04e/64 scope link stable-privacy 
       valid_lft forever preferred_lft forever

```

> La opción **−−verb 9** producirá una salida detallada, similar al programa tcpdump(8). 

> Omitir la opción **−−verb 9** para que OpenVPN funcione silenciosamente. 


<br>
<br>


# Ejemplo 3: "A tunnel with full TLS-based security"

<br>
<br>


En aquest exemple es farà un túnel host to host igual que l’anterior però utilitzant com a mecanisme de xifrat del tràfic certificats digitals, és a dir, Clau pública / clau privada. 

El resultat funcional és el mateix que el de l’exemple anterior, però ara no cal cap secret compartit entre els dos peers. 

Així si, cal disposar del conjunt de certificats apropiats.
Com que el model de tràfic segur TLS/SSL està dissenyat per actuar amb els rols de
client/serer aqui triarem arbitràriament un dels hosts de client i l’altre de server (by the face!).
Per tant un tindrà els certificats de client i l’altre els certificats de server.

# Ejemplo 4: "Tunet Network to Network"


# Prácticas

<br>
<br>

## PRACTICA 1: Tunel Host to Host [no_xifrat]

<br>
<br>

## PRACTICA 2: Tunel Host to Host []

<br>
<br>

## PRACTICA 3: Tunel Host to Host

<br>
<br>

## PRACTICA 4: Tunel Host to Host

<br>
<br>
