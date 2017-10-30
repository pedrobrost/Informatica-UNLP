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


