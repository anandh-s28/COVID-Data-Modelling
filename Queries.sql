--1
SELECT
  l.LocationName AS 'Country Name (CN)',
  ROW_NUMBER() OVER (PARTITION BY l.ISO_Code ORDER BY Date) - 1 AS 'Administered Vaccine on Day Number (DN)',
  SUM(v.daily_people_vaccinated) OVER (PARTITION BY l.ISO_Code ORDER BY Date) AS 'Total Injected People'
FROM Location l
JOIN VaccinationStatusPerCountry v ON l.ISO_Code = v.ISO_Code;


--2
--Lists all the countries' maximum cumulative doses number
SELECT l.LocationName AS Country, MAX(v.total_vaccinations + 0) AS 'Cumulative Doses'
FROM Location l JOIN VaccinationStatusPerCountry v ON l.ISO_Code = v.ISO_Code
WHERE l.ISO_Code NOT IN ('OWID_AFR','OWID_ASI','OWID_EUR','OWID_EUN','OWID_NAM','OWID_OCE','OWID_SAM','OWID_WRL')
GROUP BY l.LocationName
ORDER BY MAX(v.total_vaccinations + 0) DESC;

--Lists the country with the outright maximum cumulative number (China)
SELECT l.LocationName AS Country, MAX(v.total_vaccinations + 0) AS 'Cumulative Doses'
FROM Location l JOIN VaccinationStatusPerCountry v ON l.ISO_Code = v.ISO_Code
WHERE l.ISO_Code NOT IN ('OWID_AFR','OWID_ASI','OWID_EUR','OWID_EUN','OWID_NAM','OWID_OCE','OWID_SAM','OWID_WRL')
ORDER BY MAX(v.total_vaccinations + 0) DESC;

--3
SELECT DISTINCT(V.Vaccine) AS 'Vaccine Type', L.LocationName AS Country
FROM VaccinesByLocation V
JOIN Location L ON V.ISO_Code = L.ISO_Code
ORDER BY V.Vaccine, L.LocationName;


--4
SELECT DISTINCT(SourceURL) AS Source, MAX(total_vaccinations + 0) AS LargestTotalAdministered
FROM Location
JOIN VaccinationStatusPerCountry ON Location.ISO_Code = VaccinationStatusPerCountry.ISO_Code
WHERE SourceURL is NOT NULL
GROUP BY SourceURL
ORDER BY LargestTotalAdministered DESC;

--5
SELECT
    ObservationMonth AS 'Date',
    MAX(CASE WHEN ISO_Code = 'AUS' THEN COALESCE(people_fully_vaccinated, 0) ELSE 0 END) AS 'Australia',
    MAX(CASE WHEN ISO_Code = 'NZL' THEN COALESCE(people_fully_vaccinated, 0) ELSE 0 END) AS 'New Zealand',
    MAX(CASE WHEN ISO_Code = 'OWID_ENG' THEN COALESCE(people_fully_vaccinated, 0) ELSE 0 END) AS 'England',
    MAX(CASE WHEN ISO_Code = 'USA' THEN COALESCE(people_fully_vaccinated, 0) ELSE 0 END) AS 'USA'
FROM (
    SELECT
        substr(Date, 6, 2) AS ObservationMonth,
        ISO_Code,
        people_fully_vaccinated
    FROM VaccinationStatusPerCountry
    WHERE substr(Date, 0, 5) = '2022'
) AS subquery
GROUP BY ObservationMonth;


 
    






