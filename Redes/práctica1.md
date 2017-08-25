# Práctica 1

#### 1. ¿Qué es una red? ¿Cuál es el principal objetivo para construir una red?

 Haciendo un analisis desde el punto de vista sistemático, se puede decir que una red de computadoras es un grupo de computadoras/dispositivos interconectados con el objetivo de compartir recursos, ya sea información, servicios, etc. El conjunto formado por computadoras, software de red, medios y dispositivos de interconexión forma un sistema de comunicación. Ejemplos de redes de comuncación son: red de sala de PCs, una red universitaria, Internet, etc.

 Los componentes que forman un sistema de comuncación son:
 * Fuente
 * Emisor/Transmisor
 * Medio de transmisión y dispositivos intermedios
 * Procesos intermedios que tratan la información
 * Receptor
 * Destino
 * Otros: Protocolos, Información, mensaje transmitido
 * Señan de Información, materialización del mensaje sobre el medio

---

#### 2. ¿Qué es Internet? Describa los principales componentes que permiten su funcionamiento.

Internet es una red de redes de computadoras, descentralizada, pública, que ejecutan el conjunto abierto de protocolos (suite) TCP/IP. Integra diferentes protocolos de un nivel mas bajo: INTERNETWORKING.

Los componentes que permiten el funcionamiento de internet son:

* Servidores: Computadoras de altas prestaciones que ofrecen servicios a los usuarios.
* Líneas de comunicación primarias entre nodos de internet: “autopistas de información”, junto con los servidores forman la columna vertebral de internet.
* Clientes: Computadoras con los que los usuarios acceden a internet. Estos clientes pueden estar dentro o fuera de la red. Cuando el cliente está fuera, las líneas de comunicación secundarias permiten su conexión con los servidores de internet
* Programas o software específico: está instalado en cada uno de los nodos y hará posible que la red funcione como un todo hablando un idioma común, este idioma se llama TCP/IP.

---

#### 3. ¿Qué son las RFCs?

Request for Comments son una serie de publicaciones del grupo de trabajo de ingeniería de internet que describen diversos aspectos del funcionamiento de Internet y otras redes de computadoras, como protocolos, procedimientos, etc. y comentarios e ideas sobre estos. Cada RFC constituye un monográfico o memorando que ingenieros o expertos en la materia han hecho llegar al IETF, el consorcio de colaboración técnica más importante en Internet, para que éste sea valorado por el resto de la comunidad. De hecho, la traducción literal de RFC al español es "Petición de comentarios".

Los protocolos más importantes de Internet están definidos por RFC, como el protocolo IP detallado en el RFC 791, el FTP en el RFC 959, o el HTTP —escrito por Tim Berners-Lee et al.— en el RFC 2616 (entre otros).

---

#### 4. ¿Qué es un protocolo?

Un protocolo determina el conjunto de conductas y normas a conocer, respetar y cumplir no sólo en el medio oficial ya establecido, sino tambiñen en el medio social y laboral.

Un protocolo define el formato, el orden de los mensajes intercambiados y las acciones que se llevan a cabo en la transmición y/o recepción de un mensaje u otro evento.

Un protocolo de red define un conjunto de reglas que especifican el intercambio de datos u órdenes entre las entidades que forman parte de una red. Permiten la comunicación y están implementados en las componentes.

---

#### 5. ¿Por qué dos máquinas con distintos sistemas operativos pueden formar parte de una misma red?

A principios de los 80', las compañias comenzaron a implementar redes propias (privadas y cerradas). Estas primeras redes propietarias trajeron como consecuencia problemas ya que cada red tenñia sus especificaciones propias (protocolos). Esto conllevó a tener problemas de incompatibilidad, por lo cual la comunicación entre redes era muy difícil, la evolución era muy lenta. Estos problemas de compatibilidad se fueron solucionando con la aparición de distintos estándares que facilitaron estas tareas. Por ejemplo se definieron modelos de organización divididos en capas, lo cual permite dividir la complejidad en componentes reusables. Estas estrategias de abstracción permitieron facilitar el desarrollo y evolución de las componentes de red asegurando interoperabilidad. Este tipo de estándares son los que permiten por ejemplo que dos máquinas con distintos sistemas operativos puedan formar parte de una misma red.

---

#### 6. ¿Cuáles son las 2 categorías en las que pueden clasificarse a los sistemas finales o End Systems? Dé un ejemplo del rol de cada uno en alguna aplicación distribuida que corra sobre Internet.

Las dos categorías son: cliente y servidor. Un ejemplo del rol del lado del servidor es: un servidor Web y del lado del cliente un browser.

---

#### 7. ¿Cuál es la diferencia entre una red conmutada de paquetes de una red conmutada de circuitos?

La conmutación se considera la acción de establecer una vía o camino de extremo a extremo entre dos puntos. Un emisor y un receptor, a través de nodos o equipos de transmisión. La conmutación permite la entrega de la señal desde el origen hasta el destino requerido.

* Conmutación de circuitos: Los equipos de conmutación deben establecer un camino físico entre los medios de comunicación previo a la conexión entre usuarios. Este camino permanece activo durante la comunicación entre los usuarios, liberándose al terminar. ej: llamada telefónica. Son ideales para cuando se requiere que los datos sean transmitidos en tiempo real.

* Conmutación de paquetes: El emisor divide los mensajes a enviar en un número arbitrario de paquetes del mismo tamaño, donde adjunta una cabecera, dirección de origen y dirección de destino, así como datos de control que luego serán transmitidos por diferentes medios de conexión entre nodos temporales hasta llegar a su destino donde los paquetes son reensamblados. Este método de comunicación es el que más se utiliza en las redes de computadoras actuales.

Mientras que la conmutación de circuitos asigna un canal único para cada sesión, en los sistemas de conmutación de paquetes el canal es compartido por muchos usuarios simultáneamente. La conmutación de paquetes es más eficiente y robusta para datos que pueden ser enviados con retraso en la transmisión (no en tiempo real), tales como el correo electronico, paginas web, etc.
En el caso de aplicaciones como voz o video, la conmutación de paquetes no es muy recomendable a menos que se garantice un ancho de banda adecuado para enviar la información. Pero el canal que se establece no garantiza esto, debido a que puede existir tráfico y nodos caídos durante el recorrido de los paquetes.

---

#### 8. Analice qué tipo de red es una red de telefonía y qué tipo de red es Internet

* Red telefónica: Red conmutada de circuitos.
* Internet: Red conmutada de paquetes.

---

#### 9. Describa brevemente las distintas alternativas que conoce para acceder a Internet en su hogar.

Para poder tener acceso a internet desde un hogar lo que se suele hacer es contratar un servicio de internet a una empresa conocida como ISP (internet service provider), la cual nos garantiza una conexión a nuestro hogar a travez de difrentes tipos de conexiones. Éstas pueden ser por cable coaxial, fibra óptica, ADSL, etc. Normalmente se suele instalar un modem que convertirá las señales digitales en analógicas y viceversa. Éste permite así la comunicación entre las computadoras a través de las distintas conexiones. Finalemnte los dispositivos para poder tener acceso a Internet, se deben conectar al modem ya sea de forma directa por Ethernet, o utilizando un router o distintos dispositivos que permiten la conexión a éste (ya sea de manera cableada o wireless).

---

#### 10. ¿Qué ventajas tiene una implementación basada en capas o niveles?

La cantidad de componentes de red a interactuar genera complejidad, se requiere una organización de las mismas.

Un modelo en capas divide la complejidad en componentes reusables. Alguas de las ventajas que estos modelos proveen son:

* Reduce complejidad en componente más pequeñas.
* Las capas de abajo ocultan la complejidad a las de arriba abstracción.
* Las capas de arriba utilizan servicios de las de abajo:
Interfaces, similar a APIs.
* Los cambios en una capa no deberían afectar a las demás
si la interfaz se mantiene.
* Facilita el desarrollo, evolución de las componentes de red
asegurando interoperabilidad.
* Facilita aprendizaje, diseño y administración de las redes.

---

#### 11. ¿Cómo se llama la PDU de cada una de las siguientes capas: Aplicación, Transporte, Red y Enlace?

Cada capa define su PDU: Protocol Data Unit.

| Capa          | PDU           |
| ------------- | ------------- |
| Aplicación    | Datos         |
| Transporte    | Segmento      |
| Red           | Paquete       |
| Enlace        | Trama         |
| Física        | Bit           |

---

#### 12. . ¿Qué es la encapsulación? Si una capa realiza la encapsulación de datos, ¿qué capa del nodo receptor realizará el proceso inverso?

Encapsulación o encapsulamiento se refiere al proceso por el cual, cada capa de la pila de protocolos (excepto la de aplicación), añade información adicional (denominada información de cabecera) al PDU recibido de la capa superior, formando así, el PDU correspondiente a la capa receptora. Los PDUs sirven para gobernar el comportamiento completo del protocolo en sus funciones de establecimiento y unión de la conexión, control de flujo, control de errores, etc.

En cada capa, un paquete está formado por dos tipos de campos: un campo de cabecera y un campo de carga útil. Normalmente, la carga útil es un paquete de la capa superior.

Si una capa X realiza el encapsulamiento en el nodo emisor. La misma capa X será la encargada de hacer el proceso inverso en el nodo receptor.

---

#### 13. Describa cuáles son las funciones de cada una de las capas del stack TCP/IP o protocolo de Internet.

Capas del stack TCP/IP o protocolo de internet:

* Capa de Aplicacion
* Capa de Transporte
* Capa de Red
* Capa de Enlace
* Capa Fisica

**Capa de Aplicacion**

La capa de aplicacion es donde aplicaciones de red y sus protocolos de la capa de aplicacion residen. Esta capa incluye muchos protocolos, como el protocolo HTTP (el cual provee servicios para peticiones de documentos Web y transferencias,y FTP (el cual se utiliza para la transferencias de archivos entre dos sistemas finales). Otro ejemplo de protocolo que se ubica en esta capa es el de DNS, el cual sirve para traducir nombres de dominio. 

Un protocolo de la capa de aplicacion es distribuido sobre multiples sistemas finales, con la aplicacion en un sistema final usando el protocolo para intercambiar paquetes de informacion con la aplicacion en otro sistema final. A menudo, en la capa de aplicacion se refiere a este paquete de informacion como 'mensaje'.

**Capa de Transporte**

La capa de transporte de Internet transporta mensajes de la capa de aplicacion entre distintos puntos. En Internet hay dos protocolos de transporte, TCP y UDP, ambos de los cuales pueden transportar ensajes de la capa de aplicacion. TCP provee un servicio orientado a conecciones a sus aplicaciones. Este servicio incluye garantia en la distribucion de mensajes de la capa de aplicacion a sus destinos. TCP tambien 'rompe' mensajes largos en segmentos mas pequenos y provee un mecanismo de control de congestion. El protocolo UDP provee un servicio libre de conecciones a sus aplicaciones. Este es un servicio que no provee confiabilidad, ni control de flujo ni control de congestion. A menudo, en la capa de transporte se refiere a un paquete como un segmento.

**Capa de Red**

La capa de red es responsable de mover paquetes de la capa de red, conocidos como datagramas, de un host a otro. El protocolo de la capa de transporte (TCP o UDP) en un host fuente, pasa un segmento de la capa de transporte y una direccion de destino a la capa de red. La capa de red luego provee el servicio de distribuir el segmento a la capa de transporte en el host destino.

La capa de red incluye al protocolo IP, el cual define los campos en los datagramas, asi como tambien la forma en que los sistemas finales y los routers actuan sobre estos campos. Existe un unico protocolo IP, y todos los componentes de Internet que tienen una capa de red, deben correr el protocolo IP. La capa de red tambien contiene protocolos de ruteo que determinan las rutas que los datagramas toman entre origenes y destinos. Internet tiene muchos protocolos de ruteo. Como ya se sabe Internet es una red de redes, y dentro de una red el administrador de la red puede correr cualquier protocolo de ruteo deseado. Aunque la capa de red contiene tanto el ptorocolo IP como los protocolos de ruteo, a menudo simplemente se la refiere como la capa IP, reflejando el hecho de que IP es el 'pegamento' que une a Internet.

**Capa de Enlace**

La capa de red rutea un datagrama a traves de una serie de routers entre el origen y el destino. Para mover un paquete de un nodo (host o router) al siguiente nodo en la ruta, la capa de red depende de los servicios de la capa de enlace. En particular, en cada nodo, la capa de red pasa el datagrama a la capa de enlace, la cual distribuye el datagrama al siguiente nodo a lo largo de la ruta. En este siguiente nodo, la capa de enlace pasa el datagrama a la capa de red.

Los servicios provistos por la capa de enlace dependen en el protocolo especifico que es empleado por el enlace. Por ejemplo, algunos protocolos de la capa de enlace proveen una distribucion garantizada para la transmicion sobre un enlace. Vale aclarar que este servicio de distribucion fiable es diferente a la fiabilidad del servicio TCP, el cual provee seguridad desde un sistema final a otro sistema. Ejemplos de protocolos de la capa de enlace son: Ethernet, WiFi, y PPP. Como los datagramas normalmente necesitan atravesar una gran cantidad de enlaces desde un origen a un destino, un datagrama puede llegar a ser manejado por diferentes protocolos de la capa de enlace en los diferentes enlaces a lo largo de la ruta. La capa de red recivira diferentes servicios por cada uno de los diferentes protocolos de la capa de enlace. A menudo, en esta capa se referencian a los paquetes como frames.

**Capa Fisica**

Mientras que el trabajo de la capa de enlace es mover frames enteros de un elemento de red a otro adyacente, el trabajo de la capa fisica es mover los bits individuales que estan dentro del frame de un nodo al proximo. Los protocolos en esta capa son dependientes al enlace y por ende tambien del medio actual de transmicion del enlace (por ejemplo cable de cobre, fibra optica, etc). Por ejemplo, Ethernet tiene muchos protocolos de la capa fisica: uno para cables de cobre, otro para cable coaxial, otro para fibra optica, etc. En cada caso, un bit es movido a traves del enlace de una manera distinta.

---

#### 14. Compare el modelo OSI con la implementación TCP/IP.

El modelo OSI se compone de 7 capas: 

* Capa de Presentación
* Capa de Sesión 
* Capa de Transporte
* Capa de Red
* Capa de Enlace de Datos
* Capa Física

La funcionalidad de cinco de estas capas es aproximadamente la misma que las que se ven en el stack TCP/IP. El rol de la capa de presentación es proveer servicios que permiten a aplicaciones de comunicacion interpretar el significado de datos intercambiados. Estos servicios incluyen compresión, encriptación y descripcion de datos. La capa de sesión provee proporciona los mecanismos para controlar el diálogo entre las aplicaciones de los sistemas finales. En muchos casos, los servicios de la capa de sesión son parcialmente, o incluso, totalmente prescindibles.

Es responsabilidad del desarrollador de la aplicación decidir si un servicio es importante, y si lo es, depende del desarrollador contruir esa funcionalidad en la aplicación.
