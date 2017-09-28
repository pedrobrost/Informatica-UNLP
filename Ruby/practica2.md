# Práctica 2

## Métodos

### 1. Implementá un método que reciba como parámetro un arreglo de números, los ordene y devuelva el resultado.

```ruby
def ordenar_arreglo array
    array.sort
end
```

---

### 2. Modificá el método anterior para que en lugar de recibir un arreglo como único parámetro, reciba todos los números como parámetros separados.

```ruby
def ordenar_arreglo *array
    array.sort
end
```

---

### 3. Suponé que se te da el método que implementaste en el ejercicio anterior para que lo uses a fin de ordenar un arreglo de números que te son provistos en forma de arreglo.  ¿Cómo podrías invocar el método?

```ruby
ordenar_arreglo *[10, 9, 1, 2, 3, 5, 7, 8]
```

---

### 4. Escribí un método que dado un número variable de parámetros que pueden ser de cualquier tipo, imprima en pantalla la cantidad de caracteres que tiene su representación como String y la representación que se utilizó para contarla.

```ruby
def longitud *args
    args.each { |arg| puts "\"#{arg.to_s}\" --> #{arg.to_s.length}"}
end
```

---

### 5. Implementá el método cuanto_falta? que opcionalmente reciba como parámetro un objeto Time y que calcule la cantidad de minutos que faltan para ese momento. Si el parámetro de fecha no es provisto, asumí que la consulta es para la medianoche de hoy

```ruby
def cuanto_falta? time = Time.new(Time.new.year, Time.new.month, Time.new.day+1)
    Time.at(time - Time.now).utc.strftime("%M")
end
```

---

### 6. Analizá el siguiente código e indicá qué problema(s) puede tener.

```ruby
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

```ruby
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

```ruby
class Taller
    def probar objeto
        objeto.arrancar
    end
end
```

Suponé que, posteriormente, el taller necesita probar una motosierra. ¿Podrías
hacerlo? ¿Cómo? ¿Qué concepto del lenguaje estás usando para poder realizar
esto?


```ruby
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

```ruby
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

### 4. Implementá el Mixin Countable que te permita hacer que cualquier clase cuente la cantidad de veces que los métodos de instancia definidos en ella es invocado. Utilizalo en distintas clases, tanto desarrolladas por vos como clases de la librería standard de Ruby, y chequeá los resultados. El Mixin debe tener los siguientes métodos:

#### 1. count_invocations_of(sym): método de clase que al invocarse realiza las tareas necesarias para contabilizar las invocaciones al método de instancia cuyo nombre es sym (un símbolo).

#### 2. invoked?(sym): método de instancia que devuelve un valor booleano indicando si el método llamado sym fue invocado al menos una vez en la instancia receptora.

#### 3. invoked(sym): método de instancia que devuelve la cantidad de veces que el método identificado por sym fue invocado en la instancia receptora.

```

```

---

### 5. Dada la siguiente clase abstracta GenericFactory, implementá subclases de la misma que permitan la creación de instancias de dichas clases mediante el uso del método de clase .create, de manera tal que luego puedas usar esa lógica para instanciar objetos sin invocar directamente el constructor new.

```ruby
class GenericFactory
    def self.create (**args)
        new(**args)
    end

    def initialize (**args)
        raise NotImplementedError
    end
end
```

```ruby
class Test < GenericFactory
    def initialize **args
    end
end
```

---

### 6. Modificá la implementación del ejercicio anterior para que GenericFactory sea un módulo que se incluya como Mixin en las subclases que implementaste. ¿Qué modificaciones tuviste que hacer en tus clases?

```ruby
module GenericFactory

    module ClassMethods
        def create **args
            new **args
        end
    end

    def initialize **args
        raise NotImplementedError
    end

    def self.included base
        base.extend ClassMethods
    end 
end

class Test
    include GenericFactory
    
    def initialize **args
    end
end
```

---

### 7. Extendé las clases TrueClass y FalseClass para que ambas respondan al método de instancia opposite, el cual en cada caso debe retornar el valor opuesto al que recibe la invocación al método. 

```ruby
module Opposite
    def opposite
        !self
    end
end

true.extend Opposite
false.extend Opposite
```

---

### 8. Analizá el script Ruby presentado a continuación e indicá:

```ruby
VALUE = 'global'

module A
    VALUE = 'A'

    class B
        VALUE = 'B'

        def self.value
            VALUE
        end

        def value
            'iB'
        end
    end

    def self.value
        VALUE
    end
end

class C
    class D
        VALUE = 'D'

        def self.value
            VALUE
        end
    end

    module E
        def self.value
            VALUE
        end
    end

    def self.value
        VALUE
    end
end

class F < C
    VALUE = 'F'
end
```

#### 1. ¿Qué imprimen cada una de las siguientes sentencias? ¿De dónde está obteniendo el valor?

* puts A.value -> `A`
* puts A::B.value -> `B`
* puts C::D.value -> `D`
* puts C::E.value -> 
* puts F.value --> 

#### 2. ¿Qué pasaría si ejecutases las siguientes sentencias? ¿Por qué?

* puts A::value -> `A`
* puts A.new.value -> `A es un módulo, no se puede instanciar`
* puts B.value -> `B está fuera del alcance, debido a que está definido dentro del módulo A`
* puts C::D.value -> `D`
* puts C.value -> `uninitialized constant C::VALUE`
* puts F.superclass.value -> `uninitialized constant C::VALUE`

---

## Bloques

### 1. Escribí un método da_nil? que reciba un bloque, lo invoque y retorne si el valor de retorno del bloque fue nil. 

```ruby
def da_nil?
    yield.nil?
end
```

---

### 2. Implementá un método que reciba como parámetros un Hash y Proc, y que devuelva un nuevo Hash cuyas las claves sean los valores del Hash recibido como parámetro, y cuyos valores sean el resultado de invocar el Proc con cada clave del Hash original.

```ruby
def procesar_hash hash, proc
    hash.invert.transform_values { |value| proc.call value }
end
```

---

### 3. Implementá un método que reciba un número variable de parámetros y un bloque, y que al ser invocado ejecute el bloque recibido pasándole todos los parámetros que se recibieron encapsulando todo esto con captura de excepciones de manera tal que si en la ejecución del bloque se produce alguna excepción, proceda de la siguiente forma:

* Si la excepción es de clase RuntimeException, debe imprimir en pantalla "Algo salió mal...", y retornar :rt.

* Si la excepción es de clase NoMethodError, debe imprimir "No encontré un método: " más el mensaje original de la excepción que se produjo, y retornar :nm.

* Si se produce cualquier otra excepción, debe imprimir en pantalla "¡No sé qué hacer!", y relanzar la excepción que se produjo.

En caso que la ejecución del bloque sea exitosa, deberá retornar :ok.

```ruby
def met *args                                                                              
    begin                                                                                  
        yield args                                                                         
    rescue RuntimeError                                                                    
        puts "Algo salió mal"                                                              
        :rt                                                                                
    rescue NoMethodError => e                                                              
        puts "No encontré un método: #{e.message}"                                         
        :nm                                                                                
    rescue                                                                                 
        puts "No se que hacer"                                                             
        raise                                                                              
    else                                                                                   
        :ok                                                                                
    end                                                                                    
end
```

---

## Enumeradores

### 1. Si no lo hiciste de esa forma en la práctica 1, escribí un enumerador que calcule la serie de Fibonacci.

```ruby
fibonacci = Enumerator.new do | y |
    a = b = 1
    loop do
        y.yield a
        a, b = b, a+b
    end
end
```

---

### 2. ¿Qué son los lazy enumerators? ¿Qué ventajas les ves con respecto al uso de los enumeradores que no son lazy?

https://www.sitepoint.com/implementing-lazy-enumerables-in-ruby/

---

### 3. Extendé la clase Array con el método randomly que funcione de la siguiente manera:

* Si recibe un bloque, debe invocar ese bloque con cada uno de los elementos del arreglo en orden aleatorio.

* Si no recibe un bloque, debe devolver un enumerador que va arrojando, de a uno, los elementos del arreglo en orden aleatorio.

```ruby
class Array
    def randomly
        block_given? ? shuffle.each { |elem| yield elem } : shuffle.each
    end
end
```

---

### 4.

```ruby
require 'matrix'

class Image                                                                                    
    attr_accessor :data, :size                                                                     

    def initialize(data = nil, size = 2)                                                           
        self.size = size                                                                           
        self.data = data || Matrix.build(size) { Math::PI }                                        
    end                                                                                            

    def header_bytes                                                                               
        Matrix.rows([data.first(size)])                                                            
    end                                                                                            
                                                                                               
    def filter_a                                                                                   
        Image.new data.lazy.map { | e| e ** 1.2 }                                                  
    end                
    
    def filter_b                                                                                   
        Image.new data.lazy.map { | e| e ** 1.4 }                                                  
    end
    
    def filter_c                                                                                   
        Image.new data.lazy.map { | e| e ** 1.8 }                                                  
    end
    
    def filter_d                                                                                   
        Image.new data.lazy.map { | e| e ** 2 }                                                    
    end 
    
    def filter_e                                                                                   
        Image.new data.lazy.map { | e| e ** 2.2 }                                                  
    end 
    
    def filter_f                                                                                   
        Image.new data.lazy.map { | e| e ** 2.4 }                                                  
    end                                                                                            

    def all_filters                                                                                
        ('a'..'f').inject(self) do | pipe, type|                                                   
            pipe.public_send "filter_#{type}"                                                      
        end                                                                                        
    end                                                                                            
end
```

