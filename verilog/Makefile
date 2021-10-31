#! Usage: make DESIGN=<Design> [CONFIG=<config>] [Target]
#!

#! Designs:
#!	aca_csu/bcsa/rapcla/proposed
#!
DESIGN = NONE

CONFIG = NONE

ARCH = 32_4

DESIGN_DIR = $(realpath designs/$(DESIGN))
SPLIT_DIR = $(DESIGN_DIR)/split
VVP_DIR = $(DESIGN_DIR)/vvp
VCD_DIR = $(DESIGN_DIR)/vcd

################################################
# Bash color codes
COLOR_RED 		= \033[0;31m
COLOR_GREEN 	= \033[0;32m
COLOR_YELLOW 	= \033[0;33m
COLOR_NC 		= \033[0m
COLOR_BLACK		= \033[0;30m

################################################

default: help
#! Config:
#!	mask specification required only in case of proposed design
#!


#! Targets:
#!

# -------------------- help ---------------------
#!	help		:	print help message
.PHONY: help
help: Makefile	
	@sed -n 's/^#!//p' $<



#!
# ------------------ verify ---------------------
#!	verify		:	Verify Verilog implementation
.PHONY: verify
verify:
	@echo "$(COLOR_GREEN) $(DESIGN) : $(ARCH) : $(CONFIG) : $(COLOR_YELLOW) Verifying Verilog Implementation...  $(COLOR_NC)"
	cp ../matlab/dump/* $(DESIGN_DIR)/split/

	./Verify.py $(DESIGN) verify $(ARCH) $(CONFIG)
	@echo "$(COLOR_GREEN) Done! $(COLOR_NC)"



#!
# ------------------ gen_vcd ---------------------
#!	gen_vcd		:	Generate application VCD traces
.PHONY: gen_vcd
gen_vcd:

	@echo "$(COLOR_GREEN) $(DESIGN) : $(CONFIG) : $(COLOR_YELLOW) Generating VCD Traces...  $(COLOR_NC)"

	@echo "$(COLOR_YELLOW)--- aerial --- $(COLOR_NC)"
	./genVCD.py $(DESIGN) aerial $(CONFIG)
	@echo "$(COLOR_GREEN) Done! $(COLOR_NC)"
	
	@echo "$(COLOR_YELLOW)--- chem --- $(COLOR_NC)"
	./genVCD.py $(DESIGN) chem $(CONFIG)
	@echo "$(COLOR_GREEN) Done! $(COLOR_NC)"

	@echo "$(COLOR_YELLOW)--- lena --- $(COLOR_NC)"
	./genVCD.py $(DESIGN) lena $(CONFIG)
	@echo "$(COLOR_GREEN) Done! $(COLOR_NC)"

	@echo "$(COLOR_YELLOW)--- moon --- $(COLOR_NC)"
	./genVCD.py $(DESIGN) moon $(CONFIG)
	@echo "$(COLOR_GREEN) Done! $(COLOR_NC)"
	




#!
# ------------------- clean ---------------------
.PHONY: clean
clean: clean_split clean_vcd_dir clean_vvp_dir
	
#!	clean_split_dir	:	Clean split directory of the DESIGN
.PHONY clean_split_dir:
clean_split:
	@echo "Cleaning Split Directory.."
	rm -rf $(SPLIT_DIR)/*

#!	clean_vvp_dir	:	Clean vvp directory of the DESIGN
.PHONY clean_vvp_dir:
clean_vvp_dir:
	@echo "Cleaning vvp Directory.."
	rm -rf $(VVP_DIR)/*

#!	clean_vcd_dir	:	Clean vcd directory of the DESIGN
.PHONY clean_vcd_dir:
clean_vcd_dir:
	@echo "Cleaning vcd Directory.."
	rm -rf $(VCD_DIR)/*