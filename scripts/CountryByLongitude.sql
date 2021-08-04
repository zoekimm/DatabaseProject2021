-- CountryByLongitude.sql
-- receives a value for longitude
-- prints country that is located lower than the provided longitude

DELIMITER //
DROP PROCEDURE IF EXISTS CountryByLongitude//

CREATE PROCEDURE CountryByLongitude(IN longitudeInput VARCHAR(30))
BEGIN
    SELECT countryName, countryCode 
    FROM Country
    WHERE longitude < longitudeInput;
END; //

DELIMITER ;
