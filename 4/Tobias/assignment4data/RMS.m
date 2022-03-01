function f = RMS(x,P,X)
f = sqrt(1/size(x,2)*norm(x-pflat(P*X)).^2);
end