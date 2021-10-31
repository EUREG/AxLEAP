# Use this script to generate VCD from application traces

make DESIGN=aca_csu gen_vcd
make DESIGN=bcsa gen_vcd
make DESIGN=rapcla gen_vcd

make DESIGN=proposed CONFIG=11111110 gen_vcd
make DESIGN=proposed CONFIG=11111100 gen_vcd
make DESIGN=proposed CONFIG=11111000 gen_vcd
make DESIGN=proposed CONFIG=11110000 gen_vcd