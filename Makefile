include ./mk/defs.mk

CPPFLAGS+=-I../include

IMG=hello.bin
IMG_ELF=hello.elf
OBJS=int_vectors.o hello_main.o
VPATH+=../lib

all: exc_vec app image
app app_clean image image_clean:
	@make "$@" -C $(APPDIR)
exc_vec exc_vec_clean:
	@make "$@" -C $(EXCVECDIR)

debug.o:
	cp ../board/at91sam9260ek/dataflash/debug.o .

dasm: $(IMG)
	$(OBJDUMP) -d $(IMG) -m arm
