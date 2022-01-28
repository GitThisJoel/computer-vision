clear
A2_C3;
A2_C4;
close all

x1 = [x1;ones(1,size(x1,2))];
x2 = [x2;ones(1,size(x1,2))];
X=[];
for i=1:size(x1,2)
M = [[P1 -x1(:,i) zeros(3,1)];
    [P2 zeros(3,1) -x2(:,i)]];
[U,S,V] = svd(M);
v = V(:,end);
X=[X v(1:3,1)];
end
X = [X; ones(1,size(X,2))];
xproj1 = pflat(P1*X);
xproj2 = pflat(P2*X);

good_points = (sqrt(sum((x1(1:2,:)-xproj1(1:2,:)).^2))<3 & ...
    sqrt(sum((x2(1:2,:)-xproj2(1:2,:)).^2))<3);
X = X(:,good_points);

figure()
plot3([Xmodel(1,startind);Xmodel(1,endind)],...
    [Xmodel(2,startind);Xmodel(2,endind)],...
    [Xmodel(3,startind);Xmodel(3,endind)],'b-');
hold on
plot3(X(1,:),X(2,:),X(3,:),'b.');
