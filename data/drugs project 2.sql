
   
--a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims.
    SELECT sum(total_claim_count) AS GRAND_total,prescriber.npi
from prescriber INNER JOIN prescription ON prescriber.npi=prescription.npi
GROUP BY prescriber.npi
ORDER BY GRAND_total desc
limit 1;
--getting the sum then joinin from prescription and prescriber
-- b. Repeat the above, but this time report the nppes_provider_first_name, nppes_provider_last_org_name,  specialty_description, and the total number of claims.
select sum(total_claim_count) AS grand_total,npi,nppes_provider_first_name,nppes_provider_last_org_name,specialty_description
from prescriber
inner JOIN prescription USING(npi)
GROUP BY npi,nppes_provider_first_name,nppes_provider_last_org_name,specialty_description
ORDER BY grand_total desc
limit 1;

--2
select specialty_description,sum(total_claim_count) AS grand_total
FROM prescriber INNER JOIN prescription USING (npi)
group by specialty_description
order BY grand_total desc
limit 1;
--2b
select sum(total_claim_count) AS grand_total, specialty_description 
from prescriber INNER JOIN prescription using(npi)LEFT JOIN drug USING (drug_name)
where opioid_drug_flag='Y'
group by specialty_description
ORDER BY grand_total desc
limit 1;
--3
select distinct (specialty_description)
from prescriber
where npi NOT IN(select distnct(npi)
				from prescription)