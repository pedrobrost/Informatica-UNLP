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

### 3. Escribí una función llamada reemplazar que reciba un String y que busque y reemplace en el mismo cualquier ocurrencia de { por do\n y cualquier ocurrencia de } por \nend, de modo que convierta los bloques escritos con llaves por bloques multilínea con do y end.

```
def reemplazar(string)
    string.gsub! "{", "do\n"
    string.gsub! "}", "\nend"	
end
```

---

### 4. Escribí una función que convierta a palabras la hora actual, dividiendo en los siguientes rangos los minutos:

* Si el minuto está entre 0 y 10, debe decir "en punto"
* Si el minuto está entre 11 y 20, debe decir "y cuarto"
* Si el minuto está entre 21 y 34, debe decir "y media"
* Si el minuto está entre 35 y 44, debe decir "menos veinticinco" (de la hora siguiente)
* Si el minuto está entre 45 y 55, debe decir "menos cuarto" (de la hora siguiente)
* Si el minuto está entre 56 y 59, debe decir "casi las" (y la hora siguiente)

```
def en_palabras(time)
    case time.min
        when 0..10
            puts "Son las #{time.hour} en punto"
        when 11..20
            puts "Son las #{time.hour} y cuarto"
        when 21..34
            puts "Son las #{time.hour} y media"
        when 35..44
            puts "Son las #{time.hour + 1} menos vinticinco"
        when 45..55 
            puts "Son las #{time.hour + 1} menos cuarto"
        else
            puts "Casi las #{time.hour + 1}"
    end
end
```

---


