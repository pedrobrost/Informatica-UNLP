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

Esta solución es mas apropiada que la presentada en el enunciado debido a que bloqueando de sta manera se logra que si no hay lugar para un determinado usuario debido a su pioridad, este no bloquea a la posible entrada a los de la otra prioridad.

---

