DROP TABLE IF EXISTS RouteSmall;
DROP TABLE IF EXISTS AirlineSmall;
DROP TABLE IF EXISTS AirportSmall;
DROP TABLE IF EXISTS CountrySmall;

CREATE TABLE CountrySmall(
	countryName     varchar(40) NOT NULL,
	countryCode 	varchar(10) NOT NULL,
	latitude        varchar(25),
	longitude 		varchar(25),
	GDP 			varchar(10),
	PRIMARY KEY(countryName));

CREATE TABLE AirportSmall(
	airportName     varchar(70),
	cityName 		varchar(30),
	countryName   	varchar(40),
	airportCode   	varchar(10) NOT NULL,
	latitude 	    varchar(25),
	longitude	   	varchar(25),
	altitude    	varchar(25),
	timezone   		varchar(10),
	PRIMARY KEY(airportCode),
	FOREIGN KEY(countryName) 
	REFERENCES CountrySmall(countryName) ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE AirlineSmall(
	airlineName	        varchar(50) NOT NULL,
	airlineCode 	        varchar(10) NOT NULL,
	countryName 	        varchar(40),
	activeStatus	        varchar(10),
	PRIMARY KEY(airlineCode));
	
CREATE TABLE RouteSmall (
	airlineCode 			varchar(10) NOT NULL,
	originCode 			varchar(10) NOT NULL,
	destinationCode	                varchar(10) NOT NULL,
	PRIMARY KEY (originCode, destinationCode, airlineCode),
	FOREIGN KEY(airlineCode) REFERENCES AirlineSmall(airlineCode) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(originCode) REFERENCES AirportSmall(airportCode) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(destinationCode)  REFERENCES AirportSmall(airportCode) ON DELETE CASCADE ON UPDATE CASCADE);
    
LOAD DATA LOCAL INFILE '/Users/minjeongkim/Desktop/country-small.txt' REPLACE INTO TABLE CountrySmall
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(countryName, countryCode, latitude, longitude, GDP);

LOAD DATA LOCAL INFILE '/Users/minjeongkim/Desktop/airport-small.txt' REPLACE INTO TABLE AirportSmall
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airportName, cityName, countryName, airportCode, latitude, longitude, altitude, timezone);

LOAD DATA LOCAL INFILE '/Users/minjeongkim/Desktop/airline-small.txt' REPLACE INTO TABLE AirlineSmall
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airlineName, airlineCode, countryName, activeStatus);


LOAD DATA LOCAL INFILE '/Users/minjeongkim/Desktop/route-small.txt' REPLACE INTO TABLE RouteSmall
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(airlineCode, originCode, destinationCode);
