# Práctica 3 - Monitores

### 1. Se dispone de un puente por el cual puede pasar un solo auto a la vez. Un auto pide permiso para pasar por el puente, cruza por el mismo y luego sigue su camino. Nota: no importa el orden en que han llegado al puente.  

```
Monitor Puente
    cond cola;
    int cant= 0;

    Procedure entrarPuente (int au)
        while ( cant > 0) wait (cola);
        cant = cant + 1;
    end;

    Procedure salirPuente (int au)
        cant = cant – 1;
        signal(cola);
    end;

End Monitor;

Process Auto [a:1..M]
    Puente. entrarPuente (a);
    “el auto cruza el puente”
    Puente. salirPuente(a);
End Process;
```

#### a. ¿El código funciona correctamente? Justifique su respuesta.

Sí, el código funciona correctamente.

#### b. ¿Se podría simplificar el programa? En caso afirmativo, rescriba el código.

```
monitor Puente
    cond cola;
    int cant = 1;
    int esp = 0;

    procedure entrarPuente()
        if (cant == 0) { esp++; wait(cola) }
        else cant--;
    end

    procedure salirPuente()
        if (esp == 0) cant++;
        else { esp--; signal(cola) };
    end
end

process Auto [i=1 to N]
    Puente.entrarPuente();
    "Auto cruza puente";
    Puente.salirPuente();
end
```

#### 3. Si hubiese que respetar el orden de llegada de los vehículos, ¿La solución original lo respeta? Si rescribió el código en el punto b), ¿esa solución lo respeta?.

La solución original no respeta esto y la solución del punto `b` sí lo hace.

---

### 2. Implementar el acceso a una base de datos de solo lectura que puede atender a lo sumo 5 consultas simultáneas.

```
monitor DBController
    cond cola;
    int disponible = 5;
    
    procedure solicitarAcceso()
        while(disponible == 0) wait(cola);
        disponible = disponible - 1;
    end

    procedure liberarAcceso()
        disponible = disponible + 1;
        signal(cola);
    end
end

process lector[i=1 to N]
    DBController.solicitarAcceso();
    "Leer base de datos";
    DBController.liberarAcceso();
end
```

---

### 3. En un laboratorio de genética se debe administrar el uso de una máquina secuenciadora de ADN. Esta máquina se puede utilizar por una única persona a la vez. Existen 100 personas en el laboratorio que utilizan repetidamente esta máquina para sus estudios, para esto cada persona pide permiso para usarla, y cuando termina el análisis avisa que termino. Cuando la máquina está libre se le debe adjudicar a aquella persona cuyo pedido tiene mayor prioridad (valor numérico entre 0 y 100).

```
monitor ControladorMaquina
    bool libre = true;
    cond turno[100];
    cola espera;

    procedure solicitarAcceso(int i, int prioridad)
        if (libre) 
            libre = false;
        else {
            espera.insertarOrdenado(i, prioridad);  
            wait(turno[i]);
        }
    end

    procedure liberarAcceso()
        if (empty(espera))
            libre = true;
            else {
                i = espera.pop();
                signal(turno[i]);
            }
    end
end

process Persona [i=1 to 100]
    while (true)
        prioridad = generarPrioridad();
        ControladorMaquina.solicitarAcceso(i, prioridad);
        "Persona usa la máquina";
        ControladorMaquina.liberarAccesso();
    end
end
```

---
