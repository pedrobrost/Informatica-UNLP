# Práctica 3 - Normalización

### 7. EMPRESA_COLECTIVO (#Línea, #Ramal, #Colectivo, dniChofer, dniInspector, dniEmpleado, nombreLinea, nombreChofer, nombreInspector, nombreEmpleado)
 
* Una línea posee varios ramales.
* Los #Ramal no se repiten en distintas líneas.
* Los #Colectivo se repiten en distintas líneas.
* Los choferes están asignados a un único ramal.
* Cada colectivo de una línea está asignado a un único ramal.
* Para cada ramal existe al menos un chofer asignado.

**Clave Candidata:**
* Cc1: (#colectivo, dniChofer, dniInspector, dniEmpleado)

**Dependencias Funcionales:**
* DF1: #linea -> nombreLinea
* DF2: dniInspector -> nombreInspector
* DF3: dniEmpleado -> nombreEmpleado
* DF4: dniChofer -> #ramal, nombreChofer
* DF5: #ramal -> #linea
* DF6: #linea, #colectivo -> #ramal

#### ¿EMPRESA_COLECTIVO cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `#linea` no es superclave de EMPRESA_COLECTIVO, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**#linea**, nombreLinea)
* L2(#linea, #ramal, **#colectivo**, **dniChofer**, **dniInspector**, **dniEmpleado**, nombreChofer, nombreInspector, nombreEmpleado)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = #linea` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 a DF7 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 y `#linea` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `dniInspector` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**dniInspector**, nombreInspector)
* L4(#linea, #ramal, **#colectivo**, **dniChofer**, **dniInspector**, **dniEmpleado**, nombreChofer, nombreEmpleado)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = dniInspector` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF2 vale en L3
* DF3 a DF6 valen en L4

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF2 y `dniInspector` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `dniEmpleado` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L5(**dniEmpleado**, nombreEmpleado)
* L6(#linea, #ramal, **#colectivo**, **dniChofer**, **dniInspector**, **dniEmpleado**, nombreChofer)

#### ¿Se perdió información?

No, ya que `L5 ∩ L6 = dniEmpleado` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF3 vale en L5
* DF4 a DF6 valen en L6

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 vale DF3 donde `dniEmpleado` es superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF4` donde `dniChofer` no es superclave de L6, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF4`.

* L7(**dniChofer**, #ramal, nombreChofer)
* L8(#linea, **#colectivo**, **dniChofer**, **dniInspector**, **dniEmpleado**)

#### ¿Se perdió información?

No, ya que `L7 ∩ L8 = dniChofer` es clave en L7.

#### ¿Se perdieron dependencias funcionales?

* DF4 vale en L7
* DF5 no vale ni en L7 ni L8. Aplico el algoritmo para ver si se pierde DF5:

```
Res= #ramal
i=1
Res= #ramal U ((#ramal ∩ {#linea, nombreLinea})+ ∩ {#linea, nombreLinea}) = #ramal

Res= #ramal
i=2
Res= #ramal U ((#ramal ∩ {dniInspector, nombreInspector})+ ∩ {dniInspector, nombreInspector}) = #ramal

Res= #ramal
i=3
Res= #ramal U ((#ramal ∩ {dniEmpleado, nombreEmpleado})+ ∩ {dniEmpleado, nombreEmpleado}) = #ramal

Res= #ramal
i=4
Res= #ramal U ((#ramal ∩ {dniChofer, #ramal, nombreChofer})+ ∩ {dniChofer, #ramal, nombreChofer})
Res= #ramal U ((#ramal)+ ∩ {dniChofer, #ramal, nombreChofer})
Res= #ramal U ({#ramal, #linea, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer}) = #ramal

Res= #ramal
i=5
Res= #ramal U ((#ramal ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= #ramal U ((#ramal)+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= #ramal U ({#ramal, #linea, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado}) = {#ramal, #linea}

Res= {#ramal, #linea}
i=1
Res= {#ramal, #linea} U (({#ramal, #linea} ∩ {#linea, nombreLinea})+ ∩ {#linea, nombreLinea})
Res= {#ramal, #linea} U ((#linea)+ ∩ {#linea, nombreLinea})
Res= {#ramal, #linea} U ({#linea, nombreLinea} ∩ {#linea, nombreLinea}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=2
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {dniInspector, nombreInspector})+ ∩ {dniInspector, nombreInspector}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=3
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {dniEmpleado, nombreEmpleado})+ ∩ {dniEmpleado, nombreEmpleado}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=4
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer})+ ∩ {dniChofer, #ramal, nombreChofer})
Res= {#ramal, #linea, nombreLinea} U ((#ramal)+ ∩ {dniChofer, #ramal, nombreChofer})
Res= {#ramal, #linea, nombreLinea} U ({#ramal, #linea, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=5
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#ramal, #linea, nombreLinea} U ({#ramal, #linea, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=1
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {#linea, nombreLinea})+ ∩ {#linea, nombreLinea})
Res= {#ramal, #linea, nombreLinea} U ((#linea, nombreLinea)+ ∩ {#linea, nombreLinea})
Res= {#ramal, #linea, nombreLinea} U ({#linea, nombreLinea} ∩ {#linea, nombreLinea}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=2
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {dniInspector, nombreInspector})+ ∩ {dniInspector, nombreInspector}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=3
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {dniEmpleado, nombreEmpleado})+ ∩ {dniEmpleado, nombreEmpleado}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=4
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer})+ ∩ {dniChofer, #ramal, nombreChofer})
Res= {#ramal, #linea, nombreLinea} U ((#ramal)+ ∩ {dniChofer, #ramal, nombreChofer})
Res= {#ramal, #linea, nombreLinea} U ({#ramal, #linea, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer}) = {#ramal, #linea, nombreLinea}

Res= {#ramal, #linea, nombreLinea}
i=5
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#ramal, #linea, nombreLinea} U (({#ramal, #linea})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#ramal, #linea, nombreLinea} U ({#ramal, #linea, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado}) = {#ramal, #linea, nombreLinea}
```

Al finalizar el algoritmo, como en `Res = {#ramal, #linea, nombreLinea}` dispongo del atributo `#linea` puedo concluir que no se perdió la `DF5`.

* DF6 no vale ni en L7 ni L8. Aplico el algoritmo para ver si se pierde DF6:

```
Res= {#linea, #colectivo}
i=1
Res= {#linea, #colectivo} U (({#linea, #colectivo} ∩ {#linea, nombreLinea})+ ∩ {#linea, nombreLinea})
Res= {#linea, #colectivo} U ((#linea)+ ∩ {#linea, nombreLinea})
Res= {#linea, #colectivo} U ({#linea, nombreLinea} ∩ {#linea, nombreLinea}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=2
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {dniInspector, nombreInspector})+ ∩ {dniInspector, nombreInspector}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=3
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {dniEmpleado, nombreEmpleado})+ ∩ {dniEmpleado, nombreEmpleado}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=4
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer})+ ∩ {dniChofer, #ramal, nombreChofer}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=5
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#linea, #colectivo, nombreLinea} U ({#linea, #colectivo, nombreLinea, #ramal} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=1
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {#linea, nombreLinea})+ ∩ {#linea, nombreLinea})
Res= {#linea, #colectivo} U ((#linea, nombreLinea)+ ∩ {#linea, nombreLinea})
Res= {#linea, #colectivo} U ({#linea, nombreLinea} ∩ {#linea, nombreLinea}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=2
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {dniInspector, nombreInspector})+ ∩ {dniInspector, nombreInspector}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=3
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {dniEmpleado, nombreEmpleado})+ ∩ {dniEmpleado, nombreEmpleado}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=4
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {dniChofer, #ramal, nombreChofer})+ ∩ {dniChofer, #ramal, nombreChofer}) = {#linea, #colectivo, nombreLinea}

Res= {#linea, #colectivo, nombreLinea}
i=5
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo, nombreLinea} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#linea, #colectivo, nombreLinea} U (({#linea, #colectivo})+ ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado})
Res= {#linea, #colectivo, nombreLinea} U ({#linea, #colectivo, nombreLinea, #ramal} ∩ {#linea, #colectivo, dniChofer, dniInspector, dniEmpleado}) = {#linea, #colectivo, nombreLinea}
```

Al finalizar el algoritmo, como en `Res = {#linea, #colectivo, nombreLinea}` no dispongo del atributo `#ramal` multideterminado por la DF3 puedo determinar que se perdieron dependencias funcionales, por ende hago el pasaje a 3FN.

#### Esquemas en 3FN

* L1(**#linea**, nombreLinea)
* L2(**dniInspector**, nombreInspector)
* L3(**dniEmpleado**, nombreEmpleado)
* L4(**dniChofer**, #ramal, nombreChofer)
* L5(**#ramal**, #linea)
* L6(**#linea**, **#colectivo**, #ramal)
* L7(**#colectivo**, **dniChofer**, **dniInspector**, **dniEmpleado**)

inc --

#### Dependencias Multivaludas en L7:

* DM1: 

#### ¿L7 cumple con la definición de 4FN?

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
