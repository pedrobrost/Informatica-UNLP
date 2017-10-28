# Práctica 7 - Capa de red

## Introducción

### 1. ¿Qué servicios presta la capa de red? ¿Cuál es la PDU en esta capa? ¿Qué dispositivo es considerado sólo de la capa de red?

La función de la capa de red es tremendamente simple: transporta paquetes desde un host emisor a un host receptor. En la realización de esta tarea podemos identificar dos importantes funciones de la capa de red:
 
* Reenvío (forwarding). Cuando un paquete llega al enlace de entrada de un router, éste tiene que pasar el paquete al enlace de salida apropiado.

* Enrutamiento (routing). La capa de red tiene que determinar la ruta o camino que deben seguir los paquetes a medida que fluyen de un emisor a un receptor. Los algoritmos que calculan estas rutas se conocen como algoritmos de enrutamiento.

Todo router tiene una tabla de reenvio. Un router reenvia un paquete examinando el valor de un campo de la cabecera del paquete entrante y utilizando después ese valor para indexarlo dentro de la tabla de reenvio del router. El resultado de la tabla de reenvío indica a cuál de las interfaces del enlace de salida del router será reenviado el paquete.  El algoritmo de enrutamiento determina los valores que se introducen en las tablas de reenvío de los routers. Este algoritmo puede estar centralizado o descentralizado (en cada router).

La capa de red de Internet proporciona un único servicio conocido como servicio de mejor esfuerzo (best-effort service). Al decir servicio de mejor esfuerzo estamos utilizando un eufemismo por no decir que no proporciona ningún servicio en absoluto. Con un servicio de mejor esfuerzo, la temporización relativa entre paquetes no está garantizada, tampoco está garantizado que los paquetes se reciban en el orden que fueron emitidos y tampoco se garantiza la entrega de los paquetes transmitidos. Por tanto, teniendo en cuenta esta definición, una red que no entregara los paquetes al destino satisfaría la definición de servicio de entrega de mejor esfuerzo.

Al PDU asociado a esta capa se lo conoce como `datagrama`.

El dispositivo que solo es considerado de la capa de red es el router (que en realidad es un conmutador de paquetes, como el switch, pero este último se basa en la cabecera de la capa de enlace ya que pertenece a esta). El router no implementa las capas superiores a la capa de red.

---

### 2. ¿Cuántas redes clase A, B y C hay? ¿Cuántos hosts como máximo pueden tener cada una?

#### Redes clase A

* Cantidad de redes: `126`
* Cantidad de hosts: `16777214`

#### Redes clase B

* Cantidad de redes: `16384`
* Cantidad de hosts: `65534`

#### Redes clase C

* Cantidad de redes: `2097152`
* Cantidad de hosts: `254`

---

### 3. ¿Qué son las subredes? ¿Por qué es importante siempre especificar la máscara de subred asociada?

El concepto de máscara indica en una dirección IP qué bits son de red y qué bits son de host. Con el uso de redes con clases, la máscara estaba implícita en la dirección de clase, pues se conocía a priori los bits para red y los bits para host. Cuando se creó el concepto de subredes también se les asoció una máscara de subred, que resultó de utilizar algunos bits de hosts para crear subredes y de esta manera obtener varias subredes con menos hosts cada una. La subred se obtiene aplicando un “AND” lógico entra la IP y la máscara de subred.

---

### 4. Describa qué es y para qué sirve el protocolo ICMP.

Los hosts y los routers utilizan ICMP, especificado en [RFC 792], para intercambiarse información acerca de la capa de red. El uso más típico de ICMP es la generación de informes de error. Por ejemplo, al ejecutar una sesión Telnet, FTP o HTTP, puede encontrarse con un mensaje de error como “Red de destino inalcanzable”. Este mensaje tiene su origen en ICMP. En algún momento, un router IP no ha podido encontrar una ruta hasta el host especificado en su aplicación Telnet, FTP o HTTP, y dicho router ha creado y enviado un mensaje ICMP de tipo 3 a su host para informarle del error.

ICMP a menudo se considera parte de IP pero, en sentido arquitectónico, se encuentra justo encima de IP, ya que los mensajes ICMP son transportados dentro de los datagramas IP. Es decir, los mensajes ICMP son transportados como carga útil de IP, al igual que los segmentos TCP o UDP son transportados como carga útil de IP. De forma similar, cuando un host recibe un datagrama IP con ICMP especificado como el protocolo de la capa superior, demultiplexa el contenido del datagrama para ICMP, al igual que demultiplexaría el contenido de un datagrama para TCP o UDP.

Los mensajes ICMP tienen un campo de tipo y un campo de código, y contienen la cabecera y los 8 primeros bytes del datagrama IP que ha dado lugar a la generación del mensaje ICMP en primer lugar (de modo que el emisor puede determinar qué datagrama ha producido el error).

#### a. Analice cómo funciona el comando ping.

El programa ping envía un mensaje ICMP de tipo 8 y código 0 al host especificado. El host de destino, al ver la solicitud de eco, devuelve una respuesta de eco ICMP de tipo 0 y código 0. La mayoría de las implementaciones de TCP/IP soportan el servidor ping directamente en el sistema operativo; es decir, el servidor no es un proceso. El programa cliente necesita poder instruir al sistema operativo para generar un mensaje ICMP de tipo 8 y código 0.

#### b. Analice cómo funciona el comando traceroute (tracert en Windows) y cómo manipula el campo TTL de los paquetes IP.

El comando Traceroute nos permite trazar una ruta desde un host a cualquier otro host del mundo. Cada vez más frecuentemente, Traceroute se implementa con mensajes ICMP. Para determinar los nombres y las direcciones de los routers existentes entre el origen y el destino, Traceroute en el origen envía una serie de datagramas IP ordinarios al destino. Cada uno de estos datagramas transporta un segmento UDP con un número de puerto UDP poco probable. El primero de estos datagramas tiene un TTL de 1, el segundo de 2, el tercero de 3, y así sucesivamente. El origen también inicia los temporizadores para cada uno de los datagramas. Cuando el datagrama n-ésimo llega al router n-ésimo, éste observa que el TTL del datagrama acaba de caducar.  De acuerdo con las reglas del protocolo IP, el router descarta el datagrama y envía al origen un mensaje de advertencia ICMP (tipo 11, código 0). Este mensaje de advertencia incluye el nombre del router y su dirección IP. Cuando este mensaje ICMP llega de vuelta al origen, éste obtiene el tiempo de ida y vuelta del temporizador, y el nombre y la dirección IP del router n-ésimo del propio mensaje ICMP.

El origen incrementa el valor del campo TTL cada vez que envía un datagrama. Por tanto, uno de los datagramas terminará recorriendo el camino completo hasta el host de destino.  Dado que ese datagrama contiene un segmento UDP con un número de puerto improbable, el host de destino devuelve al origen un mensaje ICMP de puerto inalcanzable (tipo 3, código 3). Cuando el host de origen recibe este mensaje ICMP, sabe que no tiene que enviar más paquetes de prueba. (Realmente, el programa estándar Traceroute envía conjuntos de tres paquetes con el mismo TTL y, por tanto, la salida de Traceroute proporciona tres resultados para cada TTL.).

De esta forma, el host de origen obtiene el número y la identidad de los routers que existen entre él y el host de destino, así como el tiempo de ida y vuelta entre los dos hosts.  Observe que el programa cliente Traceroute tiene que poder instruir al sistema operativo para generar los datagramas UDP con valores TTL específicos y el sistema operativo también tiene que ser capaz de notificarle la llegada de mensajes ICMP.

#### c. Indique la cantidad de saltos realizados desde su computadora hasta el sitio info.unlp.edu.ar. En algunos de los saltos ¿muestra el nombre del dominio asociado al salto y su ip? Detalle los encontrados.

-- inc --

#### d. Verifique el recorrido a dos de los servidores de mail de gmail.com y compare los saltos realizados.  ¿Realizaron la misma cantidad de saltos, hicieron el mismo camino?

-- inc --

---

### 5. ¿Para que se usa el bloque 127.0.0.0/8? ¿Qué PC responde a los siguientes comandos?

El dispositivo de red loopback es una interfaz de red virtual. Las direcciones del rango `127.0.0.0/8` son direcciones de loopback, de las cuales se utiliza, de forma mayoritaria, la `127.0.0.1` por ser la primera de dicho rango, añadiendo '::1' para el caso de IPv6 ('127.0.0.1::1').

#### a. ping 127.0.0.1

`Host local`

#### b. ping 127.0.54.43

`Host local`

---

### 6. Investigue para qué sirven los comandos ifconfig y route. ¿Qué comandos podría utilizar en su reemplazo? Inicie una topología con CORE, cree una máquina y utilice en ella los comandos anteriores para practicar sus diferentes opciones, mínimamente:

* **Configurar y quitar una dirección IP en una interfaz.**
* **Ver la tabla de ruteo de la máquina.**

* **ifconfig**: Es un programa disponible en varias versiones del sistema operativo UNIX, que permite configurar o desplegar numerosos parámetros de las interfaces de red residentes en el núcleo, como la dirección IP (dinámica o estática), o la máscara de red. Si se llama sin argumentos suele mostrar la configuración vigente de las interfaces de red activas, con detalles como la dirección MAC o el tráfico que ha circulado por las mismas hasta el momento. Las interfaces de red en Linux se suelen denominar eth (eth0, eth1, etc.).

* **route**: El comando route muestra la tabla de enrutamiento que reside en el kernel y también se usa para modificarla. La tabla que especifica cómo se enrutan los paquetes a un host se llama tabla de enrutamiento.

Actualmente los dos comandos mencionados anteriormente están obsoletos, en su reemplazo se utiliza el comando `ip`.

* Agregar dirección ip a una interfaz: `ip a add ipdir dev interface`.

* Eliminar dirección ip de una interfaz: `ip a del ipdir dev interface`.

* Ver tabla de ruteo: `ip route`

---


