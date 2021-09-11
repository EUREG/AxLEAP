function geterror_upfadder(n,N,k,c)
  % ERROR STATS GENERATOR
  % 
  % @param n 10^n = no of cases
  % @param N bus length/architecture
  % @param k block size (min_val=2, max_value=N/2)
  %
  % Prints error stats

  num=power(10,n);
  fprintf('-------------------------\ncases : %d\n\n',num)  % bits
  
  er=0;
  ed = zeros(1,num);
  red = zeros(1,num);

  for i=1:num    
    a=randi(power(2,N)-1);
    b=randi(power(2,N)-1);

    A = upf_adder(a,b,N,k,c);   %  approximate calculation
    B = a+b;                    %  exact calculation
    
    if(B~=A)
        er = er+1;
        ed(i) = abs(A-B);
        red(i) = abs(A-B)/B;
    end

    if(mod(i,num/100*10)==0)
      disp("Completed: " + num2str(i/(num/100))+" %");
    end
  end
  
  fprintf('\n -------------------- ERROR STATS --------------------\n');
  er = (100*er)/num     % error rate
  MED = sum(ed)/num       % mean error distance
  NMED = MED/max(ed)    % normalised mean error distance (same as NED)
  minRED=min(red)       % min absolute relative error
  maxRED=max(red)       % max absolute relative error
  MRED = sum(red)/num   % mean absolute relative error
  MEP=mean(red.*100)    % mean percentage error
  return
end