# Using Makefile
This Makefile can be used to generate VCD from end application trace

```
Usage: make DESIGN=<Design> [CONFIG=<config>][Target] 

 Designs:
        aca_csu/bcsa/rapcla/proposed

 Config:
        mask specification required only in case of proposed design

 Targets:

        help            :       print help message

        gen_vcd         :       Generate application traces

        clean_split_dir :       Clean split directory of the DESIGN
        clean_vvp_dir   :       Clean vvp directory of the DESIGN
        clean_vcd_dir   :       Clean vcd directory of the DESIGN
```

## Directory structure
1. Each design is stored in a separate folder of same name as of the design
2. Each design folder must contain following subfolders:
       1. input: contains application traces which are used as input
       2. split: each tracefile is split into three files using the splitCSV.py script, these are stored here
       3. vvp: stores temporary vvp files
       4. stores final vcd files.

## Instructions to add a new design
suppose out new design is `popye`
1. make a folder named `popye` in `verilog/designs`
2. copy `testbench.v` and `genvcd.py` from a preexisting design: {recommended:aca_csu}
3. modify lines marked with `TODO` in `testbench.v` & `genvcd.v` according to new design and trace file names.
4. create `input`, `split`, `vvp`, and `vcd` folders in `popye`.
5. copy trace files to `popye/input`.
6. now from verilog directory run `make DESIGN=popye gen_vcd` to generate vcd.
