myarray=load('/home/newpc/Downloads/students_etudiants/students_etudiants/bilan_X.txt');
[numRows, numCols] = size(myarray);
%suppression de mauvaises valeurs
k=1;
i=1;
while k < numRows +1

    for j=1:numCols
        if myarray(i,j) == -1
               myarray(i,:)=[];
               i=i-1;
        end
    end
    i=i+1;
    k=k+1;
end;
X=myarray;
[numRowsX, numColsX] = size(X);
% standardisation de la matrice
Xc=X-mean(X);
Xs = Xc./repmat(std(X),numRowsX,1);
%matrice variancecovariance
V=Xs'*Xs/numRowsX-1;
% valeurs propres et vecteurs propres
[E,D]=eig(V);
[d,ind] = sort(diag(D),'descend');
Ds = D(ind,ind);
Vs = V(:,ind);
%Matrice de projection
P=Xs*E*Ds^(-1/2);
%plot sur les deux premiers axes principaux
x=P(:,1);
y1=P(:,2);
plot(x,y1,'.')
set(gca, "xaxislocation", "zero");
set(gca, "yaxislocation", "zero");
title('{\bf PCA}');
xlabel('PC 1');
ylabel('PC 2');