MAKEDIR?=`pwd`/..
include $(MAKEDIR)/defs.mk

APPSRCS_ASM=$(shell ls *.s)
APPSRCS_C=$(shell ls *.c 2>/dev/null)
APPOBJS=$(APPSRCS_ASM:.s=.o) $(APPSRCS_C:.c=.o)
EXCVECOBJ=$(EXCVECDIR)/exc_vectors.o
IMAGE_ELF=$(IMAGE:.bin=.elf)

LDFLAGS=-nostdlib -nostartfile -Ttext 21D00000

app: $(APPOBJS)
image: $(APPOBJS) $(EXCVECOBJ)
	$(LD) $(LDFLAGS) $(EXCVECOBJ) $(APPOBJS) -o $(IMAGE)
	cp $(IMAGE) $(IMAGE_ELF)
	$(OBJCOPY) -O binary $(IMAGE)
clean: image_clean app_clean
image_clean:
	@rm -f $(IMAGE) $(IMAGE_ELF)
app_clean:
	@rm -f $(APPOBJS)
