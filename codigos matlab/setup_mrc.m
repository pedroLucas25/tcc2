clear all

dt = 1e-9;
frequencia = 1e7;
c = 3e8;
lambda = c/frequencia;

num_mp = 3;
amp_mp = [1 0.7 0.5];
tau_mp = [0 1e-7 1.5e-7];

num_ant = 4;
d = lambda/4;

theta_inc = [pi/20 pi/4 11*pi/6];
