clear all
close all

% Lecture des données
load villes
X=donnees(:,1:12);

% Calcul de la matrice des distances entre chaque paire d’éléments de cet ensemble de données (en
% utilisant la fonction Matlab « pdist »)
Y=pdist(X);     %On calcule le vecteur des distances avec par défaut une distance euclidienne
Ymat=squareform(Y)   %On représente le résultat sous forme de matrice

% Construction de l’arbre hiérarchique par agrégations successives de deux éléments (un utilisant la
% fonction « linkage »)
Z=linkage(Y)    %Trois colonnes : dans les deux premières on affiche l'indice des éléments qui seront agrégés
                % la troisième affiche la distance entre les éléments liés et l'indice de niveau
figure, dendrogram(Z);

% Coupure de l’arbre hiérarchique pour obtenir une partition (en utilisant la fonction « cluster »)
C=cluster(Z,1:15)
nbClasses=max(C);
colors=['b','r','g','m','c','y','k','o'];
figure
plot(X(:,1),X(:,2),'ok');
gname(noms_individus);
hold on
for i=1:nbClasses
    ind=find(C==i)
    plot(X(ind,1),X(ind,2),strcat(colors(i),'x'))
end