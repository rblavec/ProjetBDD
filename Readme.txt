Cette documentation concerne la construction de la base de données du système 
« Job Overview » commandé par la société BioTech.

Le Modèle Conceptuel de Données (MCD) et le Modèle Physique de Données (MPD) ont été 
réalisés à l’aide du logiciel DateModeler, version 4.1.5, fourni par Oracle.
La base de données a été construite avec le Système de Gestion de Base de Données (SGBD) 
SQL Server 2008 R2, fourni par Microsoft.

Les différents fichiers référencés ci-après sont disponibles dans le fichier au format zip, fourni 
avec la présente documentation.

Le MCD et le MPD sont contenus dans le fichier « MCD MCP Projet.dmd » et le répertoire 
associé « MCD MCP Projet ». Ces données peuvent être consultées avec le logiciel 
DataModeler. Si ce programme n’est pas disponible, le MCP et le MPD sont fournis dans les 
fichiers « MCD – SI JobOverview » et « MPD – SI JobOverview » au format pdf, ou au 
format png sous le même nom.

Le script de création des objets de la base de données (tables et contraintes d’intégrité) a été 
généré en plusieurs étapes. Un script brut a été généré automatiquement avec les outils du 
logiciel DataModeler (fichier « Script brut Projet JobOverview.txt »). Ce script a subi un 
premier nettoyage et un réagencement via le logiciel NotePad++ (fichier « Script Nettoyé 
avec Notepad Projet JobOverview.txt »). Le script final a été écrit avec SQL Server 
Management Studio (fichier « ScriptCreationBDD.sql »). Ce script permet de construire en 
une fois les tables et contraintes d’intégrité de la base.

Le fichier « ScriptJeuDeDonnees.sql » fournit un script permettant de générer en une fois un 
jeu de données pour les différentes tables de la base.

Le fichier « ScriptLogiqueMétier.sql » fournit un script permettant de créer dans la base les 
objets (vues, procédures stockées, fonctions, types) nécessaires pour répondre à une liste 
prédéfinie de besoin métier.

Une sauvegarde de la base vide est disponible en important le fichier 
« ProjetJobOverviewVide.bak ». Cette base est totalement vierge, elle ne contient aucunes 
données dans les tables la constituant.

Le fichier « ProjetJobOverviewAvecScriptJeuDonnées.bak » correspond à la base de données 
après exécution du script de jeu de données.

Le fichier « ProjetJobOverviewFinal.bak » correspond à la base de données après exécution 
du script de jeu de données et exécution des objets disponible dans le script logique métier.

