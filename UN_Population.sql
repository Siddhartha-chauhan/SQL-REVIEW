CREATE TABLE population_raw (
    region TEXT,
    country_code TEXT,
    year INT,
    population TEXT
);

CREATE TABLE population AS
SELECT
    region,
    country_code::INT,
    year,
    (NULLIF(population, 'None')::DOUBLE PRECISION * 1000)::BIGINT AS population
FROM population_raw;

SELECT
    year,
    population
FROM population
WHERE region = 'India'
ORDER BY year;

SELECT
    region AS country,
    population
FROM population
WHERE year = 2014
  AND region IN (
        'Brunei Darussalam',
        'Cambodia',
        'Indonesia',
        'Lao People''s Democratic Republic',
        'Malaysia',
        'Myanmar',
        'Philippines',
        'Singapore',
        'Thailand',
        'Viet Nam',
        'Timor-Leste'
    )
ORDER BY population DESC;

SELECT
    year,
    SUM(population) AS total_saarc_population
FROM population
WHERE region IN (
        'Afghanistan',
        'Bangladesh',
        'Bhutan',
        'India',
        'Maldives',
        'Nepal',
        'Pakistan',
        'Sri Lanka'
    )
GROUP BY year
ORDER BY year;

SELECT
    year,
    region AS country,
    population
FROM population
WHERE year BETWEEN 2004 AND 2014
  AND region IN (
        'Brunei Darussalam',
        'Cambodia',
        'Indonesia',
        'Lao People''s Democratic Republic',
        'Malaysia',
        'Myanmar',
        'Philippines',
        'Singapore',
        'Thailand',
        'Viet Nam',
        'Timor-Leste'
    )
ORDER BY year, country;


