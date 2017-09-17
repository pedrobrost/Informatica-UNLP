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
sem sEligieron = 1
int eligieron = 0
sem arrancar[50] = ([50], 0)
sem sRealizo[10] = ([10], 1)
int realizo[10] = ([10], 0)
sem sCola = 1
sem terminoTarea = 0
sen resultado[10] = ([10], 0)
int puntaje[10]

process alumno[i=1 to 50] {
    tarea = asignarTarea()
    P(sEligieron)
    eligieron++
    if (eligieron == 50) for j=1 to 50 do V(arrancar[j]);
    v(sEligieron)

    P(arrancar[i])
    realizar(tarea)
    P(sRealizo[tarea])
    realizo[tarea]++
    if (realizo[tarea] == 5){
        P(sCola)
        cola.encolar(tarea)
        V(sCola)
        V(sTerminoTarea)
    }
    V(sRealizo[tarea])
    
    P(resultado[tarea]) 
}

process profesor {
    orden = 0 
    for i=1 to 10 do{
        P(sTerminoTarea)
        P(sCola)
        tarea = cola.desencolar()
        V(sCola)
        puntaje[tarea] = ++orden
        for j=1 to 5 do
            V(resultado[tarea])
    }
    
}
```

---

### 6. A una empresa llegan E empleados y por día hay T tareas para hacer (T>E), una vez que todos los empleados llegaron empezaran a trabajar. Mientras haya tareas para hacer los empleados tomaran una y la realizarán. Cada empleado puede tardar distinto tiempo en realizar cada tarea. Al finalizar el día se le da un premio al empleado que más tareas realizó. 

```
Empleado empleados[]
sem sArrivo = 1
sem comenzar[E] = 0
sem sCola = 1
sem finDia = 0
sem sTerminados = 1
int terminados = 0
int llegaron = 0

process empleado[i=1 to E]{
    P(sArrivo)
    llegaron++
    if (llegaron == E) for j=1 to E do V(comenzar[j])
    V(sArrivo)

    P(comenzar[i])
    
    P(sCola)
    while(tareas.size > 0) {
        tarea = tareas.desencolar()
        V(sCola)
        tarea.realizar()
        empleados[i].tareas++
        P(sCola)
    }
    
    P(sTerminados)
    terminados++
    if (terminados == E) then V(finDia)
    V(sTerminados)
}

process empresa{
    P(finDia)
    entregarPremio(empleados.max())
}
```

---

### 7. Existe una casa de comida rápida que es atendida por 1 empleado. Cuando una persona llega se pone en la cola y espera a lo sumo 10 minutos a que el empleado lo atienda. Pasado ese tiempo se retira sin realizar la compra.

```

Cola cola
sem sCola = 1
sem sPersona = 0
sem sEsperando[N] = ([N] 0)
sem sSalida[N] = ([N] 0)
sem sEstado[N] = ([N] 1)
string estado[N] = ([N] "esperando")


process persona[i=1 to N]{
    P(sCola)
    cola.encolar(i)
    V(sCola)
    V(sPersona)
    V(sEsperando[i])
    P(sSalida[i])
}

process coordinador[i=1 to N]{
    P(sEsperando[i])
    delay(10min)
    P(sEstado[i])
    if (estado == "esperando"){
        estado[i] = "saliendo"
        V(sEstado[i])
        V(sSalida[i])
    }
}

process empleado{
    while(true)
        P(sPersona)
        P(sCola)
        persona = cola.desencolar()
        V(sCola)
        P(sEstado[persona])
        if (estado[persona] == "esperando"){
            estado[persona] = "atendido"
            V(sEstado[persona])
            atender(persona)
            V(pSalida[persona])
        }
    }
}
```

---

### 8. Hay una fábrica con M operarios en donde se deben realizar N tareas (siendo M = Nx5).  Cada tarea se realiza de a grupos de 5 operarios, ni bien llegan a la fábrica se juntan de a 5 en el orden en que llegaron y cuando se ha formado el grupo se le da la tarea correspondiente empezando de la tarea uno hasta la enésima. Una vez que los operarios del grupo tienen la tarea asignada producen elementos hasta que hayan realizado exactamente X entre los operarios del grupo. Una vez que terminaron de producir los X elementos, se juntan los 5 operarios del grupo y se retiran.  Nota: cada operario puede hacer 0, 1 o más elementos de una tarea. El tiempo que cada operario tarda en hacer cada elemento es diferente y random. Maximice la concurrencia. 

```

sem sLlegaEmpleado = 1
int grupoLibre = 1
int contGrupos[N] = ([N] 0)
sem grupoListo[N] = ([N] 0)
sem sElementosProducidos[N] = ([N] 1)
int elementosProducidos[N] = ([N] 0)
sem sTerminados[N] = ([N] 1)
int terminados[N] = ([N] 0)
sem salida[N] = ([N] 0)

process operario[i=1 to M]{

    P(sLlegaEmpleado)
    grupo = grupoLibre
    contGrupos[grupo]++
    if (contGrupos[grupo] == 5){
        grupoLibre++
        V(sLlegaEmpleado)
        for 1 to 4 do V(grupoListo[grupo])
    }else{
        V(sLlegaEmpleado)
        P(grupoListo[grupo])
    }

    P(sElementosProducidos[grupo])
    while(elementosProducidos[grupo] < X){
        elementosProducidos[grupo]++
        V(sElementosProducidos[grupo])
        producirElemento(grupo)
        P(sElementosProducidos[grupo])
    }
    V(sElementosProducidos[grupo])

    P(sTerminados[grupo])
    terminados[grupo]++
    if (terminados[grupo] == 5)
        V(sTerminados[grupo])
        for i=1 to 4 V(salida[grupo])
    else
        V(sTerminados[grupo])
        P(salida[grupo])
 
}
```

---

### 9. Resolver con SEMÁFOROS el funcionamiento en una fábrica de ventanas con 7 empleados (4 carpinteros, 1 vidriero y 2 armadores) que trabajan de la siguiente manera:

* Los carpinteros continuamente hacen marcos (cada marco es armando por un único carpintero) y los deja en un depósito con capacidad de almacenar 30 marcos.

* El vidriero continuamente hace vidrios y los deja en otro depósito con capacidad para 50 vidrios.

* Los armador continuamente toman un marco y un vidrio de los depósitos correspondientes y arman la ventana (cada ventana es armada por un único armador).

```
sem sCantMarcos = 30
sem sCantVidrios = 50
sem sColaMarcos = 1
sem sColaVidrios = 1
Cola colaMarcos
Cola colaVidrios

process carpintero[i=1 to 4] {
    while(true)
        marco = generarMarco()
        P(sCantMarcos)
        P(sColaMarcos)
        colaMarcos.encolar(marco)
        V(sColaMarcos)
}

process vidriero {
    while(true)
        vidrio = generarVidrio()
        P(sCantVidrios)
        P(sColaVidrios)
        colaVidios.encolar(vidrio)
        V(sColaVidrios)
}

process armador[i=1 to 2] {
    while(true)
        P(sColaMarcos)
        marco = colaMarcos.desencoalr()
        V(sColaMarcos)
        V(sCantMarcos)
        P(sColaVidrios)
        vidrio = colaVidrios.desencoalr()
        V(sColaVidrios)
        V(sCantVidrios)
        ensamblar(marco, vidrio)
}
```

---

### 10. En un curso hay dos profesores que toman examen en forma oral, el profesor A llama a los alumnos de acuerdo al orden de llegada, mientras que el profesor B llama a cualquier alumno (que haya llegado). Existen N alumnos que llegan y se quedan esperando hasta ser llamados para rendir, luego de que uno de los dos profesores lo atiende, se va. Indicar si la siguiente solución realizada con semáforo resuelve lo pedido. Justificar la respuesta. 

```
string estado[N] = ([N], “Esperando” )
queue colaA, colaB
sem llegoA, llegoB = 0
sem esperando[N] = ([N], 0)
sem mutex[N] = ([N], 1)
sem mutexA, mutexB = 1

Profesor A::
{ int idAlumno
 while (true)
 { P(llegoA)
 P(mutexA)
 idAlumno = pop(colaA)
 V(mutexA)
 P(mutex[idAlumno])
 If (estado[idAlumno] = =“Esperando”)
 estado[idAlumno] = “A”
 V(mutex[idAlumno])
 V(esperando[idAlumno])
 //Se toma el examen//
 V(esperando[idAlumno])
 else
 V(mutex[idAlumno])
 }
}

Profesor B::
{ int idAlumno
 while (true)
 { P(llegoB)
 P(mutexB)
 idAlumno = popAleatorio(colaB)
 V(mutex(B))
 P(mutex[idAlumno])
 If (estado[idAlumno] == “Esperando”)
 estado[idAlumno] = “B”
 V(mutex[idAlumno])
 V(esperando[idAlumno])
 //Se toma el examen//
 V(esperando[idAlumno])
 else
 V(mutex[idAlumno])
 }
}

Alumno[i: 1..N]
{ P(mutexA)
 push(colaA, i)
 V(mutexA)
 P(mutexB)
 push(colaB, i)
 V(mutexB)
 P(esperando[i])
 if (estado[i] == “A”)
 //Interactúa con el Prof A//
 else
 //Interactua con el Prof B//
 P(esperando[i])
}
```

La solución planteada no resuelve el problema debido a que tanto el proceso `Profesor A` como `Profesor B` se quedan bloqueados ya que los procesos `Alumno` nunca hacen un `V(llegoA)` o `V(llegoB)` respectivamente. Además la solución se debería poder plantear haciendo uso de una única cola.

---

### 11. Resolver el funcionamiento en una empresa de genética. Hay N clientes que sucesivamente envían secuencias de ADN a la empresa para que sean analizadas y esperan los resultados para poder envían otra secuencia a analizar. Para resolver estos análisis la empresa cuenta con 2 servidores que van alternando su uso para no exigirlos de más (en todo momento uno está trabajando y los otros dos descansando); cada 8 horas cambia en servidor con el que se trabaja. El servidor que está trabajando, toma un pedido (de a uno de acuerdo al orden de llegada de los mismos), lo resuelve y devuelve el resultado al cliente correspondiente; si al terminar ya han pasado las 8 horas despierta al próximo servidor y él descansa, sino continúa con el siguiente pedido. 

```
sem sColaADN = 1
sem envioADN = 0
sem respuesta[N] = ([N], 0)
sem sServidor[3] = {1, 0, 0}
int contServidor = 1
Cola colaADN

process cliente[i=1 to N]{
    while(true)
        P(sColaADN)
        colaADN.encolar(i)
        V(sColaADN)
        V(envioADN)
        P(respuesta[i])
}

process servidor[i=1 to 3]{
    while(true){
        P(sServidor[i])
        horas = 0
        while(horas < 8){
            P(envioADN)
            P(sColaADN)
            cliente = cola.desencolar()
            V(sColaADN)
            procesar(cliente)
            V(respuesta[cliente])
        } 
        contServidor++
        if contServidor == 4 then contServidor = 1
        V(sServidor[contServidor])
    }
}
```

