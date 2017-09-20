# Práctica 4

### 1. ¿Qué protocolos se utilizan para el envío de mails entre el cliente y su servidor de correo? ¿Y entre servidores de correo?

Con el fin de enviar un correo a un destinatario, un usuario debe hacer uso de un agente de usuario para correo electrónico, que le permita enviar su correo hacia su servidor de correo. Esta transferencia de información se puede lograr haciendo uso de dos protocolos de la capa de aplicación: SMTP y HTTP.

* SMTP: El funcionamiento de este protocolo se da en línea, de manera que opera en los servicios de correo electrónico. Sin embargo, este protocolo posee algunas limitaciones en cuanto a la recepción de mensajes en el servidor de destino (cola de mensajes recibidos). Como alternativa a esta limitación se asocia normalmente a este protocolo con otros, como el POP o IMAP, otorgando a SMTP la tarea específica de enviar correo, y recibirlos empleando los otros protocolos antes mencionados (POP O IMAP).

* HTTP: Cuando el usuario utiliza un navegador web como su agente de usuario para el envio de correos, el protocolo que se utiliza para la comunicación con su servidor de correo será HTTP.

Por otro lado el protocolo que siempre se utiliza para la comunicación entre los servidores de correo es SMTP.

---

### 2.  ¿Qué protocolos se utilizan para la recepción de mails? ¿Incluiría a HTTP en dichos protocolos? Enumere y explique características y diferencias entre las alternativas posibles.

Cuando un usuario desea leer los correos que se almacenan en su servidor de correo, éste debe utilizar su agente de usuario el cual se comunicará con el servidor de correo a traves de alguno de los siguientes protocolos con el fin de recibir los correos:

* POP3: (Post Office Protocol -- Version 3) es un protocolo de acceso de correo extremadamente simple. Se define en la RFC 1939, la cual es corta y bastante fácil de entender. Debido a que el protocolo es muy simple, su funcionalidad es bastante limitada. POP3 comienza cuando el agente de usuario abre una conexión TCP hacia el servidor de correo en el puerto 110. Con la conexión TCP establecida, POP3 avanza a lo largo de 3 fases: autorización, transacción y actualización. Durante la fase de autorización el agente de usuario encía un username y una contraseña para autenticar al usuario. Durante la segunda fase, el agente de usuario recibe mensajes; durante esta fase el usuario también puede marcar correos para borrado. La fase de actualización ocurre luego de que el usuario utiliza el comando `quit`, el ual finaliza la sesión POP3; en este momento el servidor de mail elimina los correos que fueron marcados para su eliminación.

* IMAP: Como POP3, IMAP es un protocolo de acceso de correo. Tiene muchas mas características que POP3, pero también es significativamente mas complejo. Un servidor IMAP asociará cada mensaje con una carpeta; cuando un mensaje arriba al servidor por primera vez, este es asociado con la carpeta INBOX del receptor. Este último puede mover el mensaje a una nueva carpeta, leer el mensaje, eliminarlo y muchas cosas mas. Otra característica importante que posee IMAP es que tiene comandos que le permiten al usuario obtener componentes de mensajes. Por ejemplo, un agente de usuario podría solamente obtener el header del mensaje o solamente una parte de un mensaje MIME. Esta característica es muy útil cuando hay una conexión con un pequeño ancho de banda entre el agente de usuario y su servidor de correo.

* HTTP: Cuando el usuario utiliza su navegador web como agente de usuario para la recepción de correos, éste utilizará el protocolo HTTP para comunicarse con su servidor de correo, y así poder recibir los e-mails.

---





