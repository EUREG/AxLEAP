trace_dir = $(realpath trace)
temp_dir = $(realpath temp)
dump_dir = $(realpath ../matlab/dump)

application_dump_dir = $(realpath input)

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


.PHONY: gen-application-trace
gen-application-trace:
	#python3 verify_application.py 32 4 1110 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) aerial
	#python3 verify_application.py 32 4 1100 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) aerial
	#python3 verify_application.py 32 4 1000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) aerial
	#python3 verify_application.py 32 4 0000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) aerial

	python3 verify_application.py 32 4 1110 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) chem
	python3 verify_application.py 32 4 1100 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) chem
	python3 verify_application.py 32 4 1000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) chem
	python3 verify_application.py 32 4 0000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) chem


	python3 verify_application.py 32 4 1110 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) lena
	python3 verify_application.py 32 4 1100 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) lena
	python3 verify_application.py 32 4 1000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) lena
	python3 verify_application.py 32 4 0000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) lena


	python3 verify_application.py 32 4 1110 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) moon
	python3 verify_application.py 32 4 1100 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) moon
	python3 verify_application.py 32 4 1000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) moon
	python3 verify_application.py 32 4 0000 $(application_dump_dir) $(trace_dir) $(ENABLE_TRACE) $(temp_dir) moon
