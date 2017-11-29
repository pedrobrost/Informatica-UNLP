# Práctica 11 - Capa de Enlace - Parte II

### 1. Si la PC A está en una red y se quiere comunicar con la PC B que está en otra red:

#### a. ¿Como se da cuenta la PC A de esto?

Porque aplica su máscara de red en su propia IP y en la IP destino y obtiene distinto resultado.

#### b. Si la tabla ARP de la PC A esta vacía, ¿que dirección MAC necesita la PC A para poder comunicarse con la PC B?

Como la PC B está en otra red, el frame deberá ser enviado al default gateway, por ende se necesitará esta dirección MAC. Como la table ARP está vacía, se deberá primero encontrar esta dirección enviando un frame con la dirección destino correspondiente a la de broadcast.

#### c. En base a lo anterior, ¿que dirección IP destino tiene el requerimiento ARP? ¿Es la dirección IP del default gateway o es la dirección IP de la PC B? De ser necesario, ejecute de nuevo el experimento de ser necesario y complete los campos:

**Trama Ethernet:**

* MAC origen: `mac-pc-a`
* MAC destino: `broadcast`

**Solicitud ARP:**

* MAC origen: `mac-pc-a`
* ip progen: `ip-pca`
* MAC destino: `0`
* ip destino; `ip gateway`

#### d. En base a lo anterior, indique la información de capa 2 y 3 del ICMP ECHO REQUEST que la PC A le envía a la PC B cuando ejecuta un ping, en el segmento de LAN de la PC B.

**Trama Ethernet:**

* MAC origen: `mac-pc-a`
* MAC destino: `mac gateway`

**ICMP:**

* ip progen: `ip-pca`
* ip destino; `ip gateway`

---

