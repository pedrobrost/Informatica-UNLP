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

A principios de los 80', Las compañias comenzaron a implementar redes propias (privadas y cerradas). Estas primeras redes propietarias trajeron como consecuencia problemas ya que cada red tenñia sus especificaciones propias (protocolos). Esto conllevó a tener problemas de incompatibilidad, por lo cual la comunicación entre redes era muy difícil, la evolución era muy lenta. Estos problemas de compatibilidad se fueron solucionando con la aparición de distintos estándares que facilitaron estas tareas. Por ejemplo se definieron modelos de organización divididos en capas, lo cual permite dividir la complejidad en componentes reusables. Estas estrategias de abstracción permitieron facilitar el desarrollo y evolución de las componentes de red asegurando interoperabilidad. Este tipo de estándares son los que permiten por ejemplo que dos máquinas con distintos sistemas operativos puedan formar parte de una misma red.

