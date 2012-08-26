EXT_EXTENSION=.so # XXX hardcoded extension

TEST_EXT_SOURCES=$(shell ls *.c)
TEST_EXT_LIBS=$(shell echo $(TEST_EXT_SOURCES) | sed -e 's/[.]c/$(EXT_EXTENSION)/g')

CFLAGS+=-fPIC

%.so: %.o
	gcc -o $@ $< -shared

all: $(TEST_EXT_LIBS)

clean:
	rm -f *$(EXT_EXTENSION)
