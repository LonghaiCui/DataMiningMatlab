function [X_tilde X_residual_out] = pca(X, r)
%PCA offline anomaly detection algorithm.
%Requires the following inputs:
% Mandatory: data matrix (X), number of Principal Components(r).
% X is formated as :    [row_vector1(data in path 1) row_vector2(data in path 2) ...]
%Yields the following outputs:
% Always: PCA alarm positions.
% X_residual_out : residual which apd/spd would run on

%pca 从这里开始
%X = P; %May be X=B or X=F to refer to Bytes or Flows, instead of Packets
[T f] = size(X);

%X = X_P'; %Transpose X, if data matrix is in transposed form
X = X - repmat( mean(X,1) , size(X,1) , 1 ); %Then subtract off each dimension across all timesteps.

X

C = X'*X;%variance=1/(T-1)*(X*V)'*(X*V)

[V D] = eig(C); %Columns of V are the e-vectors % 
d = diag(D);
zzz = V;
V = fliplr(V);   %columns of V are principle components;make eigenvalue in decreasing order
d = flipud(d);   %same as above
D = diag(d); 

normSquare = sum((X*V).^2); %variance within a link

var = normSquare/sum(normSquare); %Percentage of variances; 

u = X*V;  %new axes
u = u ./ repmat( sqrt(normSquare) , size(X,1) , 1 ); %nomalize to unit length

%r=4; %Number of Principal Components  allocated to normal subspace
R = V(:,1:r);

%R = V(:,1:r);

X_hat = R*R'*X'; %Projections;
X_tilde = ( eye(size(R,1)) - R*R' ) * X';
X_state=sum(X_hat.^2,1);

%X_residual=sum(X_tilde.^2,1); 
X_residual=sum(X_hat.^2,1);

X_residual_out = X_residual;
