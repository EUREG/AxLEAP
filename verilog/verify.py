import sys
import subprocess

tempfilename = 'verify.vvp'

def ExecuteCommand(cmd:list, mute:bool):
    dump = subprocess.run(
        cmd , capture_output=True, text=True
    )
    if not mute and len(dump.stdout) != 0:
        print('stdout: ' + dump.stdout)
    if len(dump.stderr) != 0:
        print('stderr: '+ dump.stderr)



def verifyConfiguration(CASES:int, N:int, K:int, C:str, dump_dir:str):
    fileA = '"'+dump_dir+'/rand'+str(N)+'_'+str(K)+'_'+('1'*int((N/K)/2))+C+'_a.txt"'
    fileB = '"'+dump_dir+'/rand'+str(N)+'_'+str(K)+'_'+('1'*int((N/K)/2))+C+'_b.txt"'
    fileC = '"'+dump_dir+'/mat'+str(N)+'_'+str(K)+'_'+('1'*int((N/K)/2))+C+'_.txt"'

        
    command = ['iverilog', '-Wall', '-o', tempfilename, 'upfadder_tb.v']
    command += ['-DCASES='+str(CASES)]
    command += ['-DARCHSIZE='+str(N)]
    command += ['-DBLOCKSIZE='+str(K)]
    command += ['-DCONFIG='+C]
    command += ['-DFILEA='+fileA]
    command += ['-DFILEB='+fileB]
    command += ['-DFILEC='+fileC]

    print('-'*100+'\nExecuting: ', end='')
    for x in command:
        print(x, end = ' ')
    print('')

    ExecuteCommand(command, False)



if __name__ == "__main__":
    verifyConfiguration(int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]), sys.argv[4], sys.argv[5])
    ExecuteCommand(['vvp', tempfilename], False)