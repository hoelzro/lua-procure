TEST_EXT_DIR=t_c

test: test_extensions
	prove --exec=lua t

test_extensions:
	make -C $(TEST_EXT_DIR)

clean:
	make -C $(TEST_EXT_DIR) clean
