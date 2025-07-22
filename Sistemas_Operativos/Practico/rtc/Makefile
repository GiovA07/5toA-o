obj-m += rtc.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	rm rtc.*o rtc.mod.c
