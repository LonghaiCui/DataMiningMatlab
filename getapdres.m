%compile apd.c in the plateau folder first
%pass 4 for pca? -David
function ano=getapdres(X)
fp=fopen('dataapdtmp','w');
for i=1:length(X)
    fprintf(fp,'1 1 %f\n',X(i));
end
system('./apd -i dataapdtmp -o APD_dataapdtmp -swc 50');
A=load('APD_dataapdtmp');
ano=A(:,4);


end
