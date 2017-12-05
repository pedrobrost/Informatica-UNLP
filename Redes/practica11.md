# Práctica 11 - Capa de Enlace - Parte II

### 1. Si la PC A está en una red y se quiere comunicar con la PC B que está en otra red:

#### a. ¿Como se da cuenta la PC A de esto?

Porque aplica su máscara de red en su propia IP y en la IP destino y obtiene distinto resultado.

#### b. Si la tabla ARP de la PC A esta vacía, ¿que dirección MAC necesita la PC A para poder comunicarse con la PC B?

Como la PC B está en otra red, el frame deberá ser enviado al default gateway, por ende se necesitará esta dirección MAC. Como la tabla ARP está vacía, se deberá primero encontrar esta dirección enviando un frame con la dirección destino correspondiente a la de broadcast.

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

**IP:**

* ip progen: `ip-pca`
* ip destino; `ip gateway`

---

### 2. En la siguiente topología de red indique:

#### a. ¿Cuántos dominios de colisión hay?

`5`

#### b. ¿Cuántos dominios de broadcast hay?

`1`

#### d. . Si la PC E y la PC D hubiesen estado realizando un tcpdump para escuchar todo lo que pasa por su interfaz de red, ¿cuáles de los requerimientos/respuestas anteriores hubiesen escuchado cada una?

Ambas PC hubiesen recibido las tramas enviadas por la PC-A al hacer las consultas por las direcciones MAC de PC-B y PC-C. Además cuando la PC-C envia su respuesta de ARP, al estar conectado a un HUB/Repetidor, dicha trama tambien es recibida por la PC_D.

---

### 3. En la siguiente topología:

Suponiendo que todas las tablas ARP están vacías, tanto de PCs como de Routers. Si la PC-A le hace un ping a la PC-C, indique:

#### a. ¿En qué dominios de broadcast hay tráfico ARP?

Todos

#### b. ¿En qué dominios de broadcast hay tráfico ICMP?

Todos

---

### 4. Calcule los códigos de detección de error para las siguientes cadenas de bits utilizando paridad par y luego utilizando paridad impar:

#### a. 11010110101001111

* Par: 1
* Impar: 0

#### b. 01011101011000010

* Par: 0
* Impar: 1

#### c. 00100010001000111

* Par: 0
* Impar: 1

---

### 5. Se desea enviar la secuencia de bits 1100000111. Calcular la secuencia completa (datos + FCS) a transmitir considerando que el polinomio generador a utilizar es: G(x) = x^5 + x^4 + 1.

* G = 110001
* FCS = 11010
* Resultado: 110000011111010

---

### 6. Encontrar el FCS si se utiliza la función generadora G=1001 y el mensaje M=11100011.

FCS: 100

---

### 7. Indicar si es verdadero o falso. Justifique su respuesta.

#### a. Si se utiliza paridad par y se invierte el valor de 2 bits a causa de errores en la transmisión, el receptor detectará el error.

Falso

#### b. 00101011 es un valor válido para ser usado como polinomio generador y el resto sería de 7 bits de longitud.

Falso

#### c. Los FCS calculados con el polinomio generador 11001 tendrán una longitud de 4 bits.

Verdadero

---

### 8. ¿Existe ARP en IPv6? ¿Por qué? ¿Quién cumple esa función?

No, no existe. Su reemplazante se llama “Neighbor Discovery” que mapea las direcciones lógicas (IPv6) a direcciones de hardware (MAC, EUI-48, EUI-64). Trabaja conjuntamente con Ethernet (u otros protocolos de L2 multiacceso con broadcast: Bluetooth, Token Ring, FDDI, 802.11). Trabaja de forma dinámica, auto-aprendizaje, sin configuración. Puede configurarse de forma estática. Definido en RFC-4861.

La difusión del Protocolo de Resolución de Dirección (Address Resolution Protocol, ARP) de IPv4 afecta la eficiencia de la red. Esta situación no ha sido incluida en IPv6, y en su lugar se utiliza el Multicasting el cual funciona de la siguiente manera: 

Se crea un grupo Multicast, formado por conjunto de interfaces de red.
Si se está interesado en que cierta computadora reciba los paquetes de difusión del grupo se agrega una interfaz de red, de esa forma se envía un paquete multicast al grupo X.
Ese paquete sólo llegará a aquellas computadoras que tengan su interfaz incluida en el grupo multicast X. Con ello se permite tener niveles de eficiencia de red superiores a los presentados en IPv4, lo cual se verá traducido en la disminución de los ciclos de procesamiento de CPU de las computadoras en la red local al no procesar paquetes de difusión que no van dirigidos a ellos y de la misma manera se estará eliminando el problema de las tormentas de paquetes de difusión de IPv4.

---

### 9. ¿Qué es la IEEE 802.3? ¿Existen diferencias con Ethernet?

Ethernet es una implementación que se convirtió en estándar de facto para LANs con acceso al medio tipo CSMA/CD, definiendo las características de cableado y señalización de nivel físico y los formatos de tramas de datos del nivel de enlace de datos del modelo OSI. Las primeras versiones surgieron en los '70.  Ethernet se tomó como base, en el '83, para la redacción del estándar formal IEEE 802.3, manejándose usualmente como sinónimos, aunque se diferencian en uno de los campos de la trama de datos.

Las tecnologías más comunes de tipo Ethernet están agrupadas en el estándar 802.3 (10Base2, 10BaseT, 100BaseT, Gigabit Ethernet...). Se suele hacer referencia a Ethernet como una LAN 802.3.

La diferencia más significativa entre la tecnología Ethernet original y el estándar IEEE 802.3 es la diferencia entre los formatos de sus tramas. Esta diferencia es lo suficientemente significativa como para hacer a las dos versiones incompatibles.

Una de las diferencias entre el formato de las dos tramas está en el preámbulo. El propósito del preámbulo es anunciar la trama y permitir a todos los receptores en la red sincronizarse a sí mismos a la trama entrante. El preámbulo en Ethernet tiene una longitud de 8 bytes pero en IEEE 802.3 la longitud del mismo es de 7 bytes, en este último el octavo byte se convierte en el comienzo del delimitador de la trama.

La segunda diferencia entre el formato de las tramas es en el campo tipo de trama que se encuentra en la trama Ethernet. Un campo tipo es usado para especificar al protocolo que es transportado en la trama (IP, IPX...). Esto posibilita que muchos protocolos puedan ser transportados en la trama. El campo tipo fue reemplazado en el estándar IEEE 802.3 por un campo longitud de trama, el cual es utilizado para indicar el número de bytes que se encuentran en el campo de datos (puede diferenciarse una trama Ethernet de una 802.3 porque tipo toma valores superiores a 1500 y longitud valores menores o iguales).

La tercera diferencia entre los formatos de ambas tramas se encuentra en los campos de dirección, tanto de destino como de origen. Mientras que el formato de IEEE 802.3 permite el uso tanto de direcciones de 2 como de 6 bytes, el estándar Ethernet permite solo direcciones de 6 Bytes.

---

### 10. Nombre cinco protocolos de capa de enlace. ¿Todos los protocolos en esta capa proveen los mismos servicios?

* Ethernet
* IEEE 802.3
* Redes LAN Inalámbricas 802.11 (WiFi)
* Token ring
* PPP (Point-to-Point Protocol)
* Bluetooth en el 802.15 (IEEE 802.15).

Los servicios proporcionados por los diferentes protocolos de la capa de enlace a lo largo de la ruta terminal a terminal pueden ser distintos y por ende proporcionar distintos servicios. Ej. Algunos protocolos proporcionan una entrega fiable mientras que otros no (los que son más propenso a errores, por la atenuación de sus señales o interferencias electromagnéticas, suelen tener este servicio).
