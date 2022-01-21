H = [1 1 0; 0 1 0; -1 0 1];
x1 = [1 0 1]';
x2 = [0 1 1]';

y1 = H*x1;
y2 = H*x2; 

n1 = null([x1'; x2']);
l1 = n1 ./ n1(end);

n2 = null([y1'; y2']);
l2 = n2 ./ n2(end);

l = (H^-1)'*l1; % == l2