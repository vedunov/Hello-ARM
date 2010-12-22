MAKEDIR?=`pwd`/..
include $(MAKEDIR)/defs.mk

exc_vec: $(EXCVECOBJ)
exc_vec_clean:
	@rm -f $(EXCVECOBJ)
