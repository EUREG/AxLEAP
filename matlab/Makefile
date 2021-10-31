#! Usage: make <Target>
#!
dump_dir = $(realpath dump)
report_dir = $(realpath report)
report_file = $(report_dir)/report.md

N_CASES = 5

# Macros
define runMatlabCommand
	matlab -nodisplay -nosplash -batch $1
endef

default: geterror getdumps
#! Targets:
# -------------------- help ---------------------
#!	help		:	print help message
.PHONY: help
help: Makefile	
	@sed -n 's/^#!//p' $<


# ------------------ clean ---------------------
#!	clean		:	Clean any existing reports
.PHONY: clean
clean: 
	rm -rf $(dump_dir)/*
	rm -rf $(report_dir)/*

# ------------------ geterror ---------------------
#!	geterror	:	Generate error reports
.PHONY: geterror
geterror:
	@echo "Generating Report..."
	
	rm -f $(report_file)
	echo "## Error Report\n" > $(report_file)

	$(call runMatlabCommand,"get_all_stats($(N_CASES), '$(report_file)')")

# ------------------ getdumps ---------------------
#!	getdumps	:	Generate MATLAB dumps for verification of Verilog Implementation
.PHONY: getdumps
getdumps:
	@echo "Generating Dumps..."
	$(call runMatlabCommand,"get_all_dumps($(N_CASES), '$(dump_dir)')")
