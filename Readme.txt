Cette documentation concerne la construction de la base de donn�es du syst�me 
� Job Overview � command� par la soci�t� BioTech.

Le Mod�le Conceptuel de Donn�es (MCD) et le Mod�le Physique de Donn�es (MPD) ont �t� 
r�alis�s � l�aide du logiciel DateModeler, version 4.1.5, fourni par Oracle.
La base de donn�es a �t� construite avec le Syst�me de Gestion de Base de Donn�es (SGBD) 
SQL Server 2008 R2, fourni par Microsoft.

Les diff�rents fichiers r�f�renc�s ci-apr�s sont disponibles dans le fichier au format zip, fourni 
avec la pr�sente documentation.

Le MCD et le MPD sont contenus dans le fichier � MCD MCP Projet.dmd � et le r�pertoire 
associ� � MCD MCP Projet �. Ces donn�es peuvent �tre consult�es avec le logiciel 
DataModeler. Si ce programme n�est pas disponible, le MCP et le MPD sont fournis dans les 
fichiers � MCD � SI JobOverview � et � MPD � SI JobOverview � au format pdf, ou au 
format png sous le m�me nom.

Le script de cr�ation des objets de la base de donn�es (tables et contraintes d�int�grit�) a �t� 
g�n�r� en plusieurs �tapes. Un script brut a �t� g�n�r� automatiquement avec les outils du 
logiciel DataModeler (fichier � Script brut Projet JobOverview.txt �). Ce script a subi un 
premier nettoyage et un r�agencement via le logiciel NotePad++ (fichier � Script Nettoy� 
avec Notepad Projet JobOverview.txt �). Le script final a �t� �crit avec SQL Server 
Management Studio (fichier � ScriptCreationBDD.sql �). Ce script permet de construire en 
une fois les tables et contraintes d�int�grit� de la base.

Le fichier � ScriptJeuDeDonnees.sql � fournit un script permettant de g�n�rer en une fois un 
jeu de donn�es pour les diff�rentes tables de la base.

Le fichier � ScriptLogiqueM�tier.sql � fournit un script permettant de cr�er dans la base les 
objets (vues, proc�dures stock�es, fonctions, types) n�cessaires pour r�pondre � une liste 
pr�d�finie de besoin m�tier.

Une sauvegarde de la base vide est disponible en important le fichier 
� ProjetJobOverviewVide.bak �. Cette base est totalement vierge, elle ne contient aucunes 
donn�es dans les tables la constituant.

Le fichier � ProjetJobOverviewAvecScriptJeuDonn�es.bak � correspond � la base de donn�es 
apr�s ex�cution du script de jeu de donn�es.

Le fichier � ProjetJobOverviewFinal.bak � correspond � la base de donn�es apr�s ex�cution 
du script de jeu de donn�es et ex�cution des objets disponible dans le script logique m�tier.

