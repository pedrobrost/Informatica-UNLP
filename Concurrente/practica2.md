# Práctica 2 - Semáforos

### 1. Existen N personas que deben ser chequeadas por un detector de metales antes de poder ingresar al avión.

#### a. Implemente una solución que modele el acceso de las personas a un detector (es decir si el detector está libre la persona lo puede utilizar caso contrario debe esperar).

```
sem mutex = 1;

process persona[i=1 to N]{
    P(mutex);
    "persona pasa por detector"
    V(mutex)
    "persona sube al avión"
}
```

#### b. Modifique su solución para el caso que haya tres detectores.

```
sem mutex = 3;

process persona[i=1 to N]{
    P(mutex);
    "persona pasa por detector"
    V(mutex)
    "persona sube al avión"
}
```

---

### 2. Un sistema operativo mantiene 5 instancias de un recurso almacenadas en una cola, cuando un proceso necesita usar una instancia del recurso la saca de la cola, la usa y cuando termina de usarla la vuelve a depositar.

```
sem mutex = 5;
sem sCola = 1;

process SO[i=1 to N]{
    P(mutex);
    P(sCola);
    x = desencolar;
    V(sCola);
    "usar recurso x";
    P(sCola);
    encolar(x);
    V(sCola);
    V(mutex);
}
```

---

### 3. Suponga que existe una BD que puede ser accedida por 6 usuarios como máximo al mismo tiempo. Además los usuarios se clasifican como usuarios de prioridad alta y usuarios de prioridad baja. Por último la BD tiene la siguiente restricción:
 
* no puede haber más de 4 usuarios con prioridad alta al mismo tiempo usando la BD.
* no puede haber más de 5 usuarios con prioridad baja al mismo tiempo usando la BD.
 
Indique si la solución presentada es la más adecuada. Justifique la respuesta. 

La solucion mas adecuada sería:
```
sem mutex = 6;
sem alta = 4;
sem baja = 5;

process usuario-alta[i=1 to L]{
    P(alta);
    P(mutex);
    "usa la BD";
    V(mutex);
    V(alta);
}

process usuario-baja[i=1 to L]{
    P(baja);
    P(mutex);
    "usa la BD";
    V(mutex);
    V(baja);
}
```

Esta solución es mas apropiada que la presentada en el enunciado debido a que bloqueando de sta manera se logra que si no hay lugar para un determinado usuario debido a su pioridad, este no bloquea a la posible entrada a los de la otra prioridad.

---

### 4. Se tiene un curso con 40 alumnos, la maestra entrega una tarea distinta a cada alumno, luego cada alumno realiza su tarea y se la entrega a la maestra para que la corrija, esta revisa la tarea y si está bien le avisa al alumno que puede irse, si la tarea está mal le indica los errores, el alumno corregirá esos errores y volverá a entregarle la tarea a la maestra para que realice la corrección nuevamente, esto se repite hasta que la tarea no tenga errores.

```

sem entregada[N] = 0;
sem freeQueue = 1;
queue paraCorregir;
boolean puedeIr[N] = false;
Alumno alumnos[N];
sem entregas = 0;
sem correccion[N] = 0;
Tarea tarea[N];
int cantAlumnos = N;

process alumno[i=1 to N]{
    P(entregada[i]);
    while(!puedeIr[i]){
        alumnos[i].realizar(tarea[i]);
        P(freeQueue);
        paraCorregir.encolar(i);
        V(freeQueue);
        V(entregas);
        P(correccion[i]);
    }
}

process maestra{
    for i=1 to N {
        tarea[i] = new Tarea();
        V(entregada[i]);
    }
    while(cantAlumnos > 0){
        P(entregas);
        P(freeQueue);
        alumno = paraCorregir.desencolar();
        V(freeQueue);
        puedeIr[alumno] = maestra.estaAprobado(tarea[alumno]);
        if(puedeIr[alumno]){
             cantAlumnos--;
        }else{
            tarea[alumno] = new Correccion();
        }
        V(correccion[alumno]; 
    }
}
```

---

### 5. Suponga que se tiene un curso con 50 alumnos. Cada alumno elije una de las 10 tareas para realizar entre todos. Una vez que todos los alumnos eligieron su tarea comienzan a realizarla. Cada vez que un alumno termina su tarea le avisa al profesor y si todos los alumnos que tenían la misma tarea terminaron el profesor les otorga un puntaje que representa el orden en que se terminó esa tarea.  Nota: Para elegir la tarea suponga que existe una función elegir que le asigna una tarea a un alumno (esta función asignará 10 tareas diferentes entre 50 alumnos, es decir, que 5 alumnos tendrán la tarea 1, otros 5 la tarea 2 y así sucesivamente para las 10 tareas).

```



process alumno[i=1 to 50] {
    tarea = elegir()
    P(sEligieron)
    eligieron++
    if (eligieron == 50) for j=1 to 50 do V(arrancar[j]);
    v(sEligieron)

    P(arrancar[i])
    "alumno realiza la tarea"
    P(realizo[tarea])
    realizo[tarea]++
    if (realizo[tarea] == 5)
        P(sTerminoTarea)
        terminadas++;
        cola.encolar(tarea)
        V(sTerminoTarea)
    V(realizo[tarea]
    
       

}

process profesor {
    
}
```

---


