close all;
clear all;

% Lecture des données
load acm_out;
Fi=Fi(:,1:2);

% Calcul de la matrice des distances entre chaque paire d’éléments de cet ensemble de données
Y=pdist(Fi);
Ymat=squareform(Y);

% Construction de l’arbre hiérarchique par agrégations successives de deux éléments
Z=linkage(Y);
figure, dendrogram(Z);

% Coupure de l’arbre hiérarchique en 2 pour obtenir une partition
C=cluster(Z,2);
figure;
plot(Fi(C==1,1),Fi(C==1,2),'xr')
hold on;
plot(Fi(C==2,1),Fi(C==2,2),'xb')
gname(noms_modalites1)

% Coupure de l’arbre hiérarchique en 3 pour obtenir une partition
C=cluster(Z,3);
figure;
plot(Fi(C==1,1),Fi(C==1,2),'xr')
hold on;
plot(Fi(C==2,1),Fi(C==2,2),'xb')
hold on;
plot(Fi(C==3,1),Fi(C==3,2),'xg')
gname(noms_modalites1)