
kernel:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <boot>:
80000000:	00002117          	auipc	sp,0x2
80000004:	00010113          	mv	sp,sp
80000008:	07c000ef          	jal	80000084 <kernel_main>

8000000c <console_putc>:
8000000c:	ff010113          	addi	sp,sp,-16 # 80001ff0 <__stack0+0xff0>
80000010:	00812623          	sw	s0,12(sp)
80000014:	01010413          	addi	s0,sp,16
80000018:	100007b7          	lui	a5,0x10000
8000001c:	00578793          	addi	a5,a5,5 # 10000005 <boot-0x6ffffffb>
80000020:	0007c783          	lbu	a5,0(a5)
80000024:	0407f793          	andi	a5,a5,64
80000028:	00078063          	beqz	a5,80000028 <console_putc+0x1c>
8000002c:	100007b7          	lui	a5,0x10000
80000030:	00a78023          	sb	a0,0(a5) # 10000000 <boot-0x70000000>
80000034:	00c12403          	lw	s0,12(sp)
80000038:	01010113          	addi	sp,sp,16
8000003c:	00008067          	ret

80000040 <console_puts>:
80000040:	ff010113          	addi	sp,sp,-16
80000044:	00112623          	sw	ra,12(sp)
80000048:	00812423          	sw	s0,8(sp)
8000004c:	00912223          	sw	s1,4(sp)
80000050:	01010413          	addi	s0,sp,16
80000054:	00050493          	mv	s1,a0
80000058:	00054503          	lbu	a0,0(a0)
8000005c:	00050a63          	beqz	a0,80000070 <console_puts+0x30>
80000060:	00148493          	addi	s1,s1,1
80000064:	fa9ff0ef          	jal	8000000c <console_putc>
80000068:	0004c503          	lbu	a0,0(s1)
8000006c:	fe051ae3          	bnez	a0,80000060 <console_puts+0x20>
80000070:	00c12083          	lw	ra,12(sp)
80000074:	00812403          	lw	s0,8(sp)
80000078:	00412483          	lw	s1,4(sp)
8000007c:	01010113          	addi	sp,sp,16
80000080:	00008067          	ret

80000084 <kernel_main>:
80000084:	ff010113          	addi	sp,sp,-16
80000088:	00112623          	sw	ra,12(sp)
8000008c:	00812423          	sw	s0,8(sp)
80000090:	01010413          	addi	s0,sp,16
80000094:	00000517          	auipc	a0,0x0
80000098:	01450513          	addi	a0,a0,20 # 800000a8 <kernel_main+0x24>
8000009c:	fa5ff0ef          	jal	80000040 <console_puts>
800000a0:	f1402573          	csrr	a0,mhartid
800000a4:	0000006f          	j	800000a4 <kernel_main+0x20>
