CREATE TABLE company_master (
    cin VARCHAR(21),
    company_name VARCHAR(255),
    company_roc_code VARCHAR(50),
    company_category VARCHAR(100),
    company_subcategory VARCHAR(100),
    company_class VARCHAR(50),
    authorized_capital NUMERIC(15,2),
    paidup_capital  NUMERIC(15,2),
    company_registration_date DATE,
    registered_office_address TEXT,
    listing_status VARCHAR(50),
    company_status VARCHAR(50),
    company_state_code VARCHAR(50),
    company_indian_foreign_company VARCHAR(50),
    nic_code VARCHAR(10),
    company_industrial_classification VARCHAR(255)
);


SELECT              
    CASE                                           
        WHEN authorized_capital <= 100000 THEN '<= 1L'                                         
        WHEN authorized_capital <= 1000000 THEN '1L to 10L'                                                  
        WHEN authorized_capital <= 10000000 THEN '10L to 1Cr'
        WHEN authorized_capital <= 100000000 THEN '1Cr to 10Cr'
        ELSE '> 10Cr'
    END AS cap_bucket,
    COUNT(*) AS company_count
FROM company_master
GROUP BY cap_bucket
ORDER BY company_count DESC;


SELECT
    EXTRACT(YEAR FROM company_registration_date)::INT AS year,
    COUNT(*) AS registrations
FROM company_master
WHERE company_registration_date IS NOT NULL
GROUP BY year
ORDER BY year;


CREATE TABLE zipcode_district (
    pincode TEXT PRIMARY KEY,
    district TEXT
);


ALTER TABLE company_master ADD COLUMN pincode TEXT;

UPDATE company_master
SET pincode = regexp_replace(registered_office_address, '.*([0-9]{6}).*', '\1');


SELECT
    z.district,
    COUNT(*) AS registrations
FROM company_master c
JOIN zipcode_district z
    ON c.pincode = z.pincode
WHERE EXTRACT(YEAR FROM c.company_registration_date) = 2015
GROUP BY z.district
ORDER BY registrations DESC;


SELECT MAX(EXTRACT(YEAR FROM company_registration_date)) FROM company_master;

SELECT
    EXTRACT(YEAR FROM company_registration_date)::INT AS year,
    company_industrial_classification,
    COUNT(*) AS registrations
FROM company_master
WHERE EXTRACT(YEAR FROM company_registration_date) >= 2014
  AND company_industrial_classification IN (
      'Manufacturing (Others)',
      'Manufacturing (Machinery and Equipments)',
      'Other Service Activities',
      'Business Services',
      'Trading'
  )
GROUP BY year, company_industrial_classification
ORDER BY year, company_industrial_classification;










