# Ruby: sintaxis y tipos básicos

### 1. Investigá y probá en un intérprete de Ruby cómo crear objetos de los siguientes tipos básicos usando literales y usando el constructor new (cuando sea posible):

#### Arrays

* `array = [12, "hola", 44] => [12, "hola", 44]`
* `array = Array.new(4, :sel) => el, :sel, :sel, :sel]`
* `array = Array.new(4) { Hash.new } => [{}, {}, {}, {}]`
* `Array({:a => "a", :b => "b"}) => [[:a, "a"], [:b, "b"]]`

#### Hashes

* `hash = { "pedro" => 44, "juan" => "hola" } => {"pedro"=>44, "juan"=>"hola"}`
* `hash = { pedro: 44, juan: "hola" } => {:pedro=>44, :juan=>"hola"}`

#### Strings

* `string = "esto es un string" => "esto es un string"`
* `string = 'esto es un string' => "esto es un string"`
* `string = String.new("esto es un string") => "esto es un string"`

#### Symbols

* `symbol = :symbol => :symbol`
* `symbol = :"symbol" => :symbol`
* `symbol = "symbol".to_sym => :symbol`

---

### 2. ¿Qué devuelve la siguiente comparación? ¿Por qué?

`'TTPS Ruby'.object_id == 'TTPS Ruby'.object_id`

Devuelve falso debido a que estamos creando dos Strings que por mas de que tienen el mismo contenido, son instancias distintas, que por ende poseen un object id distinto.

---



