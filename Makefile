# Directories
matlab_dir = $(realpath matlab)
verilog_dir = $(realpath verilog)

# Default Target
default: clean report-error gen-dump verify-verilog

#################################################################################################
#~	help		:	Show help message
.PHONY : help
help : Makefile
	@echo "Targets:"
	@sed -n 's/^#~//p' $<



#################################################################################################
#~	clean		:	clean all autogenerated files
.PHONY : clean
clean:
	cd $(matlab_dir) && make clean



#################################################################################################
#~	report-error	:	generate error report

.PHONY: report-error
report-error: 
	cd $(matlab_dir) && make geterror



#################################################################################################
#~	getdumps	:	generate matlab dumps

.PHONY: getdumps
getdumps:
	@echo "Generating Matlab Dumps..."
	cd $(matlab_dir) && make getdumps



#################################################################################################
#~	verify		:	verify verilog with matlab generated dumps
.PHONY: verify
verify:

	@echo "verifying Verilog..."

	iverilog -Wall $(verilog_dir)/upfadder_tb.v -o temp/verify.vvp -D__ARCH_SIZE__=$1 -D__BLOCK_SIZE__=$2 -D__CONFIG__=$3
	vvp temp/verify.vvp



#################################################################################################
#~	trace		:	generate VCD trace
.PHONY: trace
trace:
	@echo "Generating VCD trace..."

	iverilog -Wall $(verilog_dir)/upfadder_tb.v -o temp/trace.vvp
	vvp temp/trace.vvp