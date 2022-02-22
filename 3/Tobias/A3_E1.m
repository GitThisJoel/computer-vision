clc

P1 = [eye(3) zeros(3,1)];
P2 = [1 1 0 0 ;0 2 0 2; 0 0 1 0]; 
t_x = [0 0 2; 0 0 0; -2 0 0];

F = t_x*P2(:,1:3);

x = [1 1 1]';

ep_line = F*x;
x1 = [2 0 1]';
x2 = [2 1 1]';
x3 = [4 2 1]';

ep_line'*x1
ep_line'*x2
ep_line'*x3