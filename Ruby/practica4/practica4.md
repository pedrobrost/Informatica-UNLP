# Práctica 4

## Gemas Y Bundler

### 1. ¿Qué es una gema? ¿Para qué sirve? ¿Qué estructura tienen?

http://guides.rubygems.org/what-is-a-gem/

---

### 2. ¿Cuáles son las principales diferencias entre el comando gem y Bundler? ¿Hacen lo mismo?

https://stackoverflow.com/questions/6162047/difference-between-bundle-and-gem-install

---

### 3. ¿Dónde instalan las gemas los comandos gem y bundle?

https://stackoverflow.com/questions/6162047/difference-between-bundle-and-gem-install

---

### 4. ¿Para qué sirve el comando gem server? ¿Qué información podés obtener al usarlo?

http://guides.rubygems.org/run-your-own-gem-server/

---

### 5. Investigá un poco sobre Semantic Versioning (o SemVer). ¿Qué finalidad tiene? ¿Cómo se compone una versión? ¿Ante qué situaciones debería cambiarse cada una de sus partes?

http://semver.org/

---

### 7. Utilizando el proyecto creado en el punto anterior como referencia, contestá las siguientes preguntas:

#### a. ¿Qué finalidad tiene el archivo Gemfile?

El archivo `Gemfile` es utilizado por Bundler y nos permite definir las dependencias de nuestra aplicación.

#### b. ¿Para qué sirve la directiva source del Gemfile? ¿Cuántas pueden haber en un mismo archivo?

http://bundler.io/gemfile.html

#### c. Acorde a cómo agregaste la gema colorputs, ¿qué versión se instaló de la misma?  Si mañana se publicara la versión 7.3.2, ¿esta se instalaría en tu proyecto? ¿Por qué? ¿Cómo podrías limitar esto y hacer que sólo se instalen releases de la gema en las que no cambie la versión mayor de la misma?

La versión que se instaló en el sistema es la última disponible de la gema. Si se publica una nueva version, esta sería instalada. La forma de evitar esto sería por ejemplo de la siguiente manera:

`gem 'colorputs', '~>0.2'`

#### d. ¿Qué ocurrió la primera vez que ejecutaste prueba.rb? ¿Por qué?

No encontró el archivo de la gema solicitada.

`cannot load such file -- colorputs (LoadError)`

#### e. ¿Qué cambió al ejecutar bundle install?

`bundle install` instaló la gema en el sistema, previamente especificada en el archivo `Gemfile`

#### f. ¿Qué diferencia hay entre bundle install y bundle update?

*Bundler help*

```
Bundle install

Install the gems specified in your Gemfile(5). If this is the first time you run bun‐
dle install (and a Gemfile.lock does  not  exist),  Bundler  will  fetch  all  remote
sources, resolve dependencies and install all needed gems.

If  a Gemfile.lock does exist, and you have not updated your Gemfile(5), Bundler will
fetch all remote sources, but use the  dependencies  specified  in  the  Gemfile.lock
instead of resolving dependencies.

If  a Gemfile.lock does exist, and you have updated your Gemfile(5), Bundler will use
the dependencies in the Gemfile.lock for all gems that you did not update,  but  will
re-resolve  the  dependencies of gems that you did update. You can find more informa‐
tion about this update process below under CONSERVATIVE UPDATING.
```

```
Bundle update

Update  the gems specified (all gems, if none are specified), ignoring the previously
installed gems specified in the Gemfile.lock. In  general,  you  should  use  [bundle
install(1)][bundle-install]  to  install  the  same  exact  gems  and versions across
machines.

You would use bundle update to explicitly update the version of a gem.
```

https://www.viget.com/articles/bundler-best-practices

#### g. ¿Qué ocurrió al ejecutar prueba_dos.rb de las distintas formas enunciadas? ¿Por qué? ¿Cómo modificarías el archivo prueba_dos.rb para que funcione correctamente?

* `ruby prueba_dos.rb`: Error debido a que no encuentra la constante `Bundler`.

* `bundle exec ruby prueba_dos.rb`: Funciona debido a que `bundle exec` ejecuta el script en el contexto del bundle actual definido por `Gemfile`.

Para que se pueda ejecutar el script de la primer forma, bastaría con agregar la linea:

`require 'bundler/setup'`

---

## Sinatra

### 1. ¿Qué es Rack? ¿Qué define? ¿Qué requisitos impone?

http://codefol.io/posts/What-is-Rack-A-Primer

---

