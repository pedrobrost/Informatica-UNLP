# Práctica 5

### 1. ¿Cuál es la función de la capa de transporte?

Un protocolo de la capa de transporte proporciona una comunicación lógica entre procesos de aplicación que se ejecutan en hosts diferentes. Por comunicación lógica queremos decir que, desde la perspectiva de la aplicación, es como si los hosts que ejecutan los procesos estuvieran conectados directamente.

Internet tiene dos protocolos: TCP y UDP. Cada uno de estos protocolos proporciona un conjunto diferente de servicios para la capa de transporte a la aplicación que lo haya invocado.

La responsabilidad principal de UDP y TCP es ampliar el servicio de entrega de IP entre dos sistemas terminales a un servicio de entrega entre dos procesos que estén ejecutándose en los sistemas terminales. Extender la entrega host a host a una entrega proceso a proceso es lo que se denomina multiplexación y demultiplexación de la capa de transporte. UDP y TCP también proporcionan servicios de comprobación de la integridad de los datos al incluir campos de detección de errores en las cabeceras de sus segmentos. Estos dos servicios de la capa de transporte (entrega de datos proceso a proceso y comprobación de errores) son los dos únicos servicios que ofrece UDP. En particular, al igual que IP, UDP es un servicio no fiable, que no garantiza que los datos enviados por un proceso lleguen intactos al proceso de destino. 

TCP, por el contrario, ofrece a las aplicaciones varios servicios adicionales. El primero y más importante es que proporciona una transferencia de datos fiable. Utilizando técnicas de control de flujo, números de secuencia, mensajes de reconocimiento y temporizadores. TCP garantiza que los datos transmitidos por el proceso emisor sean entregados al proceso receptor, correctamente y en orden. De este modo, TCP convierte el servicio no fiable de IP entre sistemas terminales en un servicio de transporte de datos fiable entre procesos. TCP también proporciona mecanismos de control de congestión.

---

### 2. Describa la estructura del segmento TCP y UDP.

En el lado emisor, la capa de transporte convierte los mensajes que recibe, procedentes de un proceso de aplicación emisor, en paquetes de la capa de transporte, conocidos como segmentos de la capa de transporte. Muy posiblemente, esto se hace dividiendo los mensajes de la aplicación en fragmentos más pequeños y añadiendo una cabecera de la capa de transporte a cada fragmento, con el fin de crear el segmento de la capa de transporte.

**UDP**

La cabecera UDP consta de 4 campos de los cuales 2 son opcionales. Los campos de los puertos origen y destino son campos de 16 bits que identifican el proceso de emisión y recepción. Ya que UDP carece de un servidor de estado y el origen UDP no solicita respuestas, el puerto origen es opcional. En caso de no ser utilizado, el puerto origen debe ser puesto a cero. A los campos del puerto destino le sigue un campo obligatorio que indica el tamaño en bytes del datagrama UDP incluidos los datos. El valor mínimo es de 8 bytes. El campo de la cabecera restante es una suma de comprobación de 16 bits que abarca una pseudo-cabecera IP (con las IP origen y destino, el protocolo y la longitud del paquete UDP), la cabecera UDP, los datos y 0's hasta completar un múltiplo de 16. El checksum también es opcional en IPv4, aunque generalmente se utiliza en la práctica (en IPv6 su uso es obligatorio).


**TCP**

El segmento TCP consta de campos de cabecera y un campo de datos. El campo de datos contiene un fragmento de los datos de la aplicación. El MSS limita el tamaño máximo del campo de datos de un segmento.  Cuando TCP envía un archivo grande, normalmente divide el archivo en fragmentos de tamaño MSS.

TCP. Al igual que con UDP, la cabecera incluye los número de puerto de origen y de destino, que se utilizan para multiplexar y demultiplexar los datos de y para las aplicaciones de la capa superior. También, al igual que UDP, la cabecera incluye un campo de suma de comprobación. La cabecera de un segmento TCP también contiene los siguientes campos:
 
* El campo número de secuencia de 32 bits y el campo número de reconocimiento también de 32 bits son utilizados por el emisor y el receptor de TCP para implementar un servicio de transferencia de datos fiable.

* El campo ventana de recepción de 16 bits se utiliza para el control de flujo. Se emplea para indicar el número de bytes que un receptor está dispuesto a aceptar.

* El campo longitud de cabecera de 4 bits especifica la longitud de la cabecera TCP en palabras de 32 bits. La cabecera TCP puede tener una longitud variable a causa del campo opciones de TCP (normalmente, este campo está vacío, por lo que la longitud de una cabecera TCP típica es de 20 bytes).

* El campo opciones es opcional y de longitud variable. Se utiliza cuando un emisor y un receptor negocian el tamaño máximo de segmento (MSS) o como un factor de escala de la ventana en las redes de alta velocidad. También se define una opción de marca temporal.

* El campo indicador tiene 6 bits. El bit ACK se utiliza para indicar que el valor transportado en el campo de reconocimiento es válido; es decir, el segmento contiene un reconocimiento para un segmento que ha sido recibido correctamente. Los bits RST, SYN y FIN se utilizan para el establecimiento y cierre de conexiones. La activación del bit PSH indica que el receptor deberá pasar los datos a la capa superior de forma inmediata. Por último, el bit URG se utiliza para indicar que hay datos en este segmento que la entidad de la capa superior del lado emisor ha marcado como “urgentes”. La posición de este último byte de estos datos urgentes se indica mediante el campo puntero de datos urgentes de 16 bits. TCP tiene que informar a la entidad de la capa superior del lado receptor si existen datos urgentes y pasarle un puntero a la posición donde finalizan los datos urgentes. En la práctica, PSH, URG y el puntero a datos urgentes no se utilizan.

---

### 3. ¿Cuál es el objetivo del uso de puertos en el modelo TCP/IP?

En primer lugar, recordemos que un proceso puede tener uno o más sockets, puertas por las que pasan los datos de la red al proceso, y viceversa. Por tanto, la capa de transporte del host receptor realmente no entrega los datos directamente a un proceso, sino a un socket intermedio, que a su vez tiene un identificador único (ya que puede haber más de uno por host).

Cada segmento de la capa de transporte contiene un conjunto de campos destinados para identificar el socket apropiado (entre otros). En el extremo receptor, la capa de transporte examina estos campos para identificar el socket receptor y, a continuación, envía el segmento a dicho socket. Esta tarea de entregar los datos contenidos en un segmento de la capa de transporte al socket correcto es lo que se demultiplexación. La tarea de reunir los fragmentos de datos en el host de origen desde los diferentes sockets, encapsulando cada fragmento de datos con la información de cabecera (el cual se utilizará después en el proceso de demultiplexación) para crear los segmentos y pasarlos a la capa de red es lo que se denomina multiplexación. Es importante darse cuenta de que estas técnicas son necesarias siempre que un único protocolo en una capa (cualquiera) sea utilizado por varios protocolos de la capa inmediatamente superior.

Sabemos que la operación de multiplexación que se lleva a cabo en la capa de transporte requiere (1) que los sockets tengan identificadores únicos y (2) que cada segmento tenga campos especiales que indiquen el socket al que tiene que entregarse el segmento. Estos campos especiales, son el campo número de puerto origen y número de puerto destino.  

Cada número de puerto es un número de 16 bits comprendido en el rango de 0 a 65535. Los números de puerto pertenecientes al rango de 0 a 1023 se conocen como números de puertos bien conocidos y son restringidos, lo que significa que están reservados para ser empleados por los protocolos de aplicación bien conocidos (ej. HTTP que utiliza el puerto 80 y FTP que utiliza el puerto 21).

---


