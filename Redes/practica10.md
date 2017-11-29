# Práctica 10 - Capa de Enlace - Parte I

### 1. ¿Qué función cumple la capa de enlace? Indique qué servicios presta esta capa.

Para transmitir un datagrama a través de un enlace individual se utiliza un protocolo de la capa de enlace. El protocolo de la capa de enlace define el formato de los paquetes intercambiados por los nodos situados en los extremos del enlace, así como las acciones que estos nodos llevan a cabo cuando se envían y reciben los paquetes.

Las unidades de datos intercambiadas por un protocolo de la capa de enlace se denominan tramas (frames), y cada trama de la capa de enlace suele encapsular un datagrama de la capa de red.

Mientras que la capa de red tiene asignada la tarea de mover los segmentos de la capa de transporte terminal a terminal desde el host de origen hasta el host destino, el protocolo de la capa de enlace tiene la tarea nodo a nodo, algo más simple, de mover los datagramas de la capa de red a través de un único enlace dentro de una ruta. Un mismo datagrama de la capa de enlace puede ser transportado por diferentes protocolos de la capa de enlace en los distintos enlaces que forman la ruta. Es importante observar que los servicios proporcionados por los diferentes protocolos de la capa de enlace a lo largo de la ruta terminal a terminal pueden ser distintos.

Servicios:

* Entramado o encapsulación: Casi todos los protocolos de la capa de enlace encapsulan cada datagrama de la capa de red dentro de una trama de la capa de enlace antes de transmitirla a través del enlace. Una trama consta de un campo de datos, en el que se inserta el datagrama de la capa de red, y de una serie de campos de cabecera (una trama también puede incluir campos de cola).

* Acceso al enlace: Un protocolo de control de acceso al medio (MAC, Medium Access Control) especifica las reglas que se utilizan para transmitir una trama a través de un enlace.
  * Para los enlaces punto a punto que tengan un único emisor en un extremo del enlace y un único receptor en el otro extremo, el protocolo MAC es muy simple (o no existe).
  * Cuando hay varios nodos compartiendo un mismo enlace de difusión, en cuyo caso se presenta el denominado problema del acceso múltiple. En este caso, el protocolo MAC sirve para coordinar la transmisión de las tramas de los múltiples nodos.

* Entrega fiable: Cuando se implementa, garantiza que va a transportar cada datagrama de la capa de red a través del enlace sin que se produzcan errores.
  * Para los enlaces inalámbricos es muy útil ya que tienen una alta tasa de errores.
  * Para los cableados puede considerarse una sobrecarga innecesaria ya que tienen una baja tasa de errores.

* Control de flujo: Los nodos situados en cada extremo de un enlace tienen una capacidad limitada de almacenamiento en buffer de tramas. Esto puede ser un problema cuando el nodo receptor puede recibir las tramas a más velocidad de la que puede procesarlas. Sin control de flujo, el buffer del receptor puede desbordarse con lo que las tramas se perderían. La idea es que el nodo emisor no abrume al nodo receptor.

* Detección de errores: Los errores de bit se introducen debido a la atenuación de las señales y al ruido electromagnético. Muchos protocolos de la capa de enlace proporcionan un mecanismo para detectar dichos errores de bit. Esto se lleva a cabo haciendo que el nodo transmisor incluya bits de detección de errores en la trama y que el nodo receptor realice una comprobación de errores. En general es más sofisticada que la de la capa de transporte y se implementa en hardware.

* Correción de errores: Es similar a la detección de errores, pero además, el receptor determina exactamente en qué puntos de la trama se han producido errores y los corrige. Algunos solo corrigen la cabecera y la cola (no el paquete completo).

* Semiduplex y full-duplex: Con la transmisión full-duplex, los nodos de ambos extremos de un enlace pueden transmitir paquetes al mismo tiempo. Sin embargo, con la transmisión semiduplex, un mismo nodo no puede transmitir y recibir al mismo tiempo.

---

### 2. Compare los servicios de la capa de enlace con los de la capa de transporte.

Muchos de los servicios proporcionados por la capa de enlace presentan notables paralelismos con los servicios proporcionados en la capa de transporte. Por ejemplo, el servicio de entrega fiable. Aunque los mecanismos utilizados para esto son similares en las dos capas, no son idénticos. Un protocolo de transporte proporciona una entrega fiable de segmentos entre dos procesos, en modo terminal a terminal; un protocolo de la capa de enlace fiable proporciona una entrega fiable de tramas entre dos nodos conectados por un único enlace. De forma similar, los protocolos de la capa de transporte como los de la capa de enlace pueden proporcionar servicios de control de flujo y detección de errores, pero de nuevo el control de flujo en un protocolo de la capa de transporte se proporciona en modo terminal a terminal, mientras que en un protocolo de la capa de enlace se proporciona entre dos nodos adyacentes.

---

### 3. Direccionamiento Ethernet:

* ¿Cómo se identifican dos máquinas en una red Ethernet?
* ¿Cómo se llaman y qué características poseen estas direcciones?
* ¿Cuál es la dirección de broadcast en capa de enlace? ¿Qué función cumple?

Se identifican mediante una dirección MAC (media access control). Esta dirección consta de 6 bytes de longitud, lo que da 2^48 posibles direcciones de MAC. Suelen expresarse en notación hexadecimal, indicándose cada byte de la dirección mediante una pareja de números hexadecimales. Una propiedad de las direcciones MAC es que nunca puede haber dos adaptadores con la misma dirección, para esto la IEEE se encarga de gestionar el espacio de direcciones MAC.

Broadcast  es una forma de transmisión de información donde un nodo emisor envía información a una multitud de nodos receptores de manera simultánea, sin necesidad de reproducir la misma transmisión nodo por nodo. Es posible la difusión de cualquier trama de datos a todas las paradas que se encuentren en el mismo segmento de la red. Para ello, se utiliza una dirección MAC especial. En el caso de Ethernet  realiza la difusión recibiendo tramas con dirección MAC de destino FF.FF.FF.FF.FF.FF.

---

### 4. Sobre los dispositivos de capa de enlace:

#### a. Enumere dispositivos de capa de enlace y explique sus diferencias

Un concentrador o hub es un dispositivo de la capa física que actúa sobre los bits individuales en lugar de sobre las tramas. Cuando un bit, que representa un cero o un uno, llega procedente de una interfaz, el concentrador simplemente vuelve a crear el bit, incrementa su intensidad de energía y lo transmite a todas las demás interfaces.
En particular, si un concentrador recibe tramas procedentes de dos interfaces distintas al mismo tiempo, se produce una colisión y los nodos que crean las tramas tendrán que retransmitirlas.

El Switch, a diferencia del HUB, envía los datos provenientes de la computadora de origen solamente a la computadora de destino. Esto se debe a que los switches crean una especie de canal de comunicación exclusiva entre el origen y el destino. De esta forma, la red no queda "limitada" a una única computadora en el envío de información. Esto aumenta la performance de la red ya que la comunicación está siempre disponible. Son transparentes para los dispositivos de la red: Los hosts no notan la presencia de switches y no tienen direcciones MAC.

#### b. ¿Qué es una colisión?

A medida que aumenta el número de nodos que pueden transmitir en un segmento de red, aumentan las posibilidades de que dos de ellos transmitan a la vez. Esta transmisión simultánea ocasiona una interferencia entre las señales de ambos nodos, que se conoce como colisión. Conforme aumenta el número de colisiones disminuye el rendimiento de la red.

Un dominio de colisión es un segmento físico de una red de computadores donde es posible que las tramas puedan "colisionar" (interferir) con otros. Estas colisiones se dan particularmente en el protocolo de red Ethernet.

#### c. ¿Qué dispositivos dividen dominios de broadcast?

Dominio de Broadcast es un conjunto de todos los dispositivos que reciben tramas de broadcast que se originan en cualquier dispositivo del conjunto. Los conjuntos de broadcast generalmente están limitados por routers dado que los router no envían tramas de broadcast.

Si bien los switches filtran la mayoría de las tramas según las direcciones MAC, no hacen lo mismo con las tramas de broadcast. Para que otros switches de la LAN obtengan tramas de broadcast, éstas deben ser reenviadas por switches. Una serie de switches interconectados forma un dominio de broadcast simple. Sólo una entidad de Capa 3, como un router o una LAN virtual (VLAN), puede detener un dominio de broadcast de Capa 3. Los routers y las VLAN se utilizan para segmentar los dominios de colisión y de broadcast.

Cuando un switch recibe una trama de broadcast la reenvía a cada uno de sus puertos excepto al puerto entrante en el que el switch recibió esa trama. Cada dispositivo conectado reconoce la trama de broadcast y la procesa. Esto provoca una disminución en la eficacia de la red dado que el ancho de banda se utiliza para propagar el tráfico de broadcast.

Cuando se conectan dos switches, el dominio de broadcast aumenta.

#### d. ¿Qué dispositivos dividen dominios de colisión?

El área de red donde se originan las tramas y se producen las colisiones se denomina dominio de colisiones. Todos los entornos de los medios compartidos, como aquellos creados mediante el uso de hubs, son dominios de colisión. Cuando un host se conecta a un puerto de switch, el switch crea una conexión dedicada. Esta conexión se considera como un dominio de colisiones individual, dado que el tráfico se mantiene separado de cualquier otro y, por consiguiente, se eliminan las posibilidades de colisión.

Los switches reducen las colisiones y permiten una mejor utilización del ancho de banda en los segmentos de red, ya que ofrecen un ancho de banda dedicado para cada segmento de red.

---

### 5. Describa el algoritmo de acceso al medio en Ethernet. ¿Es orientado a la conexión? 

LAN Ethernet es una auténtica LAN de difusión; es decir, cuando un adaptador transmite una trama, todos los adaptadores de la LAN reciben esa trama. Dado que Ethernet, puede emplear la comunicación por difusión, necesita un protocolo de acceso múltiple. Utiliza protocolo de acceso múltiple CSMA/CD (Carrier Sense Multiple Access with Colision Detect).

En Ethernet se utiliza un canal simple de difusión compartida, con acceso aleatorio (cualquier nodo puede transmitir en un instante de tiempo, es decir, no está predefinido en ranuras qué nodo puede transmitir): si dos nodos transmiten a la vez hay una colisión de la que deben recuperarse. Deben coordinarse utilizando el mismo canal que para transmitir (es in-line). El algoritmo de acceso al medio es CSMA/CD (Carrier Sense Multiple Access with Colision Detect). Para transmitir, el adaptador sondea el medio compartido (no utiliza ningún &quot;slot”, ranura o partición de tiempo, frecuencia o código), es decir, utiliza un mecanismo de detección de colisiones. Si está ocupado, espera hasta que se libere; si está libre, comienza a transmitir la trama. Durante la transmisión se compara la señal en el medio con la transmitida –otro nodo puede haber sensado el canal libre y comenzado a transmitir, detectándose después de un intervalo por el tiempo de propagación del medio-.

Si se transmite toda la trama sin detectar colisión: se considera transmisión exitosa. Si se detecta colisión: se aborta la transmisión de la trama, se envía al medio una señal de bloqueo (jam), patrón de 48 bits, asegura que todos los nodos detecten la colisión. Y se espera antes de volver a intentar retransmitir la señal un tiempo aleatorio que puede ser mayor según la cantidad de colisiones detectadas -backoff exponencial-.

Ethernet NO es orientado a conexión (no hay handshaking) y NO es confiable (no hay acks/nacks). Eficiente con baja carga -habrá pocas colisiones-. 

Pasos:

* El adaptador recibe un datagrama de la capa de red y crea la trama.
* Si el adaptador sensa que el canal está libre, éste comienza a transmitir la trama. Si éste sensa canal ocupado, espera hasta que esté libre y transmite.
* Si el adaptador transmite la trama entera sin detectar colisión, se considera transmisión lograda.
* Si el adaptador detecta otra transmisión mientras transmite, aborta y envía una señal de bloqueo (jam)
* Después de abortar, el adaptador entra en backoff exponencial: después de la m- ésima colisión, el adaptador elige un K aleatorio entre {0, 1, 2, …, 2^m-1}. El adaptador espera K·512 periodos de 1 bit y retorna al paso 2.

---

### 6. Investigue los comandos arp e ip neigh. Inicie una topología con CORE, cree una máquina y utilice en ella los comandos anteriores para:

En red de computadoras, el protocolo de resolución de direcciones (ARP, del inglés Address Resolution Protocol) es un protocolo de comunicaciones de la capa de enlace, responsable de encontrar la dirección de hardware (Ethernet MAC) que corresponde a una determinada dirección IP. Para ello se envía un paquete (ARP request) a la dirección de difusión de la red (broadcast, MAC = FF FF FF FF FF FF) que contiene la dirección IP por la que se pregunta, y se espera a que esa máquina (u otra) responda (ARP reply) con la dirección Ethernet que le corresponde.

ARP significa Address Resolution Protocol o protocolo de resolución de direcciones. ARP se utiliza para supervisar y modificar la tabla de asignaciones de direcciones IP y direcciones MAC (Media Access Control). ARP utiliza un cache que consiste en una tabla que almacena las asignaciones entre nivel de enlace de datos y las direcciones IP del nivel de red. El nivel de enlace de datos se encarga de gestionar las direcciones MAC y el nivel de red de las direcciones IP. ARP asocia direcciones IP a las direcciones MAC, justo a la inversa del protocolo RARP que asigna direcciones MAC a las direcciones IP.

Tanto en comando arp (obsoleto) como el ip neighbor muestran y manipulan la tabla cache ARP del sistema.

---

### 7. Dado el siguiente esquema de red, responda:

#### a. Suponiendo que las tablas de los switches están llenas con la información correcta, responda quién escucha el mensaje si:

* La estación 1 envía una trama al servidor 1: Estaciones 2, 3, 4, 5, Servidor 1 y Switch 1.
* La estación 1 envía una trama a la estación 11: Estaciones 2, 3, 4, 5, 11, Servidor 1 y Switch 1.
* La estación 1 envía una trama a la estación 9: Estaciones 2, 3, 4, 5, 8, 9, 10, Servidor 1 y Switch 1 y 2.
* La estación 4 envía una trama a la MAC de broadcast: Todos.
* La estación 6 envía una trama a la estación 7: Estación 7 y Switch 2.
* La estación 6 envía una trama a la estación 10: Estaciones 8, 9, 10 y Switch 2.

#### b. ¿En qué situaciones se pueden producir colisiones?

Todas

---

### 9. ¿Cuál es la finalidad del protocolo ARP?

El Protocolo de Resolución de Direcciones (ARP- Address Resolution Protocol) permite la traducción entre los direccionamientos IP de capa de red y MAC de capa de enlace, dentro de una misma LAN. Se implementa con una tabla IP->MAC en cada host, incluyendo un TTL.

Cada nodo IP (Host o Router) de la LAN tiene una tabla ARP (IP Address, MAC Address, TTL). 

Para enviar un datagrama IP de un host a otro, es necesario conocer tanto su dirección IP como su MAC. ARP permite obtener el último, consultando en la tabla. Si no se encuentra en la tabla, hay dos opciones:

* Que el destino sea del mismo segmento/subred: Se averigua la MAC con una consulta ARP al broadcast físico indicando la IP, y el adaptador que reconoce la IP destino responde con su MAC, que es agregada a la tabla del emisor.

* Que esté en un segmento de red diferente (al aplicar la máscara de (sub)red, se obtiene una dirección distinta a la del origen): En este caso se envía el frame al Gateway (router), que luego continúa retransmitiéndolo. El datagrama en el interior del frame contiene la IP del destino, pero el frame contiene la MAC del Gateway (si no la conoce, utiliza ARP para solicitarla). Al enviarse el frame, es recibido por el router, sube a su capa de red y al ver una IP destino distinta de la suya, vuelve a bajar a enlace para ser retransmitida al próximo router que corresponda según la tabla de ruteo. Eventualmente un router conocerá al equipo destino, y le enviará el datagrama con la MAC correcta, si no la conoce, utiliza ARP.

Al utilizar la dirección de broadcast para obtener la información que precisa, ARP es un protocolo plug-and- play (no precisa configuración).

Los nodos crean sus tablas de ARP sin intervención del administrador, por eso se dice que hay un proceso de autoaprendizaje.

---

