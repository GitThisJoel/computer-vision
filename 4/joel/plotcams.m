function plotcams(P)
%Plots the principal axes for a set of cameras. 
%P is a cell containing all the cameras.
%P{i} is a 3x4 matrix representing camera i.
c = zeros(4,length(P));
v = zeros(3,length(P));
for i = 1:length(P);
    c(:,i) = null(P{i});
    v(:,i) = sign(det(P{i}(:,1:3)))*P{i}(3,1:3);
    v(:,i) = v(:,i)./norm(v(:,i));
end
c = c./repmat(c(4,:),[4 1]);
quiver3(c(1,:),c(2,:),c(3,:),v(1,:), v(2,:), v(3,:),['r','-'],'LineWidth',1.5,'MaxHeadSize',1.5);