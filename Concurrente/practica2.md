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


