---------------------------------------------------------
--Suppression des contraintes de clés étrangères
---------------------------------------------------------
-- La suppression est sécurisée : on vérifie l'existence de la clé étrangère avant de la supprimer.

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'FK_ASS_23')
ALTER TABLE jo.ActiviteMetier
DROP CONSTRAINT FK_ASS_23
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'HistoriqueTache_Activite_FK')
ALTER TABLE jo.HistoriqueTache
DROP CONSTRAINT HistoriqueTache_Activite_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Salarie_Equipe_FK')
ALTER TABLE jo.Salarie
DROP CONSTRAINT Salarie_Equipe_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Equipe_Filiere_FK')
ALTER TABLE jo.Equipe
DROP CONSTRAINT Equipe_Filiere_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Logiciel_Filiere_FK')
ALTER TABLE jo.Logiciel
DROP CONSTRAINT Logiciel_Filiere_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Module_Logiciel_FK')
ALTER TABLE jo.Module
DROP CONSTRAINT Module_Logiciel_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Version_Logiciel_FK')
ALTER TABLE jo.Version
DROP CONSTRAINT Version_Logiciel_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'FK_ASS_22')
ALTER TABLE jo.ActiviteMetier
DROP CONSTRAINT FK_ASS_22
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Salarie_Metier_FK')
ALTER TABLE jo.Salarie
DROP CONSTRAINT Salarie_Metier_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'HistoriqueTache_Module_FK')
ALTER TABLE jo.HistoriqueTache
DROP CONSTRAINT HistoriqueTache_Module_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Module_Module_FK')
ALTER TABLE jo.Module
DROP CONSTRAINT Module_Module_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'HistoriqueTache_Salarie_FK')
ALTER TABLE jo.HistoriqueTache
DROP CONSTRAINT HistoriqueTache_Salarie_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Salarie_Salarie_FK')
ALTER TABLE jo.Salarie
DROP CONSTRAINT Salarie_Salarie_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Equipe_Service_FK')
ALTER TABLE jo.Equipe
DROP CONSTRAINT Equipe_Service_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'HistoriqueTache_Tache_FK')
ALTER TABLE jo.HistoriqueTache
DROP CONSTRAINT HistoriqueTache_Tache_FK
GO

if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'TacheAnnexe_Tache_FK')
ALTER TABLE jo.TacheAnnexe
DROP CONSTRAINT TacheAnnexe_Tache_FK
GO


if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'TacheProduction_Tache_FK')
ALTER TABLE jo.TacheProduction
DROP CONSTRAINT TacheProduction_Tache_FK
GO


if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'HistoriqueTache_Version_FK')
ALTER TABLE jo.HistoriqueTache
DROP CONSTRAINT HistoriqueTache_Version_FK
GO


if exists(select 1 from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where CONSTRAINT_SCHEMA = 'jo' and CONSTRAINT_NAME = 'Release_Version_FK')
ALTER TABLE jo.RELEASE
DROP CONSTRAINT Release_Version_FK
GO

---------------------------------------------------------
--Création des Tables
---------------------------------------------------------
--On vérifie si la table existe et on la supprime si c'est le cas.
--Puis on créé la table.



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Activite')
DROP TABLE jo.Activite
GO
CREATE TABLE jo.Activite
  (
    IdAcitvite INTEGER NOT NULL ,
    NomActivite NVARCHAR (30) NOT NULL
  )
GO
ALTER TABLE jo.Activite ADD CONSTRAINT Activite_PK PRIMARY KEY CLUSTERED (IdAcitvite)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'ActiviteMetier')
DROP TABLE jo.ActiviteMetier
GO
CREATE TABLE jo.ActiviteMetier
  (
    Metier_IdMetier     INTEGER NOT NULL ,
    Activite_IdAcitvite INTEGER NOT NULL
  )
GO
ALTER TABLE jo.ActiviteMetier ADD CONSTRAINT ActiviteMetier_PK PRIMARY KEY
CLUSTERED (Metier_IdMetier, Activite_IdAcitvite)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Equipe')
DROP TABLE jo.Equipe
GO
CREATE TABLE jo.Equipe
  (
    IdEquipe          INTEGER NOT NULL ,
    Filiere_IdFiliere INTEGER NOT NULL ,
    Service_IdService INTEGER NOT NULL ,
    NomEquipe NVARCHAR (30)
  )
GO
ALTER TABLE jo.Equipe ADD CONSTRAINT Equipe_PK PRIMARY KEY CLUSTERED (IdEquipe)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Filiere')
DROP TABLE jo.Filiere
GO
CREATE TABLE jo.Filiere
  (
    IdFiliere INTEGER NOT NULL ,
    NomFiliere NVARCHAR (30) NOT NULL
  )
GO
ALTER TABLE jo.Filiere ADD CONSTRAINT Filiere_PK PRIMARY KEY CLUSTERED (
IdFiliere)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'HistoriqueTache')
DROP TABLE jo.HistoriqueTache
GO
CREATE TABLE jo.HistoriqueTache
  (
    IdHistTache      INTEGER NOT NULL ,
    DateDuJour       DATE NOT NULL ,
    NbrHeuresParJour INTEGER NOT NULL ,
    TauxProductivite REAL NOT NULL ,
    Salarie_Login NVARCHAR (10) NOT NULL ,
    Tache_NumeroTache   INTEGER NOT NULL ,
    Activite_IdAcitvite INTEGER NOT NULL ,
    Module_CodeModule   INTEGER NOT NULL ,
    Version_Numero NVARCHAR (10) NOT NULL
  )
GO
ALTER TABLE jo.HistoriqueTache ADD CONSTRAINT HistoriqueTache_PK PRIMARY KEY
CLUSTERED (IdHistTache)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Logiciel')
DROP TABLE jo.Logiciel
GO
CREATE TABLE jo.Logiciel
  (
    Code              INTEGER NOT NULL ,
    Filiere_IdFiliere INTEGER NOT NULL ,
    NomLogiciel NVARCHAR (30) NOT NULL
  )
GO
ALTER TABLE jo.Logiciel ADD CONSTRAINT Logiciel_PK PRIMARY KEY CLUSTERED (Code)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Metier')
DROP TABLE jo.Metier
GO
CREATE TABLE jo.Metier
  (
    IdMetier INTEGER NOT NULL ,
    NomMetier NVARCHAR (30) NOT NULL
  )
GO
ALTER TABLE jo.Metier ADD CONSTRAINT Metier_PK PRIMARY KEY CLUSTERED (IdMetier)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Module')
DROP TABLE jo.Module
GO
CREATE TABLE jo.Module
  (
    CodeModule INTEGER NOT NULL ,
    Libelle NVARCHAR (100) NOT NULL ,
    Logiciel_Code         INTEGER NOT NULL ,
    SousModule_CodeModule INTEGER
  )
GO
ALTER TABLE jo.Module ADD CONSTRAINT Module_PK PRIMARY KEY CLUSTERED (
CodeModule)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'RELEASE')
DROP TABLE jo.RELEASE
GO
CREATE TABLE jo.Release
  (
    IdRelease    SMALLINT NOT NULL IDENTITY NOT FOR REPLICATION ,
    DateCreation DATE NOT NULL ,
    Version_Numero NVARCHAR (10) NOT NULL
  )
GO
ALTER TABLE jo.Release
ADD
CHECK ( IdRelease BETWEEN 1 AND 999 )
GO
ALTER TABLE jo.Release ADD CONSTRAINT Release_PK PRIMARY KEY CLUSTERED (
IdRelease)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Salarie')
DROP TABLE jo.Salarie
GO
CREATE TABLE jo.Salarie
  (
    Login NVARCHAR (10) NOT NULL ,
    Equipe_IdEquipe INTEGER NOT NULL ,
    Manager_Login NVARCHAR (10),
    Metier_IdMetier INTEGER NOT NULL ,
    NomSalarie NVARCHAR (30) ,
    PrenomSalarie NVARCHAR (30)
  )
GO
ALTER TABLE jo.Salarie ADD CONSTRAINT Salarie_PK PRIMARY KEY CLUSTERED (Login)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Service')
DROP TABLE jo.Service
GO
CREATE TABLE jo.Service
  (
    IdService INTEGER NOT NULL ,
    NomService NVARCHAR (30) NOT NULL
  )
GO
ALTER TABLE jo.Service ADD CONSTRAINT Service_PK PRIMARY KEY CLUSTERED (
IdService)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Tache')
DROP TABLE jo.Tache
GO
CREATE TABLE jo.Tache
  (
    NumeroTache INTEGER NOT NULL IDENTITY NOT FOR REPLICATION ,
    Libelle NVARCHAR (30) NOT NULL ,
    Description NVARCHAR (100) ,
    DureeEstimeeEnJours INTEGER NOT NULL
  )
GO
ALTER TABLE jo.Tache ADD CONSTRAINT Tache_PK PRIMARY KEY CLUSTERED (NumeroTache
)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'TacheAnnexe')
DROP TABLE jo.TacheAnnexe
GO
CREATE TABLE jo.TacheAnnexe
  (
    NumeroTache INTEGER NOT NULL 
  )
GO
ALTER TABLE jo.TacheAnnexe ADD CONSTRAINT TacheAnnexe_PK PRIMARY KEY CLUSTERED
(NumeroTache)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'TacheProduction')
DROP TABLE jo.TacheProduction
GO
CREATE TABLE jo.TacheProduction
  (
    NumeroTache         INTEGER NOT NULL ,
    DureeInitialePrevueEnJour INTEGER NOT NULL
  )
GO
ALTER TABLE jo.TacheProduction ADD CONSTRAINT TacheProduction_PK PRIMARY KEY
CLUSTERED (NumeroTache)
GO



if exists(select 1 from INFORMATION_SCHEMA.TABLES
		where TABLE_SCHEMA = 'jo' and TABLE_NAME = 'Version')
DROP TABLE jo.Version
GO
CREATE TABLE jo.Version
  (
    Numero NVARCHAR (10) NOT NULL ,
    Millesime        SMALLINT NOT NULL ,
    DateOuverture    DATE NOT NULL ,
    DateSortiePrevue DATE NOT NULL ,
    DateSortieReelle DATE ,
    Logiciel_Code    INTEGER NOT NULL
  )
GO
ALTER TABLE jo.Version ADD CONSTRAINT Version_PK PRIMARY KEY CLUSTERED (Numero)
GO



---------------------------------------------------------
--Création des contraintes de clés étrangères
---------------------------------------------------------


ALTER TABLE jo.Equipe
ADD CONSTRAINT Equipe_Filiere_FK FOREIGN KEY (Filiere_IdFiliere)
REFERENCES jo.Filiere (IdFiliere)
GO

ALTER TABLE jo.Equipe
ADD CONSTRAINT Equipe_Service_FK FOREIGN KEY (Service_IdService)
REFERENCES jo.Service (IdService)
GO

ALTER TABLE jo.ActiviteMetier
ADD CONSTRAINT FK_ASS_22 FOREIGN KEY (Metier_IdMetier)
REFERENCES jo.Metier (IdMetier)
GO

ALTER TABLE jo.ActiviteMetier
ADD CONSTRAINT FK_ASS_23 FOREIGN KEY (Activite_IdAcitvite)
REFERENCES jo.Activite (IdAcitvite)
GO

ALTER TABLE jo.HistoriqueTache
ADD CONSTRAINT HistoriqueTache_Activite_FK FOREIGN KEY (Activite_IdAcitvite)
REFERENCES jo.Activite (IdAcitvite)
GO

ALTER TABLE jo.HistoriqueTache
ADD CONSTRAINT HistoriqueTache_Module_FK FOREIGN KEY (Module_CodeModule)
REFERENCES jo.Module (CodeModule)
GO

ALTER TABLE jo.HistoriqueTache
ADD CONSTRAINT HistoriqueTache_Salarie_FK FOREIGN KEY (Salarie_Login)
REFERENCES jo.Salarie (Login)
GO

ALTER TABLE jo.HistoriqueTache
ADD CONSTRAINT HistoriqueTache_Tache_FK FOREIGN KEY (Tache_NumeroTache)
REFERENCES jo.Tache (NumeroTache)
GO

ALTER TABLE jo.HistoriqueTache
ADD CONSTRAINT HistoriqueTache_Version_FK FOREIGN KEY (Version_Numero)
REFERENCES jo.Version (Numero)
GO

ALTER TABLE jo.Logiciel
ADD CONSTRAINT Logiciel_Filiere_FK FOREIGN KEY (Filiere_IdFiliere)
REFERENCES jo.Filiere (IdFiliere)
GO

ALTER TABLE jo.Module
ADD CONSTRAINT Module_Logiciel_FK FOREIGN KEY (Logiciel_Code)
REFERENCES jo.Logiciel (Code)
GO

ALTER TABLE jo.Module
ADD CONSTRAINT Module_Module_FK FOREIGN KEY (SousModule_CodeModule)
REFERENCES jo.Module (CodeModule)
GO

ALTER TABLE jo.RELEASE
ADD CONSTRAINT Release_Version_FK FOREIGN KEY (Version_Numero)
REFERENCES jo.Version (Numero)
GO

ALTER TABLE jo.Salarie
ADD CONSTRAINT Salarie_Equipe_FK FOREIGN KEY (Equipe_IdEquipe)
REFERENCES jo.Equipe (IdEquipe)
GO

ALTER TABLE jo.Salarie
ADD CONSTRAINT Salarie_Metier_FK FOREIGN KEY (Metier_IdMetier)
REFERENCES jo.Metier (IdMetier)
GO

ALTER TABLE jo.Salarie
ADD CONSTRAINT Salarie_Salarie_FK FOREIGN KEY (Manager_Login)
REFERENCES jo.Salarie (Login)
GO

ALTER TABLE jo.TacheAnnexe
ADD CONSTRAINT TacheAnnexe_Tache_FK FOREIGN KEY (NumeroTache)
REFERENCES jo.Tache (NumeroTache)
GO

ALTER TABLE jo.TacheProduction
ADD CONSTRAINT TacheProduction_Tache_FK FOREIGN KEY (NumeroTache)
REFERENCES jo.Tache (NumeroTache)
GO

ALTER TABLE jo.Version
ADD CONSTRAINT Version_Logiciel_FK FOREIGN KEY (Logiciel_Code)
REFERENCES jo.Logiciel (Code)
GO

