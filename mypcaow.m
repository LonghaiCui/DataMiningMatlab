%read injected data and apply PCA on it.
%flag: a- apd
%plt- 1- plot; 0-do not plot
%sen- sensitivity
%dim- dimension used to compute in PCA
%example: [canocnt uanocnt]=mypcaow(1,5,1) ***for a and s dim = 5 ***
function [canocnt uanocnt]=mypcaow(dim)
path='//Users/longhaicui/DM/injecteddata/';
f=dir(path);
A=[];
xx = length(f);
for i=3:length(f)
    xx = f(i).name;
    tmp=load([path,f(i).name]);
    if i==3
        A=tmp(:,3);
    else if size(A,1)>size(tmp,1)
            A=[A(1:size(tmp,1),:) tmp(:,3)];
        else
            A=[A tmp(1:size(A,1),3)];
        end
    end
    
end

A

[til resi]=pca(A,dim);

til 
resi

%system('apd.out -i pca_reAsi');
%A=load('APD_pca_resi');
str='APD';
det=getapdres(resi);


%ano
fs=40;
fsx=20;
ymax=8200;
xmin=0;



hold off;
%     axes('FontName','Times New Roman','FontSize',fsx);
plot(resi);
hold on
%     axis([0 ymax xmin xmax ]);
title([str,' on PCA Residual. Normal space dimension: ',num2str(dim)],'FontWeight','bold');
xlabel('Sample Number','FontWeight','bold','FontSize',fsx,'FontName','Times New Roman');
ylabel('Data Projection','FontWeight','bold','FontSize',fsx,'FontName','Times New Roman');


mksize=23;
lw=3;
star={'g^' 'rx'};
uanocnt=0; %uncorrelated anomaly
canocnt=0; %correlated anomaly
cpos=[3000 4000 5000 6000 7000];

for i=1:length(det)
    if(det(i)==2)
        pl=plot(i,resi(i),star{2});
        set(pl,'MarkerSize',mksize,'LineWidth',lw);
        
        fg=0; %uncorrelated
        for k=1:length(cpos)
		%fg used to compute whether the anomaly is correlated or not
            if(abs(i-cpos(k))<20)
                fg=1;
                break;
            end
        end
        if(fg)
        canocnt=canocnt+1;
        else
        uanocnt=uanocnt+1;
        end
    end
end

uanocnt
canocnt

end


