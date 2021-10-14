dump_dir = $(realpath dump)
report_file = $(realpath .)/report.md

N_CASES = 5

# Macros
define runMatlabCommand
	matlab -nodisplay -nosplash -batch $1
endef

default: 

.PHONY: clean
clean: 
	rm -rf $(dump_dir)/*
	rm -f $(report_file)

.PHONY: geterror
geterror: 
	@echo "Generating Report..."
	
	rm -f $(report_file)
	echo "## Error Report\n" > $(report_file)

	$(call runMatlabCommand,"get_all_stats($(N_CASES), '$(report_file)')")


.PHONY: gendumps
gendumps: 
	@echo "Generating Dumps..."
	$(call runMatlabCommand,"get_all_dumps($(N_CASES), '$(dump_dir)')")
