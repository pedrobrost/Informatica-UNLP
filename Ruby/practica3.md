# Práctica 3

## Excepciones

### 1. Investigá la jerarquía de clases que presenta Ruby para las excepciones. ¿Para qué se utilizan las siguientes clases?

https://airbrake.io/blog/ruby-exception-handling/ruby-exception-classes

#### IOError

Es lanzada cuando una operación de entrada/salida falla.

#### NameError

Es lanzada cuando el nombre de una variable o símbolo es inválido o indefinido.

#### RuntimeError

Es lanzada cuando se intenta realizar una operación inválida de algún tipo.

#### NotImplementedError

Es lanzada cuando se intenta utilizar una característica o método que no está implementada en la plataforma actual.

#### StopIteration

StopIteration is unique in the realm of Ruby exceptions, since it isn’t generated at run-time by something going haywire, but is instead manually raised by the developer when there’s a need to halt an active iteration.

#### TypeError

Es lanzada cuando se encuentra un objeto que no es del tipo esperado.

#### SystemExit

Es lanzada cuando el método `Kernel#exit` es invocado para finalizar el proceso actual.

---


