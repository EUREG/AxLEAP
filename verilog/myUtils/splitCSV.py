import sys

def splitCSV(ifile:str, ofile1:str, ofile2:str, ofile3:str):
    of1 = open(ofile1, 'w')
    of2 = open(ofile2, 'w')
    of3 = open(ofile3, 'w')
    
    with open(ifile) as infile:
        l_no=1
        for line in infile:
            tokens = line.split(',')
            tokens[-1] = tokens[-1].replace('\n', '')
            
            try:
                num1 = int(tokens[3])
                num2 = int(tokens[4])
                res = int(tokens[5])
            except:
                print("Error in line no: "+str(l_no)+": "+line)
                exit()

            of1.write(str(hex(num1)+'\n')[2:])
            of2.write(str(hex(num2)+'\n')[2:])
            of3.write(str(hex(res)+'\n')[2:])
            l_no+=1

    of1.close()
    of2.close()
    of3.close()
    return

if __name__ == "__main__":

    helpmsg = """
        Splits a CSV file into 3 verilog initialization files
        CSV format: accurate_num1, accurate_num2, accurate_result, approximate_num1, approximate_num2, approximate_result
        Output coloumns: approximate_num1, approximate_num2, approximate_result

        Arg[1] = input file (abs path)
        Arg[2] = output file 1 (abs path)
        Arg[3] = output file 1 (abs path)
        Arg[4] = output file 1 (abs path)
    """

    if len(sys.argv) != 5 :
        print(helpmsg)
    else:
        splitCSV(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])