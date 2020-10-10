myarray=load('/home/newpc/Downloads/students_etudiants/students_etudiants/bilan_X.txt');
[numRows, numCols] = size(myarray);
%remplacement de mauvaises valeurs
k=1;
i=1;
vecteurDeMoyenne=[];
% récupérer les moyennes des colonnes on prenant en compte que les valeurs != -1
  for j=1:numCols
  sommeCol = 0;
  cpt = 0; moyenneCol = 0;
        for k=1:numRows
           if myarray(k,j) != -1
              sommeCol= sommeCol + myarray(k,j);
              cpt = cpt+1;
           end
        end
         moyenneCol = sommeCol / cpt; 
         vecteurDeMoyenne(j) = moyenneCol; 
    end
 % utiliser le vecteur contenant les moyennes pour remplacer les valeurs manquantes
    for j=1:numCols
        moyenneCol = vecteurDeMoyenne(j);
        for k=1:numRows
           if myarray(k,j) == -1
               myarray(k,j)=moyenneCol;
           end
        end
    end
% récupérer la matrice après imputation des données
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
title('{\bf PCA}');
xlabel('PC 1');
ylabel('PC 2');