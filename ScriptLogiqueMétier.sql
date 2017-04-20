----------------------------------------------------------------
-- Cr�ation d'une t�che de production et d'une t�che annexe.
----------------------------------------------------------------
-- On cr�e des proc�dures pour g�n�rer les t�che de production et les t�ches annexes.
-- Pour cela nous devons d'abord cr�er des t�ches dans la table Tache.

-- Proc�dure cr�ant une t�che
create procedure usp_CreationTache @Libelle nvarchar(30), @Description nvarchar(100), @DureeEstim�e int
as
begin
	insert jo.Tache values (@Libelle, @Description, @DureeEstim�e)
end
go

-- Proc�dure cr�ant une t�che de production
create procedure usp_CreationTacheProd @IdTache int, @DureePrevue int
as
begin
	insert jo.TacheProduction values (@IdTache, @DureePrevue)
end
go

-- Proc�dure cr�ant une t�che annexe
create procedure usp_CreationTacheAnx @IdTache int
as
begin
	insert jo.TacheAnnexe values (@IdTache)
end
go


-- On teste la cr�ation d'une t�che de production.
begin tran
exec usp_CreationTache 'Tache 3', null, 50
exec usp_CreationTacheProd 3, 40

select * from jo.Tache
select * from jo.TacheProduction

--commit

-- On teste la cr�ation d'une t�che annexe.
begin tran
exec usp_CreationTache 'Tache 4', 'Formation initiale', 10
exec usp_CreationTacheAnx 3

select * from jo.Tache
select * from jo.TacheAnnexe

--commit


----------------------------------------------------------------
-- Saisie du temps journalier sur une t�che
----------------------------------------------------------------
-- On cr�e un HistoriqueTache en v�rifiant au pr�alable que la dur�e saisie ne d�passe pas 8 heures.
-- Dans le cas contraire, un message d'erreur explicite est envoy� � l'utilisateur.

-- Cr�ation des messages d'erreur

exec sp_addmessage @msgnum = 50001, @severity = 12,
	@msgText = 'The value entered must not exceed 8 hours per day !',
	@lang='us_english',
	@replace = 'replace'

exec sp_addmessage @msgnum = 50001, @severity = 12,
	@msgText = 'La valeur entr�e ne doit pas d�passer 8 heures par jour !',
	@lang='French',
	@replace = 'replace'
	
-- On pr�f�re les messages en fran�ais
set language 'French'

-- Cr�ation d'un HistoriqueTache via une proc�dure.
-- On v�rifie la condition de dur�e maximale dans la proc�dure.

create procedure usp_NewHistoriqueTache @Id int, @DateJour date, @HeuresJour int, @Tx real, @IdSal nvarchar(10),
										@NumTache int, @IdAct int, @IdMod int, @Vers nvarchar(10)
as
begin
	if @HeuresJour > 8
		begin
			RAISERROR(50001, 12, 1)
			return
		end
	insert jo.HistoriqueTache values (@Id, @DateJour, @HeuresJour, @Tx, @IdSal,
									  @NumTache, @IdAct, @IdMod, @Vers)
end
go

-- Test de la cr�ation d'un HistoriqueTache

-- Premier test en mode esclave 15 heures par jour.
begin tran
exec usp_NewHistoriqueTache 2, '2017-04-20' , 15, 1, 'LBUTLER', 1, 1, 1, '2.50'
rollback

-- Deuxi�me test avec une tache durant 4 heures
begin tran
exec usp_NewHistoriqueTache 3, '2017-04-20' , 4, 1, 'LBUTLER', 1, 1, 1, '2.50'
--commit

select * from jo.HistoriqueTache


---------------------------------------------------------------------------
-- Remplissage des listes d�roulantes des fen�tres de saisie de temps.
---------------------------------------------------------------------------

-- Remplissage concernant les t�ches de production.
-- On reprend les proc�dures cr��es pr�c�demment (usp_CreationTache et usp_CreationTacheProd).
-- Et on ajoute les donn�es qui nous manquent

create function ufn_MenuDeroulantLogiciel ()
returns @TableId table
(
	NomLogiciel nvarchar (40), 
	NomVersion nvarchar (10),
	ModuleLibelle nvarchar (100), 
	NomActivite nvarchar (30),
	TacheLibelle nvarchar (30)
	
)
as
begin
	insert @TableId
	select l.NomLogiciel, v.Numero, m.Libelle, act.NomActivite, t.Libelle
	from jo.HistoriqueTache h
	inner join jo.Tache t on t.NumeroTache = h.Tache_NumeroTache
	inner join  jo.Activite act on act.IdAcitvite = h.Activite_IdAcitvite
	inner join jo.Module m on m.CodeModule = h.Module_CodeModule
	inner join jo.Logiciel l on l.Code = m.Logiciel_Code
	inner join jo.Version v on v.Logiciel_Code = l.Code 
	
	
	return
end
go

--Verification du remplissage des listes d�roulantes 
select * from dbo.ufn_MenuDeroulantLogiciel ()


