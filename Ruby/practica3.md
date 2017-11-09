# Práctica 3

## Excepciones

### 1. Investigá la jerarquía de clases que presenta Ruby para las excepciones. ¿Para qué se utilizan las siguientes clases?

https://airbrake.io/blog/ruby-exception-handling/ruby-exception-classes

#### IOError

Es lanzada cuando una operación de entrada/salida falla.

#### NameError

Es lanzada cuando el nombre de una variable o símbolo es inválido o indefinido.

#### RuntimeError

Es lanzada cuando se intenta realizar una operación inválida de algún tipo.

#### NotImplementedError

Es lanzada cuando se intenta utilizar una característica o método que no está implementada en la plataforma actual.

#### StopIteration

StopIteration is unique in the realm of Ruby exceptions, since it isn’t generated at run-time by something going haywire, but is instead manually raised by the developer when there’s a need to halt an active iteration.

#### TypeError

Es lanzada cuando se encuentra un objeto que no es del tipo esperado.

#### SystemExit

Es lanzada cuando el método `Kernel#exit` es invocado para finalizar el proceso actual.

---

### 2. ¿Cuál es la diferencia entre raise y throw? ¿Para qué usarías una u otra opción?

Catch/throw are not the same as raise/rescue. catch/throw allows you to quickly exit blocks back to a point where a catch is defined for a specific symbol, raise rescue is the real exception handling stuff involving the Exception object.

---

### 3. ¿Para qué sirven begin .. rescue .. else y ensure? Pensá al menos 2 casos concretos en que usarías estas sentencias en un script Ruby.

http://rubylearning.com/satishtalim/ruby_exceptions.html

https://stackoverflow.com/questions/2191632/begin-rescue-and-ensure-in-ruby

---

### 4. ¿Para qué sirve retry? ¿Cómo evitarías caer en un loop infinito al usarla?

http://blog.honeybadger.io/how-to-try-again-when-exceptions-happen-in-ruby/

---

### 5. ¿Cuáles son las diferencias entre los siguientes métodos?

```
def opcion_1
  a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
  b = 3
  c = a.map do | x|
    x * b
  end
  puts c.inspect
rescue
  0
end

def opcion_2
  c = begin
      a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
      b = 3
      a.map do | x|
        x * b
      end
    rescue
      0
    end
  puts c.inspect
end

def opcion_3
  a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
  b = 3
  c = a.map { | x| x * b } rescue 0
  puts c.inspect
end

def opcion_4
  a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
  b = 3
  c = a.map { | x| x * b rescue 0 }
  puts c.inspect
  end
```

* `opcion_1`: retorna 0;
* `opcion_2`: imprime `0` y retorna `nil`
* `opcion_3`: imprime `0` y retorna `nil`
* `opcion_4`: imprime `[3, 0, 9, 0, 15, 0, 21, 0, 27, 0]` y retorna `nil`

---


