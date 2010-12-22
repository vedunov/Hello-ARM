MAKEDIR?=`pwd`/..
include $(MAKEDIR)/defs.mk

APPSRCS=$(shell ls *.s)
APPOBJS=$(APPSRCS:.s=.o)
EXCVECOBJ=$(EXCVECDIR)/exc_vectors.o
IMAGE_ELF=$(IMAGE:.bin=.elf)

LDFLAGS=-nostdlib -nostartfile -Ttext 21D00000

app: $(APPOBJS)
image: $(APPOBJS) $(EXCVECOBJ)
	@echo I am in `pwd`
	$(LD) $(LDFLAGS) $(EXCVECOBJ) $(APPOBJS) -o $(IMAGE)
	cp $(IMAGE) $(IMAGE_ELF)
	$(OBJCOPY) -O binary $(IMAGE)
image_clean:
	@rm -f $(IMAGE) $(IMAGE_ELF)
app_clean:
	@rm -f $(APPOBJS)
