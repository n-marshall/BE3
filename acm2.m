close all;
clear all;
% Lecture des données
load csp;
noms_individus=noms_modalites1;
noms_variables=noms_modalites2;

% Construction du tableau de donnees qualitatives
% - On regarde la fréquence d'un type d'étude par csp et on classe en 5
% - classes (1=très faible, 2=faible, 3=moyen, 4=fort, 5=très fort)
Xi=max(donnees);
Xrelatif=donnees./repmat(Xi,size(donnees,1),1)
Xbrut=Xrelatif;
maxXbrut=max(max(Xbrut));
for i=1:size(donnees,1)
    for j=1:size(donnees,2)
        Xbrut(i,j)=floor(Xbrut(i,j)/0.2/maxXbrut)+1;
    end
end
% - On corrige la présence de 6 pour les maxima de chaque variable
for i=1:size(donnees,1)
    for j=1:size(donnees,2)
        if Xbrut(i,j)==6
            Xbrut(i,j)=5;
        end
    end
end
       

% Construction du tableau disjonctif complet (TDC)
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
Xburt=XTDC'*XTDC;

% Calcul des matrices X, M et D
% - X : matrice calculée à partir du TDC
I=size(XTDC,1);
X=size(XTDC,1)*XTDC./repmat(sum(XTDC),size(XTDC,1),1)-1;
% - D : matrice des poids des individus
D=eye(size(XTDC,1))/size(XTDC,1);
% - M : matrice des poids des modalités
M=diag(sum(XTDC)/size(XTDC,1)*size(Xbrut,2));



% Calcul des axes factoriels et des valeurs propres associées
% - Pour les individus
[eI,lambdaI] = eig(X'*D*X*M);
lambdaI=diag(lambdaI);
[lambdaI,eISortOrder]=sort(lambdaI,'descend');
eI=eI(:,eISortOrder);
% - Pour les variables
[eV,lambdaV] = eig(X*M*X'*D);
lambdaV=diag(lambdaV);
[lambdaV,eVSortOrder]=sort(lambdaV,'descend');
eV=eV(:,eVSortOrder);

% Calcul des facteurs associés aux axes factoriels
% - Pour le nuage des profils-lignes
Fi=X*M*eI;
    Fi1=Fi(:,1);
    Fi2=Fi(:,2);
% - Pour le nuage des profils-colonnes
Fv=X'*D*eV;
    Fv1=Fv(:,1);
    Fv2=Fv(:,2);


% Calcul des indices d’aide à l’interprétation des résultats de l’analyse factorielle :
% - Le pourcentage d’inertie associé à chaque axe (afficher le diagramme des valeurs propres)
v=lambdaI/sum(lambdaI)*100;
v=real(v); % ici j'élimine simplement la partie imaginaire de v pour permettre l'affichage, je ne sais pas pourquoi il y en a une, j'espère que ce n'est pas une erreur 
figure;
stem(v);
xlim([0 7]);
ylim([0 100]);
gname(num2str(v));
% - La contribution des profils-lignes et des profils-colonnes pour chaque axe
% - - Pour les profils-lignes
ContributionI1=D*(Fi1.*Fi1)/(Fi1'*D*Fi1);
ContributionI2=D*(Fi2.*Fi2)/(Fi2'*D*Fi2);
% - - Pour les profils-colonnes
ContributionV1=M*(Fv1.*Fv1)/(Fv1'*M*Fv1);
ContributionV2=M*(Fv2.*Fv2)/(Fv2'*M*Fv2);
% - La qualité de représentation des profils-lignes et des profils-colonnes pour chaque axe
% - - Pour les profils-lignes
distCarre=repmat(sum(X.*X,2),1,size(X,2))
Qualite=Fi.*Fi./distCarre
% - - Pour les profils-colonnes

% Visualisation des résultats (par soucis de simplification, on ne s’intéressera qu’au premier plan factoriel)
% - Projeter les profils-lignes sur le premier plan factoriel
x=[min(Fi1):0.01:max(Fi1)];
y=[min(Fi2):0.01:max(Fi2)];
figure; hold on;
% axis auto;
% plot(x,0,0,y,'-');
plot(Fi1,Fi2,'x');
gname(noms_modalites1);
% - Projeter les profils-colonnes sur le premier plan factoriel
x=[min(Fv1):0.01:max(Fv1)];
y=[min(Fv2):0.01:max(Fv2)];
figure;
plot(Fv1,Fv2,'x');
gname(noms_modalites);


% Interprétation des résultats
% - Donner une interprétation aux deux premiers facteurs
% - Réaliser une typologie des profils-lignes
% - Réaliser une typologie des profils-colonnes
% - Peut-on lier ces deux typologies ?