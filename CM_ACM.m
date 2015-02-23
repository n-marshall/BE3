close all;
clear all;

% Lecture des données
load acm_out;
Fi=Fi(:,1:2);

% Partition des individus en 2 classes grâce à l'algorithme kmeans
C=kmeans(Fi,2);
figure;
plot(Fi(C==1,1),Fi(C==1,2),'xr')
hold on;
plot(Fi(C==2,1),Fi(C==2,2),'xb')
gname(noms_modalites1)

% Partition des individus en classes grâce à l'algorithme kmeans
C=kmeans(Fi,3);
figure;
plot(Fi(C==1,1),Fi(C==1,2),'xr')
hold on;
plot(Fi(C==2,1),Fi(C==2,2),'xb')
hold on;
plot(Fi(C==3,1),Fi(C==3,2),'xg')
gname(noms_modalites1)