# Memory management

In this project we add a fixed size blocks (pages) allocator and basic virtual
memory manager.

## Page allocator

The page allocator is implemented in `kalloc.c`. Function `init_kalloc()` build
a linked list of free memory blocks (pages) after kernel data (the kernel heap).
Pages are 4KB blocks.

Function `alloc_page()` returns the `free_list` head block (if any) and
`free_page(p)` push the page in the free list.

## Virtual memory

The kernel now runs with memory protection (paging). Function `init_vm()` (in
`vm.c`) create an empty page table for the kernel and map memory regions by
calling `map_kernel_memory()`, defined in `arch.c`. It maps memory mapped device
controller registers and all physical RAM.

In the kernel main function, each CPU enable paging before calling to the
scheduler.

The mappings from kernel virtual to physical addresses is 1 to 1. 

In `arch.c`, the `map_page(pgtbl, va, pa, flags)` function maps the *virtual address*
`va` to the *physical address* `pa` into the page table `pgtbl`.
Physical page should be allocated before via `alloc_page()`.

## Task management improvements

Each task kernel mode stack is allocated on creation by calling `alloc_page()`.

The `wait_for_task(task)` function makes current task wait for `task`
termination.

When a task calls `terminate(exit_code)`, it becomes `ZOMBIE` and set its exit
code in the corresponding task descriptor field. Also, the waiting
task (if any) is awaked.

The scheduler free resources (kernel mode stack, for now) of `ZOMBIE` tasks.

The waiting task gets the terminated task exit code and free descriptor (by
seeting its state to `UNUSED`).

In this model, a finished task descriptor can't become free (`UNUSED`) until
some task is waiting for it.

In `kmain.c` task A waits for task B to finish.

## Exercises

1. Task B produce a page fault (see `kmain.c`) by trying to use the virtual
   address 0x1000. Run the program and explain why it happens. Explain the trap cause.


Al ejecutarse esa intruccion va[0] = 'B';, el hardware RISC-V comprueba la tabla de paginas activa (el satp que esta apuntando a la pagetable del contexto de Task B) y ve que no hay ninguna entrada valida (PAGE_V == 0) para la pagina que contiene el byte en 0x1000. Por tanto, el procesador dispara una excepcion de tipo Store Page Fault (código de causa 0x0F (15)).


2. Fix the code in `task_b()` function to get a valid 0x1000 virtual address.
   Now, the OS should run without page faults and you should get the output `Task B contents at va 0x1000: B`.

Para que Task B pueda leer/escribir sin page-fault en la dir 0x1000, hacemos:

    1.Reservos fisicamente una pagina (con alloc_page()).

    2.Creamos la entrada PTE en la pagetable de Task B, con permisos de lectura/escritura (osea bit R y W activados).

3. Complete `unmap_page()` function implementation in `arch.c` and verify it
   works.

La solucion propuesta: 
void unmap_page(pte* pgtbl, vaddr va, bool free) {  

   // Buscar la PTE (entrada de segundo nivel, nodo hoja) correspondiente a 'va'.
   // Si no existe (get_pte devuelve NULL), o si el bit V no esta puesto.
    pte *entry = get_pte(pgtbl, va, false);

   // COmprobamos que existe la PTE y que esta marcada como valida (PAGE_V = 1).
    if(entry && *entry & PAGE_V) {
        paddr pa = pte_pa(*entry);  //obtenemos la direccion fisica apuntada por la pte.
        if (free) {  //si necesita liberarla
            free_page( (void *) pa); //la liberamos
        }
        *entry = 0; //ponemos todo en 0
    }
}
