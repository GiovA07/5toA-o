# Mini-operating system from scratch

This project contains documentation and code for building a mini, very simple
operating system (OS) from scratch. This codebase is intended for using in an
undergraduate or graduate operating systems course.

Mini-OS was developed by Professor Marcelo Arroyo at Computer Science Department
of Río Cuarto National University, Argentina for teaching the *Operating
Systems* undergraduate course.

This version of mos-steps runs on a RISC-V 32-bit architecture.

As an educational OS, the code is divided on steps. Each step adds a new
feature. It can be used as a set of hands-on laboratory or homework projects to
develop a minimal (but complete) OS from scratch.

In each step directory there is a README.md file with a small introduction to
the required concepts and implementation details.

## Requirements

1. A cross-compiler running in the host platform for RISC-V. We use the GNU GCC
   build chain. With a few changes in `Makefile` build files it also could be
   compiled and linked with *Clang/LLVM*.
2. [QEMU](https://www.qemu.org/) for running the OS in a RISC-V emulated
   machine.

Most GNU-Linux OS provide the necessary packages.

### Debian/Ubuntu based systems

```
sudo apt-get install git build-essential gdb-multiarch qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu
```

### Arch Linux:

 ```
 $ sudo pacman -S riscv64-linux-gnu-binutils riscv64-linux-gnu-gcc riscv64-linux-gnu-gdb qemu-emulators-full
 ```

 ### MacOS

 ```
 $ xcode-select --install
 ```

 Then install RISCV compiler toolchain with [Homebrew](https://brew.sh/)

```
$ brew tap riscv/riscv
$ brew install riscv-tools
```

Maybe you should set `$PATH` environment variable (maybe in your `~/.bashrc`)
for commands.

```
PATH=$PATH:/usr/local/opt/riscv-gnu-toolchain/bin
```

Then, install QEMU with `$brew install qemu`

### MS-Windows

Install packages in an Ubuntu system installed on WSL 2 (Windows Subsystem for
Linux, version 2).

### Running in a Linux virtual machine

Install some linux distribution on some virtualization platform as
[VirtualBox](https://www.virtualbox.org/). Then install the required packages as
above.

## Resources

1. *RISCV programming book*: Prof. Edson Borin. 
   https://riscv-programming.org/book/riscv-book.html
2. *XV6,  a simple Unix-like teaching operating system*. 
   https://pdos.csail.mit.edu/6.1810/2024/xv6.html
3. Daniel Magnum RISC-V blog: https://danielmangum.com/categories/risc-v-bytes/
4. *Writing an Operating System in 1000 lines*. 
   https://github.com/nuta/operating-system-in-1000-lines
5. *Operating Systems UNRC Course Notes (in Spanish)*.
   https://marceloarroyo.gitlab.io/cursos/SO/index.html

