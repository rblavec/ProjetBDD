----------------------------------------------------------------
--Insertion de valeurs dans la table Metier
----------------------------------------------------------------

--On lance une transaction pour sécuriser l'exécution du script.
--Si une valeur a été mal rentrée dans une des tables, on utilisera un rollback.
--Sinon, on validera la transaction avec un commit. 
--Un commit et un rollback sont disponibles en commentaire à la fin de ce script.

begin tran

insert jo.Metier values (1, 'ANA'), (2,'CDP'), (3,'DEV'), (4,'DES'), (5,'TES')


--On vérifie l'insertion de nos valeurs
--select * from jo.Metier

----------------------------------------------------------------
--Insertion de valeurs dans la table Activité
----------------------------------------------------------------

insert jo.Activite values (1, 'DBE'), (2,'ARF'), (3,'ANF'), (4,'DES'), (5,'INF'),(6,'ART'),
						  (7,'ANT'), (8,'DEV'), (9,'RPT'), (10,'TES'), (11,'GDP')

--On vérifie l'insertion de nos valeurs					  
--select * from jo.Activite

----------------------------------------------------------------
--Insertion de valeurs dans la table ActivitéMétier
----------------------------------------------------------------

--On associe à un métier plusieurs activités

insert jo.ActiviteMetier values (1, 1), (1, 2), (1, 3), (2,2), (2,3), (2,6), (2,10), (2,11)

--On vérifie l'insertion de nos valeurs	
--select * from jo.ActiviteMetier


----------------------------------------------------------------
--Insertion de valeurs dans la table Filière
----------------------------------------------------------------

insert jo.Filiere values (1, 'BIOH'), (2,'BIOA'), (3,'BIOV')

--On vérifie l'insertion de nos valeurs	
--select * from jo.Filiere

----------------------------------------------------------------
--Insertion de valeurs dans la table Service
----------------------------------------------------------------

insert jo.Service values (1, 'MKT'), (2, 'DEV'), (3,'TEST'), (4,'SL')

--On vérifie l'insertion de nos valeurs	
--select * from jo.Service

----------------------------------------------------------------
--Insertion de valeurs dans la table Équipe
----------------------------------------------------------------

insert jo.Equipe values (1, 2, 2, 'Team 1'), (2, 2, 3, 'Team 2'), (3, 3, 1, 'Team 3'), (4, 1, 4, 'Team 4')

--On vérifie l'insertion de nos valeurs
--select * from jo.Equipe


----------------------------------------------------------------
--Insertion de valeurs dans la table Salarié
----------------------------------------------------------------

insert jo.Salarie values ('BNORMAND', 1, null, 2, 'NORMAND', 'Balthazar'), ('RFISHER', 1,'BNORMAND', 3, 'FISHER', 'Raymond'), 
					     ('LBUTLER', 1,'BNORMAND', 3, 'BUTLER', 'Lucien') 
		     
		
--On vérifie l'insertion de nos valeurs					  
--select * from jo.Salarie

----------------------------------------------------------------
--Insertion de valeurs dans la table Logiciel
----------------------------------------------------------------

insert jo.Logiciel values (1, 2, 'Genomica')

--On vérifie l'insertion de nos valeurs	
--select * from jo.Logiciel

----------------------------------------------------------------
--Insertion de valeurs dans la table Version
----------------------------------------------------------------

insert jo.Version values ('1.00', 2011, '2011-02-02', '2011-08-02', '2011-07-05', 1),
						 ('2.00', 2014, '2014-03-02', '2014-10-25', '2014-12-24', 1),
						 ('2.50', 2016, '2016-07-27', '2017-01-01', '2017-02-15', 1)

--On vérifie l'insertion de nos valeurs					 
--select * from jo.Version

----------------------------------------------------------------
--Insertion de valeurs dans la table Release
----------------------------------------------------------------
--Attention, l'Id est en Auto-Incrément.

insert jo.Release values ('2014-05-12', '2.00'), ('2016-01-01', '2.50')

--On vérifie l'insertion de nos valeurs	
--select * from jo.Release

----------------------------------------------------------------
--Insertion de valeurs dans la table Module
----------------------------------------------------------------

insert jo.Module values (1, 'SEQUENCAGE', 1, null), (2, 'POLYMORPHISME', 1 , null), 
						(3, 'VAR_ALLELE', 1 , null)  
	
	
--On vérifie l'insertion de nos valeurs						
--select * from jo.Module

----------------------------------------------------------------
--Insertion de valeurs dans la table Tache
----------------------------------------------------------------
--Attention, l'Id est en Auto-Incrément.

insert jo.Tache values ('Tache 1', 'Beginning Tache 1', 32),
					   ('Tache 2', 'Beginning Tache 2', 20)

--On vérifie l'insertion de nos valeurs	
--select * from jo.Tache

----------------------------------------------------------------
--Insertion de valeurs dans la table TacheAnnexe
----------------------------------------------------------------

insert jo.TacheAnnexe values (2)

--On vérifie l'insertion de nos valeurs	
--select * from jo.TacheAnnexe


----------------------------------------------------------------
--Insertion de valeurs dans la table TacheProduction
----------------------------------------------------------------

insert jo.TacheProduction values (1, 40)

--On vérifie l'insertion de nos valeurs	
--select * from jo.TacheProduction


----------------------------------------------------------------
--Insertion de valeurs dans la table HistoriqueTache
----------------------------------------------------------------

insert jo.HistoriqueTache values (1, GETDATE(), 5, 1, 'RFISHER', 1, 1, 1, '2.50') 

--On vérifie l'insertion de nos valeurs	
--select * from jo.HistoriqueTache



--rollback
--commit
