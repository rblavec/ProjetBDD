------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 1. Clients et coordonnées
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-------------------
-- Requête 1.A
-------------------
-- Clients pour lesquels on n’a pas de numéro de portable (id, nom) 
-- Nombre de lignes renvoyé par la requête : 85

select distinct CLI_ID, CLI_NOM from CLIENT c
where not exists (select 1 from TELEPHONE where CLI_ID = c.CLI_ID and TYP_CODE = 'GSM')


-------------------
-- Requête 1.B
-------------------
-- Clients pour lesquels on a au moins un N° de portable ou une adresse mail
-- Nombre de lignes renvoyé par la requête : 43

select distinct CLI_ID, CLI_NOM from CLIENT c
where exists (select 1 from TELEPHONE where CLI_ID = c.CLI_ID and TYP_CODE = 'GSM')
union
select distinct CLI_ID, CLI_NOM from CLIENT c
where exists (select 1 from EMAIL where CLI_ID = c.CLI_ID)


-------------------
-- Requête 1.C
-------------------
-- Mettre à jour les numéros de téléphone pour qu’ils soient au format « +33XXXXXXXXX » au lieu de « 0X-XX-XX-XX-XX » 
-- La requête modifie les 174 lignes de la table TELEPHONE.

begin tran
update TELEPHONE
set TEL_NUMERO = '+33' + REPLACE(substring(TEL_NUMERO, 2, 14), '-', '')
rollback

select * from TELEPHONE


-------------------
-- Requête 1.D
-------------------
-- Clients qui ont payé avec au moins deux moyens de paiement différents au cours d’un même mois (id, nom)
-- Nombre de lignes renvoyé par la requête : 28

-- On passe par une table intermédiaire
declare @temp table
(
	IdClient int,
	Année int,
	Mois int,
	Nombre int
)

-- On remplit la table @temp avec les clients ayant utilisés au moins 2 moyens de paiement au cours d'un même mois.
insert @temp
select CLI_ID, year(FAC_PMDATE) as Année, MONTH(FAC_PMDATE) as Mois, COUNT(*) as NbMoyPaiementUtilisesParMois
from FACTURE
group by CLI_ID, year(FAC_PMDATE), MONTH(FAC_PMDATE)
having COUNT(*) >1

-- On affiche les clients en enlevant les doublons.
select distinct IdClient
from @temp


-------------------
-- Requête 1.E
-------------------
-- Clients de la même ville qui se sont déjà retrouvés en même temps à l’hôtel
-- Nombre de lignes renvoyé par la requête : 689

select A.ADR_VILLE, CH.PLN_JOUR, CH.CLI_ID, COUNT(*) as nbre
from CHB_PLN_CLI CH
inner join ADRESSE A on (CH.CLI_ID = A.CLI_ID)
group by A.ADR_VILLE, CH.PLN_JOUR, CH.CLI_ID
having COUNT(*) > 1


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 2. Fréquentation
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- Nous n'avons pas eu le temps d'aborder cette partie.


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- 3. Chiffre d’affaire
------------------------------------------------------------------------------
------------------------------------------------------------------------------


-------------------
-- Requête 3.A
-------------------
-- Valeur absolue et pourcentage d’augmentation du tarif de chaque chambre sur l’ensemble de la période
-- La requête nous permet d'obtenir l'augmentation et le pourcentage d'augmentation des 20 chambres de l'hôtel.


select distinct C.CHB_ID, C.chb_numero,
		(MAX(TRF_CHB_PRIX) over (partition by T.CHB_ID) - MIN(TRF_CHB_PRIX) over (partition by T.CHB_ID)) as Augmentation,
		(MAX(TRF_CHB_PRIX) over (partition by T.CHB_ID) / MIN(TRF_CHB_PRIX) over (partition by T.CHB_ID) - 1) * 100  as PourcentageAugmentation
from TRF_CHB T
inner join CHAMBRE C on T.CHB_ID = C.CHB_ID


-------------------
-- Requête 3.B
-------------------
-- Chiffre d'affaire de l’hôtel par trimestre de chaque année
-- On considère que dans la table LIGNE_FACTURE, LIF_MONTANT = prix unitaire TTC.
-- On obtient 9 lignes correspondant au chiffre d'affaire de l'hôtel par trimestre de chaque année.

select YEAR(f.FAC_DATE) Année, DATEPART(QUARTER, f.FAC_DATE) Trimestre, 
	   SUM (lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) [Chiffre d'affaire]  
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
group by YEAR(f.FAC_DATE), DATEPART(QUARTER, f.FAC_DATE)
order by 1, 2

select * from LIGNE_FACTURE

-------------------
-- Requête 3.C
-------------------
-- Chiffre d'affaire de l’hôtel par mode de paiement et par an, 
-- avec les modes de paiement en colonne et les années en ligne.
-- On obtiendra à la fin un tableau avec de 4 colonnes et 4 lignes.

-- On affiche le chiffre d'affaire de l'hôtel par moyen de paiement et par an.


select YEAR(f.FAC_DATE) Année, PMCODE [Moyen de paiement],
	   SUM (lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) [Chiffre d'affaire]  
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
group by YEAR(f.FAC_DATE), PMCODE


-- On affiche le chiffre d'affaire par mode de paiement et par an avec les modes de paiement en colonne et les année en lignes.

select [Moyen de paiement],[2015],[2016],[2017]
from 
(
select YEAR(f.FAC_DATE) Année, PMCODE [Moyen de paiement],
	   (lf.LIF_QTE * lf.LIF_MONTANT * (1 - isnull (lf.lif_remise_pourcent,0)/100)- ISNULL (lf.LIF_REMISE_MONTANT,0)) [Chiffre d'affaire]  
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID

) as Source
pivot (SUM([Chiffre d'affaire])  
FOR Année in ([2015],[2016],[2017])) as Cible

select * from MODE_PAIEMENT

-------------------
-- Requête 3.D
-------------------
-- Délai moyen de paiement des factures par année et par mode de paiement, 
-- avec les modes de paiement en colonne et les années en ligne.
-- On obtiendra à la fin un tableau avec de 4 colonnes et 4 lignes.


-- On affiche le délai moyen de paiement des factures par année et par mode de paiement.

select YEAR(f.FAC_DATE) Année, PMCODE [Moyen de paiement], 
			avg(DATEDIFF(day, FAC_DATE, FAC_PMDATE)) [Délai de paiement moyen (en jours)]
from FACTURE f
inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
group by YEAR(f.FAC_DATE), PMCODE


-- On affiche le délai moyen de paiement (en jours) avec les modes de paiement en colonne et les années en ligne.


select [Moyen de paiement],[2015],[2016],[2017]
from 
(
	select YEAR(f.FAC_DATE) Année, PMCODE [Moyen de paiement], 
			DATEDIFF(day, FAC_DATE, FAC_PMDATE) DPM
	from FACTURE f
	inner join LIGNE_FACTURE lf on lf.FAC_ID = f.FAC_ID
) as Source
pivot (avg(DPM) 
FOR Année in ([2015],[2016],[2017])) as Cible

select * from MODE_PAIEMENT


-------------------
-- Requête 3.E
-------------------
-- Compter le nombre de clients dans chaque tranche de 5000 F de chiffre d’affaire total généré, 
-- en partant de 20000 F jusqu’à + de 45 000 F. 
-- On obtiendra à la fin un tableau avec de 2 colonnes et 4 lignes.

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
-- Requête 3.F
-------------------
-- A partir du 01/09/2017, augmenter les tarifs des chambres du rez-de-chaussée de 5%, 
-- celles du 1er étage de 4% et celles du 2d étage de 2%.
-- /!\ L'exercice est encore en chantier. Il reste à gérer la condition à partir du 01/09/2017.

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