# Práctica 4 - MySQL

### 1. Crear usuarios para las bases de datos, usando los nombres reparacion para la versión normalizada y reparacion_dn para la desnormalizada. Habiendo creado estos usuarios, evitar el uso de root para el resto del trabajo práctico.

```sql
CREATE USER 'reparacion'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON reparacion.* TO 'reparacion'@'localhost';

CREATE USER 'reparacion_dn'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON reparacion_dn.* TO 'reparacion_dn'@'localhost';

FLUSH PRIVILEGES;
```

#### 1.1 Adicionalmente, en ambas bases:

* **cree un usuario sólo con permisos para realizar consultas de selección, es decir que no puedan realizar cambios en la base. Use los nombres 'reparacion_select’ y 'reparacion_dn_select’.** 

```sql
CREATE USER 'reparacion_select'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT ON reparacion.* TO 'reparacion_select'@'localhost';

CREATE USER 'reparacion_dn_select'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT ON reparacion_dn.* TO 'reparacion_dn_select'@'localhost';

FLUSH PRIVILEGES;
```

* **cree un usuario que pueda realizar consultas de selección, actualización y eliminación a nivel de filas, pero que no puedan modificar el esquema. Use los nombres 'reparacion_update’ y 'reparacion_dn_update’.**

```sql
CREATE USER 'reparacion_update'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT, DELETE, UPDATE ON reparacion.* TO 'reparacion_update'@'localhost';

CREATE USER 'reparacion_dn_update'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT, DELETE, UPDATE ON reparacion_dn.* TO 'reparacion_dn_update'@'localhost';

FLUSH PRIVILEGES;
```

* **cree un usuario que tenga los permisos de los anteriores, pero que además pueda modificar el esquema de la base de datos. Use los nombres 'reparacion_schema’ y 'reparacion_dn_schema’.**

```sql
CREATE USER 'reparacion_schema'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT, DELETE, UPDATE, CREATE, DROP, INSERT, ALTER ON reparacion.* TO 'reparacion_schema'@'localhost';

CREATE USER 'reparacion_dn_schema'@'localhost' IDENTIFIED BY 'pass';
GRANT SELECT, DELETE, UPDATE, CREATE, DROP, INSERT, ALTER ON reparacion_dn.* TO 'reparacion_dn_schema'@'localhost';

FLUSH PRIVILEGES;
```

---

### 2. Listar dni, nombre y apellido de todos los clientes ordenados por dni en forma ascendente. Realice la consulta en ambas bases. ¿Qué diferencia nota en cuanto a performance? ¿Arrojan los mismos resultados? ¿Qué puede concluir en base a las diferencias halladas?

```sql
# reparacion

SELECT dniCliente, nombreApellidoCliente 
FROM cliente 
ORDER BY dniCliente ASC;

# 20000 rows in set
# Time: 0.985s

---

# reparacion_dn

SELECT dniCliente, nombreApellidoCliente
FROM reparacion 
ORDER BY dniCliente ASC;

# 162252 rows in set
# Time: 8.350s
```

Como se puede ver los resultados no son los mismos, la consulta hecha sobre `reparacion_dn` da mas resultados ya que se recupera a un mismo usuario las veces que este haya realizado una reparación. Obviamente como hay mas tuplas la performance será mas baja.

Si sobre `reparacion_db` realizamos una consulta que quite los repetidos obtenemos los siguientes resultados:

```sql
# reparacion_dn

SELECT dniCliente, nombreApellidoCliente
FROM reparacion
GROUP BY dniCliente
ORDER BY dniCliente ASC;

# 20000 rows in set
# Time: 0.995s
```

Como podemos observar estos últimos resultados se asemejan mucho a los realizados sobre la tabla `reparacion` de la base de datos normalizada.

---

### 3. Hallar aquellos clientes que para todas sus reparaciones siempre hayan usado su tarjeta de crédito primaria (nunca la tarjeta secundaria). Realice la consulta en ambas bases.

```sql
# reparacion

SELECT dniCliente, nombreApellidoCliente
FROM cliente
WHERE NOT EXISTS 
  (SELECT * 
  FROM reparacion
  WHERE cliente.dniCliente = reparacion.dniCliente
    AND tarjetaSecundaria = tarjetaReparacion);

---

# reparacion_dn

SELECT dniCliente, nombreApellidoCliente
FROM reparacion AS r
WHERE NOT EXISTS
  (SELECT *
  FROM reparacion
  WHERE r.dniCliente = reparacion.dniCliente
    AND r.tarjetaSecundaria = reparacion.tarjetaReparacion)
GROUP BY dniCliente;
```

---

### 4. Crear una vista llamada ‘sucursalesPorCliente’ que muestre los dni de los clientes y los códigos de sucursales de la ciudad donde vive el cliente. Cree la vista en ambas bases.

```sql
# reparacion

CREATE VIEW sucursalesPorCliente AS
SELECT dniCliente, codSucursal
FROM cliente
  INNER JOIN sucursal ON ciudadCliente = ciudadSucursal;

---

# reparacion_dn

CREATE VIEW sucursalesPorCliente AS
SELECT DISTINCT dniCliente, codSucursal
  FROM reparacion
    WHERE ciudadCliente = ciudadSucursal;
```

---

### 5. En la base normalizada, hallar los clientes que dejaron vehículos a reparar en todas las sucursales de la ciudad en la que viven.

**Restricción: resolver este ejercicio sin usar la cláusula “NOT EXIST”.**

**Nota: limite su consulta a los primeros 100 resultados, caso contrario el tiempo que tome puede ser excesivo.**

#### a. Realice la consulta sin utilizar la vista creada en el ej 4.

```sql
SELECT dniCliente
FROM cliente
WHERE
  (SELECT COUNT(codSucursal)
    FROM sucursal
    WHERE cliente.ciudadCliente = sucursal.ciudadSucursal) =
  (SELECT COUNT(DISTINCT sucursal.codSucursal)
    FROM reparacion
      INNER JOIN sucursal
        ON reparacion.codSucursal = sucursal.codSucursal
    WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
      AND cliente.dniCliente = reparacion.dniCliente)
LIMIT 100;
```

#### b. Realice la consulta utilizando la vista creada en el ej 4.

```sql
SELECT dniCliente
FROM cliente
WHERE
  (SELECT COUNT(codSucursal)
    FROM sucursalesPorCliente
    WHERE cliente.dniCliente = sucursalesPorCliente.dniCliente) =
  (SELECT COUNT(DISTINCT sucursal.codSucursal)
    FROM reparacion
      INNER JOIN sucursal
        ON reparacion.codSucursal = sucursal.codSucursal
    WHERE cliente.ciudadCliente = sucursal.ciudadSucursal
      AND cliente.dniCliente = reparacion.dniCliente)
LIMIT 100;
```

Vale aclarar que la solución de este ejercicio obtiene a aquellos clientes que no tienen sucursales en su ciudad, lo cual lo considero correcto.

---

### 6. Hallar los clientes que en alguna de sus reparaciones hayan dejado como dato de contacto el mismo domicilio y ciudad que figura en su DNI. Realice la consulta en ambas bases.

```sql
# reparacion

SELECT DISTINCT c.dniCliente, nombreapellidocliente
FROM cliente AS c
  INNER JOIN reparacion AS r ON c.dniCliente = r.dniCliente
    AND c.domicilioCliente = r.direccionReparacionCliente
    AND c.ciudadCliente = r.ciudadReparacionCliente;

---

# reparacion_dn

SELECT DISTINCT dniCliente, nombreapellidocliente
FROM reparacion
    WHERE domicilioCliente = direccionReparacionCliente
      AND ciudadCliente = ciudadReparacionCliente;
```

---

### 7. Para aquellas reparaciones que tengan registrados mas de 3 repuestos, listar el DNI del cliente, el código de sucursal, la fecha de reparación y la cantidad de repuestos utilizados. Realice la consulta en ambas bases.

```sql
# reparacion

SELECT r.dniCliente, r.fechaInicioReparacion, r.codSucursal, count(rr.repuestoReparacion) AS cantidad
FROM reparacion AS r
  INNER JOIN repuestoreparacion AS rr
    ON r.dniCliente = rr.dniCliente
    AND r.fechaInicioReparacion = rr.fechaInicioReparacion
GROUP BY r.dniCliente, r.fechaInicioReparacion
HAVING count(rr.repuestoReparacion) > 3;

---

# reparacion_dn

SELECT dniCliente, fechaInicioReparacion, codSucursal, count(distinct repuestoReparacion) AS cantidad
FROM reparacion
GROUP BY dniCliente, fechaInicioReparacion
HAVING count(distinct repuestoReparacion) > 3;
```

---

## En la base normalizada realice los siguientes ejercicios:

### 8. Agregar la siguiente tabla:

**REPARACIONESPORCLIENTE**

* idRC: int(11) PK AI
* dniCliente: int(11)
* cantidadReparaciones: int(11)
* fechaultimaactualizacion: datetime
* usuario: char(16)

```sql
CREATE TABLE REPARACIONESPORCLIENTE (
  idRC int(11) AUTO_INCREMENT,
  dniCliente int(11),
  cantidadReparaciones int(11),
  fechaultimaactualizacion datetime,
  usuario char(16),
  PRIMARY KEY(idRC)
);
```

---

### 9. Stored procedures

#### Crear un stored procedure que realice los siguientes pasos dentro de una transacción: 

* Realizar una consulta que para cada cliente(dniCliente), calcule la cantidad de reparaciones que tiene registradas. Registrar la fecha en la que se realiza la consulta y el usuario con el que la realizó.
* Guardar el resultado de la consulta en un cursor.
* Iterar el cursor e insertar los valores correspondientes en la tabla REPARACIONESPORCLIENTE.

```sql
DELIMITER $$

CREATE PROCEDURE punto9()
  BEGIN

    DECLARE done INT DEFAULT FALSE;
    DECLARE cant INT;
    DECLARE dni INT;
    DECLARE cur CURSOR FOR SELECT count(*), dniCliente FROM reparacion GROUP BY dniCliente;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    START TRANSACTION;
    OPEN cur;
    loop_1: LOOP
      FETCH cur INTO cant, dni;
      IF done THEN
        LEAVE loop_1;
      END IF;
      INSERT INTO REPARACIONESPORCLIENTE (dniCliente, cantidadReparaciones, fechaultimaactualizacion, usuario) VALUES (dni, cant, NOW(), CURRENT_USER);
    END LOOP;
    CLOSE cur;
    COMMIT;
  END$$

DELIMITER ;
```

#### Ejecute el storedprocedure.

```sql
CALL punto9();
```

---

### 10. Crear un trigger de modo que al insertar un dato en la tabla REPARACION, se actualice la cantidad de reparaciones del cliente, la fecha de actualización y el usuario responsable de la misma (actualiza la tabla REPARACIONESPORCLIENTE).

```sql
DELIMITER $$

CREATE TRIGGER after_reparacion_insert
    AFTER INSERT ON reparacion
    FOR EACH ROW BEGIN
    IF (NEW.dniCliente IN (SELECT dniCliente FROM REPARACIONESPORCLIENTE)) THEN
      UPDATE REPARACIONESPORCLIENTE
      SET cantidadReparaciones = cantidadReparaciones + 1,
      fechaultimaactualizacion = NOW(), usuario = CURRENT_USER()
      WHERE NEW.dniCliente = REPARACIONESPORCLIENTE.dniCliente;
    ELSE
      INSERT INTO REPARACIONESPORCLIENTE (dniCliente, cantidadReparaciones, fechaultimaactualizacion, usuario)
      VALUES (NEW.dniCliente, 1, NOW(), CURRENT_USER());
    END IF;
END$$

DELIMITER ;
```

---

### 11. Crear un stored procedure que sirva para agregar una reparación, junto con una revisión de un empleado (REVISIONREPARACION) y un repuesto (REPUESTOREPARACION) relacionados dentro de una sola transacción. El stored procedure debe recibir los siguientes parámetros: dniCliente,codSucursal,fechaReparacion, cantDiasReparacion,telefonoReparacion, empleadoReparacion, repuestoReparacion.

```sql
DELIMITER $$

CREATE PROCEDURE punto11(IN dni INT(11), IN sucursal INT, IN fechaReparacion DATETIME, IN dias INT,
    IN tel VARCHAR(45), IN empleado VARCHAR(30), IN repuesto VARCHAR(30))
  BEGIN

    DECLARE domicilio VARCHAR(255);
    DECLARE ciudad VARCHAR(255);
    DECLARE tarjeta VARCHAR(255);

    SELECT domicilioCliente, ciudadCliente, tarjetaPrimaria INTO domicilio, ciudad, tarjeta FROM cliente WHERE cliente.dniCliente = dni;

    START TRANSACTION;
    INSERT INTO reparacion (codSucursal, dniCliente, fechaInicioReparacion, cantDiasReparacion, telefonoReparacionCliente,
                            direccionReparacionCliente, ciudadReparacionCliente, tarjetaReparacion)
    VALUES (sucursal, dni, fechaReparacion, dias, tel, domicilio, ciudad, tarjeta);

    INSERT INTO revisionreparacion (dniCliente, fechaInicioReparacion, empleadoReparacion)
    VALUES (dni, fechaReparacion, empleado);

    INSERT INTO repuestoreparacion (dniCliente, fechaInicioReparacion, repuestoReparacion)
    VALUES (dni, fechaReparacion, repuesto);

    COMMIT;
  END$$

DELIMITER ;
```

---

### 12. Ejecutar el stored procedure del punto 11 con los siguientes datos:

* dniCliente: 1009443
* codSucursal: 100
* fechaReparacion: 2013-12-14 12:20:31
* empleadoReparacion: ‘Maidana’
* repuestoReparacion: ‘bomba de combustible’
* cantDiasReparacion: 4
* telefonoReparacion: 4243-4255

```sql
CALL punto11(1009443, 100, '2017-12-14 12:20:31', 4, '4243-4255', 'Maidana', 'bomba de combustible');
```

---

### 13. Realizar las inserciones provistas en el archivo inserciones.sql. Validar mediante una consulta que la tabla REPARACIONESPORCLIENTE se esté actualizando correctamente.

```
mysql -u reparacion -p reparacion < inserciones.sql;
```

Los resultados de la tabla `REPARACIONESPORCLIENTE` coinciden con los resultados del archivo `reparacionesxcliente.hasta14.csv`.

---

### 14. Considerando la siguiente consulta:

```sql
select count(r.dniCliente)
from reparacion r, cliente c, sucursal s, revisionreparacion rv 
where r.dnicliente=c.dnicliente
  and r.codsucursal=s.codsucursal
  and r.dnicliente=rv.dnicliente
  and r.fechainicioreparacion=rv.fechainicioreparacion
  and empleadoreparacion = 'Maidana'and s.m2<200
  and s.ciudadsucursal='La Plata';
```

#### Analice su plan de ejecución mediante el uso de la sentencia EXPLAIN.

#### a. ¿Qué atributos del plan de ejecución encuentra relevantes para evaluar la performance de la consulta?

#### b. Observeen particular el atributotype¿cómose están aplicando los JOIN entre las tablasinvolucradas?

#### c. Según lo que observóen lospuntosanteriores, ¿quémejoras se pueden realizar para optimizar la consulta?

```sql
CREATE INDEX empleado_index ON revisionreparacion (empleadoReparacion);
```

#### d. Aplique las mejoras propuestas y vuelva a analizar el plande ejecución. ¿Quécambios observa?

---

### 15. Análisis de permisos.

#### a. Para cada punto de la práctica incluido en el cuadro, ejecutarlo con cada uno de los usuarios creados en el punto 1 e indicar con cuáles fue posible realizar la operación. 
