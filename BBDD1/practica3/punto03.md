# Práctica 3 - Normalización

### 3. INFORME_MEDICO (idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe)
 
* De cada médico se conoce su nombre y apellido, tipo y número de documento, fecha de nacimiento, matricula, dirección y teléfono.
* De cada paciente se conoce su nombre y apellido, tipo y número de documento, fecha de nacimiento, dirección, teléfono, obra social y número de afiliado. Cada obra social numera a sus afiliados de forma independiente, con lo cual los nroAfiliado podrían repetirse en diferentes obras sociales.
* De cada obra social se conoce su nombre, dirección y teléfono.
* Para cada órgano se conoce su descripción.
* De cada estudio se registra a que paciente pertenece, que médico lo realizo, que órgano se estudio, un informe, el resultado y en qué fecha se realizó.

**Clave Candidata:**
* Cc2: (idEstudio)

**Dependencias Funcionales:**
DF1: idMedico -> apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM
DF2: idObraSoc -> nombreOS, direcciónOS, teléfonoOS
DF3: idPaciente -> apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP
DF4: idObraSoc, nroAfiliado -> apynPaciente, tipoDocP, nroDocP, fechaNacP, idPaciente, direcciónP, teléfonoP
DF5: idÓrgano -> descripción
DF6: idEstudio -> resultado, fechaEstudio, informe, idOrgano, IdPaciente, IdMedico
DF7: idEstudio -> resultado, fechaEstudio, informe, idOrgano, idObraSoc, nroAfiliado, IdMedico

#### ¿INFORME_MEDICO cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `idMedico` no es superclave de INFORME_MEDICO, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**idMedico**, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM)
* L2(idMedico, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = idMedico` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 a DF7 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 donde `idMedico` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `idObraSoc` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**idObraSoc**, nombreOS, direcciónOS, teléfonoOS)
* L4(idMedico, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = idObraSocial` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF2 vale en L3
* DF3 a DF7 valen en L4

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF2 donde `idObraSocial` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `idPaciente` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L5(**idPaciente**, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP)
* L6(idMedico, idPaciente, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe)

#### ¿Se perdió información?

No, ya que `L5 ∩ L6 = idPaciente` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

* DF3 y DF4 valen en L5
* DF5 a DF6 valen en L6
* DF7 no vale ni en L5 ni L6. Aplico el algoritmo para ver si se pierde DF7:

```
Res= {idEstudio}
i=1
Res= {idEstudio} U (({idEstudio} ∩ {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM})+ ∩ {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM}) = {idEstudio}

Res= {idEstudio}
i=2
Res= {idEstudio} U (({idEstudio} ∩ {idObraSoc, nombreOS, direcciónOS, teléfonoOS})+ ∩ {idObraSoc, nombreOS, direcciónOS, teléfonoOS}) = {idEstudio}

Res= {idEstudio}
i=3
Res= {idEstudio} U (({idEstudio} ∩ {idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP})+ ∩ {idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP}) = {idEstudio}

Res= {idEstudio}
i=4
Res= {idEstudio} U (({idEstudio} ∩ {idMedico, idPaciente, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe})+ ∩ {idMedico, idPaciente, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe})
Res= {idEstudio} U (({idEstudio})+ ∩ {idMedico, idPaciente, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe})
Res= {idEstudio} U ({idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe} ∩ {idMedico, idPaciente, idÓrgano, descripción, **idEstudio**, resultado, fechaEstudio, informe}) = {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe}
```

Al realizar el algoritmo, como en `Res = {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe}` dispongo de los atributos determinados por `DF5` puedo concluir que no se perdió la `DF7`.

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 valen DF3 y DF4 donde `idPaciente` y `idObraSocial, nroAfiliado` son superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF5` donde `idOrgano` no es superclave de L6, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF5`.

* L7(**idOrgano**, descripcion)
* L8(idMedico, idPaciente, idÓrgano, **idEstudio**, resultado, fechaEstudio, informe)

#### ¿Se perdió información?

No, ya que `L7 ∩ L8 = idOrgano` es clave en L7.

#### ¿Se perdieron dependencias funcionales?

* DF5 vale en L7
* DF6 vale en L8
* DF7 no vale ni en L7 ni L8. Aplico el algoritmo para ver si se pierde DF7:

```
Res= {idEstudio}
i=1
Res= {idEstudio} U (({idEstudio} ∩ {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM})+ ∩ {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM}) = {idEstudio}

Res= {idEstudio}
i=2
Res= {idEstudio} U (({idEstudio} ∩ {idObraSoc, nombreOS, direcciónOS, teléfonoOS})+ ∩ {idObraSoc, nombreOS, direcciónOS, teléfonoOS}) = {idEstudio}

Res= {idEstudio}
i=3
Res= {idEstudio} U (({idEstudio} ∩ {idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP})+ ∩ {idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP}) = {idEstudio}

Res= {idEstudio}
i=4
Res= {idEstudio} U (({idEstudio} ∩ {idMedico, idPaciente, idÓrgano, idEstudio, resultado, fechaEstudio, informe})+ ∩ {idMedico, idPaciente, idÓrgano, idEstudio, resultado, fechaEstudio, informe})
Res= {idEstudio} U (({idEstudio})+ ∩ {idMedico, idPaciente, idÓrgano, idEstudio, resultado, fechaEstudio, informe})
Res= {idEstudio} U ({idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe} ∩ {idMedico, idPaciente, idÓrgano, idEstudio, resultado, fechaEstudio, informe}) = {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe}
```

Al realizar el algoritmo, como en `Res = {idMedico, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM, idPaciente, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP, nombreOS, direcciónOS, teléfonoOS, idÓrgano, descripción, idEstudio, resultado, fechaEstudio, informe}` dispongo de los atributos determinados por `DF5` puedo concluir que no se perdió la `DF7`.

#### ¿L7 cumple con la definición de BCNF?

Sí, ya que en L7 vale DF5 donde `idOrgano` es superclave del esquema L7.

#### ¿L8 cumple con la definición de BCNF?

Sí, ya que en L8 vale DF6 donde `idEstudio` es superclave del esquema L8.

#### Particiones de INFORME_MEDICO que quedaron en BCNF:

* L1(**idMedico**, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM)
* L3(**idObraSoc**, nombreOS, direcciónOS, teléfonoOS)
* L5(**idPaciente**, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP)
* L7(**idOrgano**, descripcion)
* L8(idMedico, idPaciente, idÓrgano, **idEstudio**, resultado, fechaEstudio, informe)

#### Clave Primaria

* (idEstudio)

#### Dependencias Multivaludas en L8:

No hay dependencias multivaludas en el esquema L8

#### ¿L8 cumple con la definición de 4FN?

Sí, ya que el esquema no presenta dependencias multivaluadas.

#### Particiones de INFORME_MEDICO que quedaron en 4NF:

* L1(**idMedico**, apynMedico, tipoDocM, nroDocM, fechaNacM, matricula, direcciónM, teléfonoM)
* L3(**idObraSoc**, nombreOS, direcciónOS, teléfonoOS)
* L5(**idPaciente**, apynPaciente, tipoDocP, nroDocP, fechaNacP, idObraSoc, nroAfiliado, direcciónP, teléfonoP)
* L7(**idOrgano**, descripcion)
* L8(idMedico, idPaciente, idÓrgano, **idEstudio**, resultado, fechaEstudio, informe)

---
