n = 5;
wf = true;

% 8-Bits
geterror_upfadder(n, 8, 4, [1 0], wf);

% 16-Bits
geterror_upfadder(n, 16, 4, [1 1 1 0], wf);
geterror_upfadder(n, 16, 4, [1 1 0 0], wf);
geterror_upfadder(n, 16, 4, [1 0 0 0], wf);

geterror_upfadder(n, 16, 8, [1 0], wf);

% 32-Bits
geterror_upfadder(n, 32, 4, [1 1 1 1 1 1 1 0], wf);
geterror_upfadder(n, 32, 4, [1 1 1 1 1 1 0 0], wf);
geterror_upfadder(n, 32, 4, [1 1 1 1 1 0 0 0], wf);
geterror_upfadder(n, 32, 4, [1 1 1 1 0 0 0 0], wf);
geterror_upfadder(n, 32, 4, [1 1 1 0 0 0 0 0], wf);
geterror_upfadder(n, 32, 4, [1 1 0 0 0 0 0 0], wf);
geterror_upfadder(n, 32, 4, [1 0 0 0 0 0 0 0], wf);

geterror_upfadder(n, 32, 8, [1 1 1 0], wf);
geterror_upfadder(n, 32, 8, [1 1 0 0], wf);
geterror_upfadder(n, 32, 8, [1 0 0 0], wf);

geterror_upfadder(n, 32, 16, [1 0], wf);
