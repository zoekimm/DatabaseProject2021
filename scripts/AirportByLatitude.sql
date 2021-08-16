-- AirportByLatitude.sql
-- receives  a value for latitude
-- prints airport that is located higher than the provided latitude 

DELIMITER //
DROP PROCEDURE IF EXISTS AirportByLatitude //

CREATE PROCEDURE AirportByLatitude(IN latitudeInput VARCHAR(30))
BEGIN
    SELECT airportName, airportCode 
    FROM Airport
    WHERE latitude > latitudeInput;
END; //

DELIMITER ;
