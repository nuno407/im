function [ n_bits] = ENOB(sinal, Fs)
x=sinad(sinal, Fs);
n_bits= (x-1.76)/(6.02);
end
