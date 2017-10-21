# Práctica 3 - Normalización

### 1. LIBRERIAS_ASOCIADAS (idLibreria, nombreLibreria, idArticulo, nombreArticulo, idComponente, nombreComponente, idFabricanteArticulo, idDueño)

* Para cada librería se conoce su identificador, el cual es único. Además se conoce su nombre, que puede repetirse en distintas librerías.
* Cada librería posee uno o varios dueños (idDueño)
* Cada librería registra los artículos (idArticulo) que tiene en su inventario. Para cada artículo de una librería se conoce su nombre. 
* Los identificadores de artículos se pueden repetir en diferentes librerías, pero no dentro de una misma librería.
* Los artículos de una librería están compuestos por diversos componentes (idComponente). 
* Los identificadores de componentes se pueden repetir en diferentes librerías para diferentes artículos, pero no para el mismo componente de un artículo dentro de una misma librería. 
* Para cada componente de un artículo de una librería se conoce su nombre.
* Cada artículo de una librería tiene varios fabricantes que lo proveen (idFabricanteArticulo).

**Clave Candidata:**
* Cc1: (idLibreria, idArticulo, idComponente, idFabricanteArtículo, idDueño)

**Dependencias Funcionales:**
* DF1: idLibreria -> nombreLibreria
* DF2: idLibreria, idArticulo -> nombreArticulo
* DF3: idLibreria, idArticulo, idComponente -> nombreComponente


#### ¿LIBRERIAS_ASOCIADAS cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF1` donde `idLibreria` no es superclave de LIBRERIAS_ASOCIADAS, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF1`.

* L1(**idLibreria**, nombreLibreria)
* L2(**idLibreria**, **idArticulo**, nombreArticulo, **idComponente**, nombreComponente, **idFabricanteArticulo**, **idDueño**)

#### ¿Se perdió información?

No, ya que `L1 ∩ L2 = idLibreria` es clave en L1.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF1 vale en L1
* DF2 y DF3 valen en L2

#### ¿L1 cumple con la definición de BCNF?

Sí, ya que en L1 vale DF1 y `idLibreria` es superclave del esquema L1.

#### ¿L2 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF2` donde `idLibreria, idArticulo` no es superclave de L2, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF2`.

* L3(**idLibreria**, **idArticulo**, nombreAcrticulo)
* L4(**idLibreria**, **idArticulo**, **idComponente**, nombreComponente, **idFabricanteArticulo**, **idDueño**)

#### ¿Se perdió información?

No, ya que `L3 ∩ L4 = idLibreria, idArticulo` es clave en L3.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF2 vale en L3
* DF3 vale en L4

#### ¿L3 cumple con la definición de BCNF?

Sí, ya que en L3 vale DF2 y `idLibreira, idArticulo` es superclave del esquema L3.

#### ¿L4 cumple con la definición de BCNF?

No, ya que al menos encontramos una dependencia funcional `DF3` donde `idLibreria, idArticulo, idComponente` no es superclave de L4, ni es una dependecia funcional trivial. Por lo tanto particionamos el esquema contemplando `DF3`.

* L5(**idLibreria**, **idArticulo**, **idComponente**, nombreComponente)
* L6(**idLibreria**, **idArticulo**, **idComponente**, **idFabricanteArticulo**, **idDueño**)

#### ¿Se perdió información?

No, ya que `L5 ∩ L5 = idLibreria, idArticulo, idComponente` es clave en L5.

#### ¿Se perdieron dependencias funcionales?

No, ya que:

* DF3 vale en L5

#### ¿L5 cumple con la definición de BCNF?

Sí, ya que en L5 vale DF3 y `idLibreira, idArticulo, idComponente` es superclave del esquema L5.

#### ¿L6 cumple con la definición de BCNF?

Sí, ya que las únicas dependencias funcionales son triviales.

#### Particiones de LIBRERIAS_ASOCIADAS que quedaron en BCNF:

* L1(**idLibreria**, nombreLibreria)
* L3(**idLibreria**, **idArticulo**, nombreAcrticulo)
* L5(**idLibreria**, **idArticulo**, **idComponente**, nombreComponente)
* L6(**idLibreria**, **idArticulo**, **idComponente**, **idFabricanteArticulo**, **idDueño**)

#### Dependencias Multivaludas en L6:

* DM1: idLibreria ->> idDueño
* DM2: idLibreria, idArticulo ->> idFabricanteArticulo
* DM3: idLibreira, idArticulo ->> idComponente

#### ¿L6 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM1, DM2, DM3` que no son triviales en L6. Por lo tanto se particiona L6 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM1.

* L7(**idLibreria**, idDueño)
* L8(**idLibreria**, **idArticulo**, **idComponente**, **idFabricanteArticulo**)

#### ¿L7 cumple con la definición de 4FN?

Sí, ya que en L7 solo vale la DM1 que es trivial en L7.

#### ¿L8 cumple con la definición de 4FN?

No, ya que existen dependencias multivualadas `DM2, DM3` que no son triviales en L8. Por lo tanto se particiona L8 teniendo en cuenta las dependencias multivaluadas, por ejemplo DM2.

* L9(**idLibreria**, **idArticulo**, idFabricanteArticulo)
* L10(**idLibreria**, **idArticulo**, idComponente)

#### ¿L9 cumple con la definición de 4FN?

Sí, ya que en L9 solo vale la DM2 que es trivial en L9.

#### ¿L10 cumple con la definición de 4FN?

Sí, ya que en L10 solo vale la DM3 que es trivial en L10.

#### Particiones de LIBRERIAS_ASOCIADAS que quedaron en 4NF:

* L1(**idLibreria**, nombreLibreria)
* L3(**idLibreria**, **idArticulo**, nombreAcrticulo)
* L5(**idLibreria**, **idArticulo**, **idComponente**, nombreComponente)
* L7(**idLibreria**, idDueño)
* L9(**idLibreria**, **idArticulo**, idFabricanteArticulo)

---
