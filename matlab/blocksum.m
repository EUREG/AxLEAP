function [Sum,cout]=blocksum(x,y,k,cin,en)
    %   Function that evaluates a single block
    %
    %   block(x,y,k,cin)
    %       param x     :   first sub input operand (in binary representation) 
    %       param y     :   second sub input operand (in binary representation)
    %       param k     :   block size
    %       param cin   :   carry out of previous block
    %
    %       returns [sum,cout] vector containing sum and carry out

    % array initialisation to store sum-bits
    Sum = zeros(1,k);
      
    % Generating k-1 sum-bits of the block
    if en == 1
        for i = k:-1:1
            [Sum(i), cin] = fulladder(x(i), y(i), cin);
        end
        cout=cin;
    else
        Sum = zeros(1,k);
        cout = 0;
    end
end