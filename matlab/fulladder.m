function [add,carry] = fulladder(a,b,cin)
    add = xor(xor(a,b),cin);
    carry = or(and(a,b), and(xor(a,b), cin));
end