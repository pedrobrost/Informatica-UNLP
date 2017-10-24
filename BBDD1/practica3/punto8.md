# Práctica 3 - Normalización

### 8. INTERNACION (codHospital, cantidadHabitaciones, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, domicilioHospital, ciudadHospital, directorHospital, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación) 

* cantidadHabitaciones es la cantidad de habitaciones que hay en cada hospital.
* direcciónInternacionPaciente y telefonoInternacionPaciente, indican la dirección y el teléfono que deja un paciente cuando se interna.
* domicilioPaciente es el domicilio que figura en el dni del paciente.
* Un paciente para una internación es atendido por muchos doctores (doctorQueAtiendePaciente).
* Para una internación de un paciente, se emplean varios insumos (insumoEmpleadoInternación).
* El código de hospital (codHospital) es único.
* Existe un único director por hospital. Un director podría dirigir mas de un hospital.
* Un paciente en la misma fecha no puede estar internado en diferentes hospitales.
* En un domicilioHospital de una ciudad existe un único hospital.

**Clave Candidata:**
* Cc1: (dniPaciente, fechaInicioInternacion, doctorQueAtiendePaciente, insumoEmpleadoInternacion)

**Dependencias Funcionales:**

* DF1: codHospital -> cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital
* DF2: domicilioHospital, ciudadHospital -> codHospital, cantidadHabitaciones, directorHospital
* DF3: dniPaciente -> domicilioPaciente, nombreApellidoPaciente
* DF4: dniPaciente, fechaInicioInternacion -> codHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente
* DF5: dniPaciente, fechaInicioInternacion -> domicilioHospital, ciudadHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente


#### ¿INTERNACION cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `codHospital` no es superclave de INTERNACION, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**codHospital**, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital)
* L2(codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, **dniPaciente**, domicilioPaciente, nombreApellidoPaciente, **fechaInicioInternacion**, cantDiasIntenacion, **doctorQueAtiendePaciente**, **insumoEmpleadoInternación**) 

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = codHospital` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

* DF1 y DF2 valen en L1
* DF3 y DF4 valen en L2
* DF5 no vale ni en L1 ni L2. Aplico el algoritmo para ver si se pierde DF5:

```
Res= {dniPaciente, fechaInicioInternacion}
i=1
Res= {dniPaciente, fechaInicioInternacion} U (({dniPaciente, fechaInicioInternacion} ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})+ ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}) = {dniPaciente, fechaInicioInternacion}

Res= {dniPaciente, fechaInicioInternacion}
i=2
Res= {dniPaciente, fechaInicioInternacion} U (({dniPaciente, fechaInicioInternacion} ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación})+ ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación})
Res= {dniPaciente, fechaInicioInternacion} U (({dniPaciente, fechaInicioInternacion})+ ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación})
Res= {dniPaciente, fechaInicioInternacion} U ({dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, domicilioHospital, ciudadHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital} ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, domicilioPaciente, nombreApellidoPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación}) = {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital}

Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital}
i=1
Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital} U (({dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital} ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})+ ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})
Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital} U (({codHospital})+ ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})
Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital} U ({cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital} ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}) = {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}
```

Al realizar el algoritmo, como en `Res = {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}` dispongo de los atributos determinados por `DF5` puedo concluir que no se perdió la `DF5`.

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 valen DF1 y DF2 donde `codHospital`  y `domicilioHospital, ciudadHospital` son superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `dniPaciente` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L3(**dniPaciente**, domicilioPaciente, nombreApellidoPaciente)
* L4(codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, **dniPaciente**, **fechaInicioInternacion**, cantDiasIntenacion, **doctorQueAtiendePaciente**, **insumoEmpleadoInternación**) 

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = dniPaciente` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

* DF3 vale en L3
* DF4 vale en L4
* DF5 no vale ni en L3 ni L4. Aplico el algoritmo para ver si se pierde DF5:

```
Res= {dniPaciente, fechaInicioInternacion}
i=1
Res= {dniPaciente, fechaInicioInternacion} U (({dniPaciente, fechaInicioInternacion} ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})+ ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}) = {dniPaciente, fechaInicioInternacion}

Res= {dniPaciente, fechaInicioInternacion}
i=2
Res= {dniPaciente, fechaInicioInternacion} U (({dniPaciente, fechaInicioInternacion} ∩ {dniPaciente, domicilioPaciente, nombreApellidoPaciente})+ ∩ {dniPaciente, domicilioPaciente, nombreApellidoPaciente}) = {dniPaciente, fechaInicioInternacion}
Res= {dniPaciente, fechaInicioInternacion} U (({dniPaciente})+ ∩ {dniPaciente, domicilioPaciente, nombreApellidoPaciente})
Res= {dniPaciente, fechaInicioInternacion} U ({dniPaciente, domicilioPaciente, nombreApellidoPaciente} ∩ {dniPaciente, domicilioPaciente, nombreApellidoPaciente}) = {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente}

Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente}
i=3
Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente} U (({dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente} ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación})+ ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación})
Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente} U (({dniPaciente, fechaInicioInternacion})+ ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación})
Res= {dniPaciente, fechaInicioInternacion, domicilioPaciente, nombreApellidoPaciente} U ({dniPaciente, fechaInicioInternacion, domicilioHospital, ciudadHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital} ∩ {codHospital, direcciónInternacionPaciente, telefonoInternacionPaciente, dniPaciente, fechaInicioInternacion, cantDiasIntenacion, doctorQueAtiendePaciente, insumoEmpleadoInternación}) = {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente}

Res= {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente}
i=1
Res= {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente} U (({dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente} ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})+ ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})
Res= {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente} U (({codHospital})+ ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital})
Res= {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente} U ({codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital} ∩ {codHospital, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}) = {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}
```

Al realizar el algoritmo, como en `Res = {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}` dispongo de los atributos determinados por `DF5` puedo concluir que no se perdió la `DF5`.

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF3 y `dniPaciente` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF4` donde `dniPaciente, fechaInicioInternacion` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF4`.

* L5(**dniPaciente**, **fechaInicioInternacion**, codHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente)
* L6(**dniPaciente**, **fechaInicioInternacion**, **doctorQueAtiendePaciente**, **insumoEmpleadoInternación**) 

#### ¿Se perdió información?

No, ya que `L5 ∩ L6 = dniPaciente, fechaInicioInternacion` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

* DF4 vale en L5
* DF5 no vale ni en L5 ni L6. Aplico el algoritmo para ver si se pierde DF5:

-- falta algoritmo --

Al realizar el algoritmo, como en `Res = {dniPaciente, fechaInicioInternacion, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente, codHospital, domicilioPaciente, nombreApellidoPaciente, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital}` dispongo de los atributos determinados por `DF5` puedo concluir que no se perdió la `DF5`.

* DF4: dniPaciente, fechaInicioInternacion -> codHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente
* DF5: dniPaciente, fechaInicioInternacion -> domicilioHospital, ciudadHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 vale DF4 donde `dniPaciente, fechaInicioInternacion` es superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

Sí, ya que las únicas dependencias funcionales son triviales.

#### Particiones de EMPLEADO que quedaron en BCNF:

* L1(**codHospital**, cantidadHabitaciones, directorHospital, domicilioHospital, ciudadHospital)
* L3(**dniPaciente**, domicilioPaciente, nombreApellidoPaciente)
* L5(**dniPaciente**, **fechaInicioInternacion**, codHospital, cantDiasInternacion, direccionInternacionPaciente, telefonoInternacionPaciente)
* L6(**dniPaciente**, **fechaInicioInternacion**, **doctorQueAtiendePaciente**, **insumoEmpleadoInternación**) 

#### Dependencias Multivaludas en L6:

* DM1:

---
