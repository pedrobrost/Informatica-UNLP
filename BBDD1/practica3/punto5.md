# Práctica 3 - Normalización

### 5. DISPOSITIVOS (marca_id, descripMarca, modelo_id, descripModelo, equipo_tipo_id, descripEquipoTipo, empresa_id, nombreEmpresa, cuit, direcciónEmpresa, usuario_id, apyn, nro_doc, direcciónUsuario, cuil, plan_id, descripPlan, importe, equipo_id, imei, fec_alta, fec_baja, observaciones, línea_id, nroContrato, fec_alta_linea, fec_baja_linea)
 
* Para cada equipo interesa conocer su tipo, modelo, imei, fecha en que se dio de alta, fecha en que se da de baja y las observaciones que sean necesarias.
* De cada marca se conoce su descripción.
* De cada modelo se conoce su descripción y a que marca pertenece.
* Para cada plan, se registra que empresa lo brinda, la descripción e importe del mismo.
* Para cada tipo de equipo se conoce la descripción.
* Para cada empresa se registra el nombre, cuit y dirección.
* De cada usuario se registra su nombre y apellido, número de documento, dirección y cuil.
* Para cada línea se necesita registrar el número de contrato, que plan posee, la fecha de alta de la línea, la fecha de baja, el equipo que la posee y el usuario de la misma.


**Clave Candidata:**
* Cc1: (idEmpleado, idResponsableOficina, idActividadEmpleadoOficina)
* Cc2: (dniEmpleado, idResponsableOficina, idActividadEmpleadoOficina)

**Dependencias Funcionales:**
* DF1: equipo_id -> equipo_tipo_id, modelo_id, imei, fec_alta, fec_baja, observaciones
* DF1: imei -> equipo_tipo_id, modelo_id, equipo_id, fec_alta, fec_baja, observaciones
* DF2: marca_id -> descripMarca
* DF3: modelo_id -> descripModelo, marca_id
* DF4: plan_id -> empresa_id, descripPlan, importe
* DF5: equipo_tipo_id -> descripEquipoTipo
* DF6: empresa_id -> nombreEmpresa, cuit, direcciónEmpresa
* DF6: cuit -> nombreEmpresa, empresa_id, direcciónEmpresa
* DF7: usuario_id -> apyn, nro_doc, direcciónUsuario, cuil
* DF7: cuil -> apyn, nro_doc, direcciónUsuario, usuario_id
* DF8: 




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

idEmpleado -> nombreEmpleado, idOficina, añoIngresoOficina, dniEmpleado, cargaHorariaEnOficina

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
