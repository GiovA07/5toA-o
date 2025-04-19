
kernel:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <__kernel_start>:
80000000:	f1402273          	csrr	tp,mhartid
80000004:	00000117          	auipc	sp,0x0
80000008:	30010113          	addi	sp,sp,768 # 80000304 <__bss_end>
8000000c:	000012b7          	lui	t0,0x1
80000010:	00120313          	addi	t1,tp,1 # 1 <__kernel_start-0x7fffffff>
80000014:	026282b3          	mul	t0,t0,t1
80000018:	00510133          	add	sp,sp,t0
8000001c:	300023f3          	csrr	t2,mstatus
80000020:	ffffee37          	lui	t3,0xffffe
80000024:	7ffe0e13          	addi	t3,t3,2047 # ffffe7ff <__kernel_end+0x7fffa4fb>
80000028:	01c3f3b3          	and	t2,t2,t3
8000002c:	00001eb7          	lui	t4,0x1
80000030:	800e8e93          	addi	t4,t4,-2048 # 800 <__kernel_start-0x7ffff800>
80000034:	01d3e3b3          	or	t2,t2,t4
80000038:	30039073          	csrw	mstatus,t2
8000003c:	00000297          	auipc	t0,0x0
80000040:	03028293          	addi	t0,t0,48 # 8000006c <supervisor>
80000044:	34129073          	csrw	mepc,t0
80000048:	01f00f13          	li	t5,31
8000004c:	3a0f1073          	csrw	pmpcfg0,t5
80000050:	fff00f93          	li	t6,-1
80000054:	3b0f9073          	csrw	pmpaddr0,t6
80000058:	00010f37          	lui	t5,0x10
8000005c:	ffff0f13          	addi	t5,t5,-1 # ffff <__kernel_start-0x7fff0001>
80000060:	303f2073          	csrs	mideleg,t5
80000064:	302f2073          	csrs	medeleg,t5
80000068:	30200073          	mret

8000006c <supervisor>:
8000006c:	18001073          	csrw	satp,zero
80000070:	094000ef          	jal	80000104 <kernel_main>

80000074 <cpuid>:
80000074:	00020513          	mv	a0,tp
80000078:	00008067          	ret

8000007c <disable_interrupts>:
8000007c:	10017073          	csrci	sstatus,2
80000080:	00008067          	ret

80000084 <enable_interrupts>:
80000084:	10016073          	csrsi	sstatus,2
80000088:	00008067          	ret

8000008c <console_putc>:
8000008c:	ff010113          	addi	sp,sp,-16
80000090:	00812623          	sw	s0,12(sp)
80000094:	01010413          	addi	s0,sp,16
80000098:	100007b7          	lui	a5,0x10000
8000009c:	00578793          	addi	a5,a5,5 # 10000005 <__kernel_start-0x6ffffffb>
800000a0:	0007c783          	lbu	a5,0(a5)
800000a4:	0407f793          	andi	a5,a5,64
800000a8:	00078063          	beqz	a5,800000a8 <console_putc+0x1c>
800000ac:	100007b7          	lui	a5,0x10000
800000b0:	00a78023          	sb	a0,0(a5) # 10000000 <__kernel_start-0x70000000>
800000b4:	00c12403          	lw	s0,12(sp)
800000b8:	01010113          	addi	sp,sp,16
800000bc:	00008067          	ret

800000c0 <console_puts>:
800000c0:	ff010113          	addi	sp,sp,-16
800000c4:	00112623          	sw	ra,12(sp)
800000c8:	00812423          	sw	s0,8(sp)
800000cc:	00912223          	sw	s1,4(sp)
800000d0:	01010413          	addi	s0,sp,16
800000d4:	00050493          	mv	s1,a0
800000d8:	00054503          	lbu	a0,0(a0)
800000dc:	00050a63          	beqz	a0,800000f0 <console_puts+0x30>
800000e0:	00148493          	addi	s1,s1,1
800000e4:	fa9ff0ef          	jal	8000008c <console_putc>
800000e8:	0004c503          	lbu	a0,0(s1)
800000ec:	fe051ae3          	bnez	a0,800000e0 <console_puts+0x20>
800000f0:	00c12083          	lw	ra,12(sp)
800000f4:	00812403          	lw	s0,8(sp)
800000f8:	00412483          	lw	s1,4(sp)
800000fc:	01010113          	addi	sp,sp,16
80000100:	00008067          	ret

80000104 <kernel_main>:
80000104:	ff010113          	addi	sp,sp,-16
80000108:	00112623          	sw	ra,12(sp)
8000010c:	00812423          	sw	s0,8(sp)
80000110:	01010413          	addi	s0,sp,16
80000114:	00000517          	auipc	a0,0x0
80000118:	1ec50513          	addi	a0,a0,492 # 80000300 <lk>
8000011c:	038000ef          	jal	80000154 <acquire>
80000120:	f55ff0ef          	jal	80000074 <cpuid>
80000124:	02051063          	bnez	a0,80000144 <kernel_main+0x40>
80000128:	00000517          	auipc	a0,0x0
8000012c:	0a050513          	addi	a0,a0,160 # 800001c8 <release+0x30>
80000130:	f91ff0ef          	jal	800000c0 <console_puts>
80000134:	00000517          	auipc	a0,0x0
80000138:	1cc50513          	addi	a0,a0,460 # 80000300 <lk>
8000013c:	05c000ef          	jal	80000198 <release>
80000140:	0000006f          	j	80000140 <kernel_main+0x3c>
80000144:	00000517          	auipc	a0,0x0
80000148:	09850513          	addi	a0,a0,152 # 800001dc <release+0x44>
8000014c:	f75ff0ef          	jal	800000c0 <console_puts>
80000150:	fe5ff06f          	j	80000134 <kernel_main+0x30>

80000154 <acquire>:
80000154:	ff010113          	addi	sp,sp,-16
80000158:	00112623          	sw	ra,12(sp)
8000015c:	00812423          	sw	s0,8(sp)
80000160:	00912223          	sw	s1,4(sp)
80000164:	01010413          	addi	s0,sp,16
80000168:	00050493          	mv	s1,a0
8000016c:	f11ff0ef          	jal	8000007c <disable_interrupts>
80000170:	00100713          	li	a4,1
80000174:	00070793          	mv	a5,a4
80000178:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
8000017c:	fe079ce3          	bnez	a5,80000174 <acquire+0x20>
80000180:	0330000f          	fence	rw,rw
80000184:	00c12083          	lw	ra,12(sp)
80000188:	00812403          	lw	s0,8(sp)
8000018c:	00412483          	lw	s1,4(sp)
80000190:	01010113          	addi	sp,sp,16
80000194:	00008067          	ret

80000198 <release>:
80000198:	ff010113          	addi	sp,sp,-16
8000019c:	00112623          	sw	ra,12(sp)
800001a0:	00812423          	sw	s0,8(sp)
800001a4:	01010413          	addi	s0,sp,16
800001a8:	0330000f          	fence	rw,rw
800001ac:	0310000f          	fence	rw,w
800001b0:	00052023          	sw	zero,0(a0)
800001b4:	ed1ff0ef          	jal	80000084 <enable_interrupts>
800001b8:	00c12083          	lw	ra,12(sp)
800001bc:	00812403          	lw	s0,8(sp)
800001c0:	01010113          	addi	sp,sp,16
800001c4:	00008067          	ret
