# 1. Firmware boot loads the kernel binary (kernel) at address 
#    0x80000000 and jumps there in machine (M) mode.
# 2. boot function code is at address 0x80000000 (see kernel.ld)

.section .text

.global boot
boot:
    # Set mstatus.MPP to Supervisor Mode
    csrr    t2, mstatus            # Read mstatus into t2
    li      t3, ~(0x3 << 11)       # Mask to clear MPP bits
    and     t2, t2, t3             # Clear MPP bits
    li      t4, (0x1 << 11)        # MPP = 01 (Supervisor Mode)
    or      t2, t2, t4             # Set MPP bits to 01
    csrw    mstatus, t2            # Write back to mstatus

    # Load address of 'supervisor' code into t0 and set mepc
    la      t0, supervisor
    csrw    mepc, t0

    # Set up PMP to allow S-mode and U-mode full access to memory
    li      t5, 0x1F               # NAPOT + R/W/X permissions
    csrw    pmpcfg0, t5            # Write to pmpcfg0
    li      t6, -1                 # All ones to cover entire address space
    csrw    pmpaddr0, t6           # Write to pmpaddr0

    # Delegate interrupts and exceptions to S-mode
    li      t5, 0xffff
    csrs    medeleg, t5
    csrs    mideleg, t5

    # jump to supervisor in S-mode
    mret

# S-mode entry point (after mret)
supervisor:
    # Disable paging by setting satp to zero
    csrw    satp, x0

    # setup stack pointer at bottom of stack0 (see kernel.ld)
    la sp, __kernel_end

    # call kernel_main() in supervisor mode
    call kernel_main
