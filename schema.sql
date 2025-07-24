CREATE DATABASE covid_analytics_db;


USE covid_analytics_db;


CREATE TABLE staging_vaccinations (
  country VARCHAR(100),
  iso_code VARCHAR(10),
  date DATE,
  total_vaccinations BIGINT,
  people_vaccinated BIGINT,
  people_fully_vaccinated BIGINT,
  daily_vaccinations_raw BIGINT,
  daily_vaccinations BIGINT,
  total_vaccinations_per_hundred DECIMAL(5,2),
  people_vaccinated_per_hundred DECIMAL(5,2),
  people_fully_vaccinated_per_hundred DECIMAL(5,2),
  daily_vaccinations_per_million DECIMAL(10,2),
  vaccines VARCHAR(255),
  source_name VARCHAR(255),
  source_website VARCHAR(255)
);

CREATE TABLE staging_manufacturer (
  location VARCHAR(100),
  date DATE,
  vaccine VARCHAR(100),
  total_vaccinations BIGINT
);

CREATE TABLE countries (
  country_id INT AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(100) UNIQUE,
  iso_code VARCHAR(10),
  continent VARCHAR(50),
  population BIGINT
);

CREATE TABLE vaccines (
  vaccine_id INT AUTO_INCREMENT PRIMARY KEY,
  vaccine_name VARCHAR(100) UNIQUE,
  manufacturer VARCHAR(100),
  vaccine_type VARCHAR(50)
);


INSERT INTO countries (country_name, iso_code, continent, population) VALUES
('Afghanistan', 'AFG', 'Asia', 40000000),
('Argentina', 'ARG', 'South America', 45000000),
('India', 'IND', 'Asia', 1400000000),
('United States', 'USA', 'North America', 331000000),
('United Kingdom', 'GBR', 'Europe', 67000000);


INSERT INTO vaccines (vaccine_name, manufacturer, vaccine_type) VALUES
('Moderna', 'Moderna Inc.', 'mRNA'),
('Oxford/AstraZeneca', 'AstraZeneca', 'Viral Vector'),
('Sinopharm/Beijing', 'Sinopharm', 'Inactivated'),
('Sputnik V', 'Gamaleya Research Institute', 'Viral Vector'),
('Pfizer/BioNTech', 'Pfizer-BioNTech', 'mRNA'),
('Johnson&Johnson', 'Janssen Pharmaceuticals', 'Viral Vector');


CREATE TABLE vaccinations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  country_id INT,
  vaccine_id INT,
  date DATE,
  total_vaccinations BIGINT,
  people_vaccinated BIGINT,
  people_fully_vaccinated BIGINT,
  daily_vaccinations BIGINT,
  total_vaccinations_per_hundred DECIMAL(5,2),
  people_vaccinated_per_hundred DECIMAL(5,2),
  people_fully_vaccinated_per_hundred DECIMAL(5,2),
  daily_vaccinations_per_million DECIMAL(10,2),
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  FOREIGN KEY (vaccine_id) REFERENCES vaccines(vaccine_id)
);

CREATE TABLE vaccinations_by_manufacturer (
  id INT AUTO_INCREMENT PRIMARY KEY,
  country_id INT,
  vaccine_id INT,
  date DATE,
  total_vaccinations BIGINT,
  FOREIGN KEY (country_id) REFERENCES countries(country_id),
  FOREIGN KEY (vaccine_id) REFERENCES vaccines(vaccine_id)
);
