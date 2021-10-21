import pandas as pd
import sys

def splitCSV(ifile:str, ofile1:str, ofile2:str, ofile3:str, Cs:int=10000):
    column_names = ['accurate_num1', 'accurate_num2', 'accurate_result', 'approximate_num1', 'approximate_num2', 'approximate_result']
    
    of1 = open(ofile1, 'w')
    of2 = open(ofile2, 'w')
    of3 = open(ofile3, 'w')
    
    with open(ifile) as infile:
        for line in infile:
            line = line.split(',')
            line[-1] = line[-1].replace('\n', '')
            
            num1 = int(line[3])
            num2 = int(line[4])
            res = int(line[5])

            of1.write(str(hex(num1)+'\n')[2:])
            of2.write(str(hex(num2)+'\n')[2:])
            of3.write(str(hex(res)+'\n')[2:])


    # curr_chunk = 0
    # for chunk in pd.read_csv(ifile, names=column_names, chunksize=Cs, skiprows=Cs+1):
    #     start = curr_chunk*Cs
    #     finish = start+len(chunk)
    #     for i in range(start, finish):
    #         of1.write(str(hex(chunk['approximate_num1'][i])[2:])+'\n')
    #         of2.write(str(hex(chunk['approximate_num2'][i])[2:])+'\n')
    #         of3.write(str(hex(chunk['approximate_result'][i])[2:])+'\n')
        
    #     curr_chunk+=1
    
    of1.close()
    of2.close()
    of3.close()
    return



if __name__ == "__main__":
    Cs = 10000
    if len(sys.argv) >= 6:
        Cs = sys.argv[5]
    splitCSV(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], int(Cs))
