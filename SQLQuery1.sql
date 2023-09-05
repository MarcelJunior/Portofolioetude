SELECT location,continent
FROM Portofoliodatabase..Coviddeath0
GROUP BY location, continent


------SELECT*
FROM Portofoliodatabase..Coviddeath;
SELECT  location, continent, MAX(total_deaths) as totaldeathsperlocation, Max(total_deaths/population) * 100 as percentpopulationdeaths
FROM Portofoliodatabase..Coviddeath0
Where continent is  not null
Group by continent, location
order by totaldeathsperlocation desc

----Recherchons le ration entre le nombre de mort et le nombre de cas
--SELECT location, date, total_cases,total_deaths
--FROM Portofoliodatabase..Coviddeath
--order by 1,2;

USE Portofoliodatabase; -- Sélectionnez la base de données

------ Modifiez le type de données de la colonne total_cases en FLOAT
ALTER TABLE Coviddeath0
ALTER COLUMN total_cases FLOAT;

--Modifiez le type de données de la colonne total_deaths en FLOAT
ALTER TABLE Coviddeath0
ALTER COLUMN total_deaths FLOAT;
-- shows likehood of dying if you contract covid in you country
SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases) * 100 as DeathPercentage
FROM Coviddeath
WHERE location like '%africa%'
 
 --Cherchons le pourcentage de mort du covid par rapport à la population et total de cas par rapport à la population
USE Portofoliodatabase;
SELECT location, date, total_cases,total_deaths,population , (total_deaths/population)* 100 as DeathPercentage, (total_cases/population) * 100 as Deathcases
FROM Coviddeath
WHERE location like '%africa%'
ORDER BY 1, 2;
 
 --cHerchons le pays avec le plus haut taux d'infection

 SELECT location, population, Max(total_cases/population) * 100 as percentpopulationInfected, MAX(total_cases) as HighestInfectioncount
FROM Coviddeath0
--WHERE location like '%africa%'
where continent is not null
GROUP BY location, population
ORDER BY percentpopulationInfected DESC

-- LE plus total de mort par population

  SELECT continent, MAX(total_deaths) as totaldeathsperlocation, Max(total_deaths/population) * 100 as percentpopulationdeaths
FROM Coviddeath0
--WHERE location like '%africa%'
WHERE continent is not NULL
GROUP BY continent
ORDER BY totaldeathsperlocation DESC
 

 --les pays avec le plus grand nombre de mort et taaux de mortalité par rapport à la population

 SELECT location, MAX(total_deaths) as totaldeathsperlocation, Max(total_deaths/population) * 100 as percentpopulationdeaths
FROM Coviddeath0
--WHERE location like '%africa%'
WHERE continent is  not NULL
GROUP BY location
ORDER BY totaldeathsperlocation DESC
 
 --Classons les continent avec le grand nombre de cas
  SELECT continent, Max(total_cases/population) * 100 as percentpopulationInfected, MAX(total_cases) as HighestInfectioncount
FROM Coviddeath0
--WHERE location like '%africa%'
where continent is not null
GROUP BY continent
ORDER BY percentpopulationInfected DESC

--SELECT date,SUM(cast (new_cases as int), SUM(new_death ), total_cases,total_deaths
--FROM Coviddeath0
----WHERE location like '%africa%'
--WHERE continent is not NULL
--GROUP BY date 
--order by 1,2;

--Showing le nombre de cas et de morts enregistrés par jour
SELECT date,
       SUM(CAST(new_cases AS float)) AS total_new_cases,
       SUM(CAST(new_deaths AS float)) AS total_new_deaths 
     --total_deaths
FROM Coviddeath0
-- WHERE location LIKE '%africa%'
WHERE continent IS NOT NULL
GROUP BY date
order by 1,2; 

SELECT date,
       SUM(CAST(new_cases AS float)) AS total_new_cases,
       SUM(CAST(new_deaths AS float)) AS total_new_deaths
FROM Coviddeath0
-- WHERE location LIKE '%africa%'
WHERE continent IS NOT NULL 
GROUP BY date
ORDER BY date;

--SELECT date,
--       SUM(CAST(new_cases AS float)) AS total_new_cases,
--       SUM(CAST(new_deaths AS float)) AS total_new_deaths
--FROM Coviddeath0
---- WHERE location LIKE '%africa%'
--WHERE continent IS NOT NULL
--GROUP BY date
--HAVING total_new_cases IS NOT NULL AND total_new_deaths IS NOT NULL
--ORDER BY date;

--GLOBAL OF INFECTION and death all over the world et pourcentage de mort par rapport au nombre de cas

SELECT SUM(CAST(new_cases AS float)) AS total_new_cases,
       SUM(CAST(new_deaths AS float)) AS total_new_deaths,SUM(CAST(new_deaths AS float))/SUM(CAST(new_cases AS float))*100 as percentdeath_per_cases
FROM Coviddeath0
-- WHERE location LIKE '%africa%'
WHERE continent IS NOT NULL 
--GROUP BY date
ORDER BY 1,2;

--let's talk about the number of vaccination vs number of population
--SELECT  dea.continent, dea.location, dea.population, dea.date, vac.new_vaccinations
--,sum(cast(vac.new_vaccinations as Int)) over (partition by dea.location order by dea.location, dea.date) as RollingpeopleVaccinated
---- (RollingpeopleVaccinated/population)*100
--FROM 
--Portofoliodatabase..Coviddeath0 dea
--join Portofoliodatabase..Covidvaccination vac
--on dea.location = vac.location
--   order by 2,3

SELECT
  dea.continent,
  dea.location,
  dea.population,
  dea.date,
  vac.new_vaccinations,
  SUM(CAST(vac.new_vaccinations AS float)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingpeopleVaccinated
FROM
  Portofoliodatabase..Coviddeath0 dea
JOIN
  Portofoliodatabase..Covidvaccination vac
ON
  dea.location = vac.location
ORDER BY
  2, 3;


	--select*
	--from Portofoliodatabase..covidvaccination