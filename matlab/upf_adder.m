function Sum = upf_adder(A,B,n,k,c)
%   UPF Based RCA Adder
%
%   upf_adder(A, B, n, k);   
%       A, B are operands
%       n is architecture size
%       k is block size
%       c is the binary control signal array of size n/k

    n_blocks = n/k;

    % Preliminary checks
    if length(c) ~= n_blocks
        error('argument c of inappropriate size');
    end

    % conversion from decimal to binary
    a=de2bi(A, n, 'left-msb');
    b=de2bi(B, n, 'left-msb');

    % array initialisaton to store sum
    S=zeros(1,n);

    i=n_blocks;  % number of blocks
    carry=0;  % carry initialisation
    
    % BLOCK SUM via calling block
    while i>=1
        [S((i-1)*k+1:i*k),carry]=blocksum(a((i-1)*k+1:i*k),b((i-1)*k+1:i*k),k,carry,c(i));    
        i=i-1;
    end

    Sum = bi2de([carry, S], 'left-msb');
end