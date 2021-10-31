#! /usr/bin/python3
import sys
import os

from myUtils.execute_command import *
from myUtils.splitCSV import *

def verify(appl:str):
    design = 'proposed'
    config = sys.argv[3]
    mask = sys.argv[4]

    [N, K] = config.split('_')

    if mask == 'NONE':
        print('Proveide a Mask; See makefile usage: make help')
        return
    elif len(mask) != int(int(N)/int(K)):
        print('Mask length invalid')
        return
    
    tag = design+'_'+config+'_'+appl+'_'+mask

    design_dir = os.getcwd()+'/designs/'+design

    ofile1 = design_dir+'/split/'+tag+'_num1.txt'
    ofile2 = design_dir+'/split/'+tag+'_num2.txt'
    ofile3 = design_dir+'/split/'+tag+'_res.txt'

    testbenchfile = design_dir+'/testbench.v'
    vvpfile = design_dir+'/vvp/'+tag+'.vvp'
    vcdfile = design_dir+'/vcd/'+tag+'.vcd'

    # Compiling verilog
    print("Compiling Verilog...")
    command = ['iverilog', '-o', vvpfile, '-grelative-include']
    command += ['-DARCHSIZE=32', '-DBLOCKSIZE=4']
    command += ["-DCONFIG=4'b"+mask[4:]]

    def getlines(ifile:str)->int:
        dump = ExecuteCommand(['wc', '-l', ifile], False)
        lines = ''
        for char in dump.stdout:    # find first space
            if char == ' ':
                break
            lines+=char
        return int(lines.strip())

    command += ['-DCASES='+str(getlines(ofile3))]
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
    verify(application)
    