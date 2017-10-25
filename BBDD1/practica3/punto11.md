# Práctica 3 - Normalización

### 11. BUQUE (nombreBuque, nYApDueño, dniDueño, tipoBuque, tonelaje, tipoCasco, #Viaje, puertoOrigen, puertoDestino, puertoIntermedio, nomPaísPuertoDestino, nombrePaisPuertoOrigen, nombrePaisPuertoIntermedio, posicionActual, fechaPosicionActual, nYApPasajero, dniPasajero, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

* El #Viaje es un número consecutivo que identifica cada partida de cada buque.
* Un buque hace varios viajes. El #Viaje se puede repetir para distintos buques.
* Un buque puede tener varios dueños.
* El nombre del buque es único. Un nombreBuque se asocia a un tipo de buque.
* El tonelaje y el casco están determinados por el tipo de buque.
* Un buque reporta su posición una vez por día independientemente del viaje.
* Cada viaje de un buque tiene un puerto origen, un puerto destino y varios puertos intermedios.
* Un buque en su viaje puede pasar por varios puertos intermedios sin repetirlos.
* Un pasajero tiene una única dirección independientemente del viaje.
* Un pasajero tiene un único puerto origen y puerto destino por cada viaje de un buque.

**Clave Candidata:**
* Cc1: (nombreBuque, fechaPosicionActual, #viaje, dniPasajero, puertoIntermedio, dniDueño)

**Dependencias Funcionales:**

* DF1: tipoBuque -> tonelaje, tipoCasco
* DF2: nombreBuque -> tipoBuque
* DF3: nombreBuque, fechaPosicionActual -> posicionActual
* DF4: puertoOrigen -> nombrePaisPuertoOrigen
* DF5: puertoIntermedio -> nombrePaisPuertoIntermedio
* DF6: puertoDestino -> nombrePaisPuertoDestino
* DF7: nombreBuque, #viaje -> puertoOrigen, puertoDestino
* DF8: dniPasajero -> nYApPasajero, dirPasajero
* DF9: nombreBuque, #viaje, dniPasajero -> puertoInicioPasajero, puertoFinalPasajero
* DF10: dniDueño -> nyApDueño


#### ¿BUQUE cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `tipoBuque` no es superclave de BUQUE, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**tipoBuque**, tonelaje, tipoCasco)
* L2(**nombreBuque**, nYApDueño, **dniDueño**, tipoBuque, **#Viaje**, puertoOrigen, puertoDestino, **puertoIntermedio**, nomPaísPuertoDestino, nombrePaisPuertoOrigen, nombrePaisPuertoIntermedio, posicionActual, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = tipoBuque` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 a DF10 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 donde `tipoBuque` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `nombreBuque` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**nombreBuque**, tipoBuque)
* L4(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, puertoOrigen, puertoDestino, **puertoIntermedio**, nomPaísPuertoDestino, nombrePaisPuertoOrigen, nombrePaisPuertoIntermedio, posicionActual, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = nombreBuque` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF2 vale en L3
* DF3 a DF10 valen en L4

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF3 donde `nombreBuque` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `nombreBuque, fechaPosicionActual` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L5(**nombreBuque**, **fechaPosicionActual**, posicionActual)
* L6(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, puertoOrigen, puertoDestino, **puertoIntermedio**, nomPaísPuertoDestino, nombrePaisPuertoOrigen, nombrePaisPuertoIntermedio, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L5 ∩ L6 = nombreBuque, fechaPosicionActual` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF3 vale en L5
* DF4 a DF10 valen en L6

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 vale DF3 donde `nombreBuque, fechaPosicionActual` es superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF4` donde `puertoOrigen` no es superclave de L6, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF4`.

* L7(**puertoOrigen**, nombrePaisPuertoOrigen)
* L8(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, puertoOrigen, puertoDestino, **puertoIntermedio**, nomPaísPuertoDestino, nombrePaisPuertoIntermedio, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L7 ∩ L8 = puertoOrigen` es clave en L7.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF4 vale en L7
* DF5 a DF10 valen en L8

#### ¿L7 cumple con la definición de BCNF?

Sí, ya que en L7 vale DF4 donde `puertoOrigen` es superclave del esquema L7.

#### ¿L8 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF5` donde `puertoIntermedio` no es superclave de L8, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF5`.

* L9(**puertoIntermedio**, nombrePaisPuertoIntermedio)
* L10(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, puertoOrigen, puertoDestino, **puertoIntermedio**, nomPaísPuertoDestino, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L9 ∩ L10 = puertoIntermedio` es clave en L9.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF5 vale en L9
* DF6 a DF10 valen en L10

#### ¿L9 cumple con la definición de BCNF?

Sí, ya que en L9 vale DF5 donde `puertoIntermedio` es superclave del esquema L9.

#### ¿L10 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF6` donde `puertoDestino` no es superclave de L10, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF6`.

* L11(**puertoDestino**, nombrePaisPuertoDestino)
* L12(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, puertoOrigen, puertoDestino, **puertoIntermedio**, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L11 ∩ L12 = puertoDestino` es clave en L11.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF6 vale en L11
* DF7 a DF10 valen en L12

#### ¿L11 cumple con la definición de BCNF?

Sí, ya que en L11 vale DF6 donde `puertoDestino` es superclave del esquema L11.

#### ¿L12 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF7` donde `nombreBuque, #viaje` no es superclave de L12, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF7`.

* L13(**nombreBuque**, **#viaje**, puertoOrigen, puertoDestino)
* L14(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, **puertoIntermedio**, **fechaPosicionActual**, nYApPasajero, **dniPasajero**, dirPasajero, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L13 ∩ L14 = nombreBuque, #viaje` es clave en L13.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF7 vale en L13
* DF8 a DF10 valen en L14

#### ¿L13 cumple con la definición de BCNF?

Sí, ya que en L13 vale DF7 donde `nombreBuque, #viaje` es superclave del esquema L13.

#### ¿L14 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF8` donde `dniPasajero` no es superclave de L14, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF8`.

* L15(**dniPasajero**, nYApPasajero, dirPasajero)
* L16(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, **puertoIntermedio**, **fechaPosicionActual**, **dniPasajero**, puertoInicioPasajero, puertoFinalPasajero)

#### ¿Se perdió información?

No, ya que `L15 ∩ L16 = dniPasajero` es clave en L15.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF8 vale en L15
* DF9 a DF10 valen en L16

#### ¿L15 cumple con la definición de BCNF?

Sí, ya que en L15 vale DF8 donde `dniPasajero` es superclave del esquema L15.

#### ¿L16 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF9` donde `nombreBuque, #viaje, dniPasajero` no es superclave de L16, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF9`.

* L17(**nombreBuque**, **#viaje**, **dniPasajero**, puertoInicioPasajero, puertoFinalPasajero)
* L18(**nombreBuque**, nYApDueño, **dniDueño**, **#Viaje**, **puertoIntermedio**, **fechaPosicionActual**, **dniPasajero**)

#### ¿Se perdió información?

No, ya que `L17 ∩ L18 = nombreBuque, #viaje, dniPasajero` es clave en L17.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF9 vale en L17
* DF10 vale en L18

#### ¿L17 cumple con la definición de BCNF?

Sí, ya que en L17 vale DF9 donde `nombreBuque, #viaje, dniPasajero` es superclave del esquema L17.

#### ¿L18 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF10` donde `dniDueño` no es superclave de L18, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF10`.

* L19(**dniDueño**, nyApDueño)
* L20(**nombreBuque**, **dniDueño**, **#Viaje**, **puertoIntermedio**, **fechaPosicionActual**, **dniPasajero**)

#### ¿Se perdió información?

No, ya que `L19 ∩ L20 = dniDueño` es clave en L19.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF10 vale en L19

#### ¿L19 cumple con la definición de BCNF?

Sí, ya que en L19 vale DF10 donde `dniDueño` es superclave del esquema L19.

#### ¿L20 cumple con la definición de BCNF?

Sí, ya que las únicas dependencias funcionales son triviales.

#### Particiones de BUQUE que quedaron en BCNF:

* L1(**tipoBuque**, tonelaje, tipoCasco)
* L3(**nombreBuque**, tipoBuque)
* L5(**nombreBuque**, **fechaPosicionActual**, posicionActual)
* L7(**puertoOrigen**, nombrePaisPuertoOrigen)
* L9(**puertoIntermedio**, nombrePaisPuertoIntermedio)
* L11(**puertoDestino**, nombrePaisPuertoDestino)
* L13(**nombreBuque**, **#viaje**, puertoOrigen, puertoDestino)
* L15(**dniPasajero**, nYApPasajero, dirPasajero)
* L17(**nombreBuque**, **#viaje**, **dniPasajero**, puertoInicioPasajero, puertoFinalPasajero)
* L19(**dniDueño**, nyApDueño)
* L20(**nombreBuque**, **dniDueño**, **#Viaje**, **puertoIntermedio**, **fechaPosicionActual**, **dniPasajero**)

#### Clave Primaria

* (nombreBuque, fechaPosicionActual, #viaje, dniPasajero, puertoIntermedio, dniDueño)

#### Dependencias Multivaludas en L20:

* DM1: nombreBuque ->> dniDueño
* DM2: nombreBuque, #Viaje ->> puertoIntermedio
* DM3: nombreBuque, #Viaje ->> dniPasajero
* DM4: nombreBuque ->> fechaPosicionActual

#### ¿L20 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM1, DM2, DM3, DM4` que no son triviales en L20. Por lo tanto se particiona L20 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM1.

* L21(**nombreBuque**, **dniDueño**)
* L22(**nombreBuque**, **#Viaje**, **puertoIntermedio**, **fechaPosicionActual**, **dniPasajero**)

#### ¿L21 cumple con la definición de 4FN?

Sí, ya que en L21 solo vale la DM1 que es trivial en L21.

#### ¿L22 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM2, DM3, DM4` que no son triviales en L22. Por lo tanto se particiona L22 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM2.

* L23(**nombreBuque**, **#viaje**, **puertoIntermedio**)
* L24(**nombreBuque**, **#Viaje**, **fechaPosicionActual**, **dniPasajero**)

#### ¿L23 cumple con la definición de 4FN?

Sí, ya que en L23 solo vale la DM2 que es trivial en L23.

#### ¿L24 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM3, DM4` que no son triviales en L24. Por lo tanto se particiona L24 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM3.

* L25(**nombreBuque**, **#viaje**, **dniPasajero**)
* L26(**nombreBuque**, **#Viaje**, **fechaPosicionActual**)

#### ¿L25 cumple con la definición de 4FN?

Sí, ya que en L25 solo vale la DM3 que es trivial en L25.

#### ¿L26 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM4` que no son triviales en L26. Por lo tanto se particiona L26 teniendo en cuenta la dependencia multivaluadas DM4.

* L27(**nombreBuque**, **fechaPosicionActual**)
* L28(**nombreBuque**, **#Viaje**)

#### ¿L27 cumple con la definición de 4FN?

Sí, ya que en L27 solo vale la DM4 que es trivial en L27.

#### ¿L28 cumple con la definición de 4FN?

Sí, ya que las unicas dependencias multivaluadas serían triviales.

#### Particiones de BUQUE que quedaron en 4NF:

* L1(**tipoBuque**, tonelaje, tipoCasco)
* L3(**nombreBuque**, tipoBuque)
* L5(**nombreBuque**, **fechaPosicionActual**, posicionActual)
* L7(**puertoOrigen**, nombrePaisPuertoOrigen)
* L9(**puertoIntermedio**, nombrePaisPuertoIntermedio)
* L11(**puertoDestino**, nombrePaisPuertoDestino)
* L13(**nombreBuque**, **#viaje**, puertoOrigen, puertoDestino)
* L15(**dniPasajero**, nYApPasajero, dirPasajero)
* L17(**nombreBuque**, **#viaje**, **dniPasajero**, puertoInicioPasajero, puertoFinalPasajero)
* L19(**dniDueño**, nyApDueño)
* L21(**nombreBuque**, **dniDueño**)
* L23(**nombreBuque**, **#viaje**, **puertoIntermedio**)

---
