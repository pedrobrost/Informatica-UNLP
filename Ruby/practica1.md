# Ruby: sintaxis y tipos básicos

### 2. Investigá y probá en un intérprete de Ruby cómo crear objetos de los siguientes tipos básicos usando literales y usando el constructor new (cuando sea posible):

#### Arrays

* `array = [12, "hola", 44]` => `[12, "hola", 44]`
* `array = Array.new(4, :sel)` => `el, :sel, :sel, :sel]
* `array = Array.new(4) { Hash.new }` => `[{}, {}, {}, {}]`
* `Array({:a => "a", :b => "b"})` => `[[:a, "a"], [:b, "b"]]`
