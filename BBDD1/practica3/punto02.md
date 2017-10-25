# Práctica 3 - Normalización

### 2. EMPLEADO (idEmpleado, nombreEmpleado, idOficina, nombreOficina, idResponsableOficina, cargaHorariaEnOficina, nombreResponsableOficina, añoIngresoOficina, idActividadEmpleadoOficina, nombreActividadOficina, dniEmpleado)
 
* El idEmpleado es único por oficina. El mismo idEmpleado no se repite en diferentes oficinas.
* Cada empleado tiene asignada una única carga horaria para la oficina en la que trabaja e ingreso a la oficina en un año determinado.
* El nombre del empleado no es único, es decir puede haber más de un “Juan Perez” trabajando en una oficina.
* El nombre del responsable de la oficina no es único, es decir puede haber más de un “Juan Perez” responsable de una oficina.
* En una oficina existen muchos responsables (tener en cuenta que el esquema ya se encuentra en 1FN).
* Los responsables de oficina pueden repetirse para diferentes oficinas.
* idActividadEmpleadoOficina es cada actividad que un empleado realiza en la oficina.

**Clave Candidata:**
* Cc1: (idEmpleado, idResponsableOficina, idActividadEmpleadoOficina)
* Cc2: (dniEmpleado, idResponsableOficina, idActividadEmpleadoOficina)

**Dependencias Funcionales:**
* DF1: idOficina -> nombreOficina
* DF2: idResponsableOficina, idOficina -> nombreResponsableOficina
* DF3: idEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina
* DF4: dniEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, idEmpleado, cargaHorariaEnOficina
* DF5: idActividadEmpleadoOficina -> nombreActividadOficina


#### ¿EMPLEADO cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `idOficina` no es superclave de EMPLEADO, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**idEmpleado**, nombreOficina)
* L2(**idEmpleado**, nombreEmpleado, idOficina, **idResponsableOficina**, cargaHorariaEnOficina, nombreResponsableOficina, añoIngresoOficina, **idActividadEmpleadoOficina**, nombreActividadOficina, dniEmpleado)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = idEmpleado` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 a DF5 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 y `idEmpleado` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `idResponsableOficina, idOficina` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**idResponsableOficina**, **idOficina**, nombreResponsableOficina)
* L4(**idEmpleado**, nombreEmpleado, idOficina, **idResponsableOficina**, cargaHorariaEnOficina, añoIngresoOficina, **idActividadEmpleadoOficina**, nombreActividadOficina, dniEmpleado))

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

#### Particiones de EMPLEADO que quedaron en 4NF:

* L1(**idEmpleado**, nombreOficina)
* L3(**idResponsableOficina**, **idOficina**, nombreResponsableOficina)
* L5(**idEmpleado**, nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina)
* L7(**idActividadEmpleadoOficina**, nombreActividadOficina)
* L9(**idEmpleado**, **idActividadEmpleadoOficina**)
* L10(**idEmpleado**, **idResponsableOficina**)

---
