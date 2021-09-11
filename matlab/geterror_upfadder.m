function geterror_upfadder(n,N,k,c,wf)
  % ERROR STATS GENERATOR
  % 
  % @param n 10^n = no of cases
  % @param N bus length/architecture
  % @param k block size (min_val=2, max_value=N/2)
  % @param wf write to file
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
  
  %------------- Report generation ---------------------------
  er = (100*er)/num;     % error rate
  MED = sum(ed)/num;       % mean error distance
  NMED = MED/max(ed);    % normalised mean error distance (same as NED)
  minRED = min(red);       % min absolute relative error
  maxRED = max(red);       % max absolute relative error
  MRED = sum(red)/num;   % mean absolute relative error
  MEP = mean(red.*100);    % mean percentage error


  for i=0:1
    if i==1 && wf==false
      break;
    end

    if i==0
      fid = 1;
    else
      fid = fopen('reports.md', 'a+');  % open in append mode
      disp('Writing to file : reports.md');
    end

    % Write header
    fprintf(fid, '\n## Error Stats [%s] \n', char(datetime));

    fprintf(fid, 'cases: %d; N: %d; k: %d; c: ', num, N, k);

    for j=1:length(c)
      if j == 1
        fprintf(fid, '[%d ', c(j));
      elseif j~=length(c)
        fprintf(fid, '%d ', c(j));
      else
        fprintf(fid, '%d]\n', c(j));
      end
    end

    % Write stats table
    fprintf(fid, '| Parameter   | Value\n');
    fprintf(fid, '|-------------|--------------\n');
    fprintf(fid, '| Er          | %g \n', er);
    fprintf(fid, '| MED         | %g \n', MED);
    fprintf(fid, '| NMED        | %g \n', NMED);
    fprintf(fid, '| minRED      | %g \n', minRED);
    fprintf(fid, '| maxRED      | %g \n', maxRED);
    fprintf(fid, '| MRED        | %g \n', MRED);
    fprintf(fid, '| MEP         | %g \n', MEP);


    if wf==true && i==1
      fclose(fid);
      disp('Done');
    end
  end

end