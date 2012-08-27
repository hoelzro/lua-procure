TEST_EXT_DIR=t_c

OS=$(shell uname)
export OS

test: test_extensions
	LUA_INIT='' prove --exec=lua t

test_extensions:
	make -C $(TEST_EXT_DIR)

clean:
	make -C $(TEST_EXT_DIR) clean
