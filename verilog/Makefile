trace_dir = $(realpath trace)
dump_dir = $(realpath ../matlab/dump)

CASES = 100000

default:

.PHONY: verify
verify:
	python3 verify.py $(CASES) 32 4 1110 $(dump_dir)
	python3 verify.py $(CASES) 32 4 1100 $(dump_dir)
	python3 verify.py $(CASES) 32 4 1000 $(dump_dir)
	python3 verify.py $(CASES) 32 4 0000 $(dump_dir)

	python3 verify.py $(CASES) 32 8 10 $(dump_dir)
	python3 verify.py $(CASES) 32 8 00 $(dump_dir)

	python3 verify.py $(CASES) 32 16 0 $(dump_dir)