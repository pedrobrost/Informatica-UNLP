# Práctica 3

### 1. Investigue y describa cómo funciona el DNS. ¿Cuál es su objetivo?

El sistema de nombres de dominio (DNS, por sus siglas en inglés, Domain Name System) es un sistema de nomenclatura jerárquico descentralizado para dispositivos conectados a redes IP como Internet o una red privada. Este sistema asocia información variada con nombre de dominio asignado a cada uno de los participantes. Su función más importante es "traducir" nombres inteligibles para las personas en identificadores binarios asociados con los equipos conectados a la red, esto con el propósito de poder localizar y direccionar estos equipos mundialmente.

El servidor DNS utiliza una base de datos distribuida y jerárquica que almacena información asociada a nombres de dominio en redes como Internet. Aunque como base de datos el DNS es capaz de asociar diferentes tipos de información a cada nombre, los usos más comunes son la asignación de nombres de dominio a direcciones IP y la localización de los servidores de correo electrónico de cada dominio.

La asignación de nombres a direcciones IP es ciertamente la función más conocida de los protocolos DNS. Por ejemplo, si la dirección IP del sitio Google es 216.58.210.163, la mayoría de la gente llega a este equipo especificando www.google.es y no la dirección IP. Además de ser más fácil de recordar, el nombre es más fiable. La dirección numérica podría cambiar por muchas razones, sin que tenga que cambiar el nombre tan solo la IP del sitio web.

---

### 2. ¿Qué es un root server? ¿Qué es un generic top-level domain (gtld)?

DNS utiliza un gran número de servidores, organizados de forma jerárquica y distribuidos alrededor del mundo. Ningún servidor DNS dispone de todas las correspondencias de todos los hosts de Intenet. En su lugar, las correspondencias están repartidas por los servidores DNS. Podemos decir que existe 3 clases de servidores DNS:

* **Los servidores DNS raízu**: Existen 13 servidores DNS raíz (etiquetados de la A hasta la M), la mayoría de los cuales se localizan en América del Norte. Cada “servidor” es una agrupación (cluster) de servidores replicados (seguridad y fiabilidad).

* **Los servidores DNS de dominio de nivel superior (TLD, Top-LevelDomain)**: Estos servidors son respondables de los dominios de nivel superior.

1. **Generic TLD (gTLD)**: contienen dominios con propósitos particulares, de acuerdo a diferentes actividades, como son .com, .org, .net, .edu, y .gov, etc.

2. **Country-Code TLD (ccTLD)**: son todos los dominios de nivel superior correspondientes a los distintos países, como por ejemplo, uk, fr, ca y jp.

3. **.ARPA TLD**: es un dominio especial, usado internamente por los protocolos, creado para resolución de reversos de direcciones a nombres.

* **Los servidores DNS autoritativos**: Albergan los registros DNS que establecen la correspondencia entre los nombres de host y las direcciones IP. Todas las organizaciones que tienen hosts accesibles públicamente a través de internet deben proporcionar dichos registros DNS. Una organización puede elegir implementar su propio servidor DNS autoritativo para almacenar estos registros o puede pagar por tener esos registros almacenados en un servidor DNS autoritativo de algún proveedor de servicios.

También existe el servidor DNS local. Que actúa como proxy reenviando las consultas a la jerarquía de servidores DNS.Mantiene una cache con los nombres que va resolviendo. También puede ser un Servidor Autoritativo, en algunas organizaciones tienen sus propios servidores autoritativos (universidades y grandes empresas), así en la red local de estas, primero interactúan con un servidor DNS local, que a la vez es un servidor autoritativo.

---

### 3. ¿Qué es una respuesta del tipo autoritativa?

Una respuesta autoritativa es cuando una consulta DNS es respondida por el servidor autoritativo sobre un nombre de dominio en el cual tiene autoridad. Cuando la respuesta es emitida por un servidor DNS local, y este no oficia de servidor autoritativo para ese dominio es decir, que lo obtiene de cache), esta respuesta es NO-Autoritativa.

---

### 4. ¿Qué diferencia una consulta DNS recursiva de una iterativa?

La solicitud de una búsqueda recursiva hace solicitudes sucesivas de la dirección IP al dominio y si no la obtiene, hace nuevas solicitudes hasta encontrarla. La solicitud de búsqueda iterativa realiza una búsqueda en la base de datos de la dirección IP relacionada con el nombre de dominio, si no la obtiene pregunta al dominio donde realizar la próxima búsqueda. Si la consulta es recursiva, la resolución prevé la dirección de nuevo sin necesidad de realizar ningún otra consulta. Si es iterativa, el servidor DNS devuelve una dirección donde puede estar ubicada la dirección y si no, se conserva en la misma dirección. La resolución depende de la posibilidad de contactar la dirección o si se debe ubicar una ruta a través de su propia lista de servidores DNS.

---

### 5. ¿Qué es el resolver?

El funcionamiento del DNS se realiza en un esquema cliente/servidor, siendo el cliente cualquier aplicación que requiera la resolución de nombres. El código (instrucciones de maquina) del cliente se lo agrupa en un módulo llamado Resolver. El Resolver se lo podría considerar como un agente encargado de resolver los nombres a solicitud del cliente, por ejemplo: un servidor web, el cliente telnet, un navegador web, un servidor de mail, etc. Este agente, generalmente, no se implementa como un servicio activo, sino como un conjunto de rutinas encapsuladas en una biblioteca de funciones que se link-edita conjuntamente con la aplicación.

---

### 6. Describa para qué se utilizan los siguientes tipos de registros de DNS:

#### A y AAAA

El registro "A" hace referencia a la Dirección y es el tipo más básico de sintaxis de DNS.  Indica la dirección de IP real de un dominio.  El registro "AAAA" (también conocida como dirección IPV6) indica el nombre de alojamiento a una dirección IPv6 de 128 bits.  Las direcciones DNS normales se mapean para direcciones IPv4 de 32 bits.

#### MX

El registro "MX" o intercambio de correo es principalmente una lista de servidor de intercambio de correo que se debe utilizar para el dominio.

#### PTR

Puedes pensar en el registro PTR como lo opuesto del registro A. Mientras que un registro A apunta a una IP, el PTR resuelve una IP a un Dominio/Servidor. Los registros PTR se utilizan para la búsqueda de las DNS inversas. Utilizando la IP puede ver a qué dominio/servidor se encuentra asociada. Debe existir un registro A para cada PTR.

#### SRV

Un registro "SRV" significa "Servicio". Se utiliza para la definición de un servicio TCP en el que opera el dominio.

#### NS

El registro "NS" significa Servidor de nombres e indica qué nombre del servidor es el autorizado para el dominio.

#### CNAME

El registro de "CNAME" significa nombre canónico y su función es hacer que un dominio sea un alias para otro. El CNAME generalmente se utiliza para asociar nuevos subdominios con dominios ya existentes de registro A.

#### SOA

Un registro "SOA" significa "Comienzo de autoridad". Evidentemente, es uno de los registros DNS más importantes, dado que guarda información esencial, como la fecha de la última actualización del dominio y otros cambios y actividades.

#### TXT

Un registro "TXT" significa "Texto". Esta sintaxis de DNS permite que los administradores inserten texto en el registro DNS. A menudo se utiliza para denotar hechos o información sobre el dominio.

---

### 7. En la VM, utilice el comando dig para obtener la dirección IP del host www.redes.unlp.edu.ar. Responda:

#### a. ¿La solicitud fue recursiva? ¿Y la respuesta? ¿Cómo lo sabe?

El flag `rd` (recursion desired) nos indica que la solicitud fue recursiva.

El flag `ra` (recursion available) nos indica que el servidor puede responder recursivamente.

#### b. ¿Puede indicar si se trata de una respuesta autoritativa?

El flag `aa` (authoritative answer) nos indica que la respuesta fue autoritativa.

#### c.  ¿Cuál es la dirección IP del servidor de DNS al que le realizó la consulta? ¿Cómo lo sabe?

SERVER: `172.28.0.29`

#### d. ¿Es posible obtener la misma información con el comando host? ¿Cómo?

`host -v www.redes.unlp.edu.ar`

---

### 8. Usando el comando dig, averigüe la dirección IP de www.google.com. Observe los números que aparecen antes de la palabra IN. Vuelva a ejecutar la misma consulta y observe nuevamente esos números. ¿Qué ocurrió? ¿Por qué? ¿Qué significado cree que tienen dichos números?

Direccion IP de Google: `172.217.28.196`

El número que aparece hace referencia al TTL (time to live), el cual le dice a los dns servers locales cuanto tiempo se deberia cachear el registro. Cuando hacemos un request a un servidor no autoritativo obtendremos este número decrementandosé, en cambio si el request lo hacemos sobre un servidor autoritativo obtendremos el numero seteado para el determinado registro.

---


