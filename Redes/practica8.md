# Práctica 8 - Capa de Red - Ruteo

### 2. En las redes IP el ruteo puede configurarse en forma estática o en forma dinámica. Indique ventajas y desventajas de cada método.

#### IP Estáticas

** Ventajas **

* Ofrecen conexiones más fiables y estables.
* Suelen permitir mayores velocidades de carga y descarga.
* Te dan un control exclusivo de tu IP. Nadie más puede usarla. Así evitas bloqueos o problemas por malos usos que no sean culpa tuya.
* Son ideales por ejemplo para jugadores online, proveedores o usuarios de telefonía y vídeo por Internet (VoIP) como Skype. También en servidores de todo tipo y servicios de alojamiento web. O en sistemas de redes privadas virtuales (VPN).

** Desventajas **

* En principio son menos seguras. Los hackers u otros atacantes tienen más tiempo y oportunidades para atacar equipos con IPs que sean siempre iguales. Obligan a tomar medidas de seguridad extra y más rigurosas.
* En general hay que pagar un precio adicional para tener una IP fija en Internet. Además no las ofrecen todos los proveedores de acceso. Tendrías que consultar al tuyo.
* Lo normal es que haya que configurarlas a mano. Quien las usa debe tener más conocimientos de informática.

#### IP Dinámicas

** Ventajas **

* No tienes que pagar más por ellas. La mayoría de los proveedores de Internet asignan IPs dinámicas a sus clientes como parte de su plan de acceso normal.
* En principio son más seguras. Es más díficil para un atacante rastrear y buscar debilidades en un equipo con una IP variable.
* Ofrecen mayor privacidad en Internet. A los sitios web les cuesta más rastrear lo que haces si tu IP va cambiando.
* Su configuración en la red suele ser automática. No necesitas hacerla tú. Se encarga de ello lo que se llama un servidor DHCP.
* Optimizan el uso de recursos y abaratan costos. Cuando un equipo se desconecta de Internet u otra red ya "no necesita" su IP. Así puede reutilizarse asignándosela a otro equipo que se conecte.

** Desventajas **

* Es más fácil que la conexión falle o se interrumpa.

---

### 3. Una máquina conectada a una red pero no a Internet, ¿tiene tabla de ruteo?

Sí, porque aunque sea una red local se utiliza la tabla de enrutamiento para comunicarse con los demás dispositivos de la red. Internet es una red con las mismas características que la red privada, simplemente que es pública. Además vimos que en la tabla de enrutamiento hay que tener una entrada por defecto (0.0.0.0) que devuelve a la interface conectada y una entrada para la red donde estamos conectado con el default gateway local (0.0.0.0).

---

### 5. Con la máquina virtual con acceso a Internet realice las siguientes observaciones respecto de la autoconfiguración IP vía DHCP:

#### b. En una terminal de root, ejecute el comando sudo /sbin/dhclient eth0 y analice el intercambio de paquetes capturado.

El intercambio de mensajes que se realiza cuando un cliente desea obtener una dirección IP a traves del servicio de DHCP, es de 4 vías, las cuales se detallan a continuación:

** Descubrimiento del servidor DHCP **

La primera tarea de un host recién llegado es encontrar un servidor DHCP con el que interactuar. Esto se hace mediante un mensaje de descubrimiento DHCP, que envía un cliente dentro de un paquete UDP al puerto 67. El paquete UDP se encapsula en un datagrama IP. Pero, ¿a quién debería enviarse este datagrama? El host ni siquiera conoce la dirección IP de la red a la que se está conectando, y mucho menos la dirección de un servidor DHCP de esa red. En esta situación, el cliente DHCP crea un datagrama IP que contiene su mensaje de descubrimiento DHCP junto con la dirección IP de difusión 255.255.255.255 y una dirección IP de origen de “este host” igual a 0.0.0.0. El cliente DHCP pasa el datagrama IP a la capa de enlace, la cual difunde esta trama a todos los nodos conectados a la subred (en la Sección 5.4 estudiaremos en detalle el proceso de difusión de la capa de enlace).

** Oferta(s) del servidor DHCP **

Un servidor DHCP que recibe un mensaje de descubrimiento DHCP responde al cliente con un mensaje de oferta DHCP, que se difunde a todos los nodos de la subred utilizando de nuevo la dirección IP de difusión 255.255.  255.255 (es posible que se pregunte por qué la respuesta de este servidor también debe difundirse). Puesto que en la subred pueden existir varios servidores DHCP, el cliente puede encontrarse en la situación envidiable de poder elegir entre varias ofertas. Cada mensaje de oferta de servidor contiene el ID de transacción del mensaje de descubrimiento recibido, la dirección IP propuesta para el cliente, la máscara de red y el tiempo de arrendamiento de la dirección IP (el tiempo durante el que la dirección IP será válida). Es habitual que el servidor defina un tiempo de arrendamiento de varias horas o días.

** Solicitud DHCP **

El cliente recién llegado seleccionará de entre las ofertas de servidor y responderá a la oferta seleccionada con un mensaje de solicitud DHCP, devolviendo los parámetros de configuración.

** ACK DHCP **

El servidor contesta al mensaje de solicitud DHCP con un mensaje ACK DHCP, que confirma los parámetros solicitados.

#### c. Analice la información registrada en el archivo /var/lib/dhcp/dhclient.leases, ¿cuál parece su función?

Contiene información cómo:

* Interfaz de red
* Dirección IP
* Máscara de subred
* Tiempo de alocamiento de la dirección IP
* Default gateway
* Identificador del servidor DHCP
* Dirección del servidor de DNS
* Time Stamp de actualización y expiración de la información obtenida

#### e. En una terminal de root, vuelva a ejecutar el comando sudo /sbin/dhclient eth0 y analice el intercambio de paquetes capturado nuevamente ¿a que se debió la diferencia con lo observado en el punto “b”?

Al borrar el archivo dhclient.leases, el nuevo request no solicitará la renovación de una dirección IP anteriormente obtenida.

---


