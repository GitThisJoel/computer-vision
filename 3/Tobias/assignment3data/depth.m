function f = depth(P,X)
f = (sign(det(P(:,1:3))))/(norm(P(:,1:3),2)*X(4))*P(3,:)*X;
end