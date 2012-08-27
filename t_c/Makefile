OS=$(shell uname)

ifeq ($(OS), Linux)
EXT_EXTENSION=.so # XXX hardcoded extension
endif

ifeq ($(OS), Darwin)
EXT_EXTENSION=.dylib
endif

TEST_EXT_SOURCES=$(shell ls *.c)
TEST_EXT_LIBS=$(shell echo $(TEST_EXT_SOURCES) | sed -e 's/[.]c/$(EXT_EXTENSION)/g')

CFLAGS+=-fPIC

%.so: %.o
	gcc -o $@ $< -shared

%.dylib: %.o
	gcc -o $@ $< -bundle -undefined dynamic_lookup

all: $(TEST_EXT_LIBS)

clean:
	rm -f *$(EXT_EXTENSION)
