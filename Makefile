include ./mk/defs.mk

CPPFLAGS+=-I../include

IMG=hello.bin
IMG_ELF=hello.elf
OBJS=int_vectors.o hello_main.o
VPATH+=../lib

.PHONY: apps, exc_vec

all: exc_vec app image
app image app_clean test:
	@make "$@" -C $(APPDIR)
exc_vec exc_vec_clean:
	@make "$@" -C $(EXCVECDIR)
all: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $(IMG)
	cp $(IMG) $(IMG_ELF)
	$(OBJCOPY) -O binary $(IMG)
objdump:
	$(OBJDUMP) -d debug.o

debug.o:
	cp ../board/at91sam9260ek/dataflash/debug.o .
int_vectors.o:	int_vectors.s
hello_main.o: hello_main.s

dasm: $(IMG)
	$(OBJDUMP) -d $(IMG) -m arm
