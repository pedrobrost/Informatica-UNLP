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

* DF2 vale en L3
* La DF3 no vale ni en L3 ni L4. Aplico el algoritmo para ver si se pierde DF3:
 
```
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
```

Al finalizar el algoritmo, como en `Res = {idFoto, fechaFoto, obturacionCamaraFoto}` no dispongo de todos los atributos multideterminados por la DF3 puedo determinar que se perdieron dependencias funcionales, por ende hago el pasaje a 3FN.

#### Esquemas en 3FN

* L1(**caracteristicaTecnicaCamara**, descripcionCaracteristica, idCamara)
* L2(**idElemento**, descripcionElemento)
* L3(**idFoto**, fechaFoto, obturacionCamaraFoto, idCamara)
* L4(**caracteristicaTecnicaCamara**, **idElemento**, **idFoto**)

#### Dependencias multivaluadas en L4

* DM1: idFoto -> idElemento
* DM2: idElemento -> idFoto
* DM3: idFoto -> caracteristifaTecnicaCamara

#### ¿L4 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM1, DM2` que no son triviales en L4. Por lo tanto se particiona L4 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM1.

* L5(**idFoto**, **idElemento**)
* L6(**idFoto**, **caracteristicaTecnicaCamara**)

#### ¿L5 cumple con la definición de 4FN?

Sí, ya que en L5 valen las dependencias multivaluadas `DM1, DM2` que son triviales en L5.

#### ¿L6 cumple con la definición de 4FN?

Sí, ya que en L6 solo vale la DM3 que es trivial en L6.

#### Particiones de TOMAS_FOTOGRAFICAS que quedaron en 4NF:

* L1(**caracteristicaTecnicaCamara**, descripcionCaracteristica, idCamara)
* L2(**idElemento**, descripcionElemento)
* L3(**idFoto**, fechaFoto, obturacionCamaraFoto, idCamara)
* L5(**idFoto**, **idElemento**)
* L6(**idFoto**, **caracteristicaTecnicaCamara**)

---
