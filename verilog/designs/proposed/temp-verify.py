import sys


def appendFileTag(filename:str, N:int, K:int, C:str) -> str:
    filename+=str(N)+'_'+str(K)+'_'+('1'*int((N/K)/2))+C
    return filename

def verifyConfiguration(CASES:int, N:int, K:int, C:str, dump_dir:str, trace_file:str, enable_trace:bool, temp_dir:str, name_prefix:str):
    fileA = appendFileTag('"'+dump_dir+'/num_'+name_prefix+'_', N, K, C)+'_a.txt"'
    fileB = appendFileTag('"'+dump_dir+'/num_'+name_prefix+'_', N, K, C)+'_b.txt"'
    fileC = appendFileTag('"'+dump_dir+'/res_'+name_prefix+'_', N, K, C)+'.txt"'

    vvpfile = appendFileTag(temp_dir+'/verify_'+name_prefix+'_', N, K, C)+'.vvp'   

    command = ['iverilog', '-o', vvpfile, 'upfadder_tb.v']
    command += ['-DCASES='+str(CASES)]
    command += ['-DARCHSIZE='+str(N)]
    command += ['-DBLOCKSIZE='+str(K)]
    
    if enable_trace:
        command+=['-DTRACEFILE='+trace_file]
    
    command += ['-DCONFIG='+str(int((N/2)/K))+"'b"+C]
    command += ['-DFILEA='+fileA]
    command += ['-DFILEB='+fileB]
    command += ['-DFILEC='+fileC]

    print('-'*100+'\nExecuting: ', end='')
    for x in command:
        print(x, end = ' ')
    print('')

    ExecuteCommand(command, False)


helpmsg = """Usage: $ python3 verify.py [n] [N] [K] [C] [DDir] [TDir] [ET] [TEDir]
    n = number of cases
    N = archsize
    K = block size
    C = configuration string (eg: 1100, for 32, 4 configuration)
    DDir = Dump dir: directory containing matlab dumps.
    TDir = trace Dir: Directory to export traces to.
    ET = Enable trace (0:False, 1:True)
    TEDir = Temp dir: directory to store temporary files
"""


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Too few arguments; try: $ python3 verify.py help")
    elif len(sys.argv) == 2 and sys.argv[1] == 'help':
        print(helpmsg)
    else:
        n = int(sys.argv[1])
        N = int(sys.argv[2])
        K = int(sys.argv[3])
        C = sys.argv[4]
        DDir = sys.argv[5]
        TDir = sys.argv[6]
        ET = bool(sys.argv[7])
        TEDir = sys.argv[8]

        vvpfile = appendFileTag(TEDir+'/verify', N, K, C)+'.vvp'
        trace_file = appendFileTag('"'+TDir+'/trace', N, K, C)+'.vcd"'
        
        verifyConfiguration(n, N, K, C, DDir, trace_file, ET, TEDir, '')
        

        ExecuteCommand(['vvp', vvpfile], False)