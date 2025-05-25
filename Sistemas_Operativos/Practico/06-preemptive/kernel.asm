
kernel:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <boot>:
80000000:	f1402273          	csrr	tp,mhartid
80000004:	00013117          	auipc	sp,0x13
80000008:	ffc10113          	addi	sp,sp,-4 # 80013000 <__stack0>
8000000c:	000012b7          	lui	t0,0x1
80000010:	00120313          	addi	t1,tp,1 # 1 <boot-0x7fffffff>
80000014:	026282b3          	mul	t0,t0,t1
80000018:	00510133          	add	sp,sp,t0
8000001c:	18001073          	csrw	satp,zero
80000020:	01f00f13          	li	t5,31
80000024:	3a0f1073          	csrw	pmpcfg0,t5
80000028:	fff00f93          	li	t6,-1
8000002c:	3b0f9073          	csrw	pmpaddr0,t6
80000030:	300023f3          	csrr	t2,mstatus
80000034:	ffffee37          	lui	t3,0xffffe
80000038:	7ffe0e13          	addi	t3,t3,2047 # ffffe7ff <__kernel_end+0x7ffea7ff>
8000003c:	01c3f3b3          	and	t2,t2,t3
80000040:	00001eb7          	lui	t4,0x1
80000044:	800e8e93          	addi	t4,t4,-2048 # 800 <boot-0x7ffff800>
80000048:	01d3e3b3          	or	t2,t2,t4
8000004c:	30039073          	csrw	mstatus,t2
80000050:	00010f37          	lui	t5,0x10
80000054:	ffff0f13          	addi	t5,t5,-1 # ffff <boot-0x7fff0001>
80000058:	302f2073          	csrs	medeleg,t5
8000005c:	303f2073          	csrs	mideleg,t5
80000060:	10016073          	csrsi	sstatus,2
80000064:	22200f13          	li	t5,546
80000068:	104f2073          	csrs	sie,t5
8000006c:	00020513          	mv	a0,tp
80000070:	220000ef          	jal	80000290 <next_timer_interrupt>
80000074:	00800f13          	li	t5,8
80000078:	300f2073          	csrs	mstatus,t5
8000007c:	08000f13          	li	t5,128
80000080:	304f2073          	csrs	mie,t5
80000084:	00000f17          	auipc	t5,0x0
80000088:	1a8f0f13          	addi	t5,t5,424 # 8000022c <m_trap>
8000008c:	305f1073          	csrw	mtvec,t5
80000090:	00000297          	auipc	t0,0x0
80000094:	01028293          	addi	t0,t0,16 # 800000a0 <supervisor>
80000098:	34129073          	csrw	mepc,t0
8000009c:	30200073          	mret

800000a0 <supervisor>:
800000a0:	00000317          	auipc	t1,0x0
800000a4:	08430313          	addi	t1,t1,132 # 80000124 <s_trap>
800000a8:	10531073          	csrw	stvec,t1
800000ac:	6c4000ef          	jal	80000770 <kernel_main>

800000b0 <context_switch>:
800000b0:	00152023          	sw	ra,0(a0)
800000b4:	00252223          	sw	sp,4(a0)
800000b8:	00852423          	sw	s0,8(a0)
800000bc:	00952623          	sw	s1,12(a0)
800000c0:	01252823          	sw	s2,16(a0)
800000c4:	01352a23          	sw	s3,20(a0)
800000c8:	01452c23          	sw	s4,24(a0)
800000cc:	01552e23          	sw	s5,28(a0)
800000d0:	03652023          	sw	s6,32(a0)
800000d4:	03752223          	sw	s7,36(a0)
800000d8:	03852423          	sw	s8,40(a0)
800000dc:	03952623          	sw	s9,44(a0)
800000e0:	03a52823          	sw	s10,48(a0)
800000e4:	03b52a23          	sw	s11,52(a0)
800000e8:	0005a083          	lw	ra,0(a1)
800000ec:	0045a103          	lw	sp,4(a1)
800000f0:	0085a403          	lw	s0,8(a1)
800000f4:	00c5a483          	lw	s1,12(a1)
800000f8:	0105a903          	lw	s2,16(a1)
800000fc:	0145a983          	lw	s3,20(a1)
80000100:	0185aa03          	lw	s4,24(a1)
80000104:	01c5aa83          	lw	s5,28(a1)
80000108:	0205ab03          	lw	s6,32(a1)
8000010c:	0245ab83          	lw	s7,36(a1)
80000110:	0285ac03          	lw	s8,40(a1)
80000114:	02c5ac83          	lw	s9,44(a1)
80000118:	0305ad03          	lw	s10,48(a1)
8000011c:	0345ad83          	lw	s11,52(a1)
80000120:	00008067          	ret

80000124 <s_trap>:
80000124:	f8810113          	addi	sp,sp,-120
80000128:	00112023          	sw	ra,0(sp)
8000012c:	00312223          	sw	gp,4(sp)
80000130:	00512423          	sw	t0,8(sp)
80000134:	00612623          	sw	t1,12(sp)
80000138:	00712823          	sw	t2,16(sp)
8000013c:	01c12a23          	sw	t3,20(sp)
80000140:	01d12c23          	sw	t4,24(sp)
80000144:	01e12e23          	sw	t5,28(sp)
80000148:	03f12023          	sw	t6,32(sp)
8000014c:	02a12223          	sw	a0,36(sp)
80000150:	02b12423          	sw	a1,40(sp)
80000154:	02c12623          	sw	a2,44(sp)
80000158:	02d12823          	sw	a3,48(sp)
8000015c:	02e12a23          	sw	a4,52(sp)
80000160:	02f12c23          	sw	a5,56(sp)
80000164:	03012e23          	sw	a6,60(sp)
80000168:	05112023          	sw	a7,64(sp)
8000016c:	04812223          	sw	s0,68(sp)
80000170:	04912423          	sw	s1,72(sp)
80000174:	05212623          	sw	s2,76(sp)
80000178:	05312823          	sw	s3,80(sp)
8000017c:	05412a23          	sw	s4,84(sp)
80000180:	05512c23          	sw	s5,88(sp)
80000184:	05612e23          	sw	s6,92(sp)
80000188:	07712023          	sw	s7,96(sp)
8000018c:	07812223          	sw	s8,100(sp)
80000190:	07912423          	sw	s9,104(sp)
80000194:	07a12623          	sw	s10,108(sp)
80000198:	07b12823          	sw	s11,112(sp)
8000019c:	06212a23          	sw	sp,116(sp)
800001a0:	00010513          	mv	a0,sp
800001a4:	048010ef          	jal	800011ec <trap>
800001a8:	00012083          	lw	ra,0(sp)
800001ac:	00412183          	lw	gp,4(sp)
800001b0:	00812283          	lw	t0,8(sp)
800001b4:	00c12303          	lw	t1,12(sp)
800001b8:	01012383          	lw	t2,16(sp)
800001bc:	01412e03          	lw	t3,20(sp)
800001c0:	01812e83          	lw	t4,24(sp)
800001c4:	01c12f03          	lw	t5,28(sp)
800001c8:	02012f83          	lw	t6,32(sp)
800001cc:	02412503          	lw	a0,36(sp)
800001d0:	02812583          	lw	a1,40(sp)
800001d4:	02c12603          	lw	a2,44(sp)
800001d8:	03012683          	lw	a3,48(sp)
800001dc:	03412703          	lw	a4,52(sp)
800001e0:	03812783          	lw	a5,56(sp)
800001e4:	03c12803          	lw	a6,60(sp)
800001e8:	04012883          	lw	a7,64(sp)
800001ec:	04412403          	lw	s0,68(sp)
800001f0:	04812483          	lw	s1,72(sp)
800001f4:	04c12903          	lw	s2,76(sp)
800001f8:	05012983          	lw	s3,80(sp)
800001fc:	05412a03          	lw	s4,84(sp)
80000200:	05812a83          	lw	s5,88(sp)
80000204:	05c12b03          	lw	s6,92(sp)
80000208:	06012b83          	lw	s7,96(sp)
8000020c:	06412c03          	lw	s8,100(sp)
80000210:	06812c83          	lw	s9,104(sp)
80000214:	06c12d03          	lw	s10,108(sp)
80000218:	07012d83          	lw	s11,112(sp)
8000021c:	07412103          	lw	sp,116(sp)
80000220:	07810113          	addi	sp,sp,120
80000224:	10016073          	csrsi	sstatus,2
80000228:	10200073          	sret

8000022c <m_trap>:
8000022c:	fe010113          	addi	sp,sp,-32
80000230:	00a12023          	sw	a0,0(sp)
80000234:	00b12223          	sw	a1,4(sp)
80000238:	00c12423          	sw	a2,8(sp)
8000023c:	00d12623          	sw	a3,12(sp)
80000240:	00e12823          	sw	a4,16(sp)
80000244:	00f12a23          	sw	a5,20(sp)
80000248:	01012c23          	sw	a6,24(sp)
8000024c:	01112e23          	sw	a7,28(sp)
80000250:	00008893          	mv	a7,ra
80000254:	00020513          	mv	a0,tp
80000258:	038000ef          	jal	80000290 <next_timer_interrupt>
8000025c:	00088093          	mv	ra,a7
80000260:	00012503          	lw	a0,0(sp)
80000264:	00412583          	lw	a1,4(sp)
80000268:	00812603          	lw	a2,8(sp)
8000026c:	00c12683          	lw	a3,12(sp)
80000270:	01012703          	lw	a4,16(sp)
80000274:	01412783          	lw	a5,20(sp)
80000278:	01812803          	lw	a6,24(sp)
8000027c:	01c12883          	lw	a7,28(sp)
80000280:	02010113          	addi	sp,sp,32
80000284:	00200593          	li	a1,2
80000288:	14459073          	csrw	sip,a1
8000028c:	30200073          	mret

80000290 <next_timer_interrupt>:
80000290:	ff010113          	addi	sp,sp,-16
80000294:	00812623          	sw	s0,12(sp)
80000298:	01010413          	addi	s0,sp,16
8000029c:	004017b7          	lui	a5,0x401
800002a0:	80078793          	addi	a5,a5,-2048 # 400800 <boot-0x7fbff800>
800002a4:	00f50533          	add	a0,a0,a5
800002a8:	00351513          	slli	a0,a0,0x3
800002ac:	0200c7b7          	lui	a5,0x200c
800002b0:	ff878793          	addi	a5,a5,-8 # 200bff8 <boot-0x7dff4008>
800002b4:	0007a783          	lw	a5,0(a5)
800002b8:	004c5737          	lui	a4,0x4c5
800002bc:	b4070713          	addi	a4,a4,-1216 # 4c4b40 <boot-0x7fb3b4c0>
800002c0:	00e787b3          	add	a5,a5,a4
800002c4:	00f52023          	sw	a5,0(a0)
800002c8:	08000793          	li	a5,128
800002cc:	3007a073          	csrs	mstatus,a5
800002d0:	00c12403          	lw	s0,12(sp)
800002d4:	01010113          	addi	sp,sp,16
800002d8:	00008067          	ret

800002dc <console_putc>:
800002dc:	ff010113          	addi	sp,sp,-16
800002e0:	00812623          	sw	s0,12(sp)
800002e4:	01010413          	addi	s0,sp,16
800002e8:	100007b7          	lui	a5,0x10000
800002ec:	00578793          	addi	a5,a5,5 # 10000005 <boot-0x6ffffffb>
800002f0:	0007c783          	lbu	a5,0(a5)
800002f4:	0407f793          	andi	a5,a5,64
800002f8:	00078063          	beqz	a5,800002f8 <console_putc+0x1c>
800002fc:	100007b7          	lui	a5,0x10000
80000300:	00a78023          	sb	a0,0(a5) # 10000000 <boot-0x70000000>
80000304:	00c12403          	lw	s0,12(sp)
80000308:	01010113          	addi	sp,sp,16
8000030c:	00008067          	ret

80000310 <console_puts>:
80000310:	ff010113          	addi	sp,sp,-16
80000314:	00112623          	sw	ra,12(sp)
80000318:	00812423          	sw	s0,8(sp)
8000031c:	00912223          	sw	s1,4(sp)
80000320:	01010413          	addi	s0,sp,16
80000324:	00050493          	mv	s1,a0
80000328:	00002517          	auipc	a0,0x2
8000032c:	8f050513          	addi	a0,a0,-1808 # 80001c18 <console_lock>
80000330:	5e8000ef          	jal	80000918 <acquire>
80000334:	0004c503          	lbu	a0,0(s1)
80000338:	00050a63          	beqz	a0,8000034c <console_puts+0x3c>
8000033c:	00148493          	addi	s1,s1,1
80000340:	f9dff0ef          	jal	800002dc <console_putc>
80000344:	0004c503          	lbu	a0,0(s1)
80000348:	fe051ae3          	bnez	a0,8000033c <console_puts+0x2c>
8000034c:	00002517          	auipc	a0,0x2
80000350:	8cc50513          	addi	a0,a0,-1844 # 80001c18 <console_lock>
80000354:	608000ef          	jal	8000095c <release>
80000358:	00c12083          	lw	ra,12(sp)
8000035c:	00812403          	lw	s0,8(sp)
80000360:	00412483          	lw	s1,4(sp)
80000364:	01010113          	addi	sp,sp,16
80000368:	00008067          	ret

8000036c <memset>:
8000036c:	ff010113          	addi	sp,sp,-16
80000370:	00812623          	sw	s0,12(sp)
80000374:	01010413          	addi	s0,sp,16
80000378:	00060c63          	beqz	a2,80000390 <memset+0x24>
8000037c:	00c50633          	add	a2,a0,a2
80000380:	00050793          	mv	a5,a0
80000384:	00178793          	addi	a5,a5,1
80000388:	feb78fa3          	sb	a1,-1(a5)
8000038c:	fef61ce3          	bne	a2,a5,80000384 <memset+0x18>
80000390:	00c12403          	lw	s0,12(sp)
80000394:	01010113          	addi	sp,sp,16
80000398:	00008067          	ret

8000039c <memcpy>:
8000039c:	ff010113          	addi	sp,sp,-16
800003a0:	00812623          	sw	s0,12(sp)
800003a4:	01010413          	addi	s0,sp,16
800003a8:	02060063          	beqz	a2,800003c8 <memcpy+0x2c>
800003ac:	00c50633          	add	a2,a0,a2
800003b0:	00050793          	mv	a5,a0
800003b4:	00158593          	addi	a1,a1,1
800003b8:	00178793          	addi	a5,a5,1
800003bc:	fff5c703          	lbu	a4,-1(a1)
800003c0:	fee78fa3          	sb	a4,-1(a5)
800003c4:	fef618e3          	bne	a2,a5,800003b4 <memcpy+0x18>
800003c8:	00c12403          	lw	s0,12(sp)
800003cc:	01010113          	addi	sp,sp,16
800003d0:	00008067          	ret

800003d4 <strlen>:
800003d4:	ff010113          	addi	sp,sp,-16
800003d8:	00812623          	sw	s0,12(sp)
800003dc:	01010413          	addi	s0,sp,16
800003e0:	00054783          	lbu	a5,0(a0)
800003e4:	02078463          	beqz	a5,8000040c <strlen+0x38>
800003e8:	00050713          	mv	a4,a0
800003ec:	00000513          	li	a0,0
800003f0:	00150513          	addi	a0,a0,1
800003f4:	00a707b3          	add	a5,a4,a0
800003f8:	0007c783          	lbu	a5,0(a5)
800003fc:	fe079ae3          	bnez	a5,800003f0 <strlen+0x1c>
80000400:	00c12403          	lw	s0,12(sp)
80000404:	01010113          	addi	sp,sp,16
80000408:	00008067          	ret
8000040c:	00000513          	li	a0,0
80000410:	ff1ff06f          	j	80000400 <strlen+0x2c>

80000414 <strcpy>:
80000414:	ff010113          	addi	sp,sp,-16
80000418:	00812623          	sw	s0,12(sp)
8000041c:	01010413          	addi	s0,sp,16
80000420:	0005c783          	lbu	a5,0(a1)
80000424:	02078663          	beqz	a5,80000450 <strcpy+0x3c>
80000428:	00050713          	mv	a4,a0
8000042c:	00158593          	addi	a1,a1,1
80000430:	00170713          	addi	a4,a4,1
80000434:	fef70fa3          	sb	a5,-1(a4)
80000438:	0005c783          	lbu	a5,0(a1)
8000043c:	fe0798e3          	bnez	a5,8000042c <strcpy+0x18>
80000440:	00070023          	sb	zero,0(a4)
80000444:	00c12403          	lw	s0,12(sp)
80000448:	01010113          	addi	sp,sp,16
8000044c:	00008067          	ret
80000450:	00050713          	mv	a4,a0
80000454:	fedff06f          	j	80000440 <strcpy+0x2c>

80000458 <strcmp>:
80000458:	ff010113          	addi	sp,sp,-16
8000045c:	00812623          	sw	s0,12(sp)
80000460:	01010413          	addi	s0,sp,16
80000464:	00054783          	lbu	a5,0(a0)
80000468:	02078063          	beqz	a5,80000488 <strcmp+0x30>
8000046c:	0005c703          	lbu	a4,0(a1)
80000470:	00070c63          	beqz	a4,80000488 <strcmp+0x30>
80000474:	00f71a63          	bne	a4,a5,80000488 <strcmp+0x30>
80000478:	00150513          	addi	a0,a0,1
8000047c:	00158593          	addi	a1,a1,1
80000480:	00054783          	lbu	a5,0(a0)
80000484:	fe0794e3          	bnez	a5,8000046c <strcmp+0x14>
80000488:	0005c503          	lbu	a0,0(a1)
8000048c:	40a78533          	sub	a0,a5,a0
80000490:	00c12403          	lw	s0,12(sp)
80000494:	01010113          	addi	sp,sp,16
80000498:	00008067          	ret

8000049c <printf>:
8000049c:	fa010113          	addi	sp,sp,-96
800004a0:	02112e23          	sw	ra,60(sp)
800004a4:	02812c23          	sw	s0,56(sp)
800004a8:	02912a23          	sw	s1,52(sp)
800004ac:	04010413          	addi	s0,sp,64
800004b0:	00050493          	mv	s1,a0
800004b4:	00b42223          	sw	a1,4(s0)
800004b8:	00c42423          	sw	a2,8(s0)
800004bc:	00d42623          	sw	a3,12(s0)
800004c0:	00e42823          	sw	a4,16(s0)
800004c4:	00f42a23          	sw	a5,20(s0)
800004c8:	01042c23          	sw	a6,24(s0)
800004cc:	01142e23          	sw	a7,28(s0)
800004d0:	00440793          	addi	a5,s0,4
800004d4:	fcf42623          	sw	a5,-52(s0)
800004d8:	00001517          	auipc	a0,0x1
800004dc:	74050513          	addi	a0,a0,1856 # 80001c18 <console_lock>
800004e0:	438000ef          	jal	80000918 <acquire>
800004e4:	0004c503          	lbu	a0,0(s1)
800004e8:	06050663          	beqz	a0,80000554 <printf+0xb8>
800004ec:	03212823          	sw	s2,48(sp)
800004f0:	03312623          	sw	s3,44(sp)
800004f4:	03412423          	sw	s4,40(sp)
800004f8:	03512223          	sw	s5,36(sp)
800004fc:	03612023          	sw	s6,32(sp)
80000500:	01712e23          	sw	s7,28(sp)
80000504:	01812c23          	sw	s8,24(sp)
80000508:	02500993          	li	s3,37
8000050c:	06400a13          	li	s4,100
80000510:	07300a93          	li	s5,115
80000514:	1240006f          	j	80000638 <printf+0x19c>
80000518:	00078c63          	beqz	a5,80000530 <printf+0x94>
8000051c:	02500713          	li	a4,37
80000520:	10e79663          	bne	a5,a4,8000062c <printf+0x190>
80000524:	02500513          	li	a0,37
80000528:	db5ff0ef          	jal	800002dc <console_putc>
8000052c:	1000006f          	j	8000062c <printf+0x190>
80000530:	02500513          	li	a0,37
80000534:	da9ff0ef          	jal	800002dc <console_putc>
80000538:	03012903          	lw	s2,48(sp)
8000053c:	02c12983          	lw	s3,44(sp)
80000540:	02812a03          	lw	s4,40(sp)
80000544:	02412a83          	lw	s5,36(sp)
80000548:	02012b03          	lw	s6,32(sp)
8000054c:	01c12b83          	lw	s7,28(sp)
80000550:	01812c03          	lw	s8,24(sp)
80000554:	00001517          	auipc	a0,0x1
80000558:	6c450513          	addi	a0,a0,1732 # 80001c18 <console_lock>
8000055c:	400000ef          	jal	8000095c <release>
80000560:	03c12083          	lw	ra,60(sp)
80000564:	03812403          	lw	s0,56(sp)
80000568:	03412483          	lw	s1,52(sp)
8000056c:	06010113          	addi	sp,sp,96
80000570:	00008067          	ret
80000574:	fcc42783          	lw	a5,-52(s0)
80000578:	00478713          	addi	a4,a5,4
8000057c:	fce42623          	sw	a4,-52(s0)
80000580:	0007a483          	lw	s1,0(a5)
80000584:	0004c503          	lbu	a0,0(s1)
80000588:	0a050263          	beqz	a0,8000062c <printf+0x190>
8000058c:	d51ff0ef          	jal	800002dc <console_putc>
80000590:	00148493          	addi	s1,s1,1
80000594:	0004c503          	lbu	a0,0(s1)
80000598:	fe051ae3          	bnez	a0,8000058c <printf+0xf0>
8000059c:	0900006f          	j	8000062c <printf+0x190>
800005a0:	fcc42783          	lw	a5,-52(s0)
800005a4:	00478713          	addi	a4,a5,4
800005a8:	fce42623          	sw	a4,-52(s0)
800005ac:	0007ab03          	lw	s6,0(a5)
800005b0:	040b4e63          	bltz	s6,8000060c <printf+0x170>
800005b4:	00900793          	li	a5,9
800005b8:	0767d263          	bge	a5,s6,8000061c <printf+0x180>
800005bc:	00100493          	li	s1,1
800005c0:	00900713          	li	a4,9
800005c4:	00249793          	slli	a5,s1,0x2
800005c8:	009787b3          	add	a5,a5,s1
800005cc:	00179793          	slli	a5,a5,0x1
800005d0:	00078493          	mv	s1,a5
800005d4:	02fb47b3          	div	a5,s6,a5
800005d8:	fef746e3          	blt	a4,a5,800005c4 <printf+0x128>
800005dc:	04905863          	blez	s1,8000062c <printf+0x190>
800005e0:	00a00c13          	li	s8,10
800005e4:	00900b93          	li	s7,9
800005e8:	029b4533          	div	a0,s6,s1
800005ec:	03050513          	addi	a0,a0,48
800005f0:	0ff57513          	zext.b	a0,a0
800005f4:	ce9ff0ef          	jal	800002dc <console_putc>
800005f8:	029b6b33          	rem	s6,s6,s1
800005fc:	00048793          	mv	a5,s1
80000600:	0384c4b3          	div	s1,s1,s8
80000604:	fefbc2e3          	blt	s7,a5,800005e8 <printf+0x14c>
80000608:	0240006f          	j	8000062c <printf+0x190>
8000060c:	02d00513          	li	a0,45
80000610:	ccdff0ef          	jal	800002dc <console_putc>
80000614:	41600b33          	neg	s6,s6
80000618:	f9dff06f          	j	800005b4 <printf+0x118>
8000061c:	00100493          	li	s1,1
80000620:	fc1ff06f          	j	800005e0 <printf+0x144>
80000624:	cb9ff0ef          	jal	800002dc <console_putc>
80000628:	00048913          	mv	s2,s1
8000062c:	00190493          	addi	s1,s2,1
80000630:	00194503          	lbu	a0,1(s2)
80000634:	06050263          	beqz	a0,80000698 <printf+0x1fc>
80000638:	ff3516e3          	bne	a0,s3,80000624 <printf+0x188>
8000063c:	00148913          	addi	s2,s1,1
80000640:	0014c783          	lbu	a5,1(s1)
80000644:	f5478ee3          	beq	a5,s4,800005a0 <printf+0x104>
80000648:	ecfa78e3          	bgeu	s4,a5,80000518 <printf+0x7c>
8000064c:	f35784e3          	beq	a5,s5,80000574 <printf+0xd8>
80000650:	07800713          	li	a4,120
80000654:	fce79ce3          	bne	a5,a4,8000062c <printf+0x190>
80000658:	fcc42783          	lw	a5,-52(s0)
8000065c:	00478713          	addi	a4,a5,4
80000660:	fce42623          	sw	a4,-52(s0)
80000664:	0007ac03          	lw	s8,0(a5)
80000668:	01c00493          	li	s1,28
8000066c:	00001b97          	auipc	s7,0x1
80000670:	d40b8b93          	addi	s7,s7,-704 # 800013ac <trap+0x1c0>
80000674:	ffc00b13          	li	s6,-4
80000678:	409c57b3          	sra	a5,s8,s1
8000067c:	00f7f793          	andi	a5,a5,15
80000680:	00fb87b3          	add	a5,s7,a5
80000684:	0007c503          	lbu	a0,0(a5)
80000688:	c55ff0ef          	jal	800002dc <console_putc>
8000068c:	ffc48493          	addi	s1,s1,-4
80000690:	ff6494e3          	bne	s1,s6,80000678 <printf+0x1dc>
80000694:	f99ff06f          	j	8000062c <printf+0x190>
80000698:	03012903          	lw	s2,48(sp)
8000069c:	02c12983          	lw	s3,44(sp)
800006a0:	02812a03          	lw	s4,40(sp)
800006a4:	02412a83          	lw	s5,36(sp)
800006a8:	02012b03          	lw	s6,32(sp)
800006ac:	01c12b83          	lw	s7,28(sp)
800006b0:	01812c03          	lw	s8,24(sp)
800006b4:	ea1ff06f          	j	80000554 <printf+0xb8>

800006b8 <task_a>:
800006b8:	ff010113          	addi	sp,sp,-16
800006bc:	00112623          	sw	ra,12(sp)
800006c0:	00812423          	sw	s0,8(sp)
800006c4:	00912223          	sw	s1,4(sp)
800006c8:	01212023          	sw	s2,0(sp)
800006cc:	01010413          	addi	s0,sp,16
800006d0:	320000ef          	jal	800009f0 <current_task>
800006d4:	00050493          	mv	s1,a0
800006d8:	350000ef          	jal	80000a28 <init_task>
800006dc:	00448493          	addi	s1,s1,4
800006e0:	00001917          	auipc	s2,0x1
800006e4:	ce090913          	addi	s2,s2,-800 # 800013c0 <trap+0x1d4>
800006e8:	00020613          	mv	a2,tp
800006ec:	00048593          	mv	a1,s1
800006f0:	00090513          	mv	a0,s2
800006f4:	da9ff0ef          	jal	8000049c <printf>
800006f8:	02faf7b7          	lui	a5,0x2faf
800006fc:	08078793          	addi	a5,a5,128 # 2faf080 <boot-0x7d050f80>
80000700:	00000013          	nop
80000704:	fff78793          	addi	a5,a5,-1
80000708:	fe079ce3          	bnez	a5,80000700 <task_a+0x48>
8000070c:	fddff06f          	j	800006e8 <task_a+0x30>

80000710 <task_b>:
80000710:	ff010113          	addi	sp,sp,-16
80000714:	00112623          	sw	ra,12(sp)
80000718:	00812423          	sw	s0,8(sp)
8000071c:	00912223          	sw	s1,4(sp)
80000720:	01010413          	addi	s0,sp,16
80000724:	00020493          	mv	s1,tp
80000728:	300000ef          	jal	80000a28 <init_task>
8000072c:	00048593          	mv	a1,s1
80000730:	00001517          	auipc	a0,0x1
80000734:	ca450513          	addi	a0,a0,-860 # 800013d4 <trap+0x1e8>
80000738:	d65ff0ef          	jal	8000049c <printf>
8000073c:	00500513          	li	a0,5
80000740:	099000ef          	jal	80000fd8 <sleep>
80000744:	00048593          	mv	a1,s1
80000748:	00001517          	auipc	a0,0x1
8000074c:	cb450513          	addi	a0,a0,-844 # 800013fc <trap+0x210>
80000750:	d4dff0ef          	jal	8000049c <printf>
80000754:	00000513          	li	a0,0
80000758:	255000ef          	jal	800011ac <terminate>
8000075c:	00c12083          	lw	ra,12(sp)
80000760:	00812403          	lw	s0,8(sp)
80000764:	00412483          	lw	s1,4(sp)
80000768:	01010113          	addi	sp,sp,16
8000076c:	00008067          	ret

80000770 <kernel_main>:
80000770:	ff010113          	addi	sp,sp,-16
80000774:	00112623          	sw	ra,12(sp)
80000778:	00812423          	sw	s0,8(sp)
8000077c:	01010413          	addi	s0,sp,16
80000780:	00020793          	mv	a5,tp
80000784:	02078663          	beqz	a5,800007b0 <kernel_main+0x40>
80000788:	00001717          	auipc	a4,0x1
8000078c:	49470713          	addi	a4,a4,1172 # 80001c1c <ready>
80000790:	00072783          	lw	a5,0(a4)
80000794:	fe078ee3          	beqz	a5,80000790 <kernel_main+0x20>
80000798:	0330000f          	fence	rw,rw
8000079c:	450000ef          	jal	80000bec <scheduler>
800007a0:	00c12083          	lw	ra,12(sp)
800007a4:	00812403          	lw	s0,8(sp)
800007a8:	01010113          	addi	sp,sp,16
800007ac:	00008067          	ret
800007b0:	1dc000ef          	jal	8000098c <init_tasks>
800007b4:	00000597          	auipc	a1,0x0
800007b8:	f0458593          	addi	a1,a1,-252 # 800006b8 <task_a>
800007bc:	00001517          	auipc	a0,0x1
800007c0:	c6c50513          	addi	a0,a0,-916 # 80001428 <trap+0x23c>
800007c4:	29c000ef          	jal	80000a60 <create_task>
800007c8:	00001517          	auipc	a0,0x1
800007cc:	c6450513          	addi	a0,a0,-924 # 8000142c <trap+0x240>
800007d0:	ccdff0ef          	jal	8000049c <printf>
800007d4:	00000597          	auipc	a1,0x0
800007d8:	f3c58593          	addi	a1,a1,-196 # 80000710 <task_b>
800007dc:	00001517          	auipc	a0,0x1
800007e0:	c6450513          	addi	a0,a0,-924 # 80001440 <trap+0x254>
800007e4:	27c000ef          	jal	80000a60 <create_task>
800007e8:	00001517          	auipc	a0,0x1
800007ec:	c5c50513          	addi	a0,a0,-932 # 80001444 <trap+0x258>
800007f0:	cadff0ef          	jal	8000049c <printf>
800007f4:	00000597          	auipc	a1,0x0
800007f8:	ec458593          	addi	a1,a1,-316 # 800006b8 <task_a>
800007fc:	00001517          	auipc	a0,0x1
80000800:	c5c50513          	addi	a0,a0,-932 # 80001458 <trap+0x26c>
80000804:	25c000ef          	jal	80000a60 <create_task>
80000808:	00001517          	auipc	a0,0x1
8000080c:	c5450513          	addi	a0,a0,-940 # 8000145c <trap+0x270>
80000810:	c8dff0ef          	jal	8000049c <printf>
80000814:	0330000f          	fence	rw,rw
80000818:	00100793          	li	a5,1
8000081c:	00001717          	auipc	a4,0x1
80000820:	40f72023          	sw	a5,1024(a4) # 80001c1c <ready>
80000824:	f65ff06f          	j	80000788 <kernel_main+0x18>

80000828 <push_irq_off>:
80000828:	ff010113          	addi	sp,sp,-16
8000082c:	00812623          	sw	s0,12(sp)
80000830:	01010413          	addi	s0,sp,16
80000834:	10002673          	csrr	a2,sstatus
80000838:	00020713          	mv	a4,tp
8000083c:	10017073          	csrci	sstatus,2
80000840:	00471793          	slli	a5,a4,0x4
80000844:	00e787b3          	add	a5,a5,a4
80000848:	00279793          	slli	a5,a5,0x2
8000084c:	00001697          	auipc	a3,0x1
80000850:	3d468693          	addi	a3,a3,980 # 80001c20 <cpus_state>
80000854:	00f687b3          	add	a5,a3,a5
80000858:	0007a683          	lw	a3,0(a5)
8000085c:	02069463          	bnez	a3,80000884 <push_irq_off+0x5c>
80000860:	00471793          	slli	a5,a4,0x4
80000864:	00e787b3          	add	a5,a5,a4
80000868:	00279793          	slli	a5,a5,0x2
8000086c:	00001597          	auipc	a1,0x1
80000870:	3b458593          	addi	a1,a1,948 # 80001c20 <cpus_state>
80000874:	00f587b3          	add	a5,a1,a5
80000878:	00165613          	srli	a2,a2,0x1
8000087c:	00167613          	andi	a2,a2,1
80000880:	00c7a223          	sw	a2,4(a5)
80000884:	00471793          	slli	a5,a4,0x4
80000888:	00e787b3          	add	a5,a5,a4
8000088c:	00279793          	slli	a5,a5,0x2
80000890:	00001717          	auipc	a4,0x1
80000894:	39070713          	addi	a4,a4,912 # 80001c20 <cpus_state>
80000898:	00f707b3          	add	a5,a4,a5
8000089c:	00168693          	addi	a3,a3,1
800008a0:	00d7a023          	sw	a3,0(a5)
800008a4:	00c12403          	lw	s0,12(sp)
800008a8:	01010113          	addi	sp,sp,16
800008ac:	00008067          	ret

800008b0 <pop_irq_off>:
800008b0:	ff010113          	addi	sp,sp,-16
800008b4:	00812623          	sw	s0,12(sp)
800008b8:	01010413          	addi	s0,sp,16
800008bc:	00020693          	mv	a3,tp
800008c0:	00469793          	slli	a5,a3,0x4
800008c4:	00d787b3          	add	a5,a5,a3
800008c8:	00279793          	slli	a5,a5,0x2
800008cc:	00001717          	auipc	a4,0x1
800008d0:	35470713          	addi	a4,a4,852 # 80001c20 <cpus_state>
800008d4:	00f70733          	add	a4,a4,a5
800008d8:	00072783          	lw	a5,0(a4)
800008dc:	fff78793          	addi	a5,a5,-1
800008e0:	00f72023          	sw	a5,0(a4)
800008e4:	02079463          	bnez	a5,8000090c <pop_irq_off+0x5c>
800008e8:	00469793          	slli	a5,a3,0x4
800008ec:	00d787b3          	add	a5,a5,a3
800008f0:	00279793          	slli	a5,a5,0x2
800008f4:	00001717          	auipc	a4,0x1
800008f8:	32c70713          	addi	a4,a4,812 # 80001c20 <cpus_state>
800008fc:	00f707b3          	add	a5,a4,a5
80000900:	0047a783          	lw	a5,4(a5)
80000904:	00078463          	beqz	a5,8000090c <pop_irq_off+0x5c>
80000908:	10016073          	csrsi	sstatus,2
8000090c:	00c12403          	lw	s0,12(sp)
80000910:	01010113          	addi	sp,sp,16
80000914:	00008067          	ret

80000918 <acquire>:
80000918:	ff010113          	addi	sp,sp,-16
8000091c:	00112623          	sw	ra,12(sp)
80000920:	00812423          	sw	s0,8(sp)
80000924:	00912223          	sw	s1,4(sp)
80000928:	01010413          	addi	s0,sp,16
8000092c:	00050493          	mv	s1,a0
80000930:	ef9ff0ef          	jal	80000828 <push_irq_off>
80000934:	00100713          	li	a4,1
80000938:	00070793          	mv	a5,a4
8000093c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
80000940:	fe079ce3          	bnez	a5,80000938 <acquire+0x20>
80000944:	0330000f          	fence	rw,rw
80000948:	00c12083          	lw	ra,12(sp)
8000094c:	00812403          	lw	s0,8(sp)
80000950:	00412483          	lw	s1,4(sp)
80000954:	01010113          	addi	sp,sp,16
80000958:	00008067          	ret

8000095c <release>:
8000095c:	ff010113          	addi	sp,sp,-16
80000960:	00112623          	sw	ra,12(sp)
80000964:	00812423          	sw	s0,8(sp)
80000968:	01010413          	addi	s0,sp,16
8000096c:	0330000f          	fence	rw,rw
80000970:	0310000f          	fence	rw,w
80000974:	00052023          	sw	zero,0(a0)
80000978:	f39ff0ef          	jal	800008b0 <pop_irq_off>
8000097c:	00c12083          	lw	ra,12(sp)
80000980:	00812403          	lw	s0,8(sp)
80000984:	01010113          	addi	sp,sp,16
80000988:	00008067          	ret

8000098c <init_tasks>:
8000098c:	ff010113          	addi	sp,sp,-16
80000990:	00812623          	sw	s0,12(sp)
80000994:	01010413          	addi	s0,sp,16
80000998:	00001797          	auipc	a5,0x1
8000099c:	28878793          	addi	a5,a5,648 # 80001c20 <cpus_state>
800009a0:	0007a423          	sw	zero,8(a5)
800009a4:	0407a623          	sw	zero,76(a5)
800009a8:	0807a823          	sw	zero,144(a5)
800009ac:	0c07aa23          	sw	zero,212(a5)
800009b0:	00001797          	auipc	a5,0x1
800009b4:	3d878793          	addi	a5,a5,984 # 80001d88 <tasks+0x58>
800009b8:	00012597          	auipc	a1,0x12
800009bc:	e9058593          	addi	a1,a1,-368 # 80012848 <__bss_end+0x4c>
800009c0:	00001637          	lui	a2,0x1
800009c4:	04c60613          	addi	a2,a2,76 # 104c <boot-0x7fffefb4>
800009c8:	000016b7          	lui	a3,0x1
800009cc:	0ac68693          	addi	a3,a3,172 # 10ac <boot-0x7fffef54>
800009d0:	0007a023          	sw	zero,0(a5)
800009d4:	00c78733          	add	a4,a5,a2
800009d8:	00072023          	sw	zero,0(a4)
800009dc:	00d787b3          	add	a5,a5,a3
800009e0:	feb798e3          	bne	a5,a1,800009d0 <init_tasks+0x44>
800009e4:	00c12403          	lw	s0,12(sp)
800009e8:	01010113          	addi	sp,sp,16
800009ec:	00008067          	ret

800009f0 <current_task>:
800009f0:	ff010113          	addi	sp,sp,-16
800009f4:	00812623          	sw	s0,12(sp)
800009f8:	01010413          	addi	s0,sp,16
800009fc:	00020713          	mv	a4,tp
80000a00:	00471793          	slli	a5,a4,0x4
80000a04:	00e787b3          	add	a5,a5,a4
80000a08:	00279793          	slli	a5,a5,0x2
80000a0c:	00001717          	auipc	a4,0x1
80000a10:	21470713          	addi	a4,a4,532 # 80001c20 <cpus_state>
80000a14:	00f707b3          	add	a5,a4,a5
80000a18:	0087a503          	lw	a0,8(a5)
80000a1c:	00c12403          	lw	s0,12(sp)
80000a20:	01010113          	addi	sp,sp,16
80000a24:	00008067          	ret

80000a28 <init_task>:
80000a28:	ff010113          	addi	sp,sp,-16
80000a2c:	00112623          	sw	ra,12(sp)
80000a30:	00812423          	sw	s0,8(sp)
80000a34:	01010413          	addi	s0,sp,16
80000a38:	fb9ff0ef          	jal	800009f0 <current_task>
80000a3c:	000017b7          	lui	a5,0x1
80000a40:	0a478793          	addi	a5,a5,164 # 10a4 <boot-0x7fffef5c>
80000a44:	00f50533          	add	a0,a0,a5
80000a48:	f15ff0ef          	jal	8000095c <release>
80000a4c:	10016073          	csrsi	sstatus,2
80000a50:	00c12083          	lw	ra,12(sp)
80000a54:	00812403          	lw	s0,8(sp)
80000a58:	01010113          	addi	sp,sp,16
80000a5c:	00008067          	ret

80000a60 <create_task>:
80000a60:	fd010113          	addi	sp,sp,-48
80000a64:	02112623          	sw	ra,44(sp)
80000a68:	02812423          	sw	s0,40(sp)
80000a6c:	02912223          	sw	s1,36(sp)
80000a70:	03212023          	sw	s2,32(sp)
80000a74:	01312e23          	sw	s3,28(sp)
80000a78:	01412c23          	sw	s4,24(sp)
80000a7c:	01512a23          	sw	s5,20(sp)
80000a80:	01612823          	sw	s6,16(sp)
80000a84:	01712623          	sw	s7,12(sp)
80000a88:	01812423          	sw	s8,8(sp)
80000a8c:	03010413          	addi	s0,sp,48
80000a90:	00050a13          	mv	s4,a0
80000a94:	00058b93          	mv	s7,a1
80000a98:	00002497          	auipc	s1,0x2
80000a9c:	33c48493          	addi	s1,s1,828 # 80002dd4 <tasks+0x10a4>
80000aa0:	00000913          	li	s2,0
80000aa4:	fffffab7          	lui	s5,0xfffff
80000aa8:	fb4a8a93          	addi	s5,s5,-76 # ffffefb4 <__kernel_end+0x7ffeafb4>
80000aac:	00001b37          	lui	s6,0x1
80000ab0:	0acb0b13          	addi	s6,s6,172 # 10ac <boot-0x7fffef54>
80000ab4:	01000c13          	li	s8,16
80000ab8:	0180006f          	j	80000ad0 <create_task+0x70>
80000abc:	00048513          	mv	a0,s1
80000ac0:	e9dff0ef          	jal	8000095c <release>
80000ac4:	00190913          	addi	s2,s2,1
80000ac8:	016484b3          	add	s1,s1,s6
80000acc:	11890c63          	beq	s2,s8,80000be4 <create_task+0x184>
80000ad0:	00048993          	mv	s3,s1
80000ad4:	00048513          	mv	a0,s1
80000ad8:	e41ff0ef          	jal	80000918 <acquire>
80000adc:	015487b3          	add	a5,s1,s5
80000ae0:	0007a783          	lw	a5,0(a5)
80000ae4:	fc079ce3          	bnez	a5,80000abc <create_task+0x5c>
80000ae8:	000014b7          	lui	s1,0x1
80000aec:	0ac48493          	addi	s1,s1,172 # 10ac <boot-0x7fffef54>
80000af0:	029904b3          	mul	s1,s2,s1
80000af4:	00001a97          	auipc	s5,0x1
80000af8:	23ca8a93          	addi	s5,s5,572 # 80001d30 <tasks>
80000afc:	01548b33          	add	s6,s1,s5
80000b00:	06048513          	addi	a0,s1,96
80000b04:	03800613          	li	a2,56
80000b08:	00000593          	li	a1,0
80000b0c:	00aa8533          	add	a0,s5,a0
80000b10:	85dff0ef          	jal	8000036c <memset>
80000b14:	077b2023          	sw	s7,96(s6)
80000b18:	000017b7          	lui	a5,0x1
80000b1c:	09878793          	addi	a5,a5,152 # 1098 <boot-0x7fffef68>
80000b20:	00f487b3          	add	a5,s1,a5
80000b24:	015787b3          	add	a5,a5,s5
80000b28:	06fb2223          	sw	a5,100(s6)
80000b2c:	00012717          	auipc	a4,0x12
80000b30:	cc470713          	addi	a4,a4,-828 # 800127f0 <last_tid>
80000b34:	00072783          	lw	a5,0(a4)
80000b38:	00178793          	addi	a5,a5,1
80000b3c:	00f72023          	sw	a5,0(a4)
80000b40:	00fb2023          	sw	a5,0(s6)
80000b44:	000017b7          	lui	a5,0x1
80000b48:	016787b3          	add	a5,a5,s6
80000b4c:	fff00713          	li	a4,-1
80000b50:	08e7ae23          	sw	a4,156(a5) # 109c <boot-0x7fffef64>
80000b54:	0a07a023          	sw	zero,160(a5)
80000b58:	000a0513          	mv	a0,s4
80000b5c:	879ff0ef          	jal	800003d4 <strlen>
80000b60:	05100793          	li	a5,81
80000b64:	00a7d463          	bge	a5,a0,80000b6c <create_task+0x10c>
80000b68:	040a0823          	sb	zero,80(s4)
80000b6c:	00448493          	addi	s1,s1,4
80000b70:	00001a97          	auipc	s5,0x1
80000b74:	1c0a8a93          	addi	s5,s5,448 # 80001d30 <tasks>
80000b78:	000a0593          	mv	a1,s4
80000b7c:	009a8533          	add	a0,s5,s1
80000b80:	895ff0ef          	jal	80000414 <strcpy>
80000b84:	000017b7          	lui	a5,0x1
80000b88:	0ac78793          	addi	a5,a5,172 # 10ac <boot-0x7fffef54>
80000b8c:	02f907b3          	mul	a5,s2,a5
80000b90:	00fa8ab3          	add	s5,s5,a5
80000b94:	00100793          	li	a5,1
80000b98:	04faac23          	sw	a5,88(s5)
80000b9c:	000017b7          	lui	a5,0x1
80000ba0:	015787b3          	add	a5,a5,s5
80000ba4:	0a07a423          	sw	zero,168(a5) # 10a8 <boot-0x7fffef58>
80000ba8:	00098513          	mv	a0,s3
80000bac:	db1ff0ef          	jal	8000095c <release>
80000bb0:	000b0513          	mv	a0,s6
80000bb4:	02c12083          	lw	ra,44(sp)
80000bb8:	02812403          	lw	s0,40(sp)
80000bbc:	02412483          	lw	s1,36(sp)
80000bc0:	02012903          	lw	s2,32(sp)
80000bc4:	01c12983          	lw	s3,28(sp)
80000bc8:	01812a03          	lw	s4,24(sp)
80000bcc:	01412a83          	lw	s5,20(sp)
80000bd0:	01012b03          	lw	s6,16(sp)
80000bd4:	00c12b83          	lw	s7,12(sp)
80000bd8:	00812c03          	lw	s8,8(sp)
80000bdc:	03010113          	addi	sp,sp,48
80000be0:	00008067          	ret
80000be4:	00000b13          	li	s6,0
80000be8:	fc9ff06f          	j	80000bb0 <create_task+0x150>

80000bec <scheduler>:
80000bec:	fd010113          	addi	sp,sp,-48
80000bf0:	02112623          	sw	ra,44(sp)
80000bf4:	02812423          	sw	s0,40(sp)
80000bf8:	02912223          	sw	s1,36(sp)
80000bfc:	03212023          	sw	s2,32(sp)
80000c00:	01312e23          	sw	s3,28(sp)
80000c04:	01412c23          	sw	s4,24(sp)
80000c08:	01512a23          	sw	s5,20(sp)
80000c0c:	01612823          	sw	s6,16(sp)
80000c10:	01712623          	sw	s7,12(sp)
80000c14:	01812423          	sw	s8,8(sp)
80000c18:	01912223          	sw	s9,4(sp)
80000c1c:	01a12023          	sw	s10,0(sp)
80000c20:	03010413          	addi	s0,sp,48
80000c24:	00020c13          	mv	s8,tp
80000c28:	00001c97          	auipc	s9,0x1
80000c2c:	ff8c8c93          	addi	s9,s9,-8 # 80001c20 <cpus_state>
80000c30:	004c1793          	slli	a5,s8,0x4
80000c34:	01878733          	add	a4,a5,s8
80000c38:	00271713          	slli	a4,a4,0x2
80000c3c:	00ec8733          	add	a4,s9,a4
80000c40:	00072423          	sw	zero,8(a4)
80000c44:	018787b3          	add	a5,a5,s8
80000c48:	00279793          	slli	a5,a5,0x2
80000c4c:	00c78793          	addi	a5,a5,12
80000c50:	00fc8cb3          	add	s9,s9,a5
80000c54:	00070b93          	mv	s7,a4
80000c58:	fffffd37          	lui	s10,0xfffff
80000c5c:	fbcd0d13          	addi	s10,s10,-68 # ffffefbc <__kernel_end+0x7ffeafbc>
80000c60:	10016073          	csrsi	sstatus,2
80000c64:	00002497          	auipc	s1,0x2
80000c68:	17048493          	addi	s1,s1,368 # 80002dd4 <tasks+0x10a4>
80000c6c:	00001917          	auipc	s2,0x1
80000c70:	0c490913          	addi	s2,s2,196 # 80001d30 <tasks>
80000c74:	00013b17          	auipc	s6,0x13
80000c78:	c20b0b13          	addi	s6,s6,-992 # 80013894 <__stack0+0x894>
80000c7c:	00100a93          	li	s5,1
80000c80:	000019b7          	lui	s3,0x1
80000c84:	0ac98993          	addi	s3,s3,172 # 10ac <boot-0x7fffef54>
80000c88:	0180006f          	j	80000ca0 <scheduler+0xb4>
80000c8c:	000a0513          	mv	a0,s4
80000c90:	ccdff0ef          	jal	8000095c <release>
80000c94:	013484b3          	add	s1,s1,s3
80000c98:	01390933          	add	s2,s2,s3
80000c9c:	fd6482e3          	beq	s1,s6,80000c60 <scheduler+0x74>
80000ca0:	00048a13          	mv	s4,s1
80000ca4:	00048513          	mv	a0,s1
80000ca8:	c71ff0ef          	jal	80000918 <acquire>
80000cac:	05892783          	lw	a5,88(s2)
80000cb0:	fd579ee3          	bne	a5,s5,80000c8c <scheduler+0xa0>
80000cb4:	00200793          	li	a5,2
80000cb8:	04f92c23          	sw	a5,88(s2)
80000cbc:	ff84ac23          	sw	s8,-8(s1)
80000cc0:	012ba423          	sw	s2,8(s7)
80000cc4:	0004a223          	sw	zero,4(s1)
80000cc8:	01a485b3          	add	a1,s1,s10
80000ccc:	000c8513          	mv	a0,s9
80000cd0:	be0ff0ef          	jal	800000b0 <context_switch>
80000cd4:	fff00793          	li	a5,-1
80000cd8:	fef4ac23          	sw	a5,-8(s1)
80000cdc:	000ba423          	sw	zero,8(s7)
80000ce0:	fadff06f          	j	80000c8c <scheduler+0xa0>

80000ce4 <yield>:
80000ce4:	fe010113          	addi	sp,sp,-32
80000ce8:	00112e23          	sw	ra,28(sp)
80000cec:	00812c23          	sw	s0,24(sp)
80000cf0:	00912a23          	sw	s1,20(sp)
80000cf4:	01212823          	sw	s2,16(sp)
80000cf8:	01312623          	sw	s3,12(sp)
80000cfc:	01412423          	sw	s4,8(sp)
80000d00:	01512223          	sw	s5,4(sp)
80000d04:	01612023          	sw	s6,0(sp)
80000d08:	02010413          	addi	s0,sp,32
80000d0c:	00020493          	mv	s1,tp
80000d10:	00449793          	slli	a5,s1,0x4
80000d14:	009787b3          	add	a5,a5,s1
80000d18:	00279793          	slli	a5,a5,0x2
80000d1c:	00001717          	auipc	a4,0x1
80000d20:	f0470713          	addi	a4,a4,-252 # 80001c20 <cpus_state>
80000d24:	00f707b3          	add	a5,a4,a5
80000d28:	0087a903          	lw	s2,8(a5)
80000d2c:	0a090663          	beqz	s2,80000dd8 <yield+0xf4>
80000d30:	00048613          	mv	a2,s1
80000d34:	00490593          	addi	a1,s2,4
80000d38:	00000517          	auipc	a0,0x0
80000d3c:	75850513          	addi	a0,a0,1880 # 80001490 <trap+0x2a4>
80000d40:	f5cff0ef          	jal	8000049c <printf>
80000d44:	000019b7          	lui	s3,0x1
80000d48:	0a498993          	addi	s3,s3,164 # 10a4 <boot-0x7fffef5c>
80000d4c:	013909b3          	add	s3,s2,s3
80000d50:	00098513          	mv	a0,s3
80000d54:	bc5ff0ef          	jal	80000918 <acquire>
80000d58:	05892703          	lw	a4,88(s2)
80000d5c:	00200793          	li	a5,2
80000d60:	08f70a63          	beq	a4,a5,80000df4 <yield+0x110>
80000d64:	00001a97          	auipc	s5,0x1
80000d68:	ebca8a93          	addi	s5,s5,-324 # 80001c20 <cpus_state>
80000d6c:	00449a13          	slli	s4,s1,0x4
80000d70:	009a07b3          	add	a5,s4,s1
80000d74:	00279793          	slli	a5,a5,0x2
80000d78:	00fa87b3          	add	a5,s5,a5
80000d7c:	0047ab03          	lw	s6,4(a5)
80000d80:	009a05b3          	add	a1,s4,s1
80000d84:	00259593          	slli	a1,a1,0x2
80000d88:	00c58593          	addi	a1,a1,12
80000d8c:	00ba85b3          	add	a1,s5,a1
80000d90:	06090513          	addi	a0,s2,96
80000d94:	b1cff0ef          	jal	800000b0 <context_switch>
80000d98:	009a0a33          	add	s4,s4,s1
80000d9c:	002a1a13          	slli	s4,s4,0x2
80000da0:	014a8ab3          	add	s5,s5,s4
80000da4:	016aa223          	sw	s6,4(s5)
80000da8:	00098513          	mv	a0,s3
80000dac:	bb1ff0ef          	jal	8000095c <release>
80000db0:	01c12083          	lw	ra,28(sp)
80000db4:	01812403          	lw	s0,24(sp)
80000db8:	01412483          	lw	s1,20(sp)
80000dbc:	01012903          	lw	s2,16(sp)
80000dc0:	00c12983          	lw	s3,12(sp)
80000dc4:	00812a03          	lw	s4,8(sp)
80000dc8:	00412a83          	lw	s5,4(sp)
80000dcc:	00012b03          	lw	s6,0(sp)
80000dd0:	02010113          	addi	sp,sp,32
80000dd4:	00008067          	ret
80000dd8:	07b00613          	li	a2,123
80000ddc:	00000597          	auipc	a1,0x0
80000de0:	69458593          	addi	a1,a1,1684 # 80001470 <trap+0x284>
80000de4:	00000517          	auipc	a0,0x0
80000de8:	69450513          	addi	a0,a0,1684 # 80001478 <trap+0x28c>
80000dec:	eb0ff0ef          	jal	8000049c <printf>
80000df0:	0000006f          	j	80000df0 <yield+0x10c>
80000df4:	00100793          	li	a5,1
80000df8:	04f92c23          	sw	a5,88(s2)
80000dfc:	f69ff06f          	j	80000d64 <yield+0x80>

80000e00 <suspend>:
80000e00:	fd010113          	addi	sp,sp,-48
80000e04:	02112623          	sw	ra,44(sp)
80000e08:	02812423          	sw	s0,40(sp)
80000e0c:	02912223          	sw	s1,36(sp)
80000e10:	03212023          	sw	s2,32(sp)
80000e14:	01312e23          	sw	s3,28(sp)
80000e18:	01412c23          	sw	s4,24(sp)
80000e1c:	01512a23          	sw	s5,20(sp)
80000e20:	01612823          	sw	s6,16(sp)
80000e24:	01712623          	sw	s7,12(sp)
80000e28:	01812423          	sw	s8,8(sp)
80000e2c:	03010413          	addi	s0,sp,48
80000e30:	00050493          	mv	s1,a0
80000e34:	00058a93          	mv	s5,a1
80000e38:	bb9ff0ef          	jal	800009f0 <current_task>
80000e3c:	00050993          	mv	s3,a0
80000e40:	00001937          	lui	s2,0x1
80000e44:	0a490913          	addi	s2,s2,164 # 10a4 <boot-0x7fffef5c>
80000e48:	01250933          	add	s2,a0,s2
80000e4c:	00090513          	mv	a0,s2
80000e50:	ac9ff0ef          	jal	80000918 <acquire>
80000e54:	000a8513          	mv	a0,s5
80000e58:	b05ff0ef          	jal	8000095c <release>
80000e5c:	00001b37          	lui	s6,0x1
80000e60:	01698b33          	add	s6,s3,s6
80000e64:	0a9b2023          	sw	s1,160(s6) # 10a0 <boot-0x7fffef60>
80000e68:	00300793          	li	a5,3
80000e6c:	04f9ac23          	sw	a5,88(s3)
80000e70:	00020c13          	mv	s8,tp
80000e74:	00001a17          	auipc	s4,0x1
80000e78:	daca0a13          	addi	s4,s4,-596 # 80001c20 <cpus_state>
80000e7c:	004c1493          	slli	s1,s8,0x4
80000e80:	018487b3          	add	a5,s1,s8
80000e84:	00279793          	slli	a5,a5,0x2
80000e88:	00fa07b3          	add	a5,s4,a5
80000e8c:	0047ab83          	lw	s7,4(a5)
80000e90:	018487b3          	add	a5,s1,s8
80000e94:	00279793          	slli	a5,a5,0x2
80000e98:	00c78793          	addi	a5,a5,12
80000e9c:	00fa05b3          	add	a1,s4,a5
80000ea0:	06098513          	addi	a0,s3,96
80000ea4:	a0cff0ef          	jal	800000b0 <context_switch>
80000ea8:	018484b3          	add	s1,s1,s8
80000eac:	00249493          	slli	s1,s1,0x2
80000eb0:	009a0a33          	add	s4,s4,s1
80000eb4:	017a2223          	sw	s7,4(s4)
80000eb8:	0a0b2023          	sw	zero,160(s6)
80000ebc:	00090513          	mv	a0,s2
80000ec0:	a9dff0ef          	jal	8000095c <release>
80000ec4:	000a8513          	mv	a0,s5
80000ec8:	a51ff0ef          	jal	80000918 <acquire>
80000ecc:	02c12083          	lw	ra,44(sp)
80000ed0:	02812403          	lw	s0,40(sp)
80000ed4:	02412483          	lw	s1,36(sp)
80000ed8:	02012903          	lw	s2,32(sp)
80000edc:	01c12983          	lw	s3,28(sp)
80000ee0:	01812a03          	lw	s4,24(sp)
80000ee4:	01412a83          	lw	s5,20(sp)
80000ee8:	01012b03          	lw	s6,16(sp)
80000eec:	00c12b83          	lw	s7,12(sp)
80000ef0:	00812c03          	lw	s8,8(sp)
80000ef4:	03010113          	addi	sp,sp,48
80000ef8:	00008067          	ret

80000efc <wakeup>:
80000efc:	fd010113          	addi	sp,sp,-48
80000f00:	02112623          	sw	ra,44(sp)
80000f04:	02812423          	sw	s0,40(sp)
80000f08:	02912223          	sw	s1,36(sp)
80000f0c:	03212023          	sw	s2,32(sp)
80000f10:	01312e23          	sw	s3,28(sp)
80000f14:	01412c23          	sw	s4,24(sp)
80000f18:	01512a23          	sw	s5,20(sp)
80000f1c:	01612823          	sw	s6,16(sp)
80000f20:	01712623          	sw	s7,12(sp)
80000f24:	01812423          	sw	s8,8(sp)
80000f28:	01912223          	sw	s9,4(sp)
80000f2c:	03010413          	addi	s0,sp,48
80000f30:	00050c13          	mv	s8,a0
80000f34:	abdff0ef          	jal	800009f0 <current_task>
80000f38:	00050a13          	mv	s4,a0
80000f3c:	00001497          	auipc	s1,0x1
80000f40:	df448493          	addi	s1,s1,-524 # 80001d30 <tasks>
80000f44:	00002917          	auipc	s2,0x2
80000f48:	e9090913          	addi	s2,s2,-368 # 80002dd4 <tasks+0x10a4>
80000f4c:	00012a97          	auipc	s5,0x12
80000f50:	8a4a8a93          	addi	s5,s5,-1884 # 800127f0 <last_tid>
80000f54:	00300b13          	li	s6,3
80000f58:	000019b7          	lui	s3,0x1
80000f5c:	0ac98993          	addi	s3,s3,172 # 10ac <boot-0x7fffef54>
80000f60:	0180006f          	j	80000f78 <wakeup+0x7c>
80000f64:	000b8513          	mv	a0,s7
80000f68:	9f5ff0ef          	jal	8000095c <release>
80000f6c:	013484b3          	add	s1,s1,s3
80000f70:	01390933          	add	s2,s2,s3
80000f74:	03548863          	beq	s1,s5,80000fa4 <wakeup+0xa8>
80000f78:	fe9a0ae3          	beq	s4,s1,80000f6c <wakeup+0x70>
80000f7c:	00090b93          	mv	s7,s2
80000f80:	00090513          	mv	a0,s2
80000f84:	995ff0ef          	jal	80000918 <acquire>
80000f88:	0584a783          	lw	a5,88(s1)
80000f8c:	fd679ce3          	bne	a5,s6,80000f64 <wakeup+0x68>
80000f90:	ffc92783          	lw	a5,-4(s2)
80000f94:	fd8798e3          	bne	a5,s8,80000f64 <wakeup+0x68>
80000f98:	00100793          	li	a5,1
80000f9c:	04f4ac23          	sw	a5,88(s1)
80000fa0:	fc5ff06f          	j	80000f64 <wakeup+0x68>
80000fa4:	02c12083          	lw	ra,44(sp)
80000fa8:	02812403          	lw	s0,40(sp)
80000fac:	02412483          	lw	s1,36(sp)
80000fb0:	02012903          	lw	s2,32(sp)
80000fb4:	01c12983          	lw	s3,28(sp)
80000fb8:	01812a03          	lw	s4,24(sp)
80000fbc:	01412a83          	lw	s5,20(sp)
80000fc0:	01012b03          	lw	s6,16(sp)
80000fc4:	00c12b83          	lw	s7,12(sp)
80000fc8:	00812c03          	lw	s8,8(sp)
80000fcc:	00412c83          	lw	s9,4(sp)
80000fd0:	03010113          	addi	sp,sp,48
80000fd4:	00008067          	ret

80000fd8 <sleep>:
80000fd8:	ff010113          	addi	sp,sp,-16
80000fdc:	00112623          	sw	ra,12(sp)
80000fe0:	00812423          	sw	s0,8(sp)
80000fe4:	00912223          	sw	s1,4(sp)
80000fe8:	01212023          	sw	s2,0(sp)
80000fec:	01010413          	addi	s0,sp,16
80000ff0:	00050913          	mv	s2,a0
80000ff4:	9fdff0ef          	jal	800009f0 <current_task>
80000ff8:	04050c63          	beqz	a0,80001050 <sleep+0x78>
80000ffc:	00050493          	mv	s1,a0
80001000:	00011517          	auipc	a0,0x11
80001004:	7f450513          	addi	a0,a0,2036 # 800127f4 <ticks_lock>
80001008:	911ff0ef          	jal	80000918 <acquire>
8000100c:	000017b7          	lui	a5,0x1
80001010:	00f484b3          	add	s1,s1,a5
80001014:	0924ac23          	sw	s2,152(s1)
80001018:	00011597          	auipc	a1,0x11
8000101c:	7dc58593          	addi	a1,a1,2012 # 800127f4 <ticks_lock>
80001020:	00011517          	auipc	a0,0x11
80001024:	7d850513          	addi	a0,a0,2008 # 800127f8 <ticks>
80001028:	dd9ff0ef          	jal	80000e00 <suspend>
8000102c:	00011517          	auipc	a0,0x11
80001030:	7c850513          	addi	a0,a0,1992 # 800127f4 <ticks_lock>
80001034:	929ff0ef          	jal	8000095c <release>
80001038:	00c12083          	lw	ra,12(sp)
8000103c:	00812403          	lw	s0,8(sp)
80001040:	00412483          	lw	s1,4(sp)
80001044:	00012903          	lw	s2,0(sp)
80001048:	01010113          	addi	sp,sp,16
8000104c:	00008067          	ret
80001050:	0b500613          	li	a2,181
80001054:	00000597          	auipc	a1,0x0
80001058:	41c58593          	addi	a1,a1,1052 # 80001470 <trap+0x284>
8000105c:	00000517          	auipc	a0,0x0
80001060:	45050513          	addi	a0,a0,1104 # 800014ac <trap+0x2c0>
80001064:	c38ff0ef          	jal	8000049c <printf>
80001068:	0000006f          	j	80001068 <sleep+0x90>

8000106c <get_ticks>:
8000106c:	ff010113          	addi	sp,sp,-16
80001070:	00112623          	sw	ra,12(sp)
80001074:	00812423          	sw	s0,8(sp)
80001078:	00912223          	sw	s1,4(sp)
8000107c:	01010413          	addi	s0,sp,16
80001080:	00011517          	auipc	a0,0x11
80001084:	77450513          	addi	a0,a0,1908 # 800127f4 <ticks_lock>
80001088:	891ff0ef          	jal	80000918 <acquire>
8000108c:	00011497          	auipc	s1,0x11
80001090:	76c4a483          	lw	s1,1900(s1) # 800127f8 <ticks>
80001094:	00011517          	auipc	a0,0x11
80001098:	76050513          	addi	a0,a0,1888 # 800127f4 <ticks_lock>
8000109c:	8c1ff0ef          	jal	8000095c <release>
800010a0:	00048513          	mv	a0,s1
800010a4:	00c12083          	lw	ra,12(sp)
800010a8:	00812403          	lw	s0,8(sp)
800010ac:	00412483          	lw	s1,4(sp)
800010b0:	01010113          	addi	sp,sp,16
800010b4:	00008067          	ret

800010b8 <inc_ticks>:
800010b8:	fd010113          	addi	sp,sp,-48
800010bc:	02112623          	sw	ra,44(sp)
800010c0:	02812423          	sw	s0,40(sp)
800010c4:	02912223          	sw	s1,36(sp)
800010c8:	03212023          	sw	s2,32(sp)
800010cc:	01312e23          	sw	s3,28(sp)
800010d0:	01412c23          	sw	s4,24(sp)
800010d4:	01512a23          	sw	s5,20(sp)
800010d8:	01612823          	sw	s6,16(sp)
800010dc:	01712623          	sw	s7,12(sp)
800010e0:	03010413          	addi	s0,sp,48
800010e4:	00011517          	auipc	a0,0x11
800010e8:	71050513          	addi	a0,a0,1808 # 800127f4 <ticks_lock>
800010ec:	82dff0ef          	jal	80000918 <acquire>
800010f0:	00011717          	auipc	a4,0x11
800010f4:	70870713          	addi	a4,a4,1800 # 800127f8 <ticks>
800010f8:	00072783          	lw	a5,0(a4)
800010fc:	00178793          	addi	a5,a5,1 # 1001 <boot-0x7fffefff>
80001100:	00f72023          	sw	a5,0(a4)
80001104:	00002497          	auipc	s1,0x2
80001108:	cd048493          	addi	s1,s1,-816 # 80002dd4 <tasks+0x10a4>
8000110c:	00001917          	auipc	s2,0x1
80001110:	c7c90913          	addi	s2,s2,-900 # 80001d88 <tasks+0x58>
80001114:	00012b17          	auipc	s6,0x12
80001118:	780b0b13          	addi	s6,s6,1920 # 80013894 <__stack0+0x894>
8000111c:	00300a93          	li	s5,3
80001120:	00100b93          	li	s7,1
80001124:	000019b7          	lui	s3,0x1
80001128:	0ac98993          	addi	s3,s3,172 # 10ac <boot-0x7fffef54>
8000112c:	01c0006f          	j	80001148 <inc_ticks+0x90>
80001130:	01792023          	sw	s7,0(s2)
80001134:	000a0513          	mv	a0,s4
80001138:	825ff0ef          	jal	8000095c <release>
8000113c:	013484b3          	add	s1,s1,s3
80001140:	01390933          	add	s2,s2,s3
80001144:	03648863          	beq	s1,s6,80001174 <inc_ticks+0xbc>
80001148:	00048a13          	mv	s4,s1
8000114c:	00048513          	mv	a0,s1
80001150:	fc8ff0ef          	jal	80000918 <acquire>
80001154:	00092783          	lw	a5,0(s2)
80001158:	fd579ee3          	bne	a5,s5,80001134 <inc_ticks+0x7c>
8000115c:	ff44a783          	lw	a5,-12(s1)
80001160:	fc078ae3          	beqz	a5,80001134 <inc_ticks+0x7c>
80001164:	fff78793          	addi	a5,a5,-1
80001168:	fef4aa23          	sw	a5,-12(s1)
8000116c:	fc0794e3          	bnez	a5,80001134 <inc_ticks+0x7c>
80001170:	fc1ff06f          	j	80001130 <inc_ticks+0x78>
80001174:	00011517          	auipc	a0,0x11
80001178:	68050513          	addi	a0,a0,1664 # 800127f4 <ticks_lock>
8000117c:	fe0ff0ef          	jal	8000095c <release>
80001180:	02c12083          	lw	ra,44(sp)
80001184:	02812403          	lw	s0,40(sp)
80001188:	02412483          	lw	s1,36(sp)
8000118c:	02012903          	lw	s2,32(sp)
80001190:	01c12983          	lw	s3,28(sp)
80001194:	01812a03          	lw	s4,24(sp)
80001198:	01412a83          	lw	s5,20(sp)
8000119c:	01012b03          	lw	s6,16(sp)
800011a0:	00c12b83          	lw	s7,12(sp)
800011a4:	03010113          	addi	sp,sp,48
800011a8:	00008067          	ret

800011ac <terminate>:
800011ac:	ff010113          	addi	sp,sp,-16
800011b0:	00112623          	sw	ra,12(sp)
800011b4:	00812423          	sw	s0,8(sp)
800011b8:	00912223          	sw	s1,4(sp)
800011bc:	01010413          	addi	s0,sp,16
800011c0:	00050493          	mv	s1,a0
800011c4:	82dff0ef          	jal	800009f0 <current_task>
800011c8:	00400793          	li	a5,4
800011cc:	04f52c23          	sw	a5,88(a0)
800011d0:	04952e23          	sw	s1,92(a0)
800011d4:	b11ff0ef          	jal	80000ce4 <yield>
800011d8:	00c12083          	lw	ra,12(sp)
800011dc:	00812403          	lw	s0,8(sp)
800011e0:	00412483          	lw	s1,4(sp)
800011e4:	01010113          	addi	sp,sp,16
800011e8:	00008067          	ret

800011ec <trap>:
800011ec:	fd010113          	addi	sp,sp,-48
800011f0:	02112623          	sw	ra,44(sp)
800011f4:	02812423          	sw	s0,40(sp)
800011f8:	02912223          	sw	s1,36(sp)
800011fc:	03212023          	sw	s2,32(sp)
80001200:	01312e23          	sw	s3,28(sp)
80001204:	01412c23          	sw	s4,24(sp)
80001208:	01512a23          	sw	s5,20(sp)
8000120c:	01612823          	sw	s6,16(sp)
80001210:	01712623          	sw	s7,12(sp)
80001214:	03010413          	addi	s0,sp,48
80001218:	00050493          	mv	s1,a0
8000121c:	00020993          	mv	s3,tp
80001220:	00098b93          	mv	s7,s3
80001224:	14202a73          	csrr	s4,scause
80001228:	14102af3          	csrr	s5,sepc
8000122c:	10002b73          	csrr	s6,sstatus
80001230:	fc0ff0ef          	jal	800009f0 <current_task>
80001234:	00050913          	mv	s2,a0
80001238:	e35ff0ef          	jal	8000106c <get_ticks>
8000123c:	00050593          	mv	a1,a0
80001240:	0004c703          	lbu	a4,0(s1)
80001244:	0014c783          	lbu	a5,1(s1)
80001248:	00879793          	slli	a5,a5,0x8
8000124c:	00e7e7b3          	or	a5,a5,a4
80001250:	0024c703          	lbu	a4,2(s1)
80001254:	01071713          	slli	a4,a4,0x10
80001258:	00f76733          	or	a4,a4,a5
8000125c:	0034c783          	lbu	a5,3(s1)
80001260:	01879793          	slli	a5,a5,0x18
80001264:	00e7e7b3          	or	a5,a5,a4
80001268:	0e090a63          	beqz	s2,8000135c <trap+0x170>
8000126c:	00490493          	addi	s1,s2,4
80001270:	00048813          	mv	a6,s1
80001274:	000a8713          	mv	a4,s5
80001278:	000a0693          	mv	a3,s4
8000127c:	00098613          	mv	a2,s3
80001280:	00000517          	auipc	a0,0x0
80001284:	25450513          	addi	a0,a0,596 # 800014d4 <trap+0x2e8>
80001288:	a14ff0ef          	jal	8000049c <printf>
8000128c:	00200793          	li	a5,2
80001290:	06fa0c63          	beq	s4,a5,80001308 <trap+0x11c>
80001294:	800007b7          	lui	a5,0x80000
80001298:	00178793          	addi	a5,a5,1 # 80000001 <boot+0x1>
8000129c:	0efa1a63          	bne	s4,a5,80001390 <trap+0x1a4>
800012a0:	060b8063          	beqz	s7,80001300 <trap+0x114>
800012a4:	14417073          	csrci	sip,2
800012a8:	02090263          	beqz	s2,800012cc <trap+0xe0>
800012ac:	00499793          	slli	a5,s3,0x4
800012b0:	013787b3          	add	a5,a5,s3
800012b4:	00279793          	slli	a5,a5,0x2
800012b8:	00001717          	auipc	a4,0x1
800012bc:	96870713          	addi	a4,a4,-1688 # 80001c20 <cpus_state>
800012c0:	00f707b3          	add	a5,a4,a5
800012c4:	0087a783          	lw	a5,8(a5)
800012c8:	07278263          	beq	a5,s2,8000132c <trap+0x140>
800012cc:	141a9073          	csrw	sepc,s5
800012d0:	100b1073          	csrw	sstatus,s6
800012d4:	02c12083          	lw	ra,44(sp)
800012d8:	02812403          	lw	s0,40(sp)
800012dc:	02412483          	lw	s1,36(sp)
800012e0:	02012903          	lw	s2,32(sp)
800012e4:	01c12983          	lw	s3,28(sp)
800012e8:	01812a03          	lw	s4,24(sp)
800012ec:	01412a83          	lw	s5,20(sp)
800012f0:	01012b03          	lw	s6,16(sp)
800012f4:	00c12b83          	lw	s7,12(sp)
800012f8:	03010113          	addi	sp,sp,48
800012fc:	00008067          	ret
80001300:	db9ff0ef          	jal	800010b8 <inc_ticks>
80001304:	fa1ff06f          	j	800012a4 <trap+0xb8>
80001308:	000a8693          	mv	a3,s5
8000130c:	00098613          	mv	a2,s3
80001310:	00048593          	mv	a1,s1
80001314:	00000517          	auipc	a0,0x0
80001318:	20050513          	addi	a0,a0,512 # 80001514 <trap+0x328>
8000131c:	980ff0ef          	jal	8000049c <printf>
80001320:	fff00513          	li	a0,-1
80001324:	e89ff0ef          	jal	800011ac <terminate>
80001328:	f85ff06f          	j	800012ac <trap+0xc0>
8000132c:	05892703          	lw	a4,88(s2)
80001330:	00200793          	li	a5,2
80001334:	f8f71ce3          	bne	a4,a5,800012cc <trap+0xe0>
80001338:	00001737          	lui	a4,0x1
8000133c:	00e90733          	add	a4,s2,a4
80001340:	0a872783          	lw	a5,168(a4) # 10a8 <boot-0x7fffef58>
80001344:	00178793          	addi	a5,a5,1
80001348:	0af72423          	sw	a5,168(a4)
8000134c:	00300713          	li	a4,3
80001350:	f6e79ee3          	bne	a5,a4,800012cc <trap+0xe0>
80001354:	991ff0ef          	jal	80000ce4 <yield>
80001358:	f75ff06f          	j	800012cc <trap+0xe0>
8000135c:	00000817          	auipc	a6,0x0
80001360:	21480813          	addi	a6,a6,532 # 80001570 <trap+0x384>
80001364:	000a8713          	mv	a4,s5
80001368:	000a0693          	mv	a3,s4
8000136c:	00098613          	mv	a2,s3
80001370:	00000517          	auipc	a0,0x0
80001374:	16450513          	addi	a0,a0,356 # 800014d4 <trap+0x2e8>
80001378:	924ff0ef          	jal	8000049c <printf>
8000137c:	00200793          	li	a5,2
80001380:	f4fa06e3          	beq	s4,a5,800012cc <trap+0xe0>
80001384:	800007b7          	lui	a5,0x80000
80001388:	00178793          	addi	a5,a5,1 # 80000001 <boot+0x1>
8000138c:	f0fa0ae3          	beq	s4,a5,800012a0 <trap+0xb4>
80001390:	02400613          	li	a2,36
80001394:	00000597          	auipc	a1,0x0
80001398:	1b458593          	addi	a1,a1,436 # 80001548 <trap+0x35c>
8000139c:	00000517          	auipc	a0,0x0
800013a0:	1b450513          	addi	a0,a0,436 # 80001550 <trap+0x364>
800013a4:	8f8ff0ef          	jal	8000049c <printf>
800013a8:	0000006f          	j	800013a8 <trap+0x1bc>
