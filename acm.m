close all;
clear all;
% Lecture des donn�es
load pommes;

% Construction du tableau disjonctif complet (TDC)
Xbrut=donnees;
nbModalitesParVar=max(Xbrut);
nbModalites=sum(nbModalitesParVar);
XTDC=zeros(size(Xbrut,1),nbModalites);
for i=1:size(Xbrut,1)
    for j=1:size(Xbrut,2)
        XTDC(i,sum(nbModalitesParVar(1:j-1))+Xbrut(i,j))=1;
    end
end

noms_modalites=[];
for i=1:size(Xbrut,2)
    for j=1:nbModalitesParVar(i)
        noms_modalites{length(noms_modalites)+1}=strcat(noms_variables{i},num2str(j));
    end
end



% Construction du tableau de Burt

% Calcul des matrices X, M et D
% - X : matrice calcul�e � partir du TDC
I=size(XTDC,1);
XTDC
ap=repmat(sum(XTDC),I,1)
X=size(XTDC,1)*XTDC./repmat(sum(XTDC),size(XTDC,1),1)-1;
% - D : matrice des poids des individus
D=eye(size(XTDC,1))/size(XTDC,1);
% - M : matrice des poids des modalit�s
M=diag(sum(XTDC)/size(XTDC,1)*size(Xbrut,2));

% Calcul des axes factoriels et des valeurs propres associ�es

% Calcul des facteurs associ�s aux axes factoriels
% - Pour le nuage des individus
% - Pour le nuage des modalit�s

% Calcul des indices d�aide � l�interpr�tation des r�sultats de l�analyse factorielle :
% - Le pourcentage d�inertie associ� � chaque axe (afficher le diagramme des valeurs propres)
% - La contribution des individus, des modalit�s et des variables pour chaque axe
% - La qualit� de repr�sentation des individus pour chaque axe

% Visualisation des r�sultats (par soucis de simplification, on ne s�int�ressera qu�au premier plan factoriel)
% - Projeter les individus sur le premier plan factoriel
% - Projeter les modalit�s sur le premier plan factoriel

% Interpr�tation des r�sultats
% - Donner une interpr�tation aux deux premiers facteurs
% - R�aliser une typologie des individus
% - R�aliser une typologie des modalit�s
% - Peut-on lier ces deux typologies ?