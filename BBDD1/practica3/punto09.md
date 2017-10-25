# Práctica 3 - Normalización

### 9. INFRACCIONES_REALIZADAS (#auto, modeloAuto, #cedula, #conductor, fechaVto, #propietario, #infraccion, fechaInfraccion, tipoInfraccion)

* un auto tiene una o más cédulas asociadas que corresponden a los conductores autorizados. Cada cédula se asocia a un único auto y a un único conductor, y tiene una fecha de vencimiento.
* los #cedula y #conductor son únicos en el sistema. Si bien un conductor puede conducir varios autos, para cada uno de ellos tendrá una cédula diferente.
* un auto puede tener más de un propietario y un propietario puede tener más de un auto.
* de cada infracción que se labra se registra el número de cedula del conductor del auto. Además se conoce la fecha y el tipo de infracción.

**Clave Candidata:**
* Cc1: (#infraccion, #propietario)

**Dependencias Funcionales:**

* DF1: #auto -> modeloAuto
* DF2: #cedula -> #auto, #conductor, fechaVto
* DF3: #infraccion -> #cedula, fechaInfraccion, tipoInfraccion


#### ¿INFRACCIONES_REALIZADAS cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `#auto` no es superclave de INFRACCIONES_REALIZADAS, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**#auto**, modeloAuto)
* L2(#auto, #cedula, #conductor, fechaVto, **#propietario**, **#infraccion**, fechaInfraccion, tipoInfraccion)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = #auto` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 y DF3 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 donde `#auto` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `#cedula` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**#cedula**, #auto, #conductor, fechaVto)
* L4(#cedula, **#propietario**, **#infraccion**, fechaInfraccion, tipoInfraccion)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = #cedula` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

* DF2 vale en L3
* DF3 vale en L4

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF2 donde `#cedula` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `#infraccion` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L5(**#infraccion**, #cedula, fechaInfraccion, tipoInfraccion)
* L6(**#propietario**, **#infraccion**)

#### ¿Se perdió información?

No, ya que `L5 ∩ L6 = #infraccion` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

* DF3 vale en L5

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 vale DF3 donde `#infraccion` es superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

Sí, ya que las únicas dependencias funcionales son triviales.

#### Particiones de INFRACCIONES_REALIZADAS que quedaron en BCNF:

* L1(**#auto**, modeloAuto)
* L3(**#cedula**, #auto, #conductor, fechaVto)
* L5(**#infraccion**, #cedula, fechaInfraccion, tipoInfraccion)
* L6(**#propietario**, **#infraccion**)

#### Clave Primaria

* (#infraccion, #propietario)

#### Dependencias Multivaludas en L6:

* DM1: #propietario ->> #infraccion

#### ¿L6 cumple con la definición de 4FN?

Sí, ya que la única dependencia multivaluada que vale el `L6` es trivial.

#### Particiones de INFRACCIONES_REALIZADAS que quedaron en 4NF:

* L1(**#auto**, modeloAuto)
* L3(**#cedula**, #auto, #conductor, fechaVto)
* L5(**#infraccion**, #cedula, fechaInfraccion, tipoInfraccion)
* L6(**#propietario**, **#infraccion**)

---
