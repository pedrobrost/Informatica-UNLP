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


