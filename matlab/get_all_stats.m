function [] = getstats(n, f)
    % n : 10^n iterations
    % f : single quoted string specifying report file

    % 8-4
    geterror_upfadder(n, 8, 4, [1 0], f);

    % 16-4
    geterror_upfadder(n, 16, 4, [1 1 1 0], f);
    geterror_upfadder(n, 16, 4, [1 1 0 0], f);
    geterror_upfadder(n, 16, 4, [1 0 0 0], f);

    % 16-8
    geterror_upfadder(n, 16, 8, [1 0], f);

    % 32-4
    geterror_upfadder(n, 32, 4, [1 1 1 1 1 1 1 0], f);
    geterror_upfadder(n, 32, 4, [1 1 1 1 1 1 0 0], f);
    geterror_upfadder(n, 32, 4, [1 1 1 1 1 0 0 0], f);
    geterror_upfadder(n, 32, 4, [1 1 1 1 0 0 0 0], f);
    geterror_upfadder(n, 32, 4, [1 1 1 0 0 0 0 0], f);
    geterror_upfadder(n, 32, 4, [1 1 0 0 0 0 0 0], f);
    geterror_upfadder(n, 32, 4, [1 0 0 0 0 0 0 0], f);

    % 32-8
    geterror_upfadder(n, 32, 8, [1 1 1 0], f);
    geterror_upfadder(n, 32, 8, [1 1 0 0], f);
    geterror_upfadder(n, 32, 8, [1 0 0 0], f);

    % 32-16
    geterror_upfadder(n, 32, 16, [1 0], f);
end