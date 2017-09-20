# Práctica 4

### 1. ¿Qué protocolos se utilizan para el envío de mails entre el cliente y su servidor de correo? ¿Y entre servidores de correo?

Con el fin de enviar un correo a un destinatario, un usuario debe hacer uso de un agente de usuario para correo electrónico, que le permita enviar su correo hacia su servidor de correo. Esta transferencia de información se puede lograr haciendo uso de dos protocolos de la capa de aplicación: SMTP y HTTP.

* SMTP: El funcionamiento de este protocolo se da en línea, de manera que opera en los servicios de correo electrónico. Sin embargo, este protocolo posee algunas limitaciones en cuanto a la recepción de mensajes en el servidor de destino (cola de mensajes recibidos). Como alternativa a esta limitación se asocia normalmente a este protocolo con otros, como el POP o IMAP, otorgando a SMTP la tarea específica de enviar correo, y recibirlos empleando los otros protocolos antes mencionados (POP O IMAP).

* HTTP: Cuando el usuario utiliza un navegador web como su agente de usuario para el envio de correos, el protocolo que se utiliza para la comunicación con su servidor de correo será HTTP.

Por otro lado el protocolo que siempre se utiliza para la comunicación entre los servidores de correo es SMTP.

---


