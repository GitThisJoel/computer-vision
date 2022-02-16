function f = depth(P,X)
f =[];
for i = 1:size(X,2)
f(:,i) = (sign(det(P(:,1:3))))/(norm(P(:,1:3),2)*X(4,i))*P(3,:)*X(:,i);
end
end