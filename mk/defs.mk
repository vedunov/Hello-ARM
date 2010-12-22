HELLOBASEDIR=/home/alex/starterkit/Install/Bootstrap-v1.6_my/hello
APPDIR=$(HELLOBASEDIR)/apps
EXCVECDIR=$(HELLOBASEDIR)/exc_vec
MAKEDIR=$(HELLOBASEDIR)/mk

CROSS_PATH=/home/alex/sam/arm-2007q1/bin
CROSS_PREFIX=arm-none-linux-gnueabi-
CROSS_ENV=$(CROSS_PATH)/$(CROSS_PREFIX)

CC=$(CROSS_ENV)gcc
LD=$(CROSS_ENV)ld
AS=$(CROSS_ENV)as
OBJCOPY=$(CROSS_ENV)objcopy
OBJDUMP=$(CROSS_ENV)objdump

.S.o:
	$(AS) $< -o $@
.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<


