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

