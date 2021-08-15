DROP TABLE IF EXISTS Route;
DROP TABLE IF EXISTS Airline;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Country;

CREATE TABLE Country(
	countryName	 	varchar(40) NOT NULL,
	countryCode		varchar(10) NOT NULL,
	latitude        varchar(25),
	longitude		varchar(25),
	GDP				varchar(10),
	PRIMARY KEY(countryName));

CREATE TABLE Airport(
	airportName 	varchar(70),
	cityName		varchar(30),
	countryName 	varchar(40),
	airportCode		varchar(10) NOT NULL,
	latitude		varchar(25),
	longitude		varchar(25),
	altitude		varchar(25),
	timezone		varchar(10),
	PRIMARY KEY(airportCode),
	FOREIGN KEY(countryName) 
	REFERENCES Country(countryName) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Airline (
	airlineName	        	varchar(50) NOT NULL,
	airlineCode 	        varchar(10) NOT NULL,
	countryName 	        varchar(40),
	activeStatus	        varchar(10),
	PRIMARY KEY(airlineCode));
	
CREATE TABLE Route (
	airlineCode 					varchar(10) NOT NULL,
	originCode 						varchar(10) NOT NULL,
	destinationCode	                varchar(10) NOT NULL,
	PRIMARY KEY (originCode, destinationCode, airlineCode),
	FOREIGN KEY(airlineCode) REFERENCES Airline(airlineCode) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(originCode) REFERENCES Airport(airportCode) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(destinationCode)  REFERENCES Airport(airportCode) ON DELETE CASCADE ON UPDATE CASCADE);

LOAD DATA LOCAL INFILE '/Desktop/countries_preprocessed.txt' REPLACE INTO TABLE Country
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(countryName, countryCode, latitude, longitude, GDP);

LOAD DATA LOCAL INFILE '/Desktop/airports_preprocessed.txt' REPLACE INTO TABLE Airport
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airportName, cityName, countryName, airportCode, latitude, longitude, altitude, timezone);

LOAD DATA LOCAL INFILE '/Desktop/airlines_preprocessed.txt' REPLACE INTO TABLE Airline
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airlineName, airlineCode, countryName, activeStatus);


LOAD DATA LOCAL INFILE '/Desktop/routes_preprocessed.txt' REPLACE INTO TABLE Route
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airlineCode, originCode, destinationCode);
