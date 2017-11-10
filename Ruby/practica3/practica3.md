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

```ruby
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

### 6. Suponé que tenés el siguiente script y se te pide que lo hagas resiliente (tolerante a fallos), intentando siempre que se pueda recuperar la situación y volver a intentar la operación que falló. Realizá las modificaciones que consideres necesarias para lograr que el script sea más robusto.

```ruby
# Este script lee una secuencia de no menos de 15 números desde teclado y lue go imprime el resultado de la división
# de cada número por su entero inmediato anterior.

# Como primer paso se pide al usuario que indique la cantidad de números que ingresará.

cantidad = 0
while cantidad < 15
  puts '¿Cuál es la cantidad de números que ingresará? Debe ser al menos 15'
  cantidad = gets.to_i
end

# Luego se almacenan los números
numeros = 1.upto(cantidad).map do
  puts 'Ingrese un número'
  numero = gets.to_i
end

# Y finalmente se imprime cada número dividido por su número entero inmediato anterior

resultado = numeros.map { | x| x / (x - 1)  }
puts 'El resultado es: %s' % resultado.join(', ')
```

```ruby
cantidad = 0
while cantidad < 5
  puts '¿Cuál es la cantidad de números que ingresará? Debe ser al menos 15'
  cantidad = gets.to_i
end

begin
  # Luego se almacenan los números
  numeros = 1.upto(cantidad).map do
    puts 'Ingrese un número'
    numero = gets.to_i
  end

  # Y finalmente se imprime cada número dividido por su número entero inmediato anterior
  resultado = numeros.map { | x| x / (x - 1)  }
  puts 'El resultado es: %s' % resultado.join(', ')
rescue ZeroDivisionError
  puts "Debe ingresar numeros distintos a uno:"
  retry
end
```

---

### 7. Partiendo del script del inciso anterior, implementá una nueva clase de excepción que se utilizará para indicar que la entrada del usuario no es un valor numérico entero válido. ¿De qué clase de la jerarquía de Exception heredaría?

```ruby
class OneInputError < RangeError
  def message
    "Se ingresó el número 1, el cual no es correcto."
  end
end

cantidad = 0
while cantidad < 5
  puts '¿Cuál es la cantidad de números que ingresará? Debe ser al menos 15'
  cantidad = gets.to_i
end

begin
  # Luego se almacenan los números
  numeros = 1.upto(cantidad).map do
    puts 'Ingrese un número'
    numero = gets.to_i
    raise OneInputError if numero == 1
    numero
  end
rescue OneInputError => e
  puts e.message
  retry
end

# Y finalmente se imprime cada número dividido por su número entero inmediato anterior
resultado = numeros.map { | x| x / (x - 1)   }
puts 'El resultado es: %s' % resultado.join(', ')
```

---

### 8. Sea el siguiente código:

```ruby
def fun3
  puts "Entrando a fun3"
  raise RuntimeError, "Excepción intencional"
  puts "Terminando fun3"
rescue NoMethodError => e
  puts "Tratando excepción por falta de método"
rescue RuntimeError => e
  puts "Tratando excepción provocada en tiempo de ejecución"
rescue
  puts "Tratando una excepción cualquiera"
ensure
  puts "Ejecutando ensure de fun3"
end
def fun2(x)
  puts "Entrando a fun2"
  fun3  
  a = 5 / x
  puts "Terminando fun2"
end
def fun1(x)
  puts "Entrando a fun1"
  fun2 x
rescue  
  puts "Manejador de excepciones de fun1"
  raise
ensure  
  puts "Ejecutando ensure de fun1"
end
begin  
  x = 0
  begin
    fun1 x
  rescue Exception => e
    puts "Manejador de excepciones de Main"
    if x == 0
      puts "Corrección de x"
      x = 1
      retry
    end
  end
  puts "Salida"
end
```

#### a. Seguí el flujo de ejecución registrando la traza de impresiones que deja el programa y justificando paso a paso.

Salida:

* Entrando a fun1
* Entrando a fun2
* Entrando a fun3
* Tratando excepción provocada en tiempo de ejecución
* Ejecutando ensure de fun3
* Manejador de excepciones de fun1
* Ejecutando ensure de fun1
* Manejador de excepciones de Main
* Corrección de x
* Entrando a fun1
* Entrando a fun2
* Entrando a fun3
* Tratando excepción provocada en tiempo de ejecución
* Ejecutando ensure de fun3
* Terminando fun2
* Ejecutando ensure de fun1
* Salida

El punto mas importante a tener en cuenta es cuando hace un `raise` para volver a levantar la misma excepcion y al mismo tiempo hay un `ensure` primero ejecuta el código del `ensure` y luego se ejecuta el manejador correspondiente a la nueva excepción levantada por el `raise`.

#### b. ¿Qué pasaría si se permuta, dentro de fun3, el manejador de excepciones para RuntimeError y el manejador de excepciones genérico (el que tiene el rescue vacío)?

Cuando en `fun3` se levante la excepción `RuntimeError` será manejada por el `rescue` genérico (`StandardError`) en vez del específico para `RuntimeError`.

#### c. ¿La palabra reservada retry que función cumple? ¿Afectaría el funcionamiento del programa si se mueve la línea x = 0 dentro del segundo begin (inmediatamente antes de llamar a fun1 con x)?

La palabra reservada `retry` vuelve a ejecutar el bloque actual en el que ocurrió la excepcion manejada. Estos bloques normalmente se definen entre `begin` y `end` (a veces están implícitos como en las definiciones de métodos, clases, etc).

Si movemos la línea `x = 0` como se indica, el script entrará en un bucle infinito porque el `retry` siempre volverá a ejecutar esta linea y por ende siempre se seguirá ejecutando la sentencia `retry`.

---

## Testing

### 1. ¿En qué consiste la metodología TDD? ¿En qué se diferencia con la forma tradicional de escribir código y luego realizar los tests?

Desarrollo guiado por pruebas de software, o Test-driven development (TDD) es una práctica de ingeniería de software que involucra otras dos prácticas: Escribir las pruebas primero (Test First Development) y Refactorización (Refactoring). Para escribir las pruebas generalmente se utilizan las pruebas unitarias (unit test en inglés). En primer lugar, se escribe una prueba y se verifica que las pruebas fallan. A continuación, se implementa el código que hace que la prueba pase satisfactoriamente y seguidamente se refactoriza el código escrito. El propósito del desarrollo guiado por pruebas es lograr un código limpio que funcione. La idea es que los requisitos sean traducidos a pruebas, de este modo, cuando las pruebas pasen se garantizará que el software cumple con los requisitos que se han establecido.

Para que funcione el desarrollo guiado por pruebas, el sistema que se programa tiene que ser lo suficientemente flexible como para permitir que sea probado automáticamente. Cada prueba será suficientemente pequeña como para que permita determinar unívocamente si el código probado pasa o no la verificación que ésta le impone. El diseño se ve favorecido ya que se evita el indeseado "sobre diseño" de las aplicaciones y se logran interfaces más claras y un código más cohesivo. Frameworks como JUnit proveen de un mecanismo para manejar y ejecutar conjuntos de pruebas automatizadas.

---

### 2. Dado los siguientes tests, escribí el método correspondiente (el que se invoca en cada uno) para hacer que pasen:

```ruby
require 'minitest/autorun'
require 'minitest/spec'

describe '#incrementar' do
  describe 'cuando el valor es numérico' do
    it 'incrementa el valor en un delta recibido por parámetro' do
      x = -9
      delta = 10
      assert_equal(1, incrementar(x, delta))
    end

    it 'incrementa el valor en un delta de 1 unidad por defecto' do
      x = 10
      assert_equal(11, incrementar(x))
    end
  end

  describe 'cuando el valor es un string' do
    it 'arroja un RuntimeError' do
      x = '10'
      assert_raises(RuntimeError) do
        incrementar(x)
      end
      assert_raises(RuntimeError) do
        incrementar(x, 9)
      end
    end
  end
end

describe '#concatenar' do
  it 'concatena todos los parámetros que recibe en un string, separando por espacios' do
    class Dummies; end

    assert_equal('Lorem ipsum 4 Dummies', concatenar('Lorem', :ipsum, 4, Dummies))
  end

  it 'Elimina dobles espacios si los hubiera en la salida final' do
    assert_equal('TTPS Ruby', concatenar('TTPS', nil, '      ', "\t", "\n", 'Ruby'))
  end
end
```

```ruby
def incrementar(x, delta = 1)
  if(x.is_a?(String) || delta.is_a?(String))
    raise RuntimeError
  end
  x + delta
end

def concatenar(*args)
  args.join(" ").split.join(" ")
end
```

---

