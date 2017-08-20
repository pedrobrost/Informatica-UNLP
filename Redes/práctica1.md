# Práctica 1

> 1. ¿Qué es una red? ¿Cuál es el principal objetivo para construir una red?

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

> 2. ¿Qué es Internet? Describa los principales componentes que permiten su funcionamiento.

Internet es una red de redes de computadoras, descentralizada, pública, que ejecutan el conjunto abierto de protocolos (suite) TCP/IP. Integra diferentes protocolos de un nivel mas bajo: INTERNETWORKING.

Los componentes que permiten el funcionamiento de internet son:

* Servidores: Computadoras de altas prestaciones que ofrecen servicios a los usuarios.
* Líneas de comunicación primarias entre nodos de internet: “autopistas de información”, junto con los servidores forman la columna vertebral de internet.
* Clientes: Computadoras con los que los usuarios acceden a internet. Estos clientes pueden estar dentro o fuera de la red. Cuando el cliente está fuera, las líneas de comunicación secundarias permiten su conexión con los servidores de internet
* Programas o software específico: está instalado en cada uno de los nodos y hará posible que la red funcione como un todo hablando un idioma común, este idioma se llama TCP/IP.

> 3. ¿Qué son las RFCs?

Request for Comments son una serie de publicaciones del grupo de trabajo de ingeniería de internet que describen diversos aspectos del funcionamiento de Internet y otras redes de computadoras, como protocolos, procedimientos, etc. y comentarios e ideas sobre estos. Cada RFC constituye un monográfico o memorando que ingenieros o expertos en la materia han hecho llegar al IETF, el consorcio de colaboración técnica más importante en Internet, para que éste sea valorado por el resto de la comunidad. De hecho, la traducción literal de RFC al español es "Petición de comentarios".

Los protocolos más importantes de Internet están definidos por RFC, como el protocolo IP detallado en el RFC 791, el FTP en el RFC 959, o el HTTP —escrito por Tim Berners-Lee et al.— en el RFC 2616 (entre otros).

> 4. ¿Qué es un protocolo?

Un protocolo determina el conjunto de conductas y normas a conocer, respetar y cumplir no sólo en el medio oficial ya establecido, sino tambiñen en el medio social y laboral.

Un protocolo define el formato, el orden de los mensajes intercambiados y las acciones que se llevan a cabo en la transmición y/o recepción de un mensaje u otro evento.

Un protocolo de red define un conjunto de reglas que especifican el intercambio de datos u órdenes entre las entidades que forman parte de una red. Permiten la comunicación y están implementados en las componentes.

> 5. ¿Por qué dos máquinas con distintos sistemas operativos pueden formar parte de una misma red?

A principios de los 80', las compañias comenzaron a implementar redes propias (privadas y cerradas). Estas primeras redes propietarias trajeron como consecuencia problemas ya que cada red tenñia sus especificaciones propias (protocolos). Esto conllevó a tener problemas de incompatibilidad, por lo cual la comunicación entre redes era muy difícil, la evolución era muy lenta. Estos problemas de compatibilidad se fueron solucionando con la aparición de distintos estándares que facilitaron estas tareas. Por ejemplo se definieron modelos de organización divididos en capas, lo cual permite dividir la complejidad en componentes reusables. Estas estrategias de abstracción permitieron facilitar el desarrollo y evolución de las componentes de red asegurando interoperabilidad. Este tipo de estándares son los que permiten por ejemplo que dos máquinas con distintos sistemas operativos puedan formar parte de una misma red.

> 6. ¿Cuáles son las 2 categorías en las que pueden clasificarse a los sistemas finales o End Systems? Dé un ejemplo del rol de cada uno en alguna aplicación distribuida que corra sobre Internet.

Las dos categorías son: cliente y servidor. Un ejemplo del rol del lado del servidor es: un servidor Web y del lado del cliente un browser.

> 7. ¿Cuál es la diferencia entre una red conmutada de paquetes de una red conmutada de circuitos?

La conmutación se considera la acción de establecer una vía o camino de extremo a extremo entre dos puntos. Un emisor y un receptor, a través de nodos o equipos de transmisión. La conmutación permite la entrega de la señal desde el origen hasta el destino requerido.

* Conmutación de circuitos: Los equipos de conmutación deben establecer un camino físico entre los medios de comunicación previo a la conexión entre usuarios. Este camino permanece activo durante la comunicación entre los usuarios, liberándose al terminar. ej: llamada telefónica. Son ideales para cuando se requiere que los datos sean transmitidos en tiempo real.

* Conmutación de paquetes: El emisor divide los mensajes a enviar en un número arbitrario de paquetes del mismo tamaño, donde adjunta una cabecera, dirección de origen y dirección de destino, así como datos de control que luego serán transmitidos por diferentes medios de conexión entre nodos temporales hasta llegar a su destino donde los paquetes son reensamblados. Este método de comunicación es el que más se utiliza en las redes de computadoras actuales.

Mientras que la conmutación de circuitos asigna un canal único para cada sesión, en los sistemas de conmutación de paquetes el canal es compartido por muchos usuarios simultáneamente. La conmutación de paquetes es más eficiente y robusta para datos que pueden ser enviados con retraso en la transmisión (no en tiempo real), tales como el correo electronico, paginas web, etc.
En el caso de aplicaciones como voz o video, la conmutación de paquetes no es muy recomendable a menos que se garantice un ancho de banda adecuado para enviar la información. Pero el canal que se establece no garantiza esto, debido a que puede existir tráfico y nodos caídos durante el recorrido de los paquetes.

> 8. Analice qué tipo de red es una red de telefonía y qué tipo de red es Internet

* Red telefónica: Red conmutada de circuitos.
* Internet: Red conmutada de paquetes.

> 9. Describa brevemente las distintas alternativas que conoce para acceder a Internet en su hogar.

Para poder tener acceso a internet desde un hogar lo que se suele hacer es contratar un servicio de internet a una empresa conocida como ISP (internet service provider), la cual nos garantiza una conexión a nuestro hogar a travez de difrentes tipos de conexiones. Éstas pueden ser por cable coaxial, fibra óptica, ADSL, etc. Normalmente se suele instalar un modem que convertirá las señales digitales en analógicas y viceversa. Éste permite así la comunicación entre las computadoras a través de las distintas conexiones. Finalemnte los dispositivos para poder tener acceso a Internet, se deben conectar al modem ya sea de forma directa por Ethernet, o utilizando un router o distintos dispositivos que permiten la conexión a éste (ya sea de manera cableada o wireless).

> 10. ¿Qué ventajas tiene una implementación basada en capas o niveles?

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

> 11. ¿Cómo se llama la PDU de cada una de las siguientes capas: Aplicación, Transporte, Red y Enlace?

Cada capa define su PDU: Protocol Data Unit.

| Capa          | PDU           |
| ------------- | ------------- |
| Aplicación    | Datos         |
| Transporte    | Segmento      |
| Red           | Paquete       |
| Enlace        | Trama         |
| Física        | Bit           |

