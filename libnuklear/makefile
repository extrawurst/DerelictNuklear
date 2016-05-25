# Flags
CFLAGS = -std=c99 -pedantic -O2

ifeq ($(OS),Windows_NT)
OUTNAME = libnuklear.dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Darwin)
		OUTNAME = libnuklear.dylib
		CFLAGS += -dynamiclib
	else
		OUTNAME = libnuklear.so
		CFLAGS += -shared
	endif
endif

all: nuklear

nuklear:
	rm -f $(OUTNAME) $(OBJS)
	$(CC) $(CFLAGS) -o $(OUTNAME) libnuklear.c