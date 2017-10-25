# Práctica 3 - Normalización

### 10. RESERVA (#Reserva, #Agencia, nombreAgencia, fechaReservaVuelo, ciudadOrigen, ciudadDestino, tipoPago, nombreAerolínea, #Vuelo, dniPasajero, nombrePasajero, dirPasajero, telPasajero, clase, fechaPartida, fechaLlegada, horaPartida, horaLlegada, modeloAvión, #Asiento, tipoComida, compañíaPasajero, dirCompañía, telCompañía)
 
* Una reserva puede involucrar uno o varios pasajeros (por ejemplo un tour).
* Si bien todos los pasajeros de una reserva viajan en la misma clase del mismo vuelo, cada uno de ellos decide el tipo de pago de su asiento (El tipo de pago se refiere al la forma de pago: efectivo, tarjeta de crédito, etc.). Notar que para cada vuelo el tipo pago puede ser potencialmente diferente.
* Una reserva puede involucrar muchos vuelos (por ejemplo para desplazarse de A a C se debe pasar por una escala intermedia B); tener en cuenta que no necesariamente todos los pasajeros de una reserva viajan en todos lo vuelos de esa reserva. Para cada vuelo de una reserva se conoce la fecha para la cual se realiza. Para una fecha puede haber varios vuelos de una o varias reservas.
* La reserva es realizada a través de una única agencia de turismo.
* Los pasajeros pueden estar independientemente involucrados en distintas reservas.
* Cada aerolínea maneja su propia forma de asignar el #Reserva, con lo cuál no hay garantía que estos no se repitan para las distintas aerolíneas.
* Las aerolíneas siempre usan el mismo modelo de avión para el mismo vuelo. Y el mismo vuelo de una aerolínea siempre sale de la misma ciudad a la misma hora, y llega a la misma ciudad destino a la misma hora de llegada, los días que ese vuelo es ofrecido por la aerolínea.
* El tipo de comida significa si corresponde desayuno, almuerzo, cena o merienda o cualquier combinación de ellos para cada vuelo.
* Para cada reserva de un pasajero se conoce el domicilio del pasajero y datos de su lugar de trabajo. Un pasajero puede trabajar en más de una compañía, una compañía puede tener más de una dirección y en cada dirección de una compañía puede haber más de un teléfono.


**Clave Candidata:**
* Cc1: (#vuelo, #reserva, dniPasajero, tipoComida, nombreAerolinea, telCompañia, compañiaPasajero, dirCompañia)

**Dependencias Funcionales:**

* DF1: #vuelo, nombreAerolínea -> modeloAvión, ciudadOrigen, ciudadDestino, horaPartida, horaLlegada
* DF2: #vuelo, #reserva, nombreAerolínea -> clase, fechaReservaVuelo, fechaPartida, fechaLlegada
* DF3: #vuelo, #reserva, nombreAerolínea, dniPasajero -> tipoPago, #asiento.
* DF4: #agencia -> nombreAgencia
* DF5: #reserva, nombreAerolínea -> #agencia
* DF6: #reserva, nombreAerolínea, dniPasajero -> dirPasajero.
* DF7: dniPasajero -> nombrePasajero, telPasajero.


#### ¿RESERVA cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `#vuelo` no es superclave de RESERVA, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**#vuelo**, **nombreAerolínea**, modeloAvión, ciudadOrigen, ciudadDestino, horaPartida, horaLlegada)
* L2(**#reserva**, #agencia, nombreAgencia, fechaReservaVuelo, tipoPago, **nombreAerolínea**, **#vuelo**, **dniPasajero**, nombrePasajero, dirPasajero, telPasajero, clase, fechaPartida, fechaLlegada, #asiento, **tipoComida**, **compañíaPasajero**, **dirCompañía**, **telCompañía**)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = #vuelo` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 a DF7 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 donde `#vuelo` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `#vuelo, #reserva, nombreAerolínea` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3: (**#vuelo**, **#reserva**, **nombreAerolínea**, clase, fechaReservaVuelo, fechaPartida, fechaLlegada)
* L4: (#reserva, #agencia, nombreAgencia, nombreAerolínea, tipoPago, #vuelo, dniPasajero, nombrePasajero, dirPasajero, telPasajero, #Asiento, tipoComida, compañíaPasajero, dirCompañía, telCompañía)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = idResponsableOficina, idOficina` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF2 vale en L3
* DF3 a DF5 valen en L4

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF2 y `idResponsableOficina, idOficina` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `idEmpleado` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L5(**idEmpleado**, nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina)
* L6(**idEmpleado**, **idResponsableOficina**, **idActividadEmpleadoOficina**, nombreActividadOficina)

#### ¿Se perdió información?

No, ya que `L5 ∩ L6 = idEmpleado` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF3 y DF4 valen en L5
* DF5 vale en L6

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 valen DF3 y DF4 donde `idEmpleado` y `dniEmpleado` son superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF5` donde `idActividadEmpleadoOficina` no es superclave de L6, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF5`.

* L7(**idActividadEmpleadoOficina**, nombreActividadOficina)
* L8(**idEmpleado**, **idResponsableOficina**, **idActividadEmpleadoOficina**)

#### ¿Se perdió información?

No, ya que `L7 ∩ L8 = idActividadEmpleadoOficina` es clave en L7.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF5 vale en L7

#### ¿L7 cumple con la definición de BCNF?

Sí, ya que en L7 vale DF5 donde `idActividadEmpleadoOficina` es superclave del esquema L7.

#### ¿L8 cumple con la definición de BCNF?

Sí, ya que las únicas dependencias funcionales son triviales.

#### Particiones de EMPLEADO que quedaron en BCNF:

* L1(**idEmpleado**, nombreOficina)
* L3(**idResponsableOficina**, **idOficina**, nombreResponsableOficina)
* L5(**idEmpleado**, nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina)
* L7(**idActividadEmpleadoOficina**, nombreActividadOficina)
* L8(**idEmpleado**, **idResponsableOficina**, **idActividadEmpleadoOficina**)

#### Clave Primaria

* (idEmpleado, idResponsableOficina, idActividadEmpleadoOficina)

#### Dependencias Multivaludas en L8:

* DM1: idEmpleado ->> idActividadEmpleadoOficina
* DM2: idEmpleado ->> idResponsableOficina

#### ¿L8 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM1, DM2` que no son triviales en L8. Por lo tanto se particiona L8 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM1.

* L9(**idEmpleado**, **idActividadEmpleadoOficina**)
* L10(**idEmpleado**, **idResponsableOficina**)

#### ¿L9 cumple con la definición de 4FN?

Sí, ya que en L9 solo vale la DM1 que es trivial en L9.

#### ¿L10 cumple con la definición de 4FN?

Sí, ya que en L10 solo vale la DM2 que es trivial en L10.

#### Particiones de EMPLEADO que quedaron en 4NF, quitando particiones que son proyecciones de esquemas anteriores:

* L1(**idEmpleado**, nombreOficina)
* L3(**idResponsableOficina**, **idOficina**, nombreResponsableOficina)
* L5(**idEmpleado**, nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina)
* L7(**idActividadEmpleadoOficina**, nombreActividadOficina)
* L9(**idEmpleado**, **idActividadEmpleadoOficina**)
* L10(**idEmpleado**, **idResponsableOficina**)

---
