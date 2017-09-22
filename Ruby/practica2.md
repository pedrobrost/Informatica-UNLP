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


