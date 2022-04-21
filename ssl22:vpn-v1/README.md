# OpenVPN (HTTPS)
## @keshi ASIX M11-SAD Curs 2018-2019

# Instalated

* OpenVPN

__ssl22:vpn__ Fitxers de claus i certificats per crerar túnels virtuals amb OpenVPN. Utilitza l'entitatt de certificació VeritatAbsluta i crea certificats propis per a client i servidor.

# Objetivos

1. Implementar `OpenVPN Server` con `systemctl` en local.

2. Implementar un `servidor OpenVPN a AWS` i `dos clients locals a AWS`.

3. Se utilizan `certificados propios` y no los certificados por `defecto de OpenVPN`.

> NOTA: La creación se hará local y luego se hará el deployment

4. Permitir la comunicación `cliente a cliente` a través del `túnel VPN`.

5. Se usará una `Entidad de Certificación CA` = _Veritat Absoluta_ --> Emitirá los certificados para __edt.org__. 

    * Certificado para servidor

    * Par de certificados para cliente

6. Crear **certificados**:

    * Test-server --> Server

    * Test-Client1 --> Host1

    * Test-Client2 --> Host2

7. Vigilar las __extensiones__ --> Tiene que cumplir unos __requisitos__ para ser válidos para OpenVPN.

8. El __servidor que está a AWS__ tiene que permitir el tráfico __UDP__ al __puerto 1194__.

9. Consultar información: [OpenVPNSampleKeys](https://github.com/OpenVPN/openvpn/tree/master/sample/sample-keys)

    9.1 Generar `sample-keys` --> `openssl.cnf` y `script de generar las keys` --> `sample-keys gen-keys-keys.sh`

10. Mostrar el funcionamiento de una conexión `client to client` a través del túnel VPN.

* Activar algún servicio de red en los clientes que permita la `verificación` - `daytime` - `echo` - `web` ... etc





#### Generació de claus, requests i certs per a OpenVPN




* Apache2

[Apache2](https://chachocool.com/como-instalar-apache-en-debian-11-bullseye/)


Servidor https amb certificats digitals.

Seus virtuals:

 * www.auto1.cat amb self-signed certificate
 * www.auto2.cat amb self-signed certificate
 * www.web1.org certificat de servidor avalat per la ca VeritatAbsoluta
 * www.web2.org certificat de servidor avalat per la ca VeritatAbsoluta

#### Generació de claus, requests i certs

Certificat autosignat:
```
openssl req -new -x509 -days 3650 -nodes -keyout serverkey.auto1.pem -out servercert.auto1.pem
```

Creació de clau privada i certificat autosignat:
```
openssl genrsa -out serverkey.auto2.pem

openssl req -new -x509 -days 3650 -nodes -key serverkey.auto2.pem -out servercert.auto2.pem
```

Creació de clau privada, request i certificació:
```
openssl genrsa -out serverkey.web1.pem
openssl req -new -key serverkey.web1.pem -out serverreq.web1.pem
openssl x509 -CAkey cakey.pem -CA cacert.pem -req -in serverreq.web1.pem -days 3650 -CAcreateserial -out servercert.web1.pem
```

Fitxer exemple de configuració parcial de openssl:
```
#ca.conf
basicConstraints = critical,CA:FALSE 
extendedKeyUsage = serverAuth,emailProtection 
```

Creació de clau provada, petició de certificació i firma
de la certificació usant fitxer de configuració:
```
openssl genrsa -out serverkey.web2.pem
openssl req -new -key serverkey.web2.pem -out serverreq.web2.pem
openssl x509 -CAkey cakey.pem -CA cacert.pem -req -in serverreq.web2.pem -days 3650 -CAcreateserial -extfile ca.conf -out servercert.web2.pem
```

