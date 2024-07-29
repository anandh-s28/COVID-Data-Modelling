-- Location Table
CREATE TABLE Location (
    ISO_Code     TEXT PRIMARY KEY NOT NULL,
    LocationName TEXT,
    LastObsDate  DATE,
    SourceName   TEXT,
    SourceURL    TEXT
);

--Vaccines used in each location / VaccinesByLocation Table
CREATE TABLE VaccinesByLocation (
    ISO_Code TEXT,
    Vaccine  TEXT,
    FOREIGN KEY (
        ISO_Code
    )
    REFERENCES Location (ISO_Code),
    PRIMARY KEY (
        ISO_Code,
        Vaccine
    )
);

-- main vaccinations csv file / VaccinationStatusPerCountry table
CREATE TABLE VaccinationStatusPerCountry (
    ISO_Code                            TEXT NOT NULL,
    Date                                DATE NOT NULL,
    total_vaccinations                  INTEGER,
    people_vaccinated                   INTEGER,
    people_fully_vaccinated             INTEGER,
    total_boosters                      INTEGER,
    daily_vaccinations                  INTEGER,
    total_vaccinations_per_hundred      REAL,
    people_vaccinated_per_hundred       REAL,
    people_fully_vaccinated_per_hundred REAL,
    total_boosters_per_hundred          REAL,
    daily_vaccinations_per_million      REAL,
    daily_people_vaccinated             INTEGER,
    daily_people_vaccinated_per_hundred INTEGER,
    PRIMARY KEY (
        ISO_Code,
        Date
    )
);

--US Statewise table
CREATE TABLE US_Statewise (
    Location                            VARCHAR (40) NOT NULL,
    ISO_Code                            VARCHAR (40),
    Date                                DATE         NOT NULL,
    Total_distributed                   INTEGER,
    People_vaccinated                   INTEGER,
    People_fully_vaccinated_per_hundred INTEGER,
    Total_vaccinations_per_hundred      INTEGER,
    People_fully_vaccinated             INTEGER,
    People_vaccinated_per_hundred       INTEGER,
    Distributed_per_hundred             INTEGER,
    Daily_vaccinations                  INTEGER,
    Daily_vaccinations_per_million      INTEGER,
    Share_doses_used                    INTEGER,
    Total_boosters                      INTEGER,
    Total_boosters_per_hundred          INTEGER,
    FOREIGN KEY (
        ISO_Code
    )
    REFERENCES Location (ISO_Code),
    PRIMARY KEY (
        Date,
        Location
    )
);

-- Age Group Table
CREATE TABLE VaccinationsByAgeGroup (
    ISO_Code                        TEXT NOT NULL,
    Date                            DATE NOT NULL,
    AgeGroup                        TEXT NOT NULL,
    people_vaccinated_per_hundred   REAL,
    people_fully_vaccinated_per_100 REAL,
    booster_per_100                 REAL,
    FOREIGN KEY (
        ISO_Code
    )
    REFERENCES Location (ISO_Code),
    PRIMARY KEY (
    ISO_Code,
    Date,
    AgeGroup
    ) 
);

--VaccinesByManufacturer table
CREATE TABLE VaccinesByManufacturer (
    VaccineName       TEXT NOT NULL,
    ISO_Code          TEXT NOT NULL,
    Date              DATE NOT NULL,
    totalVaccinations INTEGER ,
    FOREIGN KEY (
        ISO_Code
    )
    REFERENCES Location (ISO_Code),
    PRIMARY KEY (
    ISO_Code,
    VaccineName,
    Date
    ) 
);
