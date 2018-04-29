# Práctica 3

## Conceptos Generales

### 1. ¿Qué es una System Call?, ¿para que se utiliza?

A system call is a request for service that a program makes of the kernel. The service is generally something that only the kernel has the privilege to do, such as doing I/O. Programmers don’t normally need to be concerned with system calls because there are functions in the GNU C Library to do virtually everything that system calls do. These functions work by making system calls themselves. For example, there is a system call that changes the permissions of a file, but you don’t need to know about it because you can just use the GNU C Library’s chmod function.

### 2. ¿Para qué sirve la macro syscall?. Describa el propósito de cada uno de sus parámetros.

There are times when you want to make a system call explicitly, and for that, the GNU C Library provides the syscall function. syscall is harder to use and less portable than functions like chmod, but easier and more portable than coding the system call in assembler instructions.

syscall is most useful when you are working with a system call which is special to your system or is newer than the GNU C Library you are using. syscall is implemented in an entirely generic way; the function does not know anything about what a particular system call does or even if it is valid.

syscall is declared in unistd.h.

Function: `long int syscall (long int sysno, …)`

syscall performs a generic system call.

sysno is the system call number. Each kind of system call is identified by a number. Macros for all the possible system call numbers are defined in sys/syscall.h

The remaining arguments are the arguments for the system call, in order, and their meanings depend on the kind of system call. Each kind of system call has a definite number of arguments, from zero to five. If you code more arguments than the system call takes, the extra ones to the right are ignored.

### 3. ¿Para que sirven los siguientes archivos?

#### <kernel_code>/arch/x86/syscalls/syscall_32.tbla

```
# 32-bit system call numbers and entry vectors
#
# The format is:
# <number> <abi> <name> <entry point> <compat entry point>
```

#### <kernel_code>/arch/x86/syscalls/syscall_64.tbl

```
# 64-bit system call numbers and entry vectors
#
# The format is:
# <number> <abi> <name> <entry point>
```

### 4. ¿Para qué sirve la macro asmlinkage?

The asmlinkage tag is one other thing that we should observe about this simple function. This is a #define for some gcc magic that tells the compiler that the function should not expect to find any of its arguments in registers (a common optimization), but only on the CPU's stack. Recall our earlier assertion that system_call consumes its first argument, the system call number, and allows up to four more arguments that are passed along to the real system call. system_call achieves this feat simply by leaving its other arguments (which were passed to it in registers) on the stack. All system calls are marked with the asmlinkage tag, so they all look to the stack for arguments. Of course, in sys_ni_syscall's case, this doesn't make any difference, because sys_ni_syscall doesn't take any arguments, but it's an issue for most other system calls. And, because you'll be seeing asmlinkage in front of many other functions, I thought you should know what it was about.

It is also used to allow calling a function from assembly files.

### 5. ¿Para qué sirve la herramienta strace?, ¿Cómo se usa?

strace es una utilidad de línea de comandos para comprobación de errores en el sistema operativo GNU/Linux. Permite monitorear las llamadas al sistema usadas por un determinado programa y todas las señales que éste recibe.​ Su funcionamiento es posible por una característica del núcleo linux llamada ptrace.

Su uso más común consiste en arrancarlo junto al programa al que se le efectúa el trazado, el cual imprime una lista de llamadas al sistema que dicho programa ejecuta. Es útil para averiguar la causa del fallo de un programa determinado porque informa de situaciones en las que por ejemplo, el programa está intentando acceder a un fichero que no existe o que no tiene permiso de lectura.

