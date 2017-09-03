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


