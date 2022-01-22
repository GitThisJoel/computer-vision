
% A function that divides the homogenous coordinates with their last entry
% for points of any dimensionality



function f = pflat(x)
lastR = x(end,:); %the last row of x which contains the last coordinate for all the homogenous coordinates
[m n] = size(x);
f = x./repmat(lastR,m,1); % Elementwise divdes x with a matrix where all the elements in the colon is
                            % the same as the last element in the corresponding
                            % colon of x
end 

