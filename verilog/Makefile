trace_dir = $(realpath trace)
temp_dir = $(realpath temp)
dump_dir = $(realpath ../matlab/dump)

CASES = 100000
ENABLE_TRACE = False

default:


.PHONY: clean
clean:
	rm -rf $(trace_dir)/*
	rm -rf $(temp_dir)/*


.PHONY: verify
verify:
	python3 verify.py $(CASES) 32 4 1110 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)
	python3 verify.py $(CASES) 32 4 1100 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)
	python3 verify.py $(CASES) 32 4 1000 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)
	python3 verify.py $(CASES) 32 4 0000 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)

	python3 verify.py $(CASES) 32 8 10 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)
	python3 verify.py $(CASES) 32 8 00 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)

	python3 verify.py $(CASES) 32 16 0 $(dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir)