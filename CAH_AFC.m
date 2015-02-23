close all;
clear all;

% Lecture des données
load afc_out;
Fi=Fi(:,1:2);
noms_individus=noms_modalites1;

% Calcul de la matrice des distances entre chaque paire d’éléments de cet ensemble de données
Y=pdist(Fi);
Ymat=squareform(Y);

% Construction de l’arbre hiérarchique par agrégations successives de deux éléments
Z=linkage(Y);
figure, dendrogram(Z);

% Coupure de l’arbre hiérarchique pour obtenir une partition
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