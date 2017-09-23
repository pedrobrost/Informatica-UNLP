# Práctica 2

## Métodos

### 1. Implementá un método que reciba como parámetro un arreglo de números, los ordene y devuelva el resultado.

```
def ordenar_arreglo array
    array.sort
end
```

---

### 2. Modificá el método anterior para que en lugar de recibir un arreglo como único parámetro, reciba todos los números como parámetros separados.

```
def ordenar_arreglo *array
    array.sort
end
```

---

### 3. Suponé que se te da el método que implementaste en el ejercicio anterior para que lo uses a fin de ordenar un arreglo de números que te son provistos en forma de arreglo.  ¿Cómo podrías invocar el método?

```
ordenar_arreglo *[10, 9, 1, 2, 3, 5, 7, 8]
```

---

### 4. Escribí un método que dado un número variable de parámetros que pueden ser de cualquier tipo, imprima en pantalla la cantidad de caracteres que tiene su representación como String y la representación que se utilizó para contarla.

```
def longitud *args
    args.each { |arg| puts "\"#{arg.to_s}\" --> #{arg.to_s.length}"}
end
```

---

### 5. Implementá el método cuanto_falta? que opcionalmente reciba como parámetro un objeto Time y que calcule la cantidad de minutos que faltan para ese momento. Si el parámetro de fecha no es provisto, asumí que la consulta es para la medianoche de hoy

```
def cuanto_falta? time = Time.new(Time.new.year, Time.new.month, Time.new.day+1)
    Time.at(time - Time.now).utc.strftime("%M")
end
```

---

### 6. Analizá el siguiente código e indicá qué problema(s) puede tener.

```
def tirar_dado
    rand 1..6
end

def mover_ficha(fichas, jugador, casilleros = tirar_dado)
    fichas[jugador] += casilleros
    if fichas[jugador] > 40
        puts "Ganó #{jugador}!!"
        true
    else
        puts "#{jugador} ahora está en el casillero #{fichas[jugador]}"
        fichas[jugador]
    end
end

posiciones = { azul: 0, rojo: 0, verde: 0 }
finalizado = false
until finalizado
    ['azul', 'rojo', 'verde'].shuffle.each do | jugador|
        finalizado = mover_ficha(posiciones, jugador)
    end
end
```

Problemas:

* Se está intentando acceder al hash `fichas` usando un string como key, cuando esta debería ser un símbolo.

* Puede suceder que un jugador gane, pero que luego juegue otro.

* Si los jugadores no ganan devuelven la posición en la que están, por ende la sentencia finalizado se entenderá como `true`.

---

### 7. Modificá el código anterior para, acorde a tu análisis, corregir los problemas que pueda tener.

```
def tirar_dado
    rand 1..6
end

def mover_ficha(fichas, jugador, casilleros = tirar_dado)
    fichas[jugador] += casilleros
    if fichas[jugador] > 40
        puts "Ganó #{jugador}!!"
        true
    else
        puts "#{jugador} ahora está en el casillero #{fichas[jugador]}"
        false
    end
end

posiciones = { azul: 0, rojo: 0, verde: 0 }
finalizado = false
until finalizado
    [:azul, :rojo, :verde].shuffle.each do |jugador|
        finalizado = mover_ficha(posiciones, jugador)
        break if finalizado
    end
end
```

---

## Clases y módulos

### 1. Modelá con una jerarquía de clases algo sencillo que represente la siguiente situación:

* Tres tipos de vehículo: Auto, Moto y Lancha
* Los tres tipos arrancan usando una llave.
* El auto, adicionalmente, requiere que no esté puesto el freno de mano y que el cambio esté en punto muerto. La moto, por otra parte, requiere una patada (sin la llave). La lancha arranca con la llave y listo.
* El arranque de los tres vehículos se prueba en un taller. La especificación de Taller es la siguiente:

```
class Taller
    def probar objeto
        objeto.arrancar
    end
end
```

Suponé que, posteriormente, el taller necesita probar una motosierra. ¿Podrías
hacerlo? ¿Cómo? ¿Qué concepto del lenguaje estás usando para poder realizar
esto?


```
class Vehiculo

end

class Auto < Vehiculo

end

class Moto < Vehiculo

end

class Lancha < Vehiculo

end

class Taller
    def probar objeto
        objeto.arrancar
    end
end
```

---

### 2. ¿Qué diferencia hay entre el uso de include y extend a la hora de incorporar un módulo en una clase?

A la hora de incorporar un módulo a una clase existen dos posiblidades las cuales son hacer uso de la sentencia `include` o bien de `extend`, las cuales trabajan de la siguiente manera:

* include: cuando se incluye un módulo, éste es includio como si los métodos que posee fuesen definidos en la misma clase a la cual se estan incluyendo.

* extend: cuando se utiliza esta sentencia se están agregando los métodos del modulo a una instancia específica. Si se hace sobre la definición de una clase, será sobre la instancia que representa a la clase, por ende los métodos serán de clase. Aunque tambien se puede utilizar sobre una instancia de un objeto creado a partir de una clase, lo cual le extenderá los metodos del módulo a esa única instancia.

#### 1. Si quisieras usar un módulo para agregar métodos de instancia a una clase, ¿qué forma usarías a la hora de incluirlo en la clase?

Utilizaría la sentencia `include`.

#### 2. Si en cambio quisieras usar un módulo para agregar métodos de clase, ¿qué forma usarías a la hora de incluir el módulo en la clase?

Utilizaría la sentencia `extend`.

---

### 3. Implementá el módulo Reverso para utilizar como Mixin e incluilo en alguna clase para probarlo. Reverso debe contener los siguientes métodos:

#### 1. #di_tcejbo: Imprime el object_id del receptor en espejo (en orden inverso).

#### 2. #ssalc: Imprime el nombre de la clase del receptor en espejo.

```
module Reverso

    def di_tcejbo
        puts self.object_id.to_s.reverse
    end

    def ssalc
        puts self.class.to_s.reverse
    end

end

class Test
    include Reverso
end
```

---



