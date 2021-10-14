function [add,carry] = fulladder(a,b,cin)
    %   Function that emulates a full adder
    
    add = xor(xor(a,b),cin);
    carry = or(and(a,b), and(xor(a,b), cin));
end