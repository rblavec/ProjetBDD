------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 1. Clients et coordonn�es
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-------------------
-- Requ�te 1.A
-------------------
-- Clients pour lesquels on n�a pas de num�ro de portable (id, nom) 
-- Nombre de lignes renvoy� par la requ�te : 85

select distinct CLI_ID, CLI_NOM from CLIENT c
where not exists (select 1 from TELEPHONE where CLI_ID = c.CLI_ID and TYP_CODE = 'GSM')


-------------------
-- Requ�te 1.B
-------------------
-- Clients pour lesquels on a au moins un N� de portable ou une adresse mail
-- Nombre de lignes renvoy� par la requ�te : 43

select distinct CLI_ID, CLI_NOM from CLIENT c
where exists (select 1 from TELEPHONE where CLI_ID = c.CLI_ID and TYP_CODE = 'GSM')
union
select distinct CLI_ID, CLI_NOM from CLIENT c
where exists (select 1 from EMAIL where CLI_ID = c.CLI_ID)


-------------------
-- Requ�te 1.C
-------------------
-- Mettre � jour les num�ros de t�l�phone pour qu�ils soient au format � +33XXXXXXXXX � au lieu de � 0X-XX-XX-XX-XX � 
-- La requ�te modifie les 174 lignes de la table TELEPHONE.

begin tran
update TELEPHONE
set TEL_NUMERO = '+33' + REPLACE(substring(TEL_NUMERO, 2, 14), '-', '')
rollback

select * from TELEPHONE


-------------------
-- Requ�te 1.D
-------------------
-- Clients qui ont pay� avec au moins deux moyens de paiement diff�rents au cours d�un m�me mois (id, nom)
-- Nombre de lignes renvoy� par la requ�te : 28

-- On passe par une table interm�diaire
declare @temp table
(
	IdClient int,
	Ann�e int,
	Mois int,
	Nombre int
)

-- On remplit la table @temp avec les clients ayant utilis�s au moins 2 moyens de paiement au cours d'un m�me mois.
insert @temp
select CLI_ID, year(FAC_PMDATE) as Ann�e, MONTH(FAC_PMDATE) as Mois, COUNT(*) as NbMoyPaiementUtilisesParMois
from FACTURE
group by CLI_ID, year(FAC_PMDATE), MONTH(FAC_PMDATE)
having COUNT(*) >1

-- On affiche les clients en enlevant les doublons.
select distinct IdClient
from @temp


-------------------
-- Requ�te 1.E
-------------------
-- Clients de la m�me ville qui se sont d�j� retrouv�s en m�me temps � l�h�tel
-- Nombre de lignes renvoy� par la requ�te : 689

select A.ADR_VILLE, CH.PLN_JOUR, CH.CLI_ID, COUNT(*) as nbre
from CHB_PLN_CLI CH
inner join ADRESSE A on (CH.CLI_ID = A.CLI_ID)
group by A.ADR_VILLE, CH.PLN_JOUR, CH.CLI_ID
having COUNT(*) > 1


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 2. Fr�quentation
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Nous n'avons pas eu le temps d'aborder cette partie.


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 3. Chiffre d�affaire
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-------------------
-- Requ�te 3.A
-------------------
-- Valeur absolue et pourcentage d�augmentation du tarif de chaque chambre sur l�ensemble de la p�riode
-- La requ�te nous permet d'obtenir l'augmentation et le pourcentage d'augmentation des 20 chambres de l'h�tel.


select distinct C.CHB_ID, C.chb_numero,
		(MAX(TRF_CHB_PRIX) over (partition by T.CHB_ID) - MIN(TRF_CHB_PRIX) over (partition by T.CHB_ID)) as Augmentation,
		(MAX(TRF_CHB_PRIX) over (partition by T.CHB_ID) / MIN(TRF_CHB_PRIX) over (partition by T.CHB_ID) - 1) * 100  as PourcentageAugmentation
from TRF_CHB T
inner join CHAMBRE C on T.CHB_ID = C.CHB_ID


-------------------
-- Requ�te 3.B
-------------------
-- Chiffre d'affaire de l�h�tel par trimestre de chaque ann�e
-- On consid�re que dans la table LIGNE_FACTURE, LIF_MONTANT = prix unitaire TTC.
-- On obtient 9 lignes correspondant au chiffre d'affaire de l'h�tel par trimestre de chaque ann�e.

select YEAR(f.FAC_DATE) Ann�e, DATEPART(QUARTER, f.FAC_DATE) Trimestre, 
	   SUM (lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) [Chiffre d'affaire]  
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
group by YEAR(f.FAC_DATE), DATEPART(QUARTER, f.FAC_DATE)
order by 1, 2

select * from LIGNE_FACTURE

-------------------
-- Requ�te 3.C
-------------------
-- Chiffre d'affaire de l�h�tel par mode de paiement et par an, 
-- avec les modes de paiement en colonne et les ann�es en ligne.
-- On obtiendra � la fin un tableau avec de 4 colonnes et 4 lignes.

-- On affiche le chiffre d'affaire de l'h�tel par moyen de paiement et par an.


select YEAR(f.FAC_DATE) Ann�e, PMCODE [Moyen de paiement],
	   SUM (lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) [Chiffre d'affaire]  
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
group by YEAR(f.FAC_DATE), PMCODE


-- On affiche le chiffre d'affaire par mode de paiement et par an avec les modes de paiement en colonne et les ann�e en lignes.

select [Moyen de paiement],[2015],[2016],[2017]
from 
(
select YEAR(f.FAC_DATE) Ann�e, PMCODE [Moyen de paiement],
	   (lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) [Chiffre d'affaire]  
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID

) as Source
pivot (SUM([Chiffre d'affaire])  
FOR Ann�e in ([2015],[2016],[2017])) as Cible

select * from MODE_PAIEMENT

-------------------
-- Requ�te 3.D
-------------------
-- D�lai moyen de paiement des factures par ann�e et par mode de paiement, 
-- avec les modes de paiement en colonne et les ann�es en ligne.
-- On obtiendra � la fin un tableau avec de 4 colonnes et 4 lignes.


-- On affiche le d�lai moyen de paiement des factures par ann�e et par mode de paiement.

select YEAR(f.FAC_DATE) Ann�e, PMCODE [Moyen de paiement], 
			avg(DATEDIFF(day, FAC_DATE, FAC_PMDATE)) [D�lai de paiement moyen (en jours)]
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
group by YEAR(f.FAC_DATE), PMCODE


-- On affiche le d�lai moyen de paiement (en jours) avec les modes de paiement en colonne et les ann�es en ligne.


select [Moyen de paiement],[2015],[2016],[2017]
from 
(
	select YEAR(f.FAC_DATE) Ann�e, PMCODE [Moyen de paiement], 
			DATEDIFF(day, FAC_DATE, FAC_PMDATE) DPM
	from FACTURE f
	inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
) as Source
pivot (avg(DPM) 
FOR Ann�e in ([2015],[2016],[2017])) as Cible

select * from MODE_PAIEMENT


-------------------
-- Requ�te 3.E
-------------------
-- Compter le nombre de clients dans chaque tranche de 5000 F de chiffre d�affaire total g�n�r�, 
-- en partant de 20000 F jusqu�� + de 45 000 F. 
-- On obtiendra � la fin un tableau avec de 2 colonnes et 4 lignes.

select Tranche, COUNT(CLI_ID) NbClients
from (
select CLI_ID, CA,
	case
		when CA < 20000 then 'T1'
		when CA < 25000 then 'T2'
		when CA < 30000 then 'T3'
		when CA < 35000 then 'T4'
		when CA < 40000 then 'T5'
		else 'T6'
	end as Tranche
from
(
	select f.CLI_ID,
	sum(lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) CA  
	from FACTURE f
	inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
	group by f.CLI_ID
)R
) R2
group by Tranche

-------------------
-- Requ�te 3.F
-------------------
-- A partir du 01/09/2017, augmenter les tarifs des chambres du rez-de-chauss�e de 5%, 
-- celles du 1er �tage de 4% et celles du 2d �tage de 2%.
-- /!\ L'exercice est encore en chantier. Il reste � g�rer la condition � partir du 01/09/2017.

begin tran
update TRF_CHB
 set TRF_CHB_PRIX = (
case CHB_ETAGE
	when 'RDC' then TRF_CHB_PRIX * 1.05
	when '1er' then TRF_CHB_PRIX * 1.04
	when '2e' then TRF_CHB_PRIX * 1.02
end
)
from TRF_CHB TC
inner join CHAMBRE C on TC.CHB_ID = C.CHB_ID


rollback


select * from CHAMBRE