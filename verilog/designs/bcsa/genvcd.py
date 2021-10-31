#! /usr/bin/python3
import sys
import os

from myUtils.execute_command import *
from myUtils.splitCSV import *

def genVCD(appl:str):
    design = 'bcsa'
    config = '32_4'
    
    tag = design+'_'+config+'_'+appl

    design_dir = os.getcwd()+'/designs/'+design

    inp_file = design_dir+'/input/'+tag+'.trace'

    ofile1 = design_dir+'/split/'+tag+'_num1.txt'
    ofile2 = design_dir+'/split/'+tag+'_num2.txt'
    ofile3 = design_dir+'/split/'+tag+'_res.txt'

    testbenchfile = design_dir+'/testbench.v'
    vvpfile = design_dir+'/vvp/'+tag+'.vvp'
    vcdfile = design_dir+'/vcd/'+tag+'.vcd'

    # Split CSV
    print("Splitting CSV...\nInput:\n\t"+inp_file+'\n\nOutput File: \n'+'\t'+ofile1+'\n\t'+ofile2+'\n\t'+ofile3+'\n')
    splitCSV(inp_file, ofile1, ofile2, ofile3)

    # Compiling verilog
    print("Compiling Verilog...")
    command = ['iverilog', '-o', vvpfile, '-grelative-include']

    def getlines(ifile:str)->int:
        dump = ExecuteCommand(['wc', '-l', ifile], False)
        lines = ''
        for char in dump.stdout:    # find first space
            if char == ' ':
                break
            lines+=char
        return int(lines.strip())

    command += ['-DCASES='+str(getlines(inp_file))]
    command += ['-DFILEA='+'"'+ofile1+'"']
    command += ['-DFILEB='+'"'+ofile2+'"']
    command += ['-DFILEC='+'"'+ofile3+'"']
    command += ['-DTRACEFILE='+'"'+vcdfile+'"']
    command += [testbenchfile]
    
    ExecuteCommand(command, False)

    # Execute VVP
    print("\nExecuting vvp...")
    ExecuteCommand(['vvp', vvpfile], False)



if __name__ == "__main__":
    application = sys.argv[1]
    genVCD(application)
    