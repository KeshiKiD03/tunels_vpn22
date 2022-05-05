**Actuem com a CA...**

* **Generem clau privada sense passphrase i fabriquem certificat autosignat de VeritatAbsoluta:**
```
openssl genrsa -out cakey.pem

openssl req -new -x509 -days 365 -key cakey.pem -out cacert.pem

You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----

Country Name (2 letter code) [AU]:CA
State or Province Name (full name) [Some-State]:Barcelona
Locality Name (eg, city) []:bcn
Organization Name (eg, company) [Internet Widgits Pty Ltd]:VeritatAbsoluta
Organizational Unit Name (eg, section) []:Certificats
Common Name (e.g. server FQDN or YOUR name) []:veritat
Email Address []:veritat@edt.org
```
