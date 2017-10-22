# Práctica 3 - Normalización

### 4. AEROPUERTO (#aeropuerto, #pista, fecha, #avion)
 
* #aeropuerto y #avion son únicos, pero el #pista se puede repetir para distintos aeropuertos.
* fecha representa la fecha de despegue de un avión. Cada avión tiene como máximo un despegue diario en un mismo aeropuerto.
* Un avión puede realizar despegues de distintos aeropuertos.

**Clave Candidata:**
* Cc1: (#aeropuerto, #avion, fecha)

**Dependencias Funcionales:**
* DF1: #aeropuerto, #avion, fecha -> #pista


#### ¿AEROPUERTO cumple con la definición de BCNF?

Sí, ya que en AEROPUERTO vale DF1 donde `#aeropuerto, #avion, fecha` es superclave del esquema AEROPUERTO.

#### Dependencias Multivaludas en AEROPUERTO:

No hay dependencias multivaludas en el esquema AEROPUERTO

#### ¿AEROPUERTO cumple con la definición de 4FN?

Sí, ya que el esquema no presenta dependencias multivaluadas.

#### Particiones de EMPLEADO que quedaron en 4NF:

* AEROPUERTO (#aeropuerto, #pista, fecha, #avion)

---
