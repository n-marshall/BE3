close all;
clear all;

% Lecture des donn�es
load afc_out;
Fi=Fi(:,1:2);
noms_individus=noms_modalites1;

% Calcul de la matrice des distances entre chaque paire d��l�ments de cet ensemble de donn�es
Y=pdist(Fi);
Ymat=squareform(Y);

% Construction de l�arbre hi�rarchique par agr�gations successives de deux �l�ments
Z=linkage(Y);
figure, dendrogram(Z);

% Coupure de l�arbre hi�rarchique pour obtenir une partition
C=cluster(Z,3);
nbClasses=max(C);
colors=['b';'r';'g';'m';'c';'y';'k'];
figure
plot(Fi(:,1),Fi(:,2),'ok');
gname(noms_individus);
hold on
for i=1:nbClasses
    ind=find(C==i)
    plot(Fi(ind,1),Fi(ind,2),strcat(colors(i),'x'))
end