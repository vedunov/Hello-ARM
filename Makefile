/* Copyright 2010 Alex Vedunov (vedunov@bk.ru) */

/* HelloARM Makefile */

/*
 * This file is part of HelloARM.
 * HelloARM is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation version 3 of the License
 * HelloARM is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with HelloARM.  If not, see <http://www.gnu.org/licenses/>.
 */

CROSS_PATH=/home/alex/sam/arm-2007q1/bin
CROSS_PREFIX=arm-none-linux-gnueabi-
CROSS_ENV=$(CROSS_PATH)/$(CROSS_PREFIX)

CC=$(CROSS_ENV)gcc
LD=$(CROSS_ENV)ld
AS=$(CROSS_ENV)as
OBJCOPY=$(CROSS_ENV)objcopy
OBJDUMP=$(CROSS_ENV)objdump

LDFLAGS=-nostdlib -nostartfile -Ttext 21D00000
CPPFLAGS+=-I../include

APPDIR=apps
IMG=hello.bin
IMG_ELF=hello.elf
OBJS=int_vectors.o hello_main.o
VPATH+=../lib

.S.o:
	$(AS) $< -o $@
.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<


all: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $(IMG)
	cp $(IMG) $(IMG_ELF)
	$(OBJCOPY) -O binary $(IMG)
clean:
	rm -f $(OBJS) $(IMG) $(IMG_ELF) $(shell echo *~)
objdump:
	$(OBJDUMP) -d debug.o

debug.o:
	cp ../board/at91sam9260ek/dataflash/debug.o .
int_vectors.o:	int_vectors.s
hello_main.o: hello_main.s

dasm: $(IMG)
	$(OBJDUMP) -d $(IMG) -m arm
