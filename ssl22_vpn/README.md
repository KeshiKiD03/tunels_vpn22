# OpenVPN

__tls18:vpn__ Fitxers de claus i certificats per crerar túnels virtuals amb OpenVPN. Utilitza l'entitatt de certificació VeritatAbsluta i crea certificats propis per a client i servidor.

## @keshi ASIX M11-SAD Curs 2011-2022

Creació de claus de client i servidor (i de CA) per crear túnels
VPN amb el servei OpenVPN.

Caldrà crear una entitat de certificació que anomenem
*VeritatAbsoluta* que gegerarà els certificats de client (un o més)
i de servidor. Usarem OpenVPN en mode client/servidor manualment o
en mode  servei usant systemctl.

Caldrà fer:

 * clau privada i certificat de CA
 * clau privada i certificat de servidor
 * clau privada i certificat de client1
 * clau privada i certificat de client2


key i cert del server:
```
$ openssl  genrsa -out serverkey.vpn.pem
$ openss req -new -key serverkey.vpn.pem -out serverreq.vpn.pem
$ openssl x509 -CAkey cakey.pem -CA cacert.pem -req -in serverreq.vpn.pem -days 3650 -CAcreateserial -extfile ext.server.conf -out servercert.vpn.pem
```

client 1: key i cert
```
$ openssl  genrsa -out clientkey.1vpn.pem
$ openssl req -new -key clientkey.1vpn.pem -out clientreq.1vpn.pem
$ openssl x509 -CAkey cakey.pem -CA cacert.pem -req -in clientreq.1vpn.pem -days 3650 -CAcreateserial -extfile ext.client.conf -out clientcert.1vpn.pem
```

client 2: key i cert
```
$ openssl  genrsa -out clientkey.2vpn.pem
$ openssl req -new -key clientkey.2vpn.pem -out clientreq.2vpn.pem
$ openssl x509 -CAkey cakey.pem -CA cacert.pem -req -in clientreq.2vpn.pem -days 3650 -CAcreateserial -extfile ext.client.conf -out clientcert.2vpn.pem

```

# Extensions dels certificats:

Servidor:
```
     X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            Netscape Cert Type: 
                SSL Server
            Netscape Comment: 
                OpenSSL Generated Server Certificate
            X509v3 Subject Key Identifier: 
                B3:9D:81:E6:16:92:64:C4:86:87:F5:29:10:1B:5E:2F:74:F7:ED:B1
            X509v3 Authority Key Identifier: 
                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
                DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@myhost.mydomain
                serial:A1:4E:DE:FA:90:F2:AE:81

            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Key Usage: 
                Digital Signature, Key Encipherment
```

Client:
```
    X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            X509v3 Subject Key Identifier: 
                D2:B4:36:0F:B1:FC:DD:A5:EA:2A:F7:C7:23:89:FA:E3:FA:7A:44:1D
            X509v3 Authority Key Identifier: 
                keyid:2B:40:E5:C9:7D:F5:F4:96:38:E9:2F:E3:2F:D9:40:64:C9:8E:05:9B
                DirName:/C=KG/ST=NA/L=BISHKEK/O=OpenVPN-TEST/emailAddress=me@myhost.mydomain
                serial:A1:4E:DE:FA:90:F2:AE:81
```

Engegar el servei:

```
Server:  # systemctl  start openvpn-server@server.service
Client1: # systemctl  start openvpn-client@client.service 
Client2: # systemctl  start openvpn-client@client.service
```

Test:
```
ping 10.8.0.1
ping 10.8.0.4
ping 10.8.0.10
```
