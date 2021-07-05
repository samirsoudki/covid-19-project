-- Database: covid death/vaccines project

-- DROP DATABASE "covid death/vaccines project";

CREATE DATABASE "covid death/vaccines project"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- select the data that we are going to use
SELECT location, date, population, total_cases, new_cases, total_deaths FROM covid_death_2
WHERE continent is not null AND location LIKE '%Ukraine%'

	
-- 	likelihood of dying in you contact covid in UKraine
SELECT location, date, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as likelihood_of_dying   
FROM covid_death_2
WHERE continent is not null AND total_deaths is not null AND location LIKE '%Ukraine%'


ALTER TABLE covid_death_2
ALTER COLUMN total_deaths SET DATA TYPE numeric

ALTER TABLE covid_death_2
ALTER COLUMN total_cases SET DATA TYPE numeric

ALTER TABLE covid_vaccines
ALTER COLUMN people_fully_vaccinated SET DATA TYPE numeric

-- 	likelihood of dying in you contact covid in UKraine
SELECT location, date, population, new_cases, CAST(total_cases as int), CAST(total_deaths as int), (total_deaths/total_cases)*100 as likelihood_of_dying   
FROM covid_death_2
WHERE continent is not null AND total_deaths is not null AND location LIKE '%Ukraine%'

--let's calculate the average of the likelihood to get killed by the covid-19 in UKRAINE
SELECT AVG((total_deaths/total_cases)*100) AS likelihood_of_dying
FROM covid_death_2
WHERE continent is not null AND location LIKE '%Ukraine%'

--let's see the population of ukraine that have been infected by covid
SELECT location, date, population, new_cases, total_cases, CAST(total_deaths as int), (total_cases/population)*100 as infected_percentage   
FROM covid_death_2
WHERE continent is not null AND location LIKE '%Ukraine%'

--let's see the countries with the highest infected rate
SELECT (location), MAX (population) AS population , MAX (CAST(total_cases as int)) AS highestinfcount, MAX (total_cases/population)*100 as infected_percentage   
FROM covid_death_2
WHERE continent is not null 
GROUP BY location, population
ORDER BY infected_percentage DESC

--let's see the countries with the highest death rate by covid
SELECT location, AVG (total_deaths/total_cases)*100 as death_percentage
FROM covid_death_2
WHERE continent is not null AND total_deaths is not null
GROUP BY location
ORDER BY death_percentage DESC

--let's see the countries with the highest death count by covid
SELECT location, MAX (total_deaths)
FROM covid_death_2
WHERE continent is not null AND total_deaths is not null
GROUP BY location
ORDER BY MAX(total_deaths) DESC

--let's see the continents with the highest death rate by covid
SELECT continent, AVG (total_deaths/total_cases)*100 as death_percentage
FROM covid_death_2
WHERE continent is not null AND total_deaths is not null
GROUP BY continent
ORDER BY death_percentage DESC

--let's see the continents with the highest death count by covid
SELECT continent, MAX (total_deaths)
FROM covid_death_2
WHERE continent is not null AND total_deaths is not null
GROUP BY continent
ORDER BY MAX(total_deaths) DESC

-- let's see the percentage of the population that are fully vacinated in ukraine
SELECT location, population, (people_fully_vaccinated/population)*100 as percentage_vacinated 
FROM covid_vaccines
WHERE continent is not null AND location ILIKE '%ukraine%'
ORDER BY percentage_vacinated DESC

--let's observe the total death, total cases and people whom got fully vaccinated in ukraine

SELECT covid_death_2.location, covid_death_2.date, covid_death_2.total_cases, covid_death_2.total_deaths, covid_vaccines.people_fully_vaccinated  
FROM covid_death_2
INNER join covid_vaccines
ON covid_death_2.location = covid_vaccines.location
AND covid_death_2.date= covid_vaccines.date
WHERE covid_vaccines.location ILIKE '%ukraine%'


--let's view (save) the above command
CREATE VIEW full_table as
SELECT covid_death_2.location, covid_death_2.date, covid_death_2.total_cases, covid_death_2.total_deaths, covid_vaccines.people_fully_vaccinated  
FROM covid_death_2
INNER join covid_vaccines
ON covid_death_2.location = covid_vaccines.location
AND covid_death_2.date= covid_vaccines.date
WHERE covid_vaccines.location ILIKE '%ukraine%'






