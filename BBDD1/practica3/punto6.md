# Práctica 3 - Normalización

### 6. TOMAS_FOTOGRAFICAS (idElemento, descripcionElemento, idFoto, fechaFoto, obturacionCamaraFoto, idCamara, caracteristicaTecnicaCamara, descripcionCaracteristica)

Cuando se toma una fotografía, se indican todos los elementos que aparecen en ella, se registra la cámara con la que se tomó, el valor de obturación del lente de la cámara y todas las características técnicas de la cámara con la que se toma la foto.
 
* En una foto puede haber varios elementos, un elemento puede aparecer en varias fotos, pero en una misma foto solo parece una vez
* El idElemento y el idFoto son únicos en el sistema.
* obturacionCamaraFoto es la obturación del lente de la cámara usada en una foto.
* caracteristicaTecnicasCamara es una característica técnica de una cámara. Cada cámara puede tener muchas características, pero tener en cuenta que la misma característica NO pertenece a mas de una cámara. Dos caracteristicaTecnicasCamara pueden tener la misma descripción pero pertenecerán a cámaras diferentes.

**Clave Candidata:**
* Cc1: (caracteristicaTecnicaCamara, idElemento, idFoto)

**Dependencias Funcionales:**
* DF1: caracteristicaTecnicaCamara -> descripcionCaracteristica, idCamara
* DF2: idElemento -> descripcionElemento
* DF3: idFoto -> fechaFoto, obturacionCamaraFoto, idCamara


#### ¿TOMAS_FOTOGRAFICAS cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `caracteristicaTecnicaCamara` no es superclave de TOMAS_FOTOGRAFICAS, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**caracteristicaTecnicaCamara**, descripcionCaracteristica, idCamara)
* L2(**idElemento**, descripcionElemento, **idFoto**, fechaFoto, obturacionCamaraFoto, **caracteristicaTecnicaCamara**)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = caracteristicaTecnicaCamara` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 y DF3 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 y `caracteristicaTecnicaCamara` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `idElemento` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**idElemento**, descripcionElemento)
* L4(**idElemento**, **idFoto**, fechaFoto, obturacionCamaraFoto, **caracteristicaTecnicaCamara**)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = idElemento` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF2 vale en L3

La DF3 no vale ni en L3 ni L4. Aplico el algoritmo para ver si se pierde DF3 y veo que
 
* DF1: caracteristicaTecnicaCamara -> descripcionCaracteristica, idCamara
* DF2: idElemento -> descripcionElemento
* DF3: idFoto -> fechaFoto, obturacionCamaraFoto, idCamara

Res= idFoto
i=1
Res= idFoto U ((idFoto ∩ {caracteristicaTecnicaCamara, descripcionCaracteristica, idCamara})+ ∩ {caracteristicaTecnicaCamara, descripcionCaracteristica, idCamara}) = idFoto 

Res= idFoto
i=2
Res= idFoto U ((idFoto ∩ {idElemento, descripcionElemento})+ ∩ {idElemento, descripcionElemento}) = idFoto 

Res= idFoto
i=3
Res= idFoto U ((idFoto ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara})+ ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara})
Res= idFoto U ((idFoto)+ ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara})
Res= idFoto U ({idFoto, fechaFoto, obturacionCamaraFoto, idCamara} ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara}) = {idFoto, fechaFoto, obturacionCamaraFoto}

Res = {idFoto, fechaFoto, obturacionCamaraFoto}
i= 1
Res= {idFoto, fechaFoto, obturacionCamaraFoto} U (({idFoto, fechaFoto, obturacionCamaraFoto} ∩ {caracteristicaTecnicaCamara, descripcionCaracteristica, idCamara})+ ∩ {caracteristicaTecnicaCamara, descripcionCaracteristica, idCamara}) = {idFoto, fechaFoto, obturacionCamaraFoto}

Res= {idFoto, fechaFoto, obturacionCamaraFoto}
i=2
Res= {idFoto, fechaFoto, obturacionCamaraFoto} U (({idFoto, fechaFoto, obturacionCamaraFoto} ∩ {idElemento, descripcionElemento})+ ∩ {idElemento, descripcionElemento}) = {idFoto, fechaFoto, obturacionCamaraFoto}

Res= {idFoto, fechaFoto, obturacionCamaraFoto}
i=3
Res= {idFoto, fechaFoto, obturacionCamaraFoto} U (({idFoto, fechaFoto, obturacionCamaraFoto} ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara})+ ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara})
Res= {idFoto, fechaFoto, obturacionCamaraFoto} U (({idFoto, fechaFoto, obturacionCamaraFoto})+ ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara}) = {fechaFoto, obturacionCamaraFoto}
Res= {idFoto, fechaFoto, obturacionCamaraFoto} U ({idFoto, fechaFoto, obturacionCamaraFoto} ∩ {idElemento, idFoto, fechaFoto, obturacionCamaraFoto, caracteristicaTecnicaCamara}) = {idFoto, fechaFoto, obturacionCamaraFoto}









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

inc --

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
