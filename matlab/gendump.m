function [] = gendump(n, N, K, C, directory)
    % n = 10^n cases
    % N = arch size
    % K = block size
    % C = Config array
    % directory in single quoted strings

    n=10^n;

    fprintf("===== Architecture : %d, %d =====\n Config: [%s", N, K);
    for x = C
        fprintf("%d ", x);
    end
    fprintf("]\n\n");


    filea = fopen(string(directory)+"/num_verify_"+num2str(N)+"_"+num2str(K)+"_"+strjoin(string(C), "")+"_a.txt", "w");
    fileb = fopen(string(directory)+"/num_verify_"+num2str(N)+"_"+num2str(K)+"_"+strjoin(string(C), "")+"_b.txt", "w");
    file =  fopen(string(directory)+"/res_verify_" +num2str(N)+"_"+num2str(K)+"_"+strjoin(string(C), "")+".txt", "w");

    textprogressbar('calculating outputs: '); 
    for i=1:n
        a=randi([0,power(2,N)-1]);
        b=randi([0,power(2,N)-1]);
        
        fprintf(filea, "%s\n",dec2hex(a, N/4));
        fprintf(fileb, "%s\n",dec2hex(b, N/4));
        ans = upf_adder(a,b,N,K,C);
        fprintf(file, "%s\n",dec2hex(ans));
        
        if(mod(i,n/100*10)==0)
            textprogressbar(i/(n/100));
        end                    
    end

    fclose(filea);fclose(fileb);fclose(file);
    textprogressbar(' done!'); 
end