from verify import *
from splittrace import *

helpmsg = """Usage: $ python3 verify-application.py [N] [K] [C] [DDir] [TDir] [ET] [TEDir]
    N = archsize
    K = block size
    C = configuration string (eg: 1100, for 32, 4 configuration)
    DDir = Dump dir: directory containing matlab dumps.
    TDir = trace Dir: Directory to export traces to.
    ET = Enable trace (0:False, 1:True)
    TEDir = Temp dir: directory to store temporary files
    trace_file_prefix: prefix for generated trace file
"""

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Too few arguments; try: $ python3 verify-application.py help")
    elif len(sys.argv) == 2 and sys.argv[1] == 'help':
        print(helpmsg)
    else:
        N = int(sys.argv[1])
        K = int(sys.argv[2])
        C = sys.argv[3]
        DDir = sys.argv[4]
        TDir = sys.argv[5]
        ET = bool(sys.argv[6])
        TEDir = sys.argv[7]
        file_prefix = sys.argv[8]

        def append_iFileTag(filename:str, prefix:str, N:int, K:int, C:str) -> str:
            filename+=str(N)+'_'+str(K)+'_'+prefix+'_'+('1'*int((N/K)/2))+C
            return filename

        # generate name for input application trace file
        iatf = append_iFileTag(DDir+'/Final_upf_', file_prefix, N, K, C)+'.trace'

        # generate name for output application trace files
        oatf1 = appendFileTag(DDir+'/num_'+file_prefix+'_', N, K, C)+'_a.txt'
        oatf2 = appendFileTag(DDir+'/num_'+file_prefix+'_', N, K, C)+'_b.txt'
        oatf3 = appendFileTag(DDir+'/res_'+file_prefix+'_', N, K, C)+'.txt'

        # get no of cases
        def get_no_of_cases(ifile:str)->int:
            dump = ExecuteCommand(['wc', '-l', ifile], False)

            # find first space
            lines = ''
            for char in dump.stdout:
                if char == ' ':
                    break
                lines+=char

            return int(lines.strip()) # ignore last line (which is blank)

        n = get_no_of_cases(iatf)

        print('Spliting CSV...')
        # Split CSV
        splitCSV(iatf, oatf1, oatf2, oatf3, 10000)

        print('Verifying & generating trace...')
        trace_file = appendFileTag('"'+TDir+'/trace_'+file_prefix+'_', N, K, C)+'.vcd"'
        verifyConfiguration(n, N, K, C, DDir, trace_file, ET, TEDir, file_prefix)

        vvpfile = appendFileTag(TEDir+'/verify_'+file_prefix+'_', N, K, C)+'.vvp'

        print('Verifying & generating trace...')
        ExecuteCommand(['vvp', vvpfile], False)