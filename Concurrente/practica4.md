# Práctica 4 - Pasaje de Mensajes

### 1. Supongamos que tenemos una abuela que tiene dos tipos de lápices para dibujar: 10 de colores y 15 negros. Además tenemos tres clases de niños que quieren dibujar con los lápices: los que quieren usar sólo los lápices de colores (tipo C), los que usan sólo los lápices negros (tipo N), y los niños que usan cualquier tipo de lápiz (tipo A).  

#### a. Implemente un código para cada clase de niño de manera que ejecute pedido de lápiz, lo use por 10 minutos y luego lo devuelva y además el proceso abuela encargada de asignar los lápices

```
chan pedidoC(int id);
chan pedidoN(int id);
chan pedidoLapiz(int id);
chan canalLapiz[1..N](string lapiz)
chan devolverColor()
chan devolverNegro()
  
process Abuela
  
  int color = 10;
  int negro = 15;

  while true
    if (!empty(pedidoC) and color>0)
      receive pedidoC(id)
      send canalLapiz[id]('color')
      color--
    end
    □ (!empty(pedidoN) and negro>0)
      receive pedidoN(id)
      send canalLapiz[id]('negro')
      negro--
    end
    □ (!empty(pedidoLapiz) and negro>0)
      receive pedidoLapiz(id)
      send canalLapiz[id]('negro')
      negro--
    end
    □ (!empty(pedidoLapiz) and color>0)
      receive pedidoLapiz(id)
      send canalLapiz[id]('color')
      color--
    end
    □ (!empty(devolverColor))
      receive devolverColor()
      color++
    end
    □ (!empty(devolverNegro))
      receive devolverNegro()
      negro++
    end
  end
end
    

process NiñoC[i=1 to N]
  string lapiz
  while true
    send pedidoC(i)
    receive canalLapiz[i](lapiz)
    delay(10*60)
    send devolverColor()
  end
end

process NiñoN[i=1 to N]
  string lapiz
  while true
    send pedidoN(i)
    receive canalLapiz[i](lapiz)
    delay(10*60)
    send devolverNegro()
  end
end

process NiñoA[i=1 to N]
  string lapiz
  while true
    send pedidoLapiz(i)
    receive canalLapiz[i](lapiz)
    delay(10*60)
    if (lapiz == 'color')
      send devolverColor()
    else
      send devolverNegro()
  end
end
```

#### b. Modificar el ejercicio para que a los niños de tipo A se les puede asignar un lápiz sólo cuando: hay lápiz negro disponible y ningún pedido pendiente de tipo N, o si hay lápiz de color disponible y ningún pedido pendiente de tipo C.

```
process Abuela
  
  int color = 10;
  int negro = 15;

  while true
    if (!empty(pedidoC) and color>0)
      receive pedidoC(id)
      send canalLapiz[id]('color')
      color--
    end
    □ (!empty(pedidoN) and negro>0)
      receive pedidoN(id)
      send canalLapiz[id]('negro')
      negro--
    end
    □ (!empty(pedidoLapiz) and negro>0 and empty(pedidoN))
      receive pedidoLapiz(id)
      send canalLapiz[id]('negro')
      negro--
    end
    □ (!empty(pedidoLapiz) and color>0 and empty(pedidoC))
      receive pedidoLapiz(id)
      send canalLapiz[id]('color')
      color--
    end
    □ (!empty(devolverColor))
      receive devolverColor()
      color++
    end
    □ (!empty(devolverNegro))
      receive devolverNegro()
      negro++
    end
  end
end
```

---

### 2. Se desea modelar el funcionamiento de un banco en el cual existen 5 cajas para realizar pagos. Existen P personas que desean pagar. Para esto cada una selecciona la caja donde hay menos personas esperando, una vez seleccionada espera a ser atendido. Nota: maximizando la concurrencia, deben usarse los valores actualizados del tamaño de las colas para seleccionar la caja con menos gente esperando.

```
chan buscalCola(int p);
chan menorCola[1..P](int cola)
chan epsera[1..5](int i)
chan atiende[1..P]()
chan atendido(int cola)

process caja[i=1 to 5]
  while(true)
    receive espera[i](id)
    "atender persona"
    send atiende[id]()
  end
end

process persona[i=1 to P]
  int cola;
  send buscarCola(p)
  receive menorCola[i](cola)
  send espera[cola](i)
  receive atiende[i]()
  send atendido(cola)
end

process coordinador
  int cola[5] = 0;
  int id;
  
  while true
    if (!empty(buscarCola) and empty(avisarAtendido))
      receive buscarCola(id)
      numero = cola.min 
      send menorCola[id](numero)
      cola[numero]++
    end
    □ (!empty atendido)
      receive atendido(numero)
      cola[numero]--
  end
end
```

---

### 3. Se debe modelar una casa de Comida Rápida, en el cual trabajan 2 cocineros y 3 vendedores. Además hay C clientes que dejan un pedido y quedan esperando a que se lo alcancen.  Los pedidos que hacen los clientes son tomados por cualquiera de los vendedores y se lo pasan a los cocineros para que realicen el plato. Cuando no hay pedidos para atender, los vendedores aprovechan para reponer un pack de bebidas de la heladera (tardan entre 1 y 3 minutos para hacer esto).  Repetidamente cada cocinero toma un pedido pendiente dejado por los vendedores, lo cocina y se lo entrega directamente al cliente correspondiente. Nota: maximizar la concurrencia.

```
chan llegoCliente(int id, int pedido)
chan pedido[1..C](string comida)
chan esperaPedido[1..3](int id)
chan tomarPedido[1..3](int cliente, string pedido)
chan cocinarPedido(int cliente, string pedido)

process cliente[i=1 to C]
  string pedido = generarPedido()
  send llegoCliente(id, pedido)
  receive pedido[id](comida)
end

process coordinador
  string pedido
  int id, cliente

  while (true)
    receive esperaPedido(id)
    if (!empty(llegoCliente))
      receive llegoCliente(cliente, pedido)
    else
      pedido = null
      cliente = null
    end
    send tomarPedido[id](cliente, pedido)
  end
end
      

process vendedor[i=1 to 3]
  
  string pedido;
  int cliente;

  while (true)
    send esperaPedido(i)
    receive tomarPedido[i](cliente, pedido)
    
    if (pedido == null)
      delay(rand(1,3) * 60)
    else
      send cocinarPedido(cliente, pedido)
    end
  end
end
      

process cocinero[i=1 to 2]

  int cliente
  string pedido
  
  while (true)
    receive cocinarPedido(cliente, pedido)
    "cocinero prepara el pedido"
    send pedido[cliente](pedido)
  end
end
```

---

### 4. Se desea modelar una competencia de atletismo. Para eso existen dos tipos de procesos: C corredores y un portero. Los corredores deben esperar que se habilite la entrada a la pista, donde deben esperar que lleguen todos los corredores para comenzar. El portero es el encargado de habilitar la entrada a la pista. El proceso portero NO puede contabilizar nada, su única función es habilitar la entrada a la pista; NO se puede suponer ningún orden en la llegada de los corredores al punto de partida.

#### a. Implementar usando un coordinador.

```
chan llegaCorredor()
chan puedenLargar()
chan llegaronTodos()

process corredor[i=1 to C]
  send llegaCorredor()
  receive puedenLargar()
end 

process portero
  receive llegaronTodos()
  for i=1 to C
    send puedenLargar()
end

process coordinador
  for i=1 to C
    receive llegaCorredor()
  send llegaronTodos()
end
```

#### b. Implementar sin usar un coordinador.

```
chan llegaCorredor()
chan puedenLargar()

process corredor[i=1 to C]
  send llegaCorredor()
  receive puedenLargar()
end 

process portero
  for i=1 to C
    receive llegaCorredor()
  for i=1 to C
    send puedenLargar()
end
```

---

### 5. Suponga que N personas llegan a la cola de un banco. Una vez que la persona se agrega en la cola no espera más de 15 minutos para su atención, si pasado ese tiempo no fue atendida se retira. Para atender a las personas existen 2 empleados que van atendiendo de a una y por orden de llegada a las personas.

```
chan startTimer[1..N]()
chan timer[1..N]()
chan llegaPersona(int id)
chan estadoPersona[1..N](string estado)
chan avisarPersona[1..N]()

process persona[i=1 to N]
  send startTimer[i]()
  receive timer[i]()
  send llegaPersona(i) 
  send estadoPersona[i]('esperando')
  receive avisarPersona[i]()
end

process empleado[i=2 to 2]
  int id
  string estado
  
  while (true)
    receive llegaPersona(id)
    receive estadoPersona[id](estado)
    if (estado == 'esperando')
      send estadoPersona[id]('atendido')
      "empleado atiende a la persona"
      send avisarPersona[id]()
    end
  end
end

process timer[i=2 to N]
  string estado

  receive startTimer[i]()
  send timer[i]()
  delay(15*60)
  receive estadoPersona[i](estado)
  if (estado == 'esperando')
    send estadoPersona[i]('yendo')
    send avisarPersona[i]()
  end
end
```

---

### 6. Existe una casa de comida rápida que es atendida por 1 empleado. Cuando una persona llega se pone en la cola y espera a lo sumo 10 minutos a que el empleado lo atienda. Pasado ese tiempo se retira sin realizar la compra.

#### a. Implementar una solución utilizando un proceso intermedio entre cada persona y el empleado.

```
```

#### b. Implementar una solución sin utilizar un proceso intermedio entre cada persona y el empleado.

```
chan startTimer[1..N]()
chan timer[1..N]()
chan llegaPersona(int id)
chan estadoPersona[1..N](string estado)
chan avisarPersona[1..N]()

process persona[i=1 to N]
  send startTimer[i]()
  receive timer[i]()
  send llegaPersona(i) 
  send estadoPersona[i]('esperando')
  receive avisarPersona[i]()
end
 
process empleado
  int id
  string estado
  
  while (true)
    receive llegaPersona(id)
    receive estadoPersona[id](estado)
    if (estado == 'esperando')
      send estadoPersona[id]('atendido')
      "empleado atiende a la persona"
      send avisarPersona[id]()
    end
  end
end

process timer[i=2 to N]
  string estado

  receive startTimer[i]()
  send timer[i]()
  delay(15*60)
  receive estadoPersona[i](estado)
  if (estado == 'esperando')
    send estadoPersona[i]('yendo')
    send avisarPersona[i]()
  end
end
```

---

### 7. En una estación de comunicaciones se cuenta con 10 radares y una unidad de procesamiento que se encarga de procesar la información enviada por los radares. Cada radar repetidamente detecta señales de radio durante 15 segundos y le envía esos datos a la unidad de procesamiento para que los analice. Los radares no deben esperar a ser atendidos para continuar trabajando. 

```

process Radar[i=1 to 10]
  string datos

  while (true)
    datos = detectarSeñanles()
    Buffer!envioDatos(datos)
  end
end

process Unidad
  string datos

  while (true)
    Buffer!recibirDatos()
    Buffer?enviarDatos(datos)
    "Unidad procesa los daots"
  end
end

process Buffer
  queue cola
  string datos

  while (true)
    if Buffer?envioDatos(datos) -> cola.encolar(datos)
       !cola.empty();Unidad?recibirDatos() -> Unidad!enviarDatos(cola.desencolar)
    end
  end
end

```

---

### 8. Supongamos que tenemos una abuela que tiene dos tipos de lápices para dibujar: 10 de colores y 15 negros. Además tenemos tres clases de niños que quieren dibujar con los lápices: los que quieren usar sólo los lápices de colores (tipo C), los que usan sólo los lápices negros (tipo N), y los niños que usan cualquier tipo de lápiz (tipo A).

#### a. Implemente un código para cada clase de niño de manera que ejecute pedido de lápiz, lo use por 10 minutos y luego lo devuelva y además el proceso abuela encargada de asignar los lápices.

```

precess Abuela
  int color = 10
  int negro = 15
  int id

  while (true)
    if color>0; NiñoC[*]?pedirLapizColor(id) -> NiñoC[id]!recibirLapizColor("color"); color--

    □ negro>0; NiñoN[*]?pedirLapizNegro(id) -> NiñoN[id]!recibirLapizNegro("negro"); negro--

    □ negro>0; NiñoA[*]?pedirLapiz(id) -> NiñoA[id]!recibirLapiz("negro"); negro--

    □ color>0; NiñoA[*]?pedirLapiz(id) -> NiñoA[id]!recibirLapiz("color"); color--

    □ NiñoC[*]?devolverLapizColor() -> color++
    □ NiñoN[*]?devolverLapizNegro() -> negro++
    □ NiñoA[*]?devolverLapizColor() -> color++
    □ NiñoA[*]?devolverLapizNegro() -> negro++
  end
end

process NiñoC[i=1 to C]
  string lapiz
  
  while (true)
    Abuela!pedirLapizColor(i)
    Abuela?recibirLapizColor()
    delay(10*60)
    Abuela!devolverLapizColor()
  end
end

process NiñoN[i=1 to N]
  string lapiz
  
  while (true)
    Abuela!pedirLapizNegro(i)
    Abuela?recibirLapizNegro()
    delay(10*60)
    Abuela!devolverLapizNegro()
  end
end


process NiñoA[i=1 to A]
  string lapiz
  
  while (true)
    Abuela!pedirLapiz(i)
    Abuela?recibirLapiz(lapiz)
    delay(10*60)
    if (lapiz == "negro")
      Abuela!devolverLapizNegro()
    else
      Abuela!devolverLapizColor()
  end
```

#### b. Modificar el ejercicio para que a los niños de tipo A se les puede asignar un lápiz sólo cuando: hay lápiz negro disponible y ningún pedido pendiente de tipo N, o si hay lápiz de color disponible y ningún pedido pendiente de tipo C.

```
```

---

### 9. Se debe modelar la atención en una panadería por parte de 3 empleados. Hay C clientes que ingresan al negocio para ser atendidos por cualquiera de los empleados, los cuales deben atenderse de acuerdo al orden de llegada.

```
process Coordinador
  queue cola
  int id

  while (true)
    if Cliente[*]?avisarLlegada(id) -> cola.encolar(id)
    
       !cola.empty(); Empleado[*]?libre(id) -> Empleado[id]!atender(cola.desencolar)
end

precess Cliente[i=1 to C]
  Coordinador!avisarLlegada(i)
  Empleado[*]?liberar()
end 

process Empleado[i=1 to 3]
  int cliente
  
  while (true)
    Coordinador!libre(i)
    Coordinador?atender(cliente)
    atender(cliente)
    Cliente[cliente]!liberar()
  end
end
```

---

### 10. Existe una casa de comida rápida que es atendida por 1 empleado. Cuando una persona llega se pone en la cola y espera a lo sumo 10 minutos a que el empleado lo atienda. Pasado ese tiempo se retira sin realizar la compra.

#### a. Implementar una solución utilizando un proceso intermedio entre cada persona y el empleado.

```
process Empleado
  int persona
  string estado

  while (true)
    Coordinador!libre()
    Coordinador?atender(persona)
    Estado[persona]!empleadoConsulta()
    Estado[persona]?check(estado)
    if (estado == 'esperando')
      atender(persona)
      Persona[persona]!irse()
  end
end

process Estado[i=1 to N]
  string estado = 'esperando'
  int id
  
  do Empleado?empleadoConsulta() -> Empleado!check(estado)
                                    if (estado == 'esperando')
                                      estado = 'atendido'
     Timer[*]?timerConsulta(id) -> Timer[id]!check(estado)
                                   if (estado == 'esperando')
                                      estado = 'yendo'
  end
end

process Coordinador
  queue cola
  int id

  do Persona[*]?avisarLlegada(id) -> cola.encolar(id)
     !empty(cola); Empleado?libre() -> Empelado!atender(cola.desencolar)
  end

end

process Persona[i=1 to N]
  Timer[i]!avisarLlegada()
  Coordinador!avisarLlegada(i)
  if Empleado?irse() -> skip()
     Timer?irse() -> skip()
end

process Timer[i=1 to N]
  Persona[i]?avisarLlegada()
  delay(10*60)
  Estado[i]!timerConsulta(i)
  Estado[i]?check(estado)
  if (estado == 'esperando')
    Persona[i]!irse()
end
```

#### b. Implementar una solución sin utilizar un proceso intermedio entre cada persona y el empleado.

Una solución a este ejercicio que no invlucre a un proceso coordinador no sería posible ya que necesitamos un proceso que de alguna manera vaya encolando las llegadas de las personas. Esto pasa con PMS ya que si una persona se queda bloqueada en el `send` de que llegó, el timer nunca podría indicarle que se debe ir.

---
