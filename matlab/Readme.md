# UPF based RCA Adder
This code simulates a UPF based ripple carry adder.

1. The `n` bit architecture is divided into `n/k` blocks of length `k`.
2. Each block's sum is calculated by `blocksum.m`. 
3. A perticular block is either turned off or on depending on enable signal.
4. An array of enable signals for all the blocks must be provided to select which blocks to enable.

Usage:
```matlab
>>> A = 34	% operand 1

>>> B = 45	% operand 2

>>> n = 16	% architecture size

>>> k = 4 	% block size

>>> sel = [1 1 1 0] % select signals

>>> upfadder(A, B, n, k, sel)

```

Use geterror function to generate errorstats and append to this file
```matlab
>>> n = 6  	% 10^6 cases

>>> N = 16	% architecture size

>>> k = 4 	% block size

>>> sel = [1 1 1 0] % select signals

>>> wf = true 	% append report to reports.md file

>>> geterror_upfadder(n, N, k, sel, wf)

```