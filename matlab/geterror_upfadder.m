function geterror_upfadder(n,N,k,c,f)
  % ERROR STATS GENERATOR
  % 
  % @param n 10^n = no of cases
  % @param N bus length/architecture
  % @param k block size (min_val=2, max_value=N/2)
  % @param f write to specified file (leave blank to avoid writing to file) --> use single quoted string
  % Prints error stats

  num=power(10,n);
  fprintf('-------------------------\ncases : %d\n\n',num)  % bits
  
  er=0;
  ed = zeros(1,num);
  red = zeros(1,num);
  
  bitsum = zeros(1, 33);

  textprogressbar('calculating outputs: '); 
  for i=1:num    
    a=randi(power(2,N)-1);
    b=randi(power(2,N)-1);

    A = upf_adder(a,b,N,k,c);   %  approximate calculation
    B = a+b;                    %  exact calculation
    
    bitsum = de2bi(A, 33, 'left-msb') + bitsum;

    if(B~=A)
        er = er+1;
        ed(i) = abs(A-B);
        red(i) = abs(A-B)/B;
    end

    if(mod(i,num/100*10)==0)
      textprogressbar(i/(num/100));
    end
  end
  textprogressbar(' Done!');


  %disp(bitsum);
  %plot(bitsum);
  
  %------------- Report generation ---------------------------
  er = (100*er)/num;     % error rate
  MED = sum(ed)/num;       % mean error distance
  NMED = MED/max(ed);    % normalised mean error distance (same as NED)
  minRED = min(red);       % min absolute relative error
  maxRED = max(red);       % max absolute relative error
  MRED = sum(red)/num;   % mean absolute relative error
  MEP = mean(red.*100);    % mean percentage error


  for i=0:1
    if i==1 && length(f)==0
      break;
    end

    if i==0
      fid = 1;
    else
      fid = fopen(f, 'a+');  % open in append mode
      disp(['Appending report to file : ' f]);
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


    if length(f)~=0 && i==1
      fclose(fid);
      disp('Done');
    end
  end

end