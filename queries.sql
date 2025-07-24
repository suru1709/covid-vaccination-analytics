
LOAD DATA LOCAL INFILE 'C:/Users/HP/Downloads/archive (1)/country_vaccinations.csv'
INTO TABLE staging_vaccinations
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';


LOAD DATA LOCAL INFILE 'C:/Users/HP/Downloads/archive (1)/country_vaccinations_by_manufacturer.csv'
INTO TABLE staging_manufacturer
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


INSERT INTO vaccinations (
  country_id, vaccine_id, date, total_vaccinations,
  people_vaccinated, people_fully_vaccinated, daily_vaccinations,
  total_vaccinations_per_hundred, people_vaccinated_per_hundred,
  people_fully_vaccinated_per_hundred, daily_vaccinations_per_million
)
SELECT c.country_id, v.vaccine_id, s.date,
  s.total_vaccinations, s.people_vaccinated, s.people_fully_vaccinated,
  s.daily_vaccinations, s.total_vaccinations_per_hundred,
  s.people_vaccinated_per_hundred, s.people_fully_vaccinated_per_hundred,
  s.daily_vaccinations_per_million
FROM staging_vaccinations s
JOIN countries c ON s.country = c.country_name
JOIN vaccines v ON TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 1), ',', -1)) = v.vaccine_name
WHERE s.country = 'Afghanistan'
UNION ALL
SELECT c.country_id, v.vaccine_id, s.date,
  s.total_vaccinations, s.people_vaccinated, s.people_fully_vaccinated,
  s.daily_vaccinations, s.total_vaccinations_per_hundred,
  s.people_vaccinated_per_hundred, s.people_fully_vaccinated_per_hundred,
  s.daily_vaccinations_per_million
FROM staging_vaccinations s
JOIN countries c ON s.country = c.country_name
JOIN vaccines v ON TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 2), ',', -1)) = v.vaccine_name
WHERE s.country = 'Afghanistan'
AND LENGTH(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 2), ',', -1))) > 0
UNION ALL
SELECT c.country_id, v.vaccine_id, s.date,
  s.total_vaccinations, s.people_vaccinated, s.people_fully_vaccinated,
  s.daily_vaccinations, s.total_vaccinations_per_hundred,
  s.people_vaccinated_per_hundred, s.people_fully_vaccinated_per_hundred,
  s.daily_vaccinations_per_million
FROM staging_vaccinations s
JOIN countries c ON s.country = c.country_name
JOIN vaccines v ON TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 3), ',', -1)) = v.vaccine_name
WHERE s.country = 'Afghanistan'
AND LENGTH(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 3), ',', -1))) > 0
UNION ALL
SELECT c.country_id, v.vaccine_id, s.date,
  s.total_vaccinations, s.people_vaccinated, s.people_fully_vaccinated,
  s.daily_vaccinations, s.total_vaccinations_per_hundred,
  s.people_vaccinated_per_hundred, s.people_fully_vaccinated_per_hundred,
  s.daily_vaccinations_per_million
FROM staging_vaccinations s
JOIN countries c ON s.country = c.country_name
JOIN vaccines v ON TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 4), ',', -1)) = v.vaccine_name
WHERE s.country = 'Afghanistan'
AND LENGTH(TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(s.vaccines, ',', 4), ',', -1))) > 0;


INSERT INTO vaccinations_by_manufacturer (
  country_id, vaccine_id, date, total_vaccinations
)
SELECT c.country_id, v.vaccine_id, s.date, s.total_vaccinations
FROM staging_manufacturer s
JOIN countries c ON s.location = c.country_name
JOIN vaccines v ON s.vaccine = v.vaccine_name;



-- Daily totals for India
SELECT date, SUM(total_vaccinations)
FROM vaccinations v JOIN countries c ON v.country_id = c.country_id
WHERE c.country_name = 'India'
GROUP BY date ORDER BY date;

-- Top vaccines
SELECT v2.vaccine_name, SUM(v1.total_vaccinations) AS total_doses
FROM vaccinations v1 JOIN vaccines v2 ON v1.vaccine_id = v2.vaccine_id
GROUP BY v2.vaccine_name ORDER BY total_doses DESC;

-- By manufacturer for Argentina
SELECT v2.vaccine_name, SUM(v1.total_vaccinations) AS total_doses
FROM vaccinations_by_manufacturer v1
JOIN vaccines v2 ON v1.vaccine_id = v2.vaccine_id
JOIN countries c ON v1.country_id = c.country_id
WHERE c.country_name = 'Argentina'
GROUP BY v2.vaccine_name
ORDER BY total_doses DESC;

-- Daily trend with running total India
SELECT
  date,
  SUM(total_vaccinations) AS daily_vax,
  SUM(SUM(total_vaccinations)) OVER (ORDER BY date) AS running_total
FROM vaccinations v
JOIN countries c ON v.country_id = c.country_id
WHERE c.country_name = 'India'
GROUP BY date ORDER BY date;
