K = [320 0 320;
     0 320 240;
     0 0 1];
 
 p1 = [0 240 1]';
 p2 = [640 240 1]';
 
 v1 = K\p1;
 v2 = K\p2;
 
v1'*v2

 