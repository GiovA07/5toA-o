/*
Simple module to show a basic Linux Kernem Module device driver.
This device driver access to the CMOS memory of the Real Time Clock (RTC) of
computer.

The RTC device exports two (one byte) ports:

 - Control port at address (I/O bus in the IBM-PC) 0x70
 - Data port at address 0x71.

The RTC device maintains the current time and date updated in CMOS memory.
You can get more details about RTC at https://wiki.osdev.org/CMOS.

Usage: See README
  
Author: Marcelo Arroyo - Universidad Nacional de Río Cuarto. 2014-2023
*/

#include <linux/module.h>
#include <linux/ioport.h>
#include <asm/io.h>
#include <linux/fs.h>		    /* for file_operations */
#include <linux/uaccess.h>      /* for copy_to_user */

#define DEFAULT_MAJOR	121

#define RTC_CONTROL_PORT    0x70
#define RTC_DATA_PORT       0x71

// Offsets in CMOS memory to get/write RTC data
#define RTC_SECONDS	    0
#define RTC_MINUTES	    2
#define RTC_HOURS       4
#define RTC_WEEKDAY 	6

MODULE_AUTHOR("The great LKM programmer");
MODULE_DESCRIPTION("Just a dummy RTC module to play with");
MODULE_LICENSE("Dual BSD/GPL");

/* MODULE PARAMETERS */
#define DEV_NAME "myrtc"
static int dev = DEFAULT_MAJOR;
/*
MODULE_PARM(dev);
MODULE_PARM_DESC(dev,"Major device number");
*/

/* PROTOTYPES */
static ssize_t rtc_read(struct file *f, char __user *buffer, size_t count, loff_t *fpos);
static unsigned char get_rtc(unsigned char addr);
static int rtc_open(struct inode *i_node, struct file *f);

/* FILE OPERATIONS */
static struct file_operations rtc_fops = {
    open: rtc_open,
    read: rtc_read
};

int init_module(void)
{
    printk("Loading module myrtc with major=%d\n", dev);

    /* reserve i/o ports */
    request_region(RTC_CONTROL_PORT, 2, "rtc_ports");

    /* Register this device driver */
    return register_chrdev(dev, DEV_NAME, &rtc_fops);
}

void cleanup_module(void)
{
    printk("Unloading module rtc\n");

    /* release port adresses */
    release_region(RTC_CONTROL_PORT, 2);

    /* Unregister this device driver */
    unregister_chrdev(dev, DEV_NAME);
}

static int rtc_open(struct inode *i_node, struct file *f)
{
    return 0;
}


static ssize_t rtc_read(struct file *f, char __user *buffer, size_t count, loff_t *fpos)
{
    unsigned char s = get_rtc(RTC_SECONDS);

    // copy data to user buffer: We have an user space virtual address
    copy_to_user(buffer, &s, 1);
    return 1;
}

static unsigned char get_rtc(unsigned char cmos_register)
{
    unsigned char result;
        
    // put offset of accessed byte in CMOS
	outb(cmos_register, RTC_CONTROL_PORT); // outb 0x70, 0
    
    // read from data port. Should wait here?
    result = inb(RTC_DATA_PORT);

    result = ((result >> 4) * 10) + (result & 0x0F);
    // result is in Binary Coded Decimal (BCD): decimal digits (0-9) encoded
    // in four bits.
    // So 00010011 in BCD, is 13 in decimal = 1101 in binary
    // To do: return value in pure binary (not BSD)
    return result;
}
